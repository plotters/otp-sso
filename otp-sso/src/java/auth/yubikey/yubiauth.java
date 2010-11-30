/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package auth.yubikey;

import auth.authDbSecrets;
import com.mysql.jdbc.Connection;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
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
public class yubiauth {

    static final String YUBICO_AUTH_SRV_URL = "http://127.0.0.1:8080/verify?id=";
    private int _clientId;
    private String _response;

    private static String DB_USER = authDbSecrets.DB_USER;
    private static String DB_PASSWORD = authDbSecrets.DB_PASSWORD;
    private static String DB_URL = authDbSecrets.DB_URL;

    /**
     * Initializes the Yubico object.
     *
     * @param initId	The Client ID you wish to verify against or operate within.
     */
    public yubiauth(int initId) {
        _clientId = initId;
    }

    /**
     * Returns the ID passed to the initialized Yubico object.
     *
     * @return id	The Client ID passed to the initializing class.
     */
    public int getId() {
        return _clientId;
    }

    public String getLastResponse() {
        return _response;
    }

    public boolean verifyUser(int uid, String otp)
    {
        String yubipre = null;
         try {
                Connection c = null;
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                c = (Connection) DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                String sql = "SELECT * FROM authYubi WHERE (uid = '"
                        + uid
                        + "') LIMIT 1";

                Statement stmt = c.createStatement();
                stmt.setFetchSize(10);

                ResultSet rs = stmt.executeQuery(sql);

                if (rs.next()) {
                    yubipre = rs.getString(3);
                }
                //System.out.println("Yubi:" + yubi);
                rs.close();
                stmt.close();

                if (c != null) {
                    try {
                        c.close();
                    } catch (SQLException ex) {
                        Logger.getLogger(yubiauth.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }



            } catch (SQLException ex) {
                Logger.getLogger(yubiauth.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InstantiationException ex) {
                Logger.getLogger(yubiauth.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IllegalAccessException ex) {
                Logger.getLogger(yubiauth.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(yubiauth.class.getName()).log(Level.SEVERE, null, ex);
            }

        if(otp.startsWith(yubipre))
        {
            return true;
        }else
        {
            return false;
        }

    }

    public boolean verify(int uid, String otp) {

        boolean result = false;


        _response = "";


        try {
            URL srv = new URL(YUBICO_AUTH_SRV_URL + _clientId + "&otp=" + otp);
            URLConnection conn = srv.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(
                    conn.getInputStream()));
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                _response += inputLine + "\n";

                if (inputLine.startsWith("status=")) {
                    if (inputLine.equals("status=OK")) {
                        result = true;
                    }
                }
            }

            in.close();
        } catch (Exception e) {
            System.err.println("Error! " + e.getMessage());
        }

        if (result == true && verifyUser(uid, otp)) {
            return true;
        } else {
            return false;
        }

    } // End of verify

    public static void main(String args[]) throws Exception {


        String otp = "riggrdndjufkhrtekfenffiikdgitifcdkcbkctkvgjg";

        yubiauth yc = new yubiauth(1);
        if (yc.verify(2, otp)) {
            System.out.println("\n* OTP verified OK");
        } else {
            System.out.println("\n* Failed to verify OTP");
        }

        System.out.println("\n* Last response:\n" + yc.getLastResponse());

    } // End of main
}
