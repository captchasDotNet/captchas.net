# Sample Apex Implementation for service http://captchas.net

You can use captchas.net very easily in Oracle APEX 5. See how it works on https://apex.oracle.com/pls/apex/f?p=71787.

## Usage
To use the service, import the application captchas.net.sql to your workspace. Create the following objects from the sample application in your application:

### Shared Components \ Application Items, Application Computations
* CAPTCHA_ALPHABET
* CAPTCHA_CLIENT
* CAPTCHA_LETTERS
* CAPTCHA_RANDOM
* CAPTCHA_SECRET

### Page Designer \ <your form page> Items
* P1_IMAGE
* P1_AUDIO
* P1_PASSWORD

### Page Designer \ Validating \ Validations
* CAPTCHA_VALIDATION

Thats all ...

If all works you can register an account on https://captchas.net/registration/ and replace the values in CAPTCHA_CLIENT and CAPTCHA_SECRET.



