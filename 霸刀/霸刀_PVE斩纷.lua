--��Ѩ��[����][��ѩ][���][����][���L][��¹][�ؼ�][�ǻ�][����][�^��][�䴨][���R]
--�ؼ������������ؿ񣬵�Х�����������Ǳ����
--���ߣ�����¥��
--����޸����ڣ�2018/4/21


--��ʼ��
if not g_MacroVars.State_16027 then
	g_MacroVars.State_16027 = 0				--��Х����3�α�־
	g_MacroVars.State_11334 = 0				--����buff��־
end


--��ȡ�Լ���Player����û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end

--�����ǰ���ɲ��ǰԵ������������Ϣ
if player.dwForceID ~= FORCE_TYPE.BA_DAO then
	s_util.OutputTip(target.nX)
	return
end

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

--��ȡ�Լ���buff��
local MyBuff = s_util.GetBuffInfo(player)

--��ȡĿ���buff��
local TargetBuff = s_util.GetBuffInfo(target)

--��ȡ�Լ���Ŀ��ľ���
local distance = s_util.GetDistance(player, target)


--��Ŀ�����������
if (not TargetBuff[11447] or TargetBuff[11447].dwSkillSrcID ~= player.dwID) and s_util.GetSkillCD(17057) <= 0 then		--���Ŀ��û��������buff���߲����ҵģ���������ȴ
	if player.nPoseState ~= POSE_TYPE.DOUBLE_BLADE then		--�����������������̬
		s_util.CastSkill(16166, false)						--ʩ����������
		return
	end
	s_util.CastSkill(17057,false)							--�ͷ� ������
	return
end


--�����������������̬
if player.nPoseState == POSE_TYPE.DOUBLE_BLADE then
	--�����������ѩ����������������������
	if MyBuff[11456]  then 
		s_util.CastSkill(16169, false)						--ʩ��ѩ������
		g_MacroVars.State_16027 = 0							--����̬�����õ�x3��־Ϊ0
	else
		s_util.CastSkill(16168, false)						--ʩ����������
	end
	return
end


--���������������̬
if player.nPoseState == POSE_TYPE.BROADSWORD then
	--���ȷż����Ұ
	if s_util.GetSkillCD(16621) <= 0 and player.nCurrentSunEnergy >= 10 then					--��������Ұ��ȴ�ˣ��������ڵ���10
		--��������
		if target.nMaxLife > 400000 then
		    if s_util.CastSkill(16454, false) then return end
        end
		--�л���ѩ��������̬
		s_util.CastSkill(16169, false)
		g_MacroVars.State_16027 = 0
		return
	end

	--���߷���
	if s_util.CastSkill(16629, false) then return end

	--�Ƹ�����
	--if s_util.CastSkill(16602, false) then return end

	--�Ͻ���ӡ �н�ֱ
	if s_util.CastSkill(16627, false) then return end

	--��������321��
	if s_util.CastSkill(17079, false) then return end
	if s_util.CastSkill(17078, false) then return end
	if s_util.CastSkill(16601, false) then return end
end


--�����ѩ��������̬  ��� + �� + ��x3 + ��
if player.nPoseState == POSE_TYPE.SHEATH_KNIFE then
	--����ѩ��������̬��������������һ�������������ﵽ�����ǻ���Ҫ���Ǹ����������
	if player.nCurrentSunEnergy < 5 then				--�������С��5��
		s_util.CastSkill(16168, false)					--ʩ����������
		return
	end

	--�����Ұ
	if s_util.CastSkill(16621, false) then return end

	--��������ε�Х����������buff��ûͬ��������
	local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(player)		--��ȡ�ҵĶ�������
	if dwSkillId == 16027 and nLeftTime < 0.5 and MyBuff[11334] and MyBuff[11334].nStackNum == 2 then			--����ڶ�����Х������ʣ��ʱ��С��0.5��, ������2�㺬��
		g_MacroVars.State_11334 = 1				--���ú���buff��־Ϊ1���͵����Ѿ���3�㺬����
	end

	--���÷Ź����ε�Х��־
	if MyBuff[11334] and MyBuff[11334].nStackNum > 2 then		--����к��磬���Һ����������2
		g_MacroVars.State_16027 = 1							--����״̬����Ϊ1����ʾ�Ѿ��ù����ε�Х
	end

	--��ն����
	if g_MacroVars.State_11334 == 1 or not MyBuff[11334] or MyBuff[11334].nStackNum > 2 then  	--�Ź�3�ε�Х������û�к��磬���ߺ����������2
		if s_util.CastSkill(16085, false) then				--ʩ����ն����
			g_MacroVars.State_11334 = 0
			return
		end
	end

	--�е���������
	if s_util.GetSkillCD(16085) > 0 and g_MacroVars.State_16027 == 1 then		--�����ն������CD�������ù����ε�Х
		s_util.CastSkill(16168, false)					--ʩ����������
		return
	end

	--��Х����
	if not MyBuff[11334] or MyBuff[11334].nStackNum < 3 then		--û�к���buff�����ߺ������С��3
		s_util.CastSkill(16027,false)								--ʩ�ŵ�Х����
	end
end
