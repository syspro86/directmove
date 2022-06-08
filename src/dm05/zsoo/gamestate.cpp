
#include "zsoo.h"
#include "gamestate.h"

void CGameState::AddEvent(CEvent* p)
{
	m_vpEvent.push_back(p);
}
