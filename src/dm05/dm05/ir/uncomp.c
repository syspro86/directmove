
#include <stdio.h>
#include <string.h>
#include <zlib.h>

int main(int argc, char* argv[])
{
	char buffer[1024] = {0};
	char buffer2[1024] = {0};
	char* data;
	unsigned long length;
	unsigned long len;

	if (argc != 2)
		return -1;

	data = argv[1];
	len = 0;
	while (*data)
	{
		sscanf(data, "%2x", &buffer2[len]);
		data += 2;
		++len;
	}
	buffer2[len] = 0;

	printf("%s", buffer2);
	uncompress(buffer, &length, buffer2, len);
	printf("%s", buffer);
}

