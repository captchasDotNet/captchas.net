<?php

require 'CaptchasDotNet.php';

// See query.php for documentation

$captchas = new CaptchasDotNet ('demo', 'secret',
                                '/tmp/captchasnet-random-strings','3600',
                                'abcdefghkmnopqrstuvwxyz','6',
                                '240','80','000088');

// Read the form values
$message       = $_REQUEST['message'];
$password      = $_REQUEST['password'];
$random_string = $_REQUEST['random'];
?>

<html>
  <head>
    <title>Sample PHP CAPTCHA Query</title>
  </head>
  <h1>Sample PHP CAPTCHA Query</h1>

<?php
  // Check the random string to be valid and return an error message
  // otherwise.
  if (!$captchas->validate ($random_string))
  {
    echo 'The session key (random) does not exist, please go back and reload form.<br/>';
    echo 'In case you are the administrator of this page, ';
    echo 'please check if random keys are stored correct.<br/>';
    echo 'See http://captchas.net/sample/php/ "Problems with save mode"';
  }
  // Check, that the right CAPTCHA password has been entered and
  // return an error message otherwise.
  elseif (!$captchas->verify ($password))
  {
    echo 'You entered the wrong password. Aren\'t you human? Please use back button and reload.';
  }
  // Return a success message
  else
  {
    echo 'Your message was verified to be entered by a human and is "' . $message . '"';
  }
?>

</html>

