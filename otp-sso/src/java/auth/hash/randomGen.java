/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package auth.hash;

/**
 *
 * @author jake
 */

import java.math.BigInteger;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.logging.Level;
import java.util.logging.Logger;


public final class randomGen
{

int passLength = 32;
int totpLength = 16;

  char[] printableAscii = new char[]{'!', '\"', '#', '$', '%', '(', ')', '*', '+', '-', '.', '/', '\'',
            '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', ':', '<', '=', '>', '?', '@',
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
            //'[', '\\', ']', '^', '_', '`', '{', '|', '}', '~',
            'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};


  char[] totpAscii = new char[]{//'!', '\"', '#', '$', '%', '(', ')', '*', '+', '-', '.', '/', '\'',
            '2', '3', '4', '5', '6', '7',// '8', '9', '0', //':', '<', '=', '>', '?', '@',
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
            //'[', '\\', ']', '^', '_', '`', '{', '|', '}', '~',
            //'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
  };

  public String Gen()
  {

    SecureRandom wheel = null;
        try {
            wheel = SecureRandom.getInstance("SHA1PRNG");
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(randomGen.class.getName()).log(Level.SEVERE, null, ex);
        }

    String ret = new String("");
    
    for (int i = 0; i < passLength; i++) {
                    int random = wheel.nextInt(printableAscii.length);
                   ret = new StringBuffer(ret).insert(0, printableAscii[random]).toString();
                }

    return ret;

  }

    public String GenTOTP()
  {

    SecureRandom wheel = null;
        try {
            wheel = SecureRandom.getInstance("SHA1PRNG");
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(randomGen.class.getName()).log(Level.SEVERE, null, ex);
        }

    String ret = new String("");

    for (int i = 0; i < totpLength; i++) {
                    int random = wheel.nextInt(totpAscii.length);
                   ret = new StringBuffer(ret).insert(0, totpAscii[random]).toString();
                }

    return ret;

  }

}


