--����Ⱥ�ѵ���Ʒ�޸�
--�޸���[����]����
local player = GetClientPlayer(player)
if not player then return end

--��ʼ��
if not g_MacroVars.State_2707 then
	g_MacroVars.State_2707 = 0				--���
end

--��ǰѪ����ֵ
local myhp = player.nCurrentLife / player.nMaxLife
--��ȡ��ǰĿ�꣬û��Ŀ�����Ŀ�겻�ǵ��ˣ�ֱ�ӷ���
local target, targetClass = s_util.GetTarget(player)							--���� Ŀ������Ŀ������(��һ���NPC)
if not target or not IsEnemy(player.dwID, target.dwID) then return end	

--Ŀ��Ѫ��
local thp = target.nCurrentLife / target.nMaxLife

--�ж�������Ϣ 
local warnmsg = s_util.GetWarnMsg()
--��ȡ�Լ���������
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState = GetSkillOTActionState(player)

--���Ŀ��������ֱ�ӷ���
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--��ȡ�Լ���buff��
local MyBuff = s_util.GetBuffInfo(player)

--��ȡĿ���buff��
local mTargetBuff = s_util.GetBuffInfo(target, true)
local TargetBuff = s_util.GetBuffInfo(target)

--��ȡ�Լ���Ŀ��ľ���
local distance = s_util.GetDistance(player, target)

--��ǰ������ֵ
local mp = player.nCurrentMana / player.nMaxMana

--��ȡNPCǿ��
local Intensity = GetNpcIntensity(target)

	
	--���Ѫ��С��40%���ͷ���صͰ�
	if myhp < 0.4 and not MyBuff[122] and not MyBuff[9933] and not MyBuff[9782] and not MyBuff[8839] and not MyBuff[9265] and not MyBuff[1242] and not MyBuff[10208] and not MyBuff[2778] then
		if s_util.CastSkill(557, false) then return end
	end
	
	--���ƺ�����
	if thp > 0.9 and s_util.GetSkillCD(2716) > 3 then
		if s_util.CastSkill(568, false) then return end
	end
	
	--����
	if(MyBuff[5788] and MyBuff[5788].nStackNum > 4) and not MyBuff[9769] then
		if s_util.CastSkill(568, false) then return end
	end
	
		
		--�ƶ�״̬����
	if s_util.CastSkill(2716, false) then return end
		--�ƶ�״̬����
	if s_util.CastSkill(561, false) then return end

		if dwSkillId == 2707 and nLeftTime < 0.5 and mTargetBuff[2920] and mTargetBuff[2920].nStackNum == 2 then
			g_MacroVars.State_2707 = 1
		end
		--��������
		if g_MacroVars.State_2707 == 1 or(mTargetBuff[2920] and mTargetBuff[2920].nStackNum > 2) then
			if s_util.CastSkill(553, false) then
				g_MacroVars.State_2707 = 0
				return
			end
		end
		--���Ҽ���
		if s_util.CastSkill(2707, false) then return end
		--�������
		if s_util.CastSkill(2716, false) then return end
		--�ƶ�״̬����
		if s_util.CastSkill(561, false) then return end

