#!/usr/bin/env python

#---------------------------------------------------------------------
# Import the necessary modules
#---------------------------------------------------------------------
import CaptchasDotNet
import cgi

#---------------------------------------------------------------------
# Construct the captchas object. Use same Settings as in query.cgi, 
# height and width aren't necessairy
#---------------------------------------------------------------------
captchas = CaptchasDotNet.CaptchasDotNet (
                                client   = 'demo', 
                                secret   = 'secret'#,
                                #alphabet = 'abcdefghkmnopqrstuvwxyz',
                                #letters  = 6
                                )

#---------------------------------------------------------------------
# Validate and verify captcha password
#---------------------------------------------------------------------
def get_body ():
    # Read the form values and keep empty fields.
    form = cgi.FieldStorage(keep_blank_values = True)
    try:
        message = form['message'].value
        password = form['password'].value
        random_string = form['random'].value
    except KeyError:
        # Return an error message, when reading the form values fails.
        return 'Invalid arguments.'

    # Check the random string to be valid and return an error message
    # otherwise.
    if not captchas.validate (random_string):
        return ('Every CAPTCHA can only be used once. The current '
                + 'CAPTCHA has already been used. Try again.')

    # Check, that the right CAPTCHA password has been entered and
    # return an error message otherwise.
    if not captchas.verify (password):
        return ('You entered the wrong password. '
                + 'Please use back button and try again.')

    # Return a success message.
    return ('Your message was verified to be entered by a human '
            + 'and is "%s"' % message)

#---------------------------------------------------------------------
# Print html page
#---------------------------------------------------------------------
print 'Content-Type: text/html'
print
print '''
<html>
  <head>
    <title>Sample Python CAPTCHA Check</title>
  </head>
  <h1>Sample Python CAPTCHA Check</h1>
    %s
</html>
''' % get_body ()
#---------------------------------------------------------------------
# End
#---------------------------------------------------------------------

