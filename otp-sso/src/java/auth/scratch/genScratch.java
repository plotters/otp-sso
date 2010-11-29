/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package auth.scratch;

import auth.hash.*;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author jake
 */
public class genScratch {

    private static String DB_USER = "auth_test";
    private static String DB_PASSWORD = "password";
    private static String DB_URL = "jdbc:mysql://10.1.1.2/auth?autoReconnect=true";

    public genScratch() {
    }

    public String[] generate(int num) {
        String[] result = new String[num];

        randomGen rg = new randomGen();

        for (int i = 0; i < num; i++) {
            result[i] = rg.Gen();
        }

        return result;
    }

    public void insertScratch(String[] codes, int uid) {
        try {
            Connection c = null;
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            c = (Connection) DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "delete FROM authScratch WHERE (uid = '"
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
                    Logger.getLogger(genScratch.class.getName()).log(Level.SEVERE, null, ex);
                }
            }



        } catch (SQLException ex) {
            Logger.getLogger(genScratch.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(genScratch.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(genScratch.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(genScratch.class.getName()).log(Level.SEVERE, null, ex);
        }



        for (int i = 0; i < codes.length; i++) {
            try {
                Connection c = null;
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                c = (Connection) DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                String sql = null;

                //System.out.println(uid);
                //System.out.println(codes[i]);
                try {
                    sql = "INSERT INTO authScratch VALUES (" + uid + ", '" + AeSimpleSHA1.SHA1(codes[i]) + "')";
                } catch (NoSuchAlgorithmException ex) {
                    Logger.getLogger(genScratch.class.getName()).log(Level.SEVERE, null, ex);
                } catch (UnsupportedEncodingException ex) {
                    Logger.getLogger(genScratch.class.getName()).log(Level.SEVERE, null, ex);
                }

                Statement stmt = c.createStatement();

                int updateCount = stmt.executeUpdate(sql);
                // sqlcount++;
                //System.out.println(sql + " : " + updateCount);


                stmt.close();

                if (c != null) {
                    try {
                        c.close();
                    } catch (SQLException ex) {
                        Logger.getLogger(genScratch.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }



            } catch (SQLException ex) {
                Logger.getLogger(genScratch.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InstantiationException ex) {
                Logger.getLogger(genScratch.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IllegalAccessException ex) {
                Logger.getLogger(genScratch.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(genScratch.class.getName()).log(Level.SEVERE, null, ex);
            }

        }


    }

    public static void main(String[] args) {

        String[] codes = new String[10];

        genScratch gs = new genScratch();

        codes = gs.generate(10);

        for (int i = 0; i < codes.length; i++) {
            System.out.println(codes[i]);

        }

        gs.insertScratch(codes, 1);


    }
}
