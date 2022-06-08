<?

include "lib.php";

$connect = dbConnect();

$ksfdata = uncomp($code);

$title = strtok($ksfdata, "\n");
$path = strtok("\n");
$crc = strtok("\n");
$stepcount = strtok("\n");
$title = addslashes($title);
$path = addslashes($path);

mysql_query("insert into dm_filelist (title, filename, crc, stepcount) values('$title', '$path', '$crc', '$stepcount')");

?>
