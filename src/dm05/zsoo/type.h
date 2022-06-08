
#pragma once

struct IRECT : public RECT
{
	IRECT()
	{
		left = top = right = bottom = 0;
	}
	IRECT(int l, int t, int r, int b)
	{
		left = l; top = t; right = r; bottom = b;
	}
};
