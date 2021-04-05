<!--#include file="CaptchasDotNet.asp" -->

<%
  ' Construct the captchas object. Replace 'demo' and 'secret' with
  ' the values you receive upon registration at http://captchas.net.
  Dim captchas
  ' Next line has to be the same as in query.asp
  Set captchas = CaptchasDotNet ("demo","secret","","","abcdefghkmnopqrstuvwxyz","6","240","80")
%>

<html>
  <head>
    <title>Sample ASP CAPTCHA Check</title>
  </head>
  <h1>Sample ASP CAPTCHA Check</h1>

  <p>
    <!-- Check the random string to be valid and print an error
         message otherwise. If you use POST instead of GET, you have
         to replace Request.QueryString by Request.Form -->
    <% If Not captchas.validate (Request.QueryString("random")) Then %>
      Every CAPTCHA can only be used once. The current CAPTCHA has already
      been used. Try again.
    <!-- Check that the right CAPTCHA password has been entered and print
         an error message otherwise -->
    <% ElseIf Not captchas.verify (Request.QueryString("password"), Request.QueryString("random")) Then %>
      You entered the wrong password. Please use back button and reload.
    <!-- Otherwise print success message -->
    <% Else %>
      Your message was verified to be entered by a human and is
      "<%= Request.QueryString("message") %>".
    <% End If %>
  </p>

</html>

<%
  ' Delete the captchas object.
  Set captchas = Nothing
%>

