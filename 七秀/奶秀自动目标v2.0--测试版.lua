--�����Զ�ѡ��Ŀ�� v2.0
--��2018.07.20���޸�����Ӱ���֣��Լ���¥�޺������Ż� ʢ��or˫�� ��д�����޸�֮ǰ�ҿ�������bug���޸Ļ�ѩϹ��
--�Ƽ���Ѩ ��¶����ʢ��or˫�ϡ������¡������ˡ������ɡ���ɢ��ϼ�������硪���������˪�硪����������ա����ຮӳ��
--˫�Ͻű����ƴ�
--��ȡ�Լ���Player����û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end

--��ȡ���������Ϣ
local bPrepare2, dwSkillId2, dwLevel2, nLeftTime2, nActionState2 = GetSkillOTActionState(player)
--�϶���
if dwSkillId2 == 565 or dwSkillId2 == 18222 then
	if bPrepare2 and nLeftTime2 < 0.34 then
		s_util.StopSkill()
	else return
	end
end
--�����ǰ���ɲ������㣬���������Ϣ
if player.dwForceID ~= FORCE_TYPE.QI_XIU then
	s_util.OutputTip("��ǰ���ɲ������㣬������޷���ȷ���С�", 1)
	return
end

--��Ӱ����
local yueying = nil
for _, v in ipairs(GetAllPlayer()) do
	local TargetBuff = s_util.GetBuffInfo(v)
	if TargetBuff[12891] and TargetBuff[12891].nLeftTime < 3.5 then
		yueying = v
		break
	end
end

--�Լ�Ѫ����ֵ
local myhp = player.nCurrentLife / player.nMaxLife

--��ȡ �Ŷ���Ѫ����͵���ң���Ѫ
local duiyou, teamHP = s_util.GetTeamMember()
if not duiyou then duiyou = GetClientPlayer() end	
local dhp = duiyou.nCurrentLife / duiyou.nMaxLife

if yueying then
	s_util.SetTarget(TARGET.PLAYER, yueying.dwID)
else	
	--�Զ�ѡ���Ŷ���Ѫ�����ٵ�Ŀ��
	if myhp > dhp then
		if dhp < 0.97 then
			SetTarget(TARGET.PLAYER, duiyou.dwID)
		end
	else
		if myhp < 0.97 then
			SetTarget(TARGET.PLAYER, player.dwID)
		end
	end
end
--��ȡ��ǰĿ�꣬Ŀ������ û��Ŀ�������Լ�ΪĿ��
local target, targetClass = s_util.GetTarget(player)		
if not target then SetTarget(TARGET.PLAYER, player.dwID) return end	
local thp = target.nCurrentLife / target.nMaxLife

--�ж��Ƿ�жԣ��ж�ѡ�Լ�ΪĿ��
if IsEnemy(player.dwID, target.dwID) then SetTarget(TARGET.PLAYER, player.dwID) return end

--��ȡ�Լ���buff��
local MyBuff = s_util.GetBuffInfo(player)
local mMyBuff = s_util.GetBuffInfo(player, true)
--��ȡĿ���buff��
local TargetBuff = s_util.GetBuffInfo(target)
local mTargetBuff = s_util.GetBuffInfo(target, true)
--��ȡ�Լ���Ŀ��ľ���
local distance = s_util.GetDistance(player, target)

--��ɢ����
if TargetBuff[12891] and TargetBuff[12891].nLeftTime <= 2 then
	if s_util.CastSkill(566, false, true) then return end
end

--��ս��������
local npc = s_util.GetNpc(52087) or s_util.GetNpc(52088) or s_util.GetNpc(51211)
if npc then
	local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState = GetSkillOTActionState(npc)
	local bt = s_util.GetTarget(npc)
	if bPrepare and(dwSkillId == 16449 or dwSkillId == 16398 or dwSkillId == 16029) then
		SetTarget(TARGET.PLAYER, bt.dwID)
		local TargetBuff = s_util.GetBuffInfo(bt)
		if not TargetBuff[684] then
			if s_util.CastSkill(555, false, true) then return end --����
			if s_util.CastSkill(569, false, true) then return end --��ĸ
		end
	end
end
--����������������
if MyBuff[13034] and MyBuff[13034].nLeftTime > 2.5 then
	--��϶���
	if bPrepare2 then
		s_util.StopSkill()
	end
	--����
	if s_util.CastSkill(9007, false) then return end
end

--������
if not MyBuff[673] then
	if s_util.CastSkill(545, true) then return end
end

--���Ŀ��������ִ����һ��
if target.nMoveState ~= MOVE_STATE.ON_DEATH then
	--Ŀ��Ѫ������30%���޼�����[����Ͱ�]
	if thp < 0.3 and not mTargetBuff[684] then
		if s_util.CastSkill(555, false) then return end
	end
	if myhp < 0.7 and not mMyBuff[684] then --�ҵ�Ѫ������70%���޼�����[��صͰ�]
		if s_util.CastSkill(557, true) then return end
	end
	--Ŀ��Ѫ������60%���޼��� [����Ͱ�]������
	if thp < 0.6 and not mTargetBuff[684] then
		if(not mTargetBuff[680] or mTargetBuff[680].nLeftTime <= 5) and s_util.GetSkillCD(555) <= 0 then
			if s_util.CastSkill(554, false) then end
		end
		if mTargetBuff[680] and mTargetBuff[680].nLeftTime > 5 then
			if s_util.CastSkill(555, false) then return end
		end
	end
	--��ĸ
	if thp < 0.6 then
		if s_util.CastSkill(569, false) then return end
	end
	--[�ຮӳ��]
	if MyBuff[6436] and thp < 0.45 then
		if s_util.CastSkill(18221, false) then return end
	end
	--[��������]
	if not mTargetBuff[684] and s_util.GetSkillCD(569) > 1.5 and s_util.GetSkillCD(555) > 1.5 and thp < 0.5 then
		--[��������]
		if s_util.CastSkill(568, false) then return end	
		--[�ຮӳ��]	
		if s_util.CastSkill(18221, false) then return end	
	end
	--���Լ���Ԫ��֤����
	if not mMyBuff[681] then
		if s_util.CastSkill(556, true) then return end
	end
	
	--������Ѩ
	if s_util.GetTalentIndex(2) == 1 then
		--�����貹����
		if not mTargetBuff[680] then
			if s_util.CastSkill(554, false) then return end
		end
		--��Ԫ
		if not mTargetBuff[681] then
			if s_util.CastSkill(556, false) then return end
		end
	else
		--��Ԫ
		if not mTargetBuff[681] then
			if s_util.CastSkill(556, false) then return end
		end
		--�����貹����
		if not mTargetBuff[680] then
			if s_util.CastSkill(554, false) then return end
		end
	end
	
	--���޻�ѩ
	if s_util.CastSkill(554, false) then return end
	if MyBuff[12287] then
		if s_util.CastSkill(18222, false) then return end
	end
	if s_util.CastSkill(565, false) then return end
end 