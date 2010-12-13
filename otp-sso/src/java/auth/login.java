package auth;
// import java.sql.*;

import auth.scratch.scratchauth;
import auth.yubikey.*;
import auth.totp.*;
import com.mysql.jdbc.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;


public class login {

    private String username = "";
    private String password = "";
    private static String DB_USER = authDbSecrets.DB_USER;
    private static String DB_PASSWORD = authDbSecrets.DB_PASSWORD;
    private static String DB_URL = authDbSecrets.DB_URL;

    public login() {
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean authenticate(String username,
            String password) {


        boolean isAuthenticated = false;
        int yubi = 0;
        int totp = 0;
        int scratch = 0;
        int uid = 0;

        if (username != null && password != null && password.length()>7) {
            try {
                Connection c = null;
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                c = (Connection) DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                String sql = "SELECT * FROM authUsers WHERE (username = '"
                        + username
                        + "') LIMIT 1";

                Statement stmt = c.createStatement();
                stmt.setFetchSize(10);

                ResultSet rs = stmt.executeQuery(sql);

                if (rs.next()) {
                    uid = rs.getInt(1);
                    yubi = rs.getInt(3);
                    totp = rs.getInt(4);
                    scratch = rs.getInt(6);
                }
                //System.out.println("Yubi:" + yubi);
                rs.close();
                stmt.close();

                if (c != null) {
                    try {
                        c.close();
                    } catch (SQLException ex) {
                        Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }



            } catch (SQLException ex) {
                Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InstantiationException ex) {
                Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IllegalAccessException ex) {
                Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
            }


            if (yubi == 1) {
                yubiauth yc = new yubiauth(1);
                if (yc.verify(uid, password)) {
                    isAuthenticated = true;
                }
            }
            if (totp == 1) {
                totpauth tp = new totpauth();
                if (tp.verify(uid, password)) {
                    //System.out.println("Uid: " + uid + "Password: " + password);
                    isAuthenticated = true;
                }
            }
            if (scratch == 1) {
                scratchauth sc = new scratchauth();
                if (sc.verify(uid, password)) {
                    //System.out.println("Uid: " + uid + "Password: " + password);
                    isAuthenticated = true;
                }
            }

        }

        return isAuthenticated;
    }
}
// }
//}}

