--��Ҷ���
local player = GetClientPlayer()
--Ŀ�����
local target = s_util.GetTarget(player)

s_util.UseEquip(7, 37483)
s_util.UseItem(5, 24779)
if target then
    s_Output("Ŀ�꣺"..tostring(target.nMoveState))
    s_Output(target.dwTeamID)
    s_Output("װ�ܷ֣�"..tostring(target.GetTotalEquipScore()))
    s_Output("װ���֣�"..tostring(target.GetBaseEquipScore()))
    s_Output("������"..tostring(target.nBattleFieldSide))
    s_Output("�������"..tostring(target.nActivityAward))
end

s_Output("�Լ���"..tostring(player.nMoveState))
s_Output(player.dwTeamID)
s_Output("װ�ܷ֣�"..tostring(player.GetTotalEquipScore()))
s_Output("װ���֣�"..tostring(player.GetBaseEquipScore()))
s_Output("������"..tostring(player.nBattleFieldSide))
s_Output("�������"..tostring(player.nActivityAward))

local MinDistance = 20		
local MindwID = 0
local MinHp = 80000		    
for i,v in ipairs(GetAllPlayer()) do		--����
    if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nMoveState ~= MOVE_STATE.ON_DEATH and v.nCurrentLife < MinHp then
        MinHp = v.nCurrentLife
        MindwID = v.dwID
    end
end
if MindwID == 0 then 
    return
else
    SetTarget(TARGET.PLAYER, MindwID)  --�趨Ŀ��
end