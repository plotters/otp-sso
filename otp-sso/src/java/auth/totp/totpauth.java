/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package auth.totp;

import auth.authDbSecrets;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;

import auth.hash.AeSimpleSHA1;
import auth.hash.randomGen;

/**
 *
 * @author jake
 */
public class totpauth {

    private static String DB_USER = authDbSecrets.DB_USER;
    private static String DB_PASSWORD = authDbSecrets.DB_PASSWORD;
    private static String DB_URL = authDbSecrets.DB_URL;

    public totpauth() {
    }

    public boolean verify(int uid, String password) {
        boolean result = false;

        String secret = null;
        String prefix = null;
        try {
            Connection c = null;
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            c = (Connection) DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "SELECT * FROM authTotp WHERE (uid = '"
                    + uid
                    + "') LIMIT 1";

            Statement stmt = c.createStatement();
            stmt.setFetchSize(10);

            ResultSet rs = stmt.executeQuery(sql);

            if (rs.next()) {
                secret = rs.getString(2);
                prefix = rs.getString(3);
            }
            //System.out.println("Secret:" + secret);
            //System.out.println("Prefix:" + prefix);
            rs.close();
            stmt.close();

            if (c != null) {
                try {
                    c.close();
                } catch (SQLException ex) {
                    Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        }

        byte[] hex = Base32.decode(secret);


        long X = 30;
        Calendar now = Calendar.getInstance();
        long time = now.getTimeInMillis();

        time = time / 1000;

        String sha1hash = (String) password.subSequence(0, (password.length() - 6));
        try {
            sha1hash = AeSimpleSHA1.SHA1(sha1hash);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        }

        //System.out.println(sha1hash);



        for (int i = 0; i < 90; i = i + 30) {


            long T = (time - i) / X;

            String steps = Long.toHexString(T).toUpperCase();

            while (steps.length() < 16) {
                steps = "0" + steps;
            }

            String otp = totp.generateTOTP(hex, steps, "6", "HmacSHA1");

            if (sha1hash.equals(prefix) && password.endsWith(otp)) {
                result = true;
            }


        }

        return result;
    }

    public String getSecret(String uidString) {
        boolean result = false;

        int uid = Integer.parseInt(uidString);

        String secret = null;

        try {
            Connection c = null;
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            c = (Connection) DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "SELECT * FROM authTotp WHERE (uid = '"
                    + uid
                    + "') LIMIT 1";

            Statement stmt = c.createStatement();
            stmt.setFetchSize(10);

            ResultSet rs = stmt.executeQuery(sql);

            if (rs.next()) {
                secret = rs.getString(2);

            }
            //System.out.println("Secret:" + secret);
            //System.out.println("Prefix:" + prefix);
            rs.close();
            stmt.close();

            if (c != null) {
                try {
                    c.close();
                } catch (SQLException ex) {
                    Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        }


        return secret;
    }

    public void newSecret(String uidString) {

        int uid = Integer.parseInt(uidString);


        try {
            Connection c = null;
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            c = (Connection) DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = null;

            //System.out.println(uid);
            //System.out.println(codes[i]);
            randomGen rg = new randomGen();
            String secret = rg.GenTOTP();
            sql = "UPDATE authTotp SET secret='" + secret + "' WHERE (uid = '"
                    + uid
                    + "')";


            Statement stmt = c.createStatement();

            int updateCount = stmt.executeUpdate(sql);
            // sqlcount++;
            //System.out.println(sql + " : " + updateCount);


            stmt.close();

            if (c != null) {
                try {
                    c.close();
                } catch (SQLException ex) {
                    Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
                }
            }



        } catch (SQLException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void newPrefix(String uidString, String prefix) {


        int uid = Integer.parseInt(uidString);
        String sha1hash = null;
        try {
            sha1hash = AeSimpleSHA1.SHA1(prefix);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            Connection c = null;
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            c = (Connection) DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = null;

            
            randomGen rg = new randomGen();


            sql = "UPDATE authTotp SET prefix='" + sha1hash + "' WHERE (uid = '"
                    + uid
                    + "')";


            Statement stmt = c.createStatement();

            int updateCount = stmt.executeUpdate(sql);
            // sqlcount++;
           //System.out.println(prefix + ":" + sql + " : " + updateCount);


            stmt.close();

            if (c != null) {
                try {
                    c.close();
                } catch (SQLException ex) {
                    Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
                }
            }



        } catch (SQLException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(totpauth.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {

        long X = 30;
        Calendar now = Calendar.getInstance();
        long time = now.getTimeInMillis();

        String secret = "JBSWY3DPEHPK3PXP";
        byte[] hex = Base32.decode(secret);

        time = time / 1000;
        //time = time - 60;
        //SSSystem.out.println(time);


        for (int i = 0; i < 90; i = i + 30) {


            long T = (time - i) / X;
            //System.out.println(T);

            String steps = Long.toHexString(T).toUpperCase();

            while (steps.length() < 16) {
                steps = "0" + steps;
            }

            String otp = totp.generateTOTP(hex, steps, "6", "HmacSHA1");
            System.out.println(otp);


        }



    }
}
