<?

function dbConnect()
{
	$conn = mysql_connect("호스트명", "아이디", "비밀번호");
	mysql_select_db("데이터베이스", $conn);
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
