<%--
 % Example for using the Webservice http://captchas.net 
 % Replace the required parameters 'demo' and 'secret' with the
 % values you receive upon http://captchas.net/registration/ .
 % 
 % Optional Parameters and Defaults:
 % 
 % alphabet: abcdefghkmnopqrstuvwxyz (Used characters in captcha)
 % We recommend alphabet without mistakable ijl
 % 
 % letters: 6 (Number of characters in captcha)
 % 
 % width: 240 (image width)
 % height: 80 (image height)
 % 
 % Don't forget the same settings in check.jsp
 --%>

<%@ page language="java" import="captchas.CaptchasDotNet" %>

<html>
  <head>
    <title>Sample JSP CAPTCHA Query</title>
  </head>
  <h1>Sample JSP CAPTCHA Query</h1>
<%
// Construct the captchas object (Default Values)
CaptchasDotNet captchas = new captchas.CaptchasDotNet(
  request.getSession(true),     // Ensure session
  "demo",                       // client
  "secret"                      // secret
  );
// Construct the captchas object (Extended example)
// CaptchasDotNet captchas = new captchas.CaptchasDotNet(
//  request.getSession(true),     // Ensure session
//  "demo",                       // client
//  "secret",                     // secret
//  "01",                         // alphabet
//  16,                           // letters
//  500,                          // width
//  80                            // height
//  );
%>
  <%-- 
   % encodeUrl produces jsessionid=xyz in case of disabled cookies
   % Please test your implementation also with disabled cookies
   --%>
  <form method="get" action="<%=response.encodeUrl("check.jsp")%>">
    <table>
      <tr>
        <td>
          Your message:</td><td><input name="message" size="60" />
        </td>
      </tr>
      <tr>
        <td>
          The CAPTCHA password:
        </td>
        <td>
          <input name="password" size="16" />
        </td>
      </tr>
      <tr>
        <td>
        </td>
        <td>
          <%-- 
           % it's possible to set a random in captchas.image("xyz"),
           % captchas.imageUrl("xyz") and captchas.audioUrl("xyz").
           % This is only needed at the first request
           --%>
          <%= captchas.image() %><br>
          <a href="<%= captchas.audioUrl() %>">Phonetic spelling (mp3)</a>
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
