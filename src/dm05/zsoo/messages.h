
#pragma once

#include <windows.h>

#define WM_ZSOO_USER		(WM_USER+1000) /*
	zsoo�� �޽����� 1000���� ��� �׵ڷ�.. zsoo������ �޽���
*/

#define WM_ADDSTATE			(WM_USER+100) /*
	���ο� ���ӽ�����Ʈ�� �߰��Ѵ�.
	����Ÿ�� : SendMessage
	wParam : char* ������Ʈ�� �̸�
	lParam : CREATEPROC �� ������Ʈ�� �����͸� ���� �� �ִ� �Լ��� ������
*/
#define WM_CHANGESTATE		(WM_USER+101) /*
	���� ���ӽ�����Ʈ�� �����Ѵ�.
	���� ������Ʈ�� �ı��ϰ� ���ο� ������Ʈ�� ����&�ʱ�ȭ�Ѵ�.
	����Ÿ�� : PostMessage
	wParam : char* ������Ʈ�� �̸�
	lParam : 
*/
