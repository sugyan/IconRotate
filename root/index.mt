<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript" src="http://www.google.com/jsapi"></script>
    <script type="text/javascript">google.load("jquery", "1.4.2");</script>
    <script type="text/javascript">
$(function() {
    $(".loading").each(function() {
        var img = $(this);
        $.ajax({
            url: "/api/rotate?type=" + img.attr("id"),
            success: function(data) {
                img.attr("src", data);
            }
        });
    });
});
    </script>
  </head>
  <body>
    <div class="header">
? if ($c->user) {
      <a href="/signout">Sign out</a>  
? } else {
      <a href="/signin">Sign in</a>  
? }
    </div>
? if ($c->user) {
    <div>
      current profile image:
      <img src="<?= $c->stash->{icon} ?>" />
    </div>
    <div>
      <form method="POST">
        <table>
          <tr>
            <td style="border-right: solid 1px gray;">
              <input type="radio" name="icon" value="rotate1" id="icon1" />
              <label for="icon1"><img class="loading" id="rotate1" src="/img/loading.gif" /></label><br />
            </td>
            <td style="border-right: solid 1px gray;">
              <input type="radio" name="icon" value="rotate2" id="icon2" />
              <label for="icon2"><img class="loading" id="rotate2" src="/img/loading.gif" /></label><br />
            </td>
            <td style="border-right: solid 1px gray;">
              <input type="radio" name="icon" value="rotate3" id="icon3" />
              <label for="icon3"><img class="loading" id="rotate3" src="/img/loading.gif" /></label><br />
            </td>
            <td>
              <input type="radio" name="icon" value="rotate4" id="icon4" />
              <label for="icon4"><img class="loading" id="rotate4" src="/img/loading.gif" /></label><br />
            </td>
          </tr>
        </table>
        <input type="submit" value="change!" />
      </form>
    </div>
? }
  </body>
</html>