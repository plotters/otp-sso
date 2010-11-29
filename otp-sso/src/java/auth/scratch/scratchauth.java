/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package auth.scratch;

import auth.hash.AeSimpleSHA1;
import com.mysql.jdbc.Connection;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
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
public class scratchauth {
    
        private static String DB_USER = "auth_test";
    private static String DB_PASSWORD = "password";
    private static String DB_URL = "jdbc:mysql://10.1.1.2/auth?autoReconnect=true";

    public scratchauth(){

    }

    public boolean verify(int uid, String password)
    {
        boolean result = false;

         String secret = null;

             //System.out.println(uid);
             //System.out.println(password);

         try {
                Connection c = null;
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                c = (Connection) DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                String sql = null;
            try {
                sql = "SELECT * FROM authScratch WHERE (uid = '" + uid + "' && scratch = '" + AeSimpleSHA1.SHA1(password) + "') LIMIT 1";
                //System.out.println(sql);
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(scratchauth.class.getName()).log(Level.SEVERE, null, ex);
            } catch (UnsupportedEncodingException ex) {
                Logger.getLogger(scratchauth.class.getName()).log(Level.SEVERE, null, ex);
            }

                Statement stmt = c.createStatement();
                stmt.setFetchSize(1);

                ResultSet rs = stmt.executeQuery(sql);

                if (rs.next()) {
                    result = true;
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
                        Logger.getLogger(scratchauth.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

            } catch (SQLException ex) {
                Logger.getLogger(scratchauth.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InstantiationException ex) {
                Logger.getLogger(scratchauth.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IllegalAccessException ex) {
                Logger.getLogger(scratchauth.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(scratchauth.class.getName()).log(Level.SEVERE, null, ex);
            }

             if(result == true)
             {
                 try {
            Connection c = null;
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            c = (Connection) DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = null;
                try {
                    sql = "delete FROM authScratch WHERE (uid = '" + uid + "' && scratch = '" + AeSimpleSHA1.SHA1(password) + "')";
                } catch (NoSuchAlgorithmException ex) {
                    Logger.getLogger(scratchauth.class.getName()).log(Level.SEVERE, null, ex);
                } catch (UnsupportedEncodingException ex) {
                    Logger.getLogger(scratchauth.class.getName()).log(Level.SEVERE, null, ex);
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
                    Logger.getLogger(scratchauth.class.getName()).log(Level.SEVERE, null, ex);
                }
            }



        } catch (SQLException ex) {
            Logger.getLogger(scratchauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(scratchauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(scratchauth.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(scratchauth.class.getName()).log(Level.SEVERE, null, ex);
        }
             }




        return result;
    }



}
