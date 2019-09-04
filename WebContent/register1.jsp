<!DOCTYPE html>
<html>
    <head>
        <title>jQuery Examples</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://freetuts.net/public/javascript/jquery.min.js" ></script>
        <script language="javascript">
            $(document).ready(function(){
                $('#form_register').submit(function(){
                     
                    // Code validate form
                     
                });
            });
        </script>
    </head>
    <body>
        <form method="post" action="" id="form_register">
            <table border="1" cellspacing="0" cellpadding="5">
                <tr>
                    <td>Tên đăng nhập</td>
                    <td>
                        <input type="text" name="username" id="username" value="" />
                        <span id="username_error"></span>
                    </td>
                </tr>
                <tr>
                    <td>Mật khẩu:</td>
                    <td>
                        <input type="password" name="password" id="password" value="" />
                        <span id="password_error"></span>
                    </td>
                </tr>
                <tr>
                    <td>Nhập lại mật khẩu:</td>
                    <td>
                        <input type="password" name="re-password" id="re_password" value="" />
                        <span id="re_password_error"></span>
                    </td>
                </tr>
                <tr>
                    <td>Email:</td>
                    <td>
                        <input type="text" name="email" id="email" value="" />
                        <span id="email_error"></span>
                    </td>
                </tr>
                <tr>
                    <td>Điện thoại:</td>
                    <td>
                        <input type="text" name="phone" id="phone" value="" />
                        <span id="phone_error"></span>
                    </td>
                </tr>
                <tr>
                    <td>Địa chỉ:</td>
                    <td>
                        <input type="text" name="address" id="address" value=""  />
                        <span id="address_error"></span>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" name="register" id="register" value="Đăng ký" /></td>
                </tr>
            </table>
        </form>
    </body>
</html>