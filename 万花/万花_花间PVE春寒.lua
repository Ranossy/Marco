--��Ѩ����ָ ѩ���� ���� ���� ��� ��� ���� ѩ�� ��Ϣ �θ� ̤�� ���
--���ԣ�����Ҫ��249
--�ؼ���3������ʱ��+3S�����������֡����߼�����ʱ��

--��ͷ������������Ȼ�ȡ�Լ��Ķ���û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end
--------------------------��������Ŀ�괦������ʼ��������-------------------------

--��ȡ��ǰĿ��,δ��սûĿ��ֱ�ӷ���,ս����ûĿ��ѡ������ж�NPC,��������
local target, targetClass = s_util.GetTarget(player)							
if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end 
if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
local MinDistance = 20			--��С����
local MindwID = 0		    --���NPC��ID
for i,v in ipairs(GetAllNpc()) do		--��������NPC
	if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nMaxLife>1000 then
		MinDistance = s_util.GetDistance(v, player)                             
		MindwID = v.dwID                           --����жԲ��Ҿ���������滻�����ID
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

--��ʼ������ȫ�ֱ���
if not g_MacroVars.State_baofa then
    g_MacroVars.State_baofa = 0
    g_MacroVars.State_guodu = 0
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

--�Լ�û�����Ĳ�����
if not MyBuff[112] then
    if s_util.CastSkill(130,true) then return end
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
	--��϶���
	s_util.StopSkill()
	--����
	if s_util.CastSkill(9007, false) then return end 
end

--����"Alt"ͣ��
if IsAltKeyDown() then
	return
end
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

--ˮ��CDС�ڵ���7.8S��Ŀ����3������ʯ��CD���뱬��ѭ��
if s_util.GetSkillCD(136) <=7.8 and s_util.GetSkillCD(182) <=0 and not TargetBuff[666] and not TargetBuff[714] and not TargetBuff[711] then
    g_MacroVars.State_baofa = 1 
    g_MacroVars.State_guodu = 0
end
--����������3����ȫʱ������ͨѭ��
if g_MacroVars.State_baofa == 15 and (not TargetBuff[666] or not TargetBuff[714] or not TargetBuff[711]) then
    g_MacroVars.State_guodu = 1
end
s_Output(g_MacroVars.State_baofa)
s_Output(g_MacroVars.State_guodu)
--��������ѭ����ʼ����
--(190) ��������
if g_MacroVars.State_baofa == 2 then
    if s_util.CastSkill(190,false) then g_MacroVars.State_baofa = 3 return end
end
--(189) ����ع��
if g_MacroVars.State_baofa == 1 then
    if s_util.CastSkill(189,false) then g_MacroVars.State_baofa = 2 return end
end
--(180) ����ָ
if g_MacroVars.State_baofa == 3 then
    if s_util.CastSkill(180,false) and TargetBuff[666] then g_MacroVars.State_baofa = 4 return end
end
--(182) ��ʯ���
if g_MacroVars.State_baofa == 4 then
    if s_util.CastSkill(182,false) and s_util.GetSkillCD(182) >0 then g_MacroVars.State_baofa = 5 return end
end
--(189) ����ع��
if g_MacroVars.State_baofa == 5 then
    if s_util.CastSkill(189,false) then g_MacroVars.State_baofa = 6 return end
end
--(190) ��������
if g_MacroVars.State_baofa == 6 then
    if s_util.CastSkill(190,false) then g_MacroVars.State_baofa = 7 return end
end
--(180) ����ָ
if g_MacroVars.State_baofa == 7 then
    if s_util.CastSkill(180,false) and TargetBuff[666] then g_MacroVars.State_baofa = 8 return end
end
--(136) ˮ���޼�
if g_MacroVars.State_baofa == 8 then
    if s_util.CastSkill(136,false) then g_MacroVars.State_baofa = 9 return end
end
--(2645) �������
if g_MacroVars.State_baofa == 9 then
    if s_util.CastSkill(2645,false) then g_MacroVars.State_baofa = 10 return end
end
--(2636) ��ѩʱ��
if g_MacroVars.State_baofa == 10 then
    if s_util.CastSkill(2636,false) then g_MacroVars.State_baofa = 11 return end
end
--(2636) ��ѩʱ��϶���
if g_MacroVars.State_baofa == 11 and dwSkillIdMe==2636 and nLeftTimeMe<=0.398 then
    if s_util.CastSkill(2636,false,true) then g_MacroVars.State_baofa = 12 return end
end
--(182) ��ʯ��ٶ϶���
if g_MacroVars.State_baofa == 12 and dwSkillIdMe==2636 and nLeftTimeMe<=0.398 then
    if s_util.CastSkill(182,false,true) then g_MacroVars.State_baofa = 13 return end
end
--(180) ����ָ
if g_MacroVars.State_baofa == 13 then
    if s_util.CastSkill(180,false) then g_MacroVars.State_baofa = 14 return end
end
--(179) ����ָ
if g_MacroVars.State_baofa == 14 then
    if s_util.CastSkill(179,false) then g_MacroVars.State_baofa = 15 return end
end
--��������ѭ����������

--������ͨѭ����ʼ����
--(190) ��������
if g_MacroVars.State_guodu == 1  then
    if bPrepareMe and dwSkillIdMe==2636 and nLeftTimeMe<0.2 then
        if s_util.CastSkill(190,false,true) then 
            g_MacroVars.State_baofa = 16 
            g_MacroVars.State_guodu = 2 
            return 
        end
    else
        if s_util.CastSkill(190,false,true) then 
            g_MacroVars.State_baofa = 16 
            g_MacroVars.State_guodu = 2 
            return 
        end
    end
end
--(189) ����ع��
if g_MacroVars.State_guodu == 2 then
    if s_util.CastSkill(189,false) then g_MacroVars.State_guodu = 3 return end
end
--(180) ����ָ
if g_MacroVars.State_guodu == 3 then
    if s_util.CastSkill(180,false) then g_MacroVars.State_guodu = 4 return end
end
--(182) ��ʯ���
if g_MacroVars.State_guodu == 4 then
    if s_util.CastSkill(182,false) then g_MacroVars.State_guodu = 5 return end
end
--(189) ����ع��
if g_MacroVars.State_guodu == 5 then
    if s_util.CastSkill(189,false) then g_MacroVars.State_guodu = 6 return end
end
--(190) ��������
if g_MacroVars.State_guodu == 6 then
    if s_util.CastSkill(190,false) then g_MacroVars.State_guodu = 7 return end
end
--(180) ����ָ
if g_MacroVars.State_guodu == 7 then
    if s_util.CastSkill(180,false) then g_MacroVars.State_guodu = 8 return end
end
--������ͨѭ����������

--��3�� (2636) ��ѩʱ��
if TargetBuff[666] and TargetBuff[711] and TargetBuff[714] then
    if s_util.CastSkill(2636,false) then return end
end