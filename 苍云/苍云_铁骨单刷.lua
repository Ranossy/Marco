--��Ѩ��[����][����][���][����][ʤǰ][����][��Ѫ][����][����][����][ʯ��][����]
--�˺����Ҫ��������Ѩ������Ѩ��һ��Ŀ�ġ���ס�������С�
--�ؼ���PVE�ؼ�
--���ߣ����

--��ͷ������������Ȼ�ȡ�Լ��Ķ���û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end

--��ǰѪ����ֵ
local hpRatio = player.nCurrentLife / player.nMaxLife

--��ȡ��ǰĿ�꣬����Ŀ������Ŀ������(��һ���NPC)
local target, targetClass = s_util.GetTarget(player)

--û��Ŀ�����Ŀ�겻�ǵ��ˣ�ֱ�ӷ���
if not target or not IsEnemy(player.dwID, target.dwID) then return end

--���Ŀ��������ֱ�ӷ���
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--��ȡ�Լ���buff��
local MyBuff = s_util.GetBuffInfo(player)

--��ȡĿ���buff��
local TargetBuff = s_util.GetBuffInfo(target)

--��ȡ�Լ���Ŀ��ľ���
local dis = s_util.GetDistance(player, target)
if dis > 3.5 then
s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
else
MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
end

--���Ѫ��С��35%��ʩ�Ŷܱ�
if hpRatio < 0.35 and s_util.CastSkill(13070, false) then return end

--�����������80%ʩ��Ѫŭ
if hpRatio < 0.8 then					
   if s_util.CastSkill(13040, false) then return end
end

--�����̬�����
if player.nPoseState == 2 then

--ŭ��>95������BUFF����ʩ�Ŷܷ�
if player.nCurrentRage > 95 and MyBuff[8437] then
   if s_util.CastSkill(13050, false)  then return end	
end

--�����������<60ʩ�Ŷܻ�
if hpRatio < 0.6 then					
if s_util.CastSkill(13047, false) then return end
end

--��ѹ
if s_util.CastSkill(13045, false) then return end
	
--����
if s_util.CastSkill(13046, false) then return end

--�ܵ���4321��
if s_util.CastSkill(13119, false) then return end
if s_util.CastSkill(13060, false) then return end
if s_util.CastSkill(13059, false) then return end
if s_util.CastSkill(13044, false) then return end
end

--�����̬���浶
if player.nPoseState == 1 then

--���Ŀ��û����Ѫbuff����ʱ��С��9��,�ͷ�ն��												
if not TargetBuff[8249] or TargetBuff[8249].nLeftTime < 9 then  
   if s_util.CastSkill(13054, false) then return end 
end
	
--���Ŀ������ѪBUFF������ѪBUFF>16�룬ʩ������
if TargetBuff[8249] and TargetBuff[8249].nLeftTime > 16 then					
		if s_util.CastSkill(13053, false) then return end			
	end

--�ٵ�
if s_util.CastSkill(13052, false) then return end
end

--���ŭ��<30�����û�к���BUFF��ʩ�Ŷܻأ�
if not MyBuff[8437] or player.nCurrentRage < 30 then 			
	if s_util.CastSkill(13051, false) then return end			
end


