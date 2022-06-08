<?

include "lib.php";

$connect = dbConnect();

echo "<html><head><meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>\n"; 

echo "<a href='list.php?list=lastest'>최신 등록</a>";
echo " | ";
echo "<a href='list.php?list=ksflist'>KSF 목록</a>";
echo " | ";
echo "<a href='list.php?list=id'>내 점수</a>";
echo "<br /><br />\n";

if (!$list)
	$list = "lastest";

if (!$page)
	$page = 0;

$list_type = "score";

if ($list == "ksf")
{
	if (!$count) $count = 100;
	if (!$order) $order = "no";
	$result = mysql_query("select * from dm_scorelist where ksf='$ksf' order by $order desc limit $count");

	$result2 = mysql_query("select * from dm_filelist where no='$ksf'");
	$data2 = mysql_fetch_array($result2);
	$title = stripslashes($data2[title]);
	$filename = stripslashes($data2[filename]);
	echo "<h1>$title</h1>\n";
	echo "$filename<br />\n";
	echo "<a href=list.php?list=ksf&ksf=$ksf&order=no>날짜순</a>\n";
	echo "<a href=list.php?list=ksf&ksf=$ksf&order=score>점수순</a>\n";
}
else if ($list == "lastest")
{
	$result = mysql_query("select * from dm_scorelist order by no desc limit 1");
	$data = mysql_fetch_array($result);
	$total = $data[no];
	$page *= 100;
	$result = mysql_query("select * from dm_scorelist order by no desc limit $page, 100");
}
else if ($list == "ksflist")
{
	if (!$order)
		$order = "last_reg_time";
	$result = mysql_query("select * from dm_filelist order by no desc limit 1");
	$data = mysql_fetch_array($result);
	$total = $data[no];
	$page *= 100;
	$result = mysql_query("select * from dm_filelist order by $order desc limit $page, 100");
	$list_type = "ksf";
}
else if ($list == "id")
{
	$member = member_info();
	if (!$member[no]) die("invalid id");
	echo "ID : ".$member[user_id];
	$result = mysql_query("select * from dm_scorelist where id=$member[user_id] order by '$time' desc limit 50");
}
else
{
	die("");
}

echo "<table cellspacing=2 cellpadding=2 width=100% border=1>\n";

$index = 1;
if (!$total)
	$total = 0;
$total = $total / 100;
for ($i = 0; $i < $total; $i++)
{
	echo "<a href=list.php?list=$list&page=$i";
	if ($list == "ksflist")
		echo "&order=$order";
	echo ">$i </a>";
}

while ($data = mysql_fetch_array($result))
{
	if ($list_type == "score")
	{
		echo "<tr>\n<td width=100 bgcolor=black><font color=white>$index</font></td>\n";
		$result2 = mysql_query("select * from dm_filelist where no='$data[ksf]'");
		$data2 = mysql_fetch_array($result2);
		echo "<td><a href=list.php?list=ksf&ksf=$data2[no]>$data2[title]</a></td>\n";
		echo "<td width=200>".date("Y-m-d h:i:s",$data[time])."</td>";
		echo "<td width=300>$data[score] ($data[exorbitant],$data[perfect],$data[great],$data[good],$data[bad],$data[miss])</td>\n";
		echo "<td width=100>$data[maxcombo] combo</td>\n";
		echo "<td width=50>$data[percentage]%</td>\n</tr>\n";
		$name = stripslashes($data[name]);
		$comment = stripslashes($data[comment]);
		echo "<tr>\n<td width=100>$name</td>\n";
		echo "<td colspan=5>$comment</td>\n</tr>\n";
		echo "<tr>\n<td colspan=6 align=right>delete</td>\n</tr>\n";
		++$index;
	}
	else if ($list_type == "ksf")
	{
		if ($index == 1)
		{
			echo "<tr>\n<td width=100 bgcolor=black></td>\n";
			echo "<td><a href=list.php?list=ksflist&order=title>제목</a></td>\n";
			echo "<td width=300><a href=list.php?list=ksflist&order=last_reg_time>최신등록시간</a></td>\n";
			echo "<td width=200><a href=list.php?list=ksflist&order=filename>파일이름</a></td>\n";
			echo "<td width=50><a href=list.php?list=ksflist&order=score_count>등록수</a></td></tr>\n";
		}
		echo "<tr>\n<td width=100 bgcolor=black><font color=white>$index</font></td>\n";
		echo "<td><a href=list.php?list=ksf&ksf=$data[no]>$data[title]</a></td>\n";
		echo "<td width=300>".date("Y-m-d h:i:s",$data[last_reg_time])."</td>";
		echo "<td width=200>$data[filename]</td>\n";
		echo "<td width=50>$data[score_count]</td>\n";
		echo "</tr>\n";
		++$index;
	}
}

echo "</table>";

?>
