--��Ҷ���
local player = GetClientPlayer()
--Ŀ�����
local target = s_util.GetTarget(player)


--s_util.UseItem(5, 24779)
--[[if target then
    s_Output("Ŀ�꣺"..tostring(target.szName))
    s_Output("Ŀ���ķ���"..tostring(near_zhiliao1))
    s_Output("Ŀ��װ�ܷ֣�"..tostring(target.GetTotalEquipScore()))
    s_Output("Ŀ��װ���֣�"..tostring(target.GetBaseEquipScore()))
    s_Output("Ŀ��������"..tostring(target.nActivityAward))
    GetClientTeam().SetTeamMark(1, target.dwID)
end--]]

local MinDistance = 20		
local MindwID = 0
local MinHp = 80000		    
for i,v in ipairs(GetAllPlayer()) do		--����
    if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nMoveState ~= MOVE_STATE.ON_DEATH and v.nCurrentLife < MinHp then
        MinHp = v.nCurrentLife
        MindwID = v.dwID
    end
    local Buff = s_util.GetBuffInfo(v)
    if  Buff and Buff[112] then
        local fID = Buff[112].dwSkillSrcID
        s_Output(tostring(v.szName).."("..tostring(v.dwID)..")������Buff����Դ�ڣ�"..tostring(fID))
    end
end
if MindwID == 0 then 
    return
else
    SetTarget(TARGET.PLAYER, MindwID)  --�趨Ŀ��
end