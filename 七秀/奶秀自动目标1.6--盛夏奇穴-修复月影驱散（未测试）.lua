--�Զ�ѡ��Ŀ�� v1.6
--���£���������������Ԫ��˳����ʺ�pveʹ��
--��2018.07.08������ ��Ӱ���� �Զ���ɢ ��δ���ԣ� ����������������
--���� ����Ѫ����ѡ�Լ�ΪĿ�꣬������д����δ���ԣ����Զ�������
--�Ƽ���Ѩ ��¶����ʢ��or˫�ϡ������¡������ˡ������ɡ���ɢ��ϼ�������硪���������˪�硪����������ա����ຮӳ��
--˫�Ͻű����ƴ�

if not g_MacroVars.State_680 then
	g_MacroVars.State_680 = 0				--������
end

--��ȡ�Լ���Player����û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end

--��ȡ���������Ϣ
local bPrepare2, dwSkillId2, dwLevel2, nLeftTime2, nActionState2 =  GetSkillOTActionState(player)
--�϶���
if dwSkillId2 == 565 or dwSkillId2 == 18222 then
	if nLeftTime2 < 0.333 then
		s_util.StopSkill()
		else return
	end
end
--�����ǰ���ɲ������㣬���������Ϣ
if player.dwForceID ~= FORCE_TYPE.QI_XIU then
	s_util.OutputTip("��ǰ���ɲ������㣬������޷���ȷ���С�", 1)
	return
end

--��Ӱ����BUFFʣ��ʱ��С��3.5Sʱѡ��
local yueying = nil
for _,v in ipairs(GetAllPlayer()) do
    local TargetBuffyue = s_util.GetBuffInfo(v)
    if TargetBuffyue[12891] and TargetBuffyue[12891].nLeftTime < 3.5 then
        yueying = v
        break
    end
end
--��Ӱ����BUFFʣ��ʱ��С��2Sʱ��ɢ���ڼ䲻���л�Ŀ��
if yueying then 
    s_util.SetTarget(TARGET.PLAYER, yueying.dwID)
    if s_util.GetBuffInfo(yueying)[12891] and s_util.GetBuffInfo(yueying)[12891].nLeftTime < 2 then 
        if s_util.CastSkill(566,false,true) then return end  
    end
    return
end

--�Լ�Ѫ����ֵ
local myhp = player.nCurrentLife / player.nMaxLife

--��ȡ �Ŷ���Ѫ����͵���ң���Ѫ�������⣩
local duiyou,teamHP = s_util.GetTeamMember()
if not duiyou then duiyou = GetClientPlayer() end	
local dhp = duiyou.nCurrentLife / duiyou.nMaxLife

--����Ѫ���Ͷ���Ѫ���ȶ�
if myhp >= dhp then
	--�Զ�ѡ���Ŷ���Ѫ�����ٵ�Ŀ��
	if dhp < 0.97 then
		SetTarget(TARGET.PLAYER,duiyou.dwID)
	end
	else SetTarget(TARGET.PLAYER,player.dwID)
end

--��ȡ��ǰĿ�꣬Ŀ������ û��Ŀ�������Լ�ΪĿ��
local target, targetClass = s_util.GetTarget(player)		
if not target then SetTarget(TARGET.PLAYER,player.dwID) return end	
local thp = target.nCurrentLife / target.nMaxLife

--�ж��Ƿ�жԣ��ж�ѡ�Լ�ΪĿ��
if  IsEnemy(player.dwID, target.dwID) then SetTarget(TARGET.PLAYER,player.dwID) end

--��ȡ�Լ���buff��
local MyBuff = s_util.GetBuffInfo(player)
local mMyBuff = s_util.GetBuffInfo(player,true)
--��ȡĿ���buff��
local TargetBuff = s_util.GetBuffInfo(target)
local mTargetBuff = s_util.GetBuffInfo(target,true)
--��ȡ�Լ���Ŀ��ľ���
local distance = s_util.GetDistance(player, target)

--����������������
if MyBuff[13034] and MyBuff[13034].nLeftTime > 2.5 then
	--��϶���
	s_util.StopSkill()
	--����
	if s_util.CastSkill(9007, false) then return end 
end

--������
if not MyBuff[673] then
	if s_util.CastSkill(545,true) then return end
end

--���Ŀ��������ִ����һ��
if target.nMoveState ~= MOVE_STATE.ON_DEATH then 
	--Ŀ��Ѫ������30%���޼�����[����Ͱ�]
	if thp < 0.3 and not mTargetBuff[684] and not TargetBuff[9694] then 
		if s_util.CastSkill(555,false) then return end
	end
	if myhp < 0.7 and not mMyBuff[684] then --�ҵ�Ѫ������70%���޼�����[��صͰ�]
		if s_util.CastSkill(557,true) then return end
	end
	--Ŀ��Ѫ������60%���޼��� [����Ͱ�]������
	if thp < 0.6 and not mTargetBuff[684] and s_util.GetSkillCD(555) <= 0 then 
		if not TargetBuff[680] or TargetBuff[680].nLeftTime <= 5 then 
			if s_util.CastSkill(554,false) then 
				g_MacroVars.State_680 = 1
			end
		end
		if  TargetBuff[680] and (g_MacroVars.State_680 == 1 or TargetBuff[680].nLeftTime > 5 ) then
			if s_util.CastSkill(555,false) then 
				g_MacroVars.State_680 = 0
				return 
			end
		end
	end
	--��ĸ
	if thp < 0.6 then
		if s_util.CastSkill(569,false) then return end
	end
	--[�ຮӳ��]
	if MyBuff[6436] and thp < 0.45 then 
		if s_util.CastSkill(18221,false) then return end
	end
	--[��������]
	if s_util.GetSkillCD(569) > 0 and s_util.GetSkillCD(555) > 0 and target.nMoveState ~= MOVE_STATE.ON_DEATH and thp < 0.5 then
		if s_util.CastSkill(568,false) then return end --[��������]
		if s_util.CastSkill(18221,false) then return end --[�ຮӳ��]
	end
	--���Լ���Ԫ��֤����
	if not mMyBuff[681] then
		if s_util.CastSkill(556,true) then return end
	end
	--�����貹����
	if not mTargetBuff[680] then
		if s_util.CastSkill(554,false) then return end
	end
	--��Ԫ
	if not mTargetBuff[681] then
		if s_util.CastSkill(556,false) then return end
	end
	--��Ѫ��buff����
	if thp <= 0.97 then
		s_util.CastSkill(554,false) 
		if MyBuff[12287] then
			if s_util.CastSkill(18222,false) then return end
		end
		if s_util.CastSkill(565,false) then return end
	end
end