#!/usr/bin/perl

#---------------------------------------------------------------------
# Import the necessary module.
#---------------------------------------------------------------------
use WebService::CaptchasDotNet;

#---------------------------------------------------------------------
# Construct the captchas object. Replace the required parameters
# 'demo' and 'secret' with the values you receive upon 
# registration at http://captchas.net.
#
# Optional Parameters and Defaults:
#
# alphabet: 'abcdefghijklmnopqrstuvwxyz' (Used characters in captcha)
# We recommend alphabet without ijl: 'abcdefghkmnopqrstuvwxyz'
#
# letters: '6' (Number of characters in captcha)
#
# width: '240' (image width)
# height: '80' (image height)
#
# Don't forget the same settings in check.cgi
#---------------------------------------------------------------------
my $captchas = WebService::CaptchasDotNet->new(
                                 client   => 'demo',
                                 secret   => 'secret'#,
                                 #alphabet => 'abcdefghkmnopqrstuvwxyz',
                                 #letters => 6,
                                 #width   => 240,
                                 #height  => 80,
                                 );
my $random     = $captchas->random;
my $image_url  = $captchas->image_url;
my $audio_url  = $captchas->audio_url;
my $image      = $captchas->image;

#---------------------------------------------------------------------
# Print html page
#---------------------------------------------------------------------
print "Content-Type: text/html\n\n";
print '<html>
<head>
  <title>Sample Perl CAPTCHA Query</title>
</head>
  <h1>Sample Perl CAPTCHA Query</h1>
  <form method="get" action="check.cgi">
    <table>
      <tr>
        <td>
          <input type="hidden" name="random" value="' .$random. '" />
          Your message:</td><td><input name="message" size="60" />
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
          ' . $image . '<a href="javascript:captchas_image_reload(\'captchas.net\')">Reload Image</a>
          <br> <a href="' . $audio_url . '">Phonetic spelling (mp3)</a>
          <br> <a href="' . $audio_url . '&language=de">Buchstabieren (mp3)</a>
          <br> <a href="' . $audio_url . '&language=it">Compitare (mp3)</a>
          <br> <a href="' . $audio_url . '&language=nl">Spellen (mp3)</a>
          <br> <a href="' . $audio_url . '&language=fr">Epeler (mp3)</a>
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
</html>';
#---------------------------------------------------------------------
# End
#---------------------------------------------------------------------

