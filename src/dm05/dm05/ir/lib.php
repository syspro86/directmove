<?

function dbConnect()
{
	$conn = mysql_connect("ȣ��Ʈ��", "���̵�", "��й�ȣ");
	mysql_select_db("�����ͺ��̽�", $conn);
	return $conn;
}

function uncomp($code)
{
	$src = "";
	$index = 0;
	while (strlen($code) >= 2)
	{
		$strtmp = substr($code, 0, 2);
		$code = substr($code, 2);
		$datatmp = sscanf($datatmp, "%x");
		$datatmp = sscanf($strtmp, "%x");
		$src .= sprintf("%c", $datatmp[0]);
		++$index;
	}
	return gzuncompress($src);
}

?>
