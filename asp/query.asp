<!--#include file="CaptchasDotNet.asp" -->

<%
  ' Construct the captchas object.
  ' Required Parameters
  ' You receive this values upon registration at http://captchas.net.
  ' client: "demo"
  ' secret: "secret"
  ' Optional Parameters and defaults
  ' repository_prefix: "captchas_net_random/" (path to repository)
  ' cleanup_time: "3600" (max 1 hour between query and check)
  ' alphabet: "abcdefghijklmnopqrstuvwxyz" (Used characters in captcha)
  ' letters: "6" (Number of characters in captcha)
  ' width: "240" (image width)
  ' height: "80" (image height)

  Dim captchas
  Set captchas = CaptchasDotNet ("demo","secret","","","abcdefghkmnopqrstuvwxyz","6","240","80")

  ' We recommend small letters without mistakable ijl:
  ' Set captchas = CaptchasDotNet ("demo","secret","","","abcdefghkmnopqrstuvwxyz","","","")
  ' Don't forget same settings in check.asp
%>

<html>
  <head>
    <title>Sample ASP CAPTCHA Query</title>
  </head>
  <h1>Sample ASP CAPTCHA Query</h1>

  <form method="get" action="check.asp">
    <table>
      <tr>
        <td>
         <!-- Insert the random string as a hidden entry -->
         <input type="hidden" name="random"
            value="<% = captchas.random () %>" />
            Your message:</td><td><input name="message" size="60" />
        </td>
      </tr>
      <tr>
        <td>
          The CAPTCHA password:
        </td>
        <td>
          <input name="password" size="6" />
        </td>
      </tr>
      <tr>
        <td>
        </td>
        <td>
          <!-- Insert the CAPTCHA image and audio link-->
          <%= captchas.image () %>
          <br> <a href="<%= captchas.audio_url () %>">Phonetic spelling (mp3)</a>
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
</html>

<%
  ' Delete the captchas object.
  Set captchas = Nothing
%>

