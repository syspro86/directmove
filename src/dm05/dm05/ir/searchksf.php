<?

include "lib.php";

$connect = dbConnect();

$result = mysql_query("select * from dm_filelist where crc='$crc'");

$data = mysql_fetch_array($result);

if ($data[no])
{
	echo $data[no];
}
else
{
	echo "-1";
}

?>
