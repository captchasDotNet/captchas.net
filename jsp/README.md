# Sample jsp Implementation for service http://captchas.net

## Usage
The following query-check-examples shows the usage of CaptchasDotNet.java to use the service captchas.net. 
Note: The sample uses a session, which is handed over by cookies or, if the user has disabled cookies, attached to the url: check.jsp;jsessionid=xyz 
Please test your implementation also with cookies disabled in your Browser.

### query.jsp
In general the process of using a CAPTCHA can be divided into two stages. First you have to query the user for the CAPTCHA, on that page you also usually let the user input the data, which has to be protected.

### check.jsp
The second part is to check, whether the user has input the correct letter sequence (as given by the CAPTCHA image or audio). If that is the case the protected operation can be performed. Otherwise the corresponding error message is to be output.

There are three different ways, in which a CAPTCHA check can fail:

1. The user enters a wrong CAPTCHA Code
2. The user sends the form form more than once, for example if he reloads the check page
3. The session is timed out or is broken for any reason
