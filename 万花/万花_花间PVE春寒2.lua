--��Ѩ����ָ ѩ���� ���� ���� ��� ��� ���� ѩ�� ��Ϣ �θ� ̤�� ���
--���ԣ�����Ҫ��249
--�ؼ���3������ʱ��+3S�����������֡����߼�����ʱ��

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
if not g_MacroVars.State_714 then
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

--����dot�ӳ�˫��������
if  (dwSkillId == 714 and nLeftTime > 0.7) or (dwSkillId == 179 and nLeftTime > 0.7) then  --����ڶ��������70%
    g_MacroVars.State_714 = 1 	--��������ˢ��DOT��־
end
--�ж�ˢ���ͷ� ����
if  g_MacroVars.State_714 == 1 then
    if s_util.CastSkill(180, false)  then g_MacroVars.State_14064 = 0 return end
end
--������������dot
if not TargetBuff[714] and g_MacroVars.State_714 == 0 and Mybuff[412] then 
    if s_util.CastSkill(179,false) then g_MacroVars.State_14064 = 1 return end
end
--������dot
if not TargetBuff[711] then 
    if s_util.CastSkill(190,false) then return end
end
--������dot
if not TargetBuff[714] and g_MacroVars.State_714 == 0 then 
    if s_util.CastSkill(189,false) then g_MacroVars.State_14064 = 1 return end
end

--3������ʱ��>15S����ʯCD ˮ������
if TargetBuff[666] and TargetBuff[666].nLeftTime > 15 and s_util.GetSkillCD(182) > 0 then
    s_util.CastSkill(136,true)
    s_util.CastSkill(2645,true)
    return 
end

--3������ʱ��>15S����ˮ��BUFF (182) ��ʯ���
if TargetBuff[666] and TargetBuff[666].nLeftTime > 15 and not MyBuff[412] then
    if s_util.CastSkill(182,false) then return end
end

--ˮ��BUFF<8S���ڶ�����ѩʱ�϶����ͷ� ��ʯ
if MyBuff[412] and MyBuff[412].nLeftTime < 8 and dwSkillIdMe==2636 and nLeftTimeMe<=0.398 then
    if s_util.CastSkill(182,false,true) then return end
end

--��3�� (2636) ��ѩʱ��
if TargetBuff[666] and TargetBuff[711] and TargetBuff[714] then
    if Mybuff[412] and dwSkillIdMe==2636 and nLeftTimeMe<=0.398 then --ˮ��BUFF�ڼ��Զ϶���
        if s_util.CastSkill(2636,false,true) then return end
    else
        if s_util.CastSkill(2636,false) then return end              --��ˮ�²��϶���
    end
end