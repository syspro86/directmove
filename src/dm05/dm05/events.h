
#pragma once

class CKeyEvent : public CEvent
{
public:
	struct key
	{
		int vk;
		string name;
	};

	bool Initialize(const char* name,...)
	{
		Name = name;
		va_list va;
		va_start(va, name);

		int vk;
		while (vk = va_arg(va, int))
		{
			char* n = va_arg(va, char*);
			key k = {vk, string(n)};
			vKey.push_back(k);
		}
		va_end(va);
		return true;
	}

	bool IsOccured()
	{
		return !vGet.empty();
	}

	bool IsExpired()
	{
		return false;
	}

	void OnDelete()
	{
		vKey.clear();
		vGet.clear();
		delete this;
	}

	const char* GetName()
	{
		return Name.c_str();
	}

	long GetValue()
	{
		if (!vGet.size())
			return 0;

		static char c[1024];
		strcpy(c, vKey[vGet.front()].name.c_str());
		vGet.erase(vGet.begin());
		return (long)c;
	}

	LRESULT WndProc(HWND, UINT msg, WPARAM wParam, LPARAM)
	{
		switch (msg)
		{
			case WM_SYSKEYDOWN:
			case WM_KEYDOWN:
			{
				for (int i=0; i<(int)vKey.size(); ++i)
				{
					if (vKey[i].vk == wParam)
					{
						vGet.push_back(i);
						return 0;
					}
				}
			}
		}
		return 1;
	}

	string Name;
	vector<key> vKey;
	vector<int> vGet;
};
