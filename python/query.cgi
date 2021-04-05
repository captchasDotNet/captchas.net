#!/usr/bin/env python

#---------------------------------------------------------------------
# Import the necessary module.
#---------------------------------------------------------------------
import CaptchasDotNet

#---------------------------------------------------------------------
# Construct the captchas object. Replace the required parameters
# 'demo' and 'secret' with the values you receive upon 
# registration at http://captchas.net.
#
# Optional Parameters and Defaults:
#
# alphabet: 'abcdefghkmnopqrstuvwxyz' (Used characters in captcha)
# We recommend alphabet without mistakable ijl.
#
# letters: '6' (Number of characters in captcha)
#
# width: '240' (image width)
# height: '80' (image height)
#
# Don't forget the same settings in check.cgi
#---------------------------------------------------------------------
captchas = CaptchasDotNet.CaptchasDotNet (
                                client   = 'demo', 
                                secret   = 'secret'#,
                                #alphabet = 'abcdefghkmnopqrstuvwxyz',
                                #letters  = 6,
                                #width    = 240,
                                #height   = 80
                                )

#---------------------------------------------------------------------
# Print html page
#---------------------------------------------------------------------
print 'Content-Type: text/html'
print
print '''
<html>
  <head><title>Sample Python CAPTCHA Query</title></head>
  <h1>Sample Python CAPTCHA Query</h1>
  <form method="get" action="check.cgi">
    <table>
      <tr>
        <td>
          <input type="hidden" name="random" value="%s" />
          Your message:</td><td><input name="message" value="Hello World" size="60" />
        </td>
      </tr>
      <tr>
        <td>
          The CAPTCHA password:
        </td>
        <td>
          <input name="password" size="16" />
        </td>
      </tr>
      <tr>
        <td>
        </td>
        <td>
           %s <br>
           <a href="%s">Phonetic spelling (mp3)</a>
        </td>
      </tr>
      <tr>
        <td>
        </td>
        <td>
          <input type="submit" value="Submit" />
        </td>
      </tr>
    </table>
  </form>
</html>
''' % (captchas.random (), captchas.image (), captchas.audio_url ())
#---------------------------------------------------------------------
# End
#---------------------------------------------------------------------

