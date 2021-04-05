<!--

// ASP module for easy utilization of the free captchas.net CAPTCHA service
//
// To use this module you have to download the JavaScript MD5 module
// from Paul Johnston at http://pajhome.org.uk/crypt/md5/md5.js and
// place it in the same directory as this file.
//
// For documentation look at http://captchas.net/sample/asp/
//
// Written by
//   Sebastian Wilhelmi <seppi@seppi.de>
//   Felix Holderied <felix@holderied.de>
//
// This file is in the public domain.
//
// ChangeLog:
//
// 2006-03-03: Initial version.
// 2006-08-16: Add new optional parameters and audio url
//

-->

<script language="JScript" src="md5.js" runat="Server">
  // Include the md5.js module providing the needed str_md5 function
</script>

<script language="JScript" runat="Server">
  function CaptchasDotNetClass (client, secret,
                                repository_prefix, cleanup_time,
                                alphabet, letters,
                                width, height)
  {
    // Required parameters, Default "demo", "secret"

    this.__client = client;
    this.__secret = secret;

    // Optional parameters

    // path to repository "captchas_net_random/"
    this.__repository_prefix = "captchas_net_random/";
    if (repository_prefix) this.__repository_prefix = repository_prefix;

    // generate time stamp
    this.__time_stamp_name =  this.__repository_prefix + "__time_stamp__";

    // cleanup time Default 3600 seconds = 1 hour
    // Maximum time between requesting form and sending form
    this.__cleanup_time = 3600;
    if (cleanup_time) this.__cleanup_time = cleanup_time;

    // characters and ciphers used in Captcha
    this.__alphabet = "abcdefghijklmnopqrstuvwxyz";
    if (alphabet) this.__alphabet = alphabet;

    // number of letters in captcha
    this.__letters = 6;
    if (letters) this.__letters = letters;

    // width and height of image
    this.__width  = 240;
    this.__height =  80;
    if (width)  this.__width  = width;
    if (height) this.__height = height;

    // Create a new random string and register it.
    this.random = function ()
    {
      // The random string shall consist of small letters, big letters
      // and digits.
      var random_string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

      // The random starts out empty, then 40 random possible
      // characters are appended.
      var result = "";
      for (var i = 0; i < 40; i++)
        result += random_string.charAt (Math.random () * random_string.length);

      // Get the current time in seconds.
      var now = new Date ().getTime () / 1000;

      // Determine the time, before which to remove random strings.
      var cleanup_time = now - this.__cleanup_time;

      // If the time stamp variable does not yet exist, create it.
      if (!Application (this.__time_stamp_name))
        Application (this.__time_stamp_name) = now;

      // If the last cleanup is older than specified, cleanup the
      // application variables.
      if (Application (this.__time_stamp_name) < cleanup_time)
      {
        // Loop over all application variables.
        var contents = new Enumerator (Application.Contents);
        for (; !contents.atEnd(); contents.moveNext ())
        {
          // If the application variable is from our random string
          // repository and is older than the cleanup time, remove it.
          var key = contents.item ();
          if (key.substr (0, this.__repository_prefix.length)
              == this.__repository_prefix)
            if (Application (key) < cleanup_time)
              Application.Contents.Remove (key);
        }
      }

      // Add the new random string to the application variable
      // repository.
      Application (this.__repository_prefix + result) = now;

      // Return the successfully registered random string.
      this.__random = result;
      return result;
    }

    // image url The random
    // argument is optional and taken from the last random() call, if not present.
    this.image_url = function (random, image_base)
    {
      if (!random)
        random = this.__random;
      if (!image_base)
        image_base = "http://image.captchas.net/";
      // add parameters
      image_base = image_base + "?client=" + this.__client + "&random=" + this.__random;
      if (this.__alphabet != "abcdefghijklmnopqrstuvwxyz")
        image_base = image_base + "&alphabet=" + this.__alphabet;
      if (this.__letters != 6)
        image_base = image_base + "&letters=" + this.__letters;
      if (this.__height != 80)
        image_base = image_base + "&height=" + this.__height;
      if (this.__width != 240)
        image_base = image_base + "&width=" + this.__width;
      return image_base
    }

    // audio url
    // same as image, but with other base and without height and width
    this.audio_url = function (random, audio_base)
    {
      if (!random)
        random = this.__random;
      if (!audio_base)
        audio_base = "http://audio.captchas.net/";
      // add parameters
      audio_base = audio_base + "?client=" + this.__client + "&random=" + this.__random;
      if (this.__alphabet != "abcdefghijklmnopqrstuvwxyz")
        audio_base = audio_base + "&alphabet=" + this.__alphabet;
      if (this.__letters != 6)
        audio_base = audio_base + "&letters=" + this.__letters;
      return audio_base;
    }

    // Return a fault-tolerant image HTML snippet. The random argument
    // is optional and taken from the last random() call, if not
    // present.
    this.image = function (random, id)
    {
      if (!random) random = this.__random;
      if (!id) id = 'captchas.net';

      // Return the corresponding HTML snippet. Some tricks has to be
      // used to make ASP accept this embedded script. Be very careful
      // when touching this!
      return '<a href="http://captchas.net"><img '
        + 'style="border: none; vertical-align: bottom" id="' + id
        + '" src="' + this.image_url (random) +'" width="' + this.__width
        + '" height="' + this.__height + '" alt="The CAPTCHA image" /></a>'
        + '<' + 'script type="text/javascript">\n'
        + '<' + '!--\n'
        + '  function captchas_image_error (image)\n'
        + '  {\n'
        + '    if (!image.timeout) return true;\n'
        + '    image.src = image.src.replace (\n'
        + '                     /^http:\\/\\/image\\.captchas\\.net/,\n'
        + '                     \'http://image.backup.captchas.net\');\n'
        + '    return captchas_image_loaded (image);\n'
        + '  }\n'
        + '\n'
        + '  function captchas_image_loaded (image)\n'
        + '  {\n'
        + '    if (!image.timeout) return true;\n'
        + '    window.clearTimeout (image.timeout);\n'
        + '    image.timeout = false;\n'
        + '    return true;\n'
        + '  }\n'
        + '\n'
        + '  var image = document.getElementById (\'' + id + '\');\n'
        + '  image.onerror = function()\n'
        + '    {return captchas_image_error (image);};\n'
        + '  image.onload = function()\n'
        + '    {return captchas_image_loaded (image);};\n'
        + '  image.timeout\n'
        + '    = window.setTimeout(\n'
        + '       "captchas_image_error ('
        + '         document.getElementById (\'' + id + '\'))",\n'
        + '       10000);\n'
        + '  image.src = image.src;\n'
        + '  //--' + '>\n'
        + '<' + '/script>'
    }

    // Validate, that the given random string has not been used
    // before.
    this.validate = function (random)
    {
      this.__random = random;

      // Find out, whether the corresponding entry in the application
      // variable repository exists. If so, store it for later
      // removal and return with success, else without success.
      var key = this.__repository_prefix + random;
      if (Application (key))
      {
	this.__repository_key = key;
        return true;
      }
      else
      {
        return false;
      }
    }

    // Verify, that the given input is correct. The random argument is
    // optional and taken from the last validate() call, if not
    // present.
    this.verify = function (input, random)
    {
      // Get the random string, if not provided.
      if (!random) random = this.__random;

      // Force input to be a JScript string. Needed to apply String
      // methods.
      input = String (input);

      // The format of the password. Never change this.

      // If the user input has the wrong length, the input can't be
      // correct.
      if (input.length != this.__letters)
        return false;

      // Calculate the MD5 digest of the concatenation of secret key
      // and random string.

      var encryption_base = this.__secret + random;
      if ((this.__alphabet != "abcdefghijklmnopqrstuvwxyz") || (this.__letters != "6"))
        encryption_base = encryption_base + ":" + this.__alphabet + ":" + this.__letters;
      var md5 = str_md5 (encryption_base);

      // Check the password according to the rules from the first 6
      // positions of the digest.
      for(var pos = 0; pos < this.__letters; pos++)
      {
        var letter_num = md5.charCodeAt (pos) % this.__alphabet.length;
        // If the letter at the current position is wrong, the user
        // input isn't correct.
	if (input.charAt (pos) != this.__alphabet.charAt (letter_num))
	  return false;
      }

      // Remove the correspondig random file, if it exists.
      if (this.__repository_key)
      {
        Application.Contents.Remove (this.__repository_key);
        delete this.__repository_key;
      }

      // The user input was correct.
      return true;
    }
  }

  // Return an CaptchasDotNetClass object. This is necessary, as
  // VBScript does not allow constructors to have arguments.
  function CaptchasDotNet (client, secret, repository_prefix, cleanup_time, alphabet, letters, width, height)
  {
    return new CaptchasDotNetClass (client, secret,
                                    repository_prefix, cleanup_time,
                                    alphabet, letters,
                                    width, height);
  }
</script>
