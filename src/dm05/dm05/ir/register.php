<?

include "lib.php";

$connect = dbConnect();

$scoredata = uncomp($code);

$crc = strtok($scoredata, "\n");
$total = strtok("\n");
$exorbitant = strtok("\n");
$perfect = strtok("\n");
$great = strtok("\n");
$good = strtok("\n");
$bad = strtok("\n");
$miss = strtok("\n");
$maxcombo = strtok("\n");
$percentage = strtok("\n");
$fade = strtok("\n");
$rush = strtok("\n");
$random = strtok("\n");
$xxx = strtok("\n");
$id = strtok("\n");
$name = strtok("\n");
$comment = strtok("\n");
$time = time();
$comment = str_replace("<", "&lt;", $comment);

$name = addslashes($name);
$comment = addslashes($comment);

$result = mysql_query("select * from dm_filelist where crc='$crc'");
$data = mysql_fetch_array($result);

if ($data[no])
{
	mysql_query("insert into dm_scorelist (time, id, name, ksf, score, exorbitant, perfect, great, good, bad, miss, maxcombo, percentage, mode_fade, mode_rush, mode_random, mode_unknown, comment) values('$time', '$id', '$name', '$data[no]', '$total', '$exorbitant', '$perfect', '$great', '$good', '$bad', '$miss', '$maxcombo', '$percentage', '$fade', '$rush', '$random', '$xxx', '$comment')");

	$data2 = mysql_fetch_array(mysql_query("select * from dm_filelist where no='$data[ksf]'"));

	$score_count = $data2[score_count];
	++$score_count;

	mysql_query("update dm_filelist set score_count='$score_count', last_reg_time='$time' where no='$data[no]'");
}

?>
