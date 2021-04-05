# Sample perl Implementation for service http://captchas.net

Our perl sample is based on a module kindly published by Geoffrey Young (https://metacpan.org/author/GEOFF) on CPAN.
The original version (https://metacpan.org/release/WebService-CaptchasDotNet) don't use optional parameters alphabet, letters, width and height. If you want to upgrade, you have to uninstall the old module.

See how it works on http://captchas.net/sample/perl/query.cgi

## Usage
To use it drop the file WebService/CaptchasDotNet.pm into a new subdirectory WebService in the directory containing the files using the module.

### query.cgi
In general the process of using CAPTCHA can be divided into two stages. First you have to query the user for the CAPTCHA, on that page you also usually let the user input the data, which has to be protected, e.g. blog entries.

### check.cgi
The second part is to check, whether the user has input the correct letter sequence (as given by the CAPTCHA image or audio). If that is the case the protected operation can be performed. Otherwise the corresponding error message is to be output.

There are two ways, in which a CAPTCHA check can fail. The user can have simply input the wrong letters. But also the random string can have been used more than once. If you would allow a random string to be used multiple times, a human could find out the correct CAPTCHA letter sequence for one random string once and use that information to make a robot post non-human entries to your web application, which still would seem made by a human.
