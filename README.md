# captchas.net
Open Source samples for Service http://captchas.net

## How to use our samples
If you are not very familiar in programming, we recommend the following approach, independent from your programming language. You need access to the source code of your application. Assuming you have a running form script, a guestbook, a mail form or another form without captcha and want to integrate our service, the easiest way is to go through the following steps:

1. Install our sample files query, check and CaptchasDotNet on your server and get them run correctly.
2. Read and try to understand the query and the check files and, if not written by yourself, your application code. You don't need to get through our CaptchasDotNet module.
3. Copy the relevant query code into your form. As soon as you are familiar with query, you will be able to identify the relevant lines. Check your script after every step.
4. Go through the same procedure with the check file. Additionally, you have to adjust the error handling (User entered wrong Code) to your application. This is the most difficult part of the implementation.
5. Register for our service on https://captchas.net/registration/ and replace "demo" and "secret" with the values, received by mail.

## Known Problems
In some applications, the form is static html (e.g. form.html) while the receiving script is dynamic (e.g. request.php). As our images need to be generated dynamically, this would prevent our sample from running. There are possibilities to deal with the problem:

1. Convert form.html to form.php, if possible.
2. Run the captcha validation in a second step. Don't change form.html. If no captcha code is submitted, change request.php (or cgi, pl ...) to show only our captcha image and the code form. Hand all parameters over into hidden fields.

If you have any further question or if you want to report any bugs, please tell us the first steps, where the problem occurs.
