# Sample PHP Implementation for service http://captchas.net

See how it works on http://holderied.com/query.php

## Problems with Safe Mode
If your webserver starts PHP-scripts in the safe mode, you will not be able to leave the default path to the random string repository unchanged. Instead use a name in a directory, which the owner of the PHP-script owns:

    require 'CaptchasDotNet.php';
    ...
    $captchas = new CaptchasDotNet ('demo', 'secret', '/writable/path/captchasnet-random-strings');
    ...
