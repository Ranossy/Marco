--��Ҷ���
local player = GetClientPlayer()
--Ŀ�����
local target = s_util.GetTarget(player)

if target then
    s_Output(target.nMoveState)
end

s_Output(player.nMoveState)