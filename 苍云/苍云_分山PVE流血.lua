--��Ѩ��[����][����][����][����][��Į][����][����][��ս][����][����][����][����]
--�ؼ����Լ�����Ū
--���ߣ�����¥��
--����޸����ڣ�2018/3/31
--˵�������ֻ����ʾ���о����кܶ����Ҫ�޸ģ�ŭ���ò��꣬�ٵ����̫�٣��ܻ����̫�ࡣ
--Ϊʲô���ܺ�Buff����ID���������֣���Ϊ�ܶ�buff�����ص�û�����֡���ID���Ծ�ȷ���ơ�



--��ͷ������������Ȼ�ȡ�Լ��Ķ���û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end

--��ǰѪ����ֵ
local hpRatio = player.nCurrentLife / player.nMaxLife

--���Ѫ��С��35% ���öܱ�
if hpRatio < 0.35 and s_util.CastSkill(13070, false) then return end

--��ȡ��ǰĿ�꣬û��Ŀ�����Ŀ�겻�ǵ��ˣ�ֱ�ӷ���
local target, targetClass = s_util.GetTarget()							--���� Ŀ������Ŀ������(��һ���NPC)
if not target or not IsEnemy(player.dwID, target.dwID) then return end

--���Ŀ��������ֱ�ӷ���
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--�ж�Ŀ�����������û�������������ж϶����ļ���ID����Ӧ����(��ϡ�ӭ����˵ȵ�)
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)		--���� �Ƿ��ڶ���, ����ID���ȼ���ʣ��ʱ��(��)����������

--��ȡ�Լ���buff��
local MyBuff = s_util.GetBuffInfo(player)

--��ȡĿ���buff��
local TargetBuff = s_util.GetBuffInfo(target)

--��ȡ�Լ���Ŀ��ľ���
local distance = s_util.GetDistance(player, target)

--Ѫŭ ���˷ߺ������
--if not MyBuff[8385] and hpRatio > 0.91 then					--���û��Ѫŭbuff������Ѫ������91%
--	if s_util.CastSkill(13040, false) then return end		--���ʩ��Ѫŭ�ɹ���ֱ�ӷ���(ÿ�ΰ��¾�ʩ��һ�����ܣ�û��Ҫ����������)
--end

--Ѫŭ û�е�ߺ��������ע�� buff ID �ǲ�һ����
if not MyBuff[8244] or MyBuff[8244].nStackNum < 2 then		--���û��Ѫŭbuff,����Ѫŭbuff�ѵ�����С��2
	if s_util.CastSkill(13040, false) then return end
end

--�����̬�����
if player.nPoseState == 2 then
	--�����ﵽ������ʩ�ųɹ�û�У������أ����ȱ�֤3�ܻ�
	if TargetBuff[8249] and s_util.GetSkillCN(13047) > 0 and distance < 4 then		--��� Ŀ������Ѫbuff, �ܻ���ʹ�ô�������0, ����С��4��
		s_util.CastSkill(13047, false)												--ʩ�Ŷܻ�
		return
	end

	--��ѹ
	if s_util.CastSkill(13045, false) then return end

	--ն����ȴ�˾�Ҫ�е�����Ѫ
	if player.nCurrentRage > 30 and s_util.GetSkillCD(13054) == 0 then			--���ŭ������30��, ����ն����ȴ��
		if s_util.CastSkill(13050, false) then return end						--ʩ�Ŷܷ�
	end

	--����
	if s_util.CastSkill(13046, false) then return end

	--���ŭ������70���е���ٵ�
	if player.nCurrentRage > 70 then
		if s_util.CastSkill(13050, false) then return end						--ʩ�Ŷܷ�
	end

	--�ܵ���4321��
	if s_util.CastSkill(13119, false) then return end
	if s_util.CastSkill(13060, false) then return end
	if s_util.CastSkill(13059, false) then return end
	if s_util.CastSkill(13044, false) then return end
end

--�����̬���浶
if player.nPoseState == 1 then
	--�л���̬
	if player.nCurrentRage < 10 then					--���ŭ��С��5��
		s_util.CastSkill(13051, false)				--ʩ�Ŷܻ�
		return
	end

	--����ն��������Ѫ
	if s_util.CastSkill(13054, false) then return end

	--�����˺����ߣ�һ��ն�������һ������������
	if TargetBuff[8249] and TargetBuff[8249].nLeftTime > 18 then		--�������Ѫbuff, ����buffʣ��ʱ�����18��
		if s_util.CastSkill(13053, false) then return end				--ʩ������
	end

	--�����3�ζܻ������лض�
	local djCount, djLefttime = s_util.GetSkillCN(13047)		--��ȡ�ܻ��ĺ�ʹ�ô����ͳ���ʣ��ʱ��
	if TargetBuff[8249] and TargetBuff[8249].nLeftTime > 4 and djCount >= 2 and djLefttime < 2 then		--�������Ѫbuff������ʱ�����4��, �ܻ��������ڵ���2�����ҳ���ʣ��ʱ��С��2��(ǰ���ζܻ�2��)
		s_util.CastSkill(13051, false)							--ʩ�Ŷܻ�
		return
	end

	--�ٵ�
	if s_util.CastSkill(13052, false) then return end
end
