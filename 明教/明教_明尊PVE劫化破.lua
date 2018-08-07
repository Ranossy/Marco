--[[
��Ѩ����ʥ���������ȱ��ġ������𡿡��¾�����������ŵ���������������������Ե��������š����ɶ�����������ͬ�ԡ�������������Ļ�̾��
1.��Ѩ������Ҫ���е�������11����Ѩ�����������Ӱ������ѭ����
2.Ĭ���Զ��ȱ�Ը���ֶ������ࡣ
3.Ĭ������������٣�����F����л�Ϊ˫��ħ��
--]]

--��ͷ������������Ȼ�ȡ�Լ��Ķ���û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end

--��ǰѪ����ֵ
local hpRatio = player.nCurrentLife / player.nMaxLife

--��ȡ��ǰĿ��,δ��սûĿ��ֱ�ӷ���,ս����ûĿ��ѡ������ж�NPC,��������
local target, targetClass = s_util.GetTarget(player)							
if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end --
if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
local MinDistance = 20			--��С����
local MindwID = 0		    --���NPC��ID
for i,v in ipairs(GetAllNpc()) do		--��������NPC
	if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nLevel>0 then	--����ǵжԣ����Ҿ����С
		MinDistance = s_util.GetDistance(v, player)                             
		MindwID = v.dwID                                                                      --�滻�����ID
		end
	end
if MindwID == 0 then 
    return --û�еж�NPC�򷵻�
else	
    SetTarget(TARGET.NPC, MindwID)  --�趨Ŀ��Ϊ����ĵж�NPC                
end
end
if target then s_util.TurnTo(target.nX,target.nY,target.nZ) end

--���Ŀ��������ֱ�ӷ���
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--�ж�Ŀ�����������û�������������ж϶����ļ���ID����Ӧ����(��ϡ�ӭ����ˡ�����ȵ�)
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)		--���� �Ƿ��ڶ���, ����ID���ȼ���ʣ��ʱ��(��)����������

--��ȡ�Լ���buff��
local MyBuff = s_util.GetBuffInfo(player)

--��ȡ�Լ���Ŀ����ɵ�buff��
local TargetBuff = s_util.GetBuffInfo(target, true)

--��ȡĿ��ȫ����buff��
local TargetBuffAll = s_util.GetBuffInfo(target)

--��ȡ�Լ���Ŀ��ľ���
local distance = s_util.GetDistance(player, target)
local CurrentSun=player.nCurrentSunEnergy/100
local CurrentMoon=player.nCurrentMoonEnergy/100

--��ȡ�ҵĶ�������
local bPrepareMe, dwSkillIdMe, dwLevelMe, nLeftTimeMe, nActionStateMe =  GetSkillOTActionState(player)	

--����Լ��ڶ���ֱ�ӷ��أ������ϳ�ʥ��
if bPrepareMe then return end --����û�ã������Լ�ͣ������

--ȡ���Լ����ϵ�����в����buff
if MyBuff[4487] then s_util.CancelBuff(4487) end  --���̼���
if MyBuff[917] then s_util.CancelBuff(917) end    --��ʦ��
if MyBuff[8422] then s_util.CancelBuff(8422) end  --���ƶ�ǽ
if MyBuff[926] then s_util.CancelBuff(926) end    --�����
if MyBuff[4101] then s_util.CancelBuff(4101) end  --�����Ǽ��


--���ն
if not TargetBuff[4058] or (TargetBuff[4058] and TargetBuff[4058].nLeftTime < 1)then
	if s_util.CastSkill(3980,false) then return end
end

--����ǰʹ���Ļ�̾
if player.nSunPowerValue > 0 or player.nMoonPowerValue > 0 or MyBuff[9909] and MyBuff[9909].nLeftTime < 12.97 and player.nCurrentSunEnergy > player.nCurrentMoonEnergy then
    if s_util.CastSkill(14922,false) then return end
end

--����F�л�Ϊ��ħѭ��
if IsKeyDown("F") then 
    --��ħ
    if s_util.CastSkill(3967,false) then return end
else
    --������
    if s_util.CastSkill(3966,false) then return end
end

--�ȱ�Ը
if s_util.CastSkill(3982,false) then return end

--����ն������ѭ���ϳ�
if CurrentMoon >= CurrentSun and CurrentMoon < 61  then
    if  s_util.CastSkill(3960,false)  then return end
end

-- ����ն������>����ʱ�ͷ�
if CurrentSun > CurrentMoon and CurrentSun < 61 then
    if  s_util.CastSkill(3963,false)  then return end
end

-- ������ڵ��������Ҳ�����ʱ�������
if CurrentSun >= CurrentMoon and CurrentSun < 100 then
    if  s_util.CastSkill(3962,false)  then return end
end

--������������Ҳ�����ʱ��������
if CurrentSun < CurrentMoon and CurrentMoon < 100 then
    if s_util.CastSkill(3959,false) then return end
end