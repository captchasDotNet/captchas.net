# Sample asp Implementation for service http://captchas.net

## Usage
We are providing a ASP module to simplify the task of writing a web application using captchas.net. It is named CaptchasDotNet.asp. To use it, simply copy it into the directory with the ASP-scripts using it. Also you have to download the JavaScript MD5 implementation file md5.js from Paul Johnston (http://pajhome.org.uk/crypt/md5/) and place it in the same directory.

### query
In general the process of using CAPTCHA can be divided into two stages. First you have to query the user for the CAPTCHA, on that page you also usually let the user input the data, which has to be protected, e.g. blog entries.

### check
The second part is to check, whether the user has input the correct letter sequence (as given by the CAPTCHA image or audio). If that is the case the protected operation can be performed. Otherwise the corresponding error message is to be output.

There are two ways, in which a CAPTCHA check can fail. The user can have simply input the wrong letters. But also the random string can have been used more than once. If you would allow a random string to be used multiple times, a human could find out the correct CAPTCHA letter sequence for one random string once and use that information to make a robot post non-human entries to your web application, which still would seem made by a human.
