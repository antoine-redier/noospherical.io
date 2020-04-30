defmodule NoosphericalWeb.Email do
  import Bamboo.Email

  def recovery_email(user) do
    token = Phoenix.Token.sign(NoosphericalWeb.Endpoint, "salt", user.uuid)

    new_email(
      from: "NOOSPHERICAL <mailgun@mg.noospherical.io>",
      to: user.email,
      subject: "Password recovery",
      html_body:
        "
      <h2 class='code-line' data-line-start=0 data-line-end=1 ><a id='Reset_your_password_0'></a><strong>Reset your password?</strong></h2>
      <p class='has-line-data' data-line-start='2' data-line-end='3'>If you requested a password reset for <strong><em>@#{
          user.username
        }</em></strong>, click on the link below. If you didn’t make this request, ignore this email.</p>
      <h3 class='code-line' data-line-start=4 data-line-end=5 ><a id='RESET_PASSWORDhttpsnoosphericaliorecovertoken_4'></a><strong><a href='https://noospherical.io/recover/#{
          token
        }'>RESET PASSWORD</a></strong></h3>",
      text_body: "
      Reset your password?

      If you requested a password reset for @#{user.username}, click on the link below. If you didn't make this request, ignore this email.

      https://noospherical.io/recover/#{token}"
    )
  end

  def welcome_email(user) do
    new_email(
      from: "NOOSPHERICAL <mailgun@mg.noospherical.io>",
      to: user.email,
      subject: "Welcome to noospherical.io",
      html_body:
        "<h2 class='code-line' data-line-start=0 data-line-end=1 ><a id='Welcome_userusername_0'></a><strong>Welcome, #{
          user.username
        }.</strong></h2>
<blockquote>
<p class='has-line-data' data-line-start='2' data-line-end='3'>Thank you for joining in today! Maybe you’re wondering where to go from here.</p>
</blockquote>
<ul>
<li class='has-line-data' data-line-start='4' data-line-end='6'>
<p class='has-line-data' data-line-start='4' data-line-end='5'>You can already take a look at your brand-new profile <a href='https://noospherical.io/users/#{
          user.uuid
        }'>right here</a> and edit it to your liking.</p>
</li>
<li class='has-line-data' data-line-start='6' data-line-end='8'>
<p class='has-line-data' data-line-start='6' data-line-end='7'>Be sure to check out our <a href='https://noospherical.io/articles'>articles</a> and <a href='https://noospherical.io/videos'>videos</a> and tell us what you thought of them!</p>
</li>
<li class='has-line-data' data-line-start='8' data-line-end='10'>
<p class='has-line-data' data-line-start='8' data-line-end='9'>This website is still in-development. If you encounter some bugs or problems, don’t hesitate to issue them on the <a href='https://github.com/antoine-redier/noospherical.io'>GitHub repository</a>.</p>
</li>
<li class='has-line-data' data-line-start='10' data-line-end='12'>
<p class='has-line-data' data-line-start='10' data-line-end='11'>If you’re interested in the project and would like to participate in any way, be it on the content or development side, don’t be shy — contact me directly via my twitter account <a href='https://twitter.com/noospherical'>@noospherical</a>.</p>
</li>
</ul>
<p class='has-line-data' data-line-start='12' data-line-end='13'>Best,</p>
<p class='has-line-data' data-line-start='14' data-line-end='16'><strong>Antoine Redier</strong><br>
— <em><a href='http://noospherical.io'>noospherical.io</a>'s creator</em> —</p>",
      text_body:
        "
Welcome, #{user.username}.

Thank you for joining in today! Maybe you're wondering where to go from here.

- You can already take a look at your brand-new profile (https://noospherical.io/users/#{
          user.uuid
        }) and edit it to your liking.

- Be sure to check out our articles (https://noospherical.io/articles) and  videos (https://noospherical.io/videos) and tell us what you thought of them!

- This website is still in-development. If you encounter some bugs or problems, don't hesitate to issue them on the  GitHub repository (https://github.com/antoine-redier/noospherical.io).

- If you're interested in the project and would like to participate in any way, be it on the content or development side, don't be shy --- contact me directly via my twitter account (https://twitter.com/noospherical).

Best,

Antoine Redier,
--- noospherical.io's creator ---"
    )
  end
end
