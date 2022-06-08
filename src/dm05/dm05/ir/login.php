<?

include "lib.php";

$connect = dbConnect();

$user_id = trim($user_id);
$password = trim($password);

if (!$user_id) die("bad id");
if (!$password) die("bad pw");

$password = md5($password);
$result = mysql_query("select uid from users where name = '$user_id' and pass = '$password'") or die("error");

$member_data = mysql_fetch_array($result);

if ($member_data['uid'])
{
	echo "success";
}
else
{
	echo "failure";
}

?>
