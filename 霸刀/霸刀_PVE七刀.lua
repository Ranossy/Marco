--�ο������¥���İԵ���
--��Ѩ������ ���� �麨 ˪�� ���� ���� �ֽ� �ǻ� ���� ���� ���� �ľ�
--�Զ����Ͻ��������
--���ߣ���Ͱ#2743
--����޸����ڣ�2018/7/03

--��ȡ�Լ���Player����û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end

--�����ǰ���ɲ��ǰԵ������������Ϣ
if player.dwForceID ~= FORCE_TYPE.BA_DAO then
	s_util.OutputTip("��ǰ���ɲ��ǰԵ���������޷���ȷ���С�", 1)
	return
end

--��ǰѪ����ֵ
local myhp = player.nCurrentLife / player.nMaxLife

--��ȡ��ǰĿ��,δ��սûĿ��ֱ�ӷ���,ս����ûĿ��ѡ������ж�NPC,��������
local target, targetClass = s_util.GetTarget(player)							
if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end
if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
local MinDistance = 20		--��С����
local MindwID = 0		    --���NPC��ID
for i,v in ipairs(GetAllNpc()) do		--��������NPC
	if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nLevel>0 then  --����ǵжԣ����Ҿ����С
		MinDistance = s_util.GetDistance(v, player)                             
		MindwID = v.dwID                                                                  --�滻�����ID
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
local mTargetBuff = s_util.GetBuffInfo(target,true)

--��ȡ�Լ���Ŀ��ľ���
local dis = s_util.GetDistance(player, target)
if dis > 3.5 then
s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
else
MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
end

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
	if s_util.GetSkillCD(16621) <= 0 and player.nCurrentSunEnergy >= 10  then					--��������Ұ��ȴ�ˣ��������ڵ���10
		s_util.CastSkill(16169, false)						--ʩ��ѩ������
	end
	--if player.nCurrentRage > 25 and dis < 6 then
	--	s_util.CastSkill(16168, false)						--ʩ����������
	--end
	--����3��+����
	if s_util.CastSkill(16870,false) then return end
	if MyBuff[11156] then 
		if s_util.CastSkill(34,false) then return end
	end
	if s_util.CastSkill(16871,false) then return end
	if s_util.CastSkill(16872,false) then return end
	if  MyBuff[11156] and MyBuff[11156].nStackNum > 1 and player.nCurrentRage > 28 then
		s_util.CastSkill(16168, false)						--ʩ����������
	end
end


--���������������̬
if player.nPoseState == POSE_TYPE.BROADSWORD then
	if MyBuff[11322] and MyBuff[11322].nLeftTime < 0.7 then s_util.CastSkill(18976,false,true) end
	if dis > 8 then  s_util.CastSkill(16166, false) return end --�е�׷��
	--���ȷż����Ұ
	if s_util.GetSkillCD(16621) <= 0 and player.nCurrentSunEnergy >= 10 then					--��������Ұ��ȴ�ˣ��������ڵ���10
		--�л���ѩ��������̬
		s_util.CastSkill(16169, false,true)
		return
	end
	if player.nCurrentRage < 5 then  s_util.CastSkill(16166, false,true) return end --û���е�

	--���߷���
	if s_util.CastSkill(16629, false) then return end

		--�Ͻ���ӡ 7��
	if s_util.CastSkill(19344, false) then return end

	if player.nCurrentSunEnergy > 20 then s_util.CastSkill(16169, false) return end

	--�Ƹ����� cw��Ч���Դ�
	--if MyBuff[xxx] then
	--	if s_util.CastSkill(16602, false) then return end
	--end

	--��������321��
	if s_util.CastSkill(17079, false) then return end
	if s_util.CastSkill(17078, false) then return end
	if s_util.CastSkill(16601, false) then return end
end


--�����ѩ��������̬ 
if player.nPoseState == POSE_TYPE.SHEATH_KNIFE then
	--����ѩ��������̬������������
	if player.nCurrentSunEnergy < 5 then				--�������С��5��
		s_util.CastSkill(16166, false)					--ʩ����������
		return
	end

	--�����Ұ
	if s_util.CastSkill(16621, false,true) then return end


	--�е���������
	if s_util.GetSkillCD(19344) <= 0 then		--
		s_util.CastSkill(16168, false,true)			--ʩ����������
		return
	end

	--��Х����
	if s_util.CastSkill(16027,false) then return end	--ʩ�ŵ�Х����
	--��ն����
	if s_util.CastSkill(16085, false) then return end
end
