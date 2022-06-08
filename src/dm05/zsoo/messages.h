
#pragma once

#include <windows.h>

#define WM_ZSOO_USER		(WM_USER+1000) /*
	zsoo의 메시지는 1000개로 잡고 그뒤로.. zsoo게임의 메시지
*/

#define WM_ADDSTATE			(WM_USER+100) /*
	새로운 게임스테이트를 추가한다.
	전송타입 : SendMessage
	wParam : char* 스테이트의 이름
	lParam : CREATEPROC 새 스테이트의 포인터를 얻을 수 있는 함수의 포인터
*/
#define WM_CHANGESTATE		(WM_USER+101) /*
	현재 게임스테이트를 변경한다.
	현재 스테이트를 파괴하고 새로운 스테이트를 생성&초기화한다.
	전송타입 : PostMessage
	wParam : char* 스테이트의 이름
	lParam : 
*/
