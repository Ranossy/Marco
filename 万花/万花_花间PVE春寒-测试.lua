--��Ѩ����ָ ѩ���� ���� ���� ��� ��� ���� ѩ�� ��Ϣ �θ� ̤�� ���
--���ԣ�����Ҫ��249
--�ؼ���3������ʱ��+3S�����������֡����߼�����ʱ�䣬����2������Ϣʱ��

--��ͷ������������Ȼ�ȡ�Լ��Ķ���û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end

--�Լ�û�����Ĳ�����
if not s_util.GetBuffInfo(player)[112] then
    if s_util.CastSkill(130,true) then return end
end
--------------------------��������Ŀ�괦������ʼ��������-------------------------

--��ȡ��ǰĿ��,δ��սûĿ��ֱ�ӷ���,ս����ûĿ��ѡ������ж�NPC,��������
local target, targetClass = s_util.GetTarget(player)							
if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end 
if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
local MinDistance=20	--��С����
local MindwID=0		    --���NPC��ID
for i,v in ipairs(GetAllNpc()) do		--��������NPC
    --����жԲ��Ҿ���������滻�����ID
	if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player)<MinDistance and v.nMaxLife>1000 then
		MinDistance = s_util.GetDistance(v, player)                             
		MindwID = v.dwID    
		end
	end
if MindwID == 0 then 
    return                          --û�еж�NPC�򷵻�
else	
    SetTarget(TARGET.NPC, MindwID)  --�趨Ŀ��Ϊ����ĵж�NPC                
end
end
if target then s_util.TurnTo(target.nX,target.nY) end  --��������

--���Ŀ��������ֱ�ӷ���
if target.nMoveState == MOVE_STATE.ON_DEATH then return end
--------------------------��������Ŀ�괦����������������-------------------------

--------------------------��������������������ʼ��������-------------------------

--��ʼ������ȫ�ֱ���������ս��״̬����Ϊ0
if not g_MacroVars.State_714 or not player.bFightState then
    g_MacroVars.State_714 = 0
end

--�����Լ���Ŀ��ľ���
local distance = s_util.GetDistance(player, target)	

--�����Լ���buff��
local MyBuff = s_util.GetBuffInfo(player)

--�����Լ���Ŀ����ɵ�buff�б�
local TargetBuff = s_util.GetBuffInfo(target, true)

--����Ŀ���ȫ��buff�б�
local TargetBuffAll = s_util.GetBuffInfo(target)

--����Ŀ��������ݣ��Ƿ��ڶ���, ����ID���ȼ��������ٷֱȣ���������
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)

--�����Լ��������ݣ��Ƿ��ڶ���, ����ID���ȼ��������ٷֱȣ���������
local bPrepareMe, dwSkillIdMe, dwLevelMe, nLeftTimeMe, nActionStateMe =  GetSkillOTActionState(player)

--�����Լ���Ѫ����
local hpRatio = player.nCurrentLife / player.nMaxLife

--�����Լ���������
local ManaRatio = player.nCurrentMana / player.nMaxMana
--------------------------������������������������������-------------------------

--------------------------��������Ӧ����������ʼ��������-------------------------

--Ѫ��С��30%���Լ��ͷŴ��໤��
if hpRatio < 0.3 then 
    if s_util.CastSkill(132,true) then return end
end

--����С��30%���Լ��ͷű�ˮ
if ManaRatio < 0.3 then
    if s_util.CastSkill(131,true) then return end
end

--����"Alt"+"Q" ����
if(IsAltKeyDown() and IsKeyDown("Q")) then
	s_util.CastSkill(9003,false,true)
end

--���¡�Alt��+��E�� ��ҡ��
if(IsAltKeyDown() and IsKeyDown("E")) then
	s_util.CastSkill(9002,true,false)
	if(playerBuffs[208]) then Jump() end
end

--����������������
if MyBuff[13034] and MyBuff[13034].nLeftTime > 2.5 then
	s_util.StopSkill()  --��϶���
	if s_util.CastSkill(9007, false) then return end    --����
end

--����"Alt"ͣ��
if IsAltKeyDown() then
	return
end

--ȡ��ˮ��buff����ֹ����˲�����dot�ж�����
if MyBuff[412] then s_util.CancelBuff(412) end

--------------------------��������Ӧ��������������������-------------------------

--------------------------���������Զ�λ������ʼ��������-------------------------
--[[
--��Ŀ����볬��15���Զ�����Ŀ�꣨Ӱ����λ���ƣ��ű����ã�
if distance > 15 then
	s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
else
	MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
end
--]]
--------------------------���������Զ�λ����������������-------------------------

--------------------------�����������ѭ������ʼ��������-------------------------

--����dot�ӳ�˫��������
if dwSkillIdMe == 189 and nLeftTimeMe > 0.5 then   --����ڶ�������
    g_MacroVars.State_714 = 1 	                   --��������ˢ�±�־
end
if dwSkillIdMe == 179 and nLeftTimeMe > 0.5 then   --����ڶ�������
    g_MacroVars.State_714 = 2                      --������������ˢ�±�־
end

--������ȫ����3����ѩ�� ������
if (not TargetBuff[666] or not TargetBuff[711] or not TargetBuff[714]) and dwSkillIdMe == 2636 and nLeftTimeMe < 0.4 then
    if s_util.CastSkill(190,false,true) then return end
end

--������������dot
if not TargetBuff[714] and g_MacroVars.State_714 == 0 and MyBuff[2719] then 
    if s_util.CastSkill(179,false) then return end
end

--������dot
if not TargetBuff[711] and g_MacroVars.State_714 ~= 2 then  --Ŀ����dot������δˢ��
    if s_util.CastSkill(190,false) then return end
end

--������dot
if not TargetBuff[714] and g_MacroVars.State_714 == 0 then  --Ŀ����dot������δˢ��
    if s_util.CastSkill(189,false) then return end
end

--�ж���������ˢ�� ������
if  g_MacroVars.State_714 == 1 or g_MacroVars.State_714 == 2 then
    if s_util.CastSkill(180, false) then g_MacroVars.State_714 = 3 return end
end

--��������ʱ��>11S����ʯCD ˮ������
if TargetBuff[666] and TargetBuff[666].nLeftTime > 11 and s_util.GetSkillCD(182) > 2 and s_util.GetSkillCD(182) < 15 then
    if s_util.CastSkill(136,false) then return end
    if s_util.CastSkill(2645,false) then return end
end

--��������ʱ��>11S��������BUFF ��ʯ���
if TargetBuff[666] and TargetBuff[666].nLeftTime > 11 and not MyBuff[2719] then
    if s_util.CastSkill(182,false) then g_MacroVars.State_714 = 0  return end
end

--����BUFF<7S��3����ѩ�� ��ʯ
if MyBuff[2719] and MyBuff[2719].nLeftTime < 7 and dwSkillIdMe == 2636 and nLeftTimeMe < 0.4 then
    if s_util.CastSkill(182,false,true) then g_MacroVars.State_714 = 0  return end
end

--����BUFF>4S �϶�����3����ѩ
if MyBuff[2719] and MyBuff[2719].nLeftTime > 4 and dwSkillIdMe == 2636 and nLeftTimeMe < 0.4 then
    if s_util.CastSkill(2636,false,true) then g_MacroVars.State_714 = 0 return end         
end

--��3�� ��ѩʱ��
if TargetBuff[666] and TargetBuff[711] and TargetBuff[714] then
    if s_util.CastSkill(2636,false) then g_MacroVars.State_714 = 0 return end  
end