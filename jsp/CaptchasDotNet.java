/**
 * JSP module for easy utilization of the free captchas.net CAPTCHA 
 * service
 * 
 * For documentation see http://captchas.net/sample/jsp/ .
 * 
 * Written by Felix Holderied <felix@holderied.de>
 *
 * This file is in the public domain.
 *
 * ChangeLog:
 *
 * 2006-09-21: Initial version.
 */

package captchas;

import java.io.*;
import java.util.Random;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.servlet.http.*;

public class CaptchasDotNet {
  // Required Parameters
  private String client;
  private String secret;
  // Optional parameters and defaults
  final String ALPHABET_RECOMMENDED = "abcdefghkmnopqrstuvwxyz";
  // Default-Values from image and audio implementation
  final String ALPHABET_DEFAULT = "abcdefghijklmnopqrstuvwxyz";
  final int LETTERS_DEFAULT = 6;
  final int WIDTH_DEFAULT = 240;
  final int HEIGHT_DEFAULT = 80;
  private String alphabet = ALPHABET_RECOMMENDED;
  private int letters = LETTERS_DEFAULT;
  private int width = WIDTH_DEFAULT;
  private int height = HEIGHT_DEFAULT;
  // Session handling
  private HttpSession httpSess;
  // The current random
  private String captchaRandom = "";

  /**
   * Constructor 
   */
  // only required parameters
  public CaptchasDotNet(HttpSession httpSess, 
                        String client, 
                        String secret) {
    this.httpSess = httpSess;
    this.client   = client;
    this.secret   = secret;
  } 
  // additional alphabet, letters
  public CaptchasDotNet(HttpSession httpSess, 
                        String client, 
                        String secret,
                        String alphabet,
                        int letters) {
    this.httpSess = httpSess;
    this.client   = client;
    this.secret   = secret;
    this.alphabet = alphabet;
    this.letters  = letters;
    this.width    = width;
    this.height   = height;
  } 
  // additional alphabet, letters, width, height
  public CaptchasDotNet(HttpSession httpSess, 
                        String client, 
                        String secret,
                        String alphabet,
                        int letters,
                        int width,
                        int height) {
    this.httpSess = httpSess;
    this.client   = client;
    this.secret   = secret;
    this.alphabet = alphabet;
    this.letters  = letters;
    this.width    = width;
    this.height   = height;
  } 

  /**
   * The first objects are needed in the query phase 
   */

  /**
   * Generate 8 byte hexrandom and set captchasDotNetRandom
   */
  private String randomString() {
    Random r = new Random();
    captchaRandom = Integer.toHexString(r.nextInt())+Integer.toHexString(r.nextInt());
    httpSess.setAttribute("captchasDotNetRandom", captchaRandom);
    return captchaRandom;
  }

  /**
   * Generate image url with parameters
   */
  public String imageUrl() {
    // Check if random already exists or is used
    if (captchaRandom=="" || captchaRandom=="used") {
      captchaRandom = randomString();
    }
    String url = "http://image.captchas.net/";
    // Required parameters
    url += "?client=" + client;
    url += "&random=" + captchaRandom;
    // Optional parameters 
    if (!alphabet.equals(ALPHABET_DEFAULT)) {
      url += "&alphabet=" + alphabet;
    }
    if (letters!=LETTERS_DEFAULT) {
      url += "&letters=" + letters;
    }
    if (width!=WIDTH_DEFAULT) {
      url += "&width=" + width;
    }
    if (height!=HEIGHT_DEFAULT) {
      url += "&height=" + height;
    }
    return url;
  }
  // the same with random
  public String imageUrl(String randomString) {
    captchaRandom = randomString;
    httpSess.setAttribute("captchasDotNetRandom", captchaRandom);
    return imageUrl();
  }

  /**
   * Generate audio url with parameters
   * same as image url without width and height
   */
  public String audioUrl() {
    if (captchaRandom=="" || captchaRandom=="used") {
      captchaRandom = randomString();
    }
    String url = "http://audio.captchas.net/";
    url += "?client=" + client;
    url += "&random=" + captchaRandom;
    if (!alphabet.equals(ALPHABET_DEFAULT)) {
      url += "&alphabet=" + alphabet;
    }
    if (letters!=LETTERS_DEFAULT) {
      url += "&letters=" + letters;
    }
    return url;
  }
  // the same with random
  public String audioUrl(String randomString) {
    captchaRandom = randomString;
    httpSess.setAttribute("captchasDotNetRandom", captchaRandom);
    return audioUrl();
  }

  /**
   * Generate complete image code with javascript for fault tolerant image loading
   */
  public String image() {
    StringBuffer imageCode = new StringBuffer();
    imageCode.append("<a href=\"http://captchas.net\"><img style=\"border: none; vertical-align: bottom\" ");
    imageCode.append("id=\"captchas.net\" src=\"" + imageUrl() + "\" "); 
    imageCode.append("width=\"" + width + "\" height=\"" + height + "\" "); 
    imageCode.append("alt=\"The CAPTCHA image\" /></a> \n");
    imageCode.append("<script type=\"text/javascript\">\n");
    imageCode.append("  <!--\n");
    imageCode.append("  function captchas_image_error (image)\n");
    imageCode.append("  {\n");
    imageCode.append("    if (!image.timeout) return true;\n");
    imageCode.append("    image.src = image.src.replace (/^http:\\/\\/image\\.captchas\\.net/,\n");
    imageCode.append("                                'http://image.backup.captchas.net');\n");
    imageCode.append("    return captchas_image_loaded (image);\n");
    imageCode.append("  }\n\n");
    imageCode.append("  function captchas_image_loaded (image)\n");
    imageCode.append("  {\n");
    imageCode.append("    if (!image.timeout) return true;\n");
    imageCode.append("    window.clearTimeout (image.timeout);\n");
    imageCode.append("    image.timeout = false;\n");
    imageCode.append("    return true;\n");
    imageCode.append("  }\n\n");
    imageCode.append("  var image = document.getElementById ('captchas.net');\n");
    imageCode.append("  image.onerror = function() {return captchas_image_error (image);};\n");
    imageCode.append("  image.onload = function() {return captchas_image_loaded (image);};\n");
    imageCode.append("  image.timeout \n");
    imageCode.append("    = window.setTimeout(\n");
    imageCode.append("    \"captchas_image_error (document.getElementById ('captchas.net'))\",\n");
    imageCode.append("    10000);\n");
    imageCode.append("  image.src = image.src;\n");
    imageCode.append("  //--> \n");
    imageCode.append("</script>\n");
    return imageCode.toString();
  }
  // the same with random
  public String image(String randomString) {
    captchaRandom = randomString;
    httpSess.setAttribute("captchasDotNetRandom", captchaRandom);
    return image();
  }

  /**
   * And this is for the check phase 
   */


  /**
   * Check the CAPTCHA code 
   * Returns 3 errors codes s, m, w and t if successfull
   */
  public char check(String password) {
    captchaRandom = "" + httpSess.getAttribute("captchasDotNetRandom");
 
    // check if 's'ession object "captchasDotNetRandom" exists
    if (captchaRandom.equals("null")) {
      return 's';
    }
    // check if the captcha is used 'm'ore than once
    if (captchaRandom.equals("used")) {
      return 'm';
    }

    // Compute the correct password
    String encryptionBase = secret + captchaRandom;
    if (!alphabet.equals(ALPHABET_DEFAULT) || letters!=LETTERS_DEFAULT) {
      encryptionBase += ":" + alphabet + ":" + letters;
    }
    MessageDigest md5;
    byte[] digest = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}; 
    try {
      md5 = MessageDigest.getInstance("MD5");
      md5.update(encryptionBase.getBytes());
      digest = md5.digest();
    } catch (NoSuchAlgorithmException e) {
    }
    String correctPassword = "";
    int index;
    for (int i=0; i<letters; i++) {
      index = (digest[i]+256)%256%alphabet.length();
      correctPassword += alphabet.substring(index, index+1);
    }
    // Check if password is correct
    if (!password.equals(correctPassword)) {
      // 'w'rong Password
      return 'w';
    } else {
      // invalidate used captcha random
      httpSess.setAttribute("captchasDotNetRandom", "used");
      // 't'rue
      return 't';
    }
  }
}
