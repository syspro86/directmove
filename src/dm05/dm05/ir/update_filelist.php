<?

include "lib.php";

$connect = dbConnect();

echo "<html><head><meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>\n";

$result = mysql_query("select * from dm_filelist");
while ($data = mysql_fetch_array($result))
{
	mysql_query("update dm_filelist set score_count=0, last_reg_time=0 where no='$data[no]'");
}

$result = mysql_query("select * from dm_scorelist");
while ($data = mysql_fetch_array($result))
{
	$data2 = mysql_fetch_array(mysql_query("select * from dm_filelist where no='$data[ksf]'"));

	$score_count = $data2[score_count];
	$last_reg_time = $data2[last_reg_time];

	++$score_count;
	if ($last_reg_time < $data[time])
		$last_reg_time = $data[time];

	mysql_query("update dm_filelist set score_count='$score_count', last_reg_time='$last_reg_time' where no='$data[ksf]'");
}

echo "Done!";

?>

