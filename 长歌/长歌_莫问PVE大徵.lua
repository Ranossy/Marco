--��Ѩ�������ӡ����ɷ�/���顿��ষ硿���趬�������顿��ʦ�塿�����š������Ρ������롿������������ü�����޾��ء�
--Ŀǰ���ڵ����У�����ľ׮����ս�н��в��ԣ��д������Ҫ�Ż��ĵط���ӭ����

--��ȡ�Լ���Player����û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end

--��ǰѪ����ֵ
local hpRatio = player.nCurrentLife / player.nMaxLife

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
if target then s_util.TurnTo(target.nX,target.nY) end

--���Ŀ��������ֱ�ӷ���
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--��ȡ�Լ���buff��
local MyBuff = s_util.GetBuffInfo(player)

--��ȡ�Լ���Ŀ����ɵ�buff��
local TargetBuff = s_util.GetBuffInfo(target, true)

--��ȡĿ��ȫ����buff��
local TargetBuffAll = s_util.GetBuffInfo(target)

--��ȡ�Լ���Ŀ��ľ���
local distance = s_util.GetDistance(player, target)

--��ȡ�Լ�Ӱ������
local ShadowNumber = s_util.GetShadow()

if distance > 20 then
s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
else
MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
end

--��ʼ��DOTˢ�±�־
if not g_MacroVars.State_14064 then
	g_MacroVars.State_14064 = 0				--DOTˢ�±�־
end		

if player.nPoseState ~= POSE_TYPE.YANGCUNBAIXUE then		--�������������ѩ����
		s_util.CastSkill(14070, false)						--�л�������ѩ
		return
	end

--��Ӱ�����粻��CD��Ŀ�����Ѫ��>40Wʱ����Ӱ
if s_util.GetSkillCN(14082) > 2 and s_util.GetSkillCD(14067) <=0 and target.nMaxLife > 400000 then
   if s_util.CastSkill(14081, false) then return end
end
--Ŀ�����Ѫ��С��40W���Է�Ӱ��
if ShadowNumber < 6 and target.nMaxLife < 300000  and not bPrepareMe and s_util.GetSkillCN(14082) > 0 then
   if s_util.CastSkill(14082, false) then return end
end
--��Ӱ��˫buffС��1S���ù�Ӱ
if MyBuff[9284] and MyBuff[9284].nLeftTime < 1 then
    if s_util.CastSkill(14162, false) then return end
end	

--�ͷ�������ѩ(���ȣ�
if s_util.CastSkill(14230, false, true) then return end

--��ȡ�ҵĶ�������
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(player)

--�����̡���ˢ���ӳ��ظ���������
--������ڶ���
if  dwSkillId == 14064 and nLeftTime < 0.5 then  
    g_MacroVars.State_14064 = 1 	--����ˢ��DOT��־
end

--�ж�ˢ���ҳ��ܴ������ڵ���2���ͷ���
if  g_MacroVars.State_14064 == 1 and s_util.GetSkillCN(14068) >= 2 then
if s_util.CastSkill(14068, false)  then 
	g_MacroVars.State_14064 = 0
	return 
	end   --�ͷ���
end

--Ŀ���̻�ǳ���ʱ��С��4S��û��ˢ��DOT��־������
if (TargetBuff[9357] and TargetBuff[9357].nLeftTime < 4 and g_MacroVars.State_14064 == 0) or (TargetBuff[9361] and TargetBuff[9361].nLeftTime < 4 and g_MacroVars.State_14064 == 0) then
if s_util.CastSkill(14064, false) then				--ʩ�Ź�ˢ��DOT
			g_MacroVars.State_14064 = 1             --����ˢ��DOT��־
			return
		end
	end
	
--���Ӱ�Ӳ������ҳ��ܴ���0�ҹ�ӰCD>50S�Ҳ��ڶ����ͷ�Ӱ��
if ShadowNumber < 6 and s_util.GetSkillCN(14082) > 0 and s_util.GetSkillCD(14081) > 50 and not bPrepare then
   if s_util.CastSkill(14082, false) then return end
end
--��������7Ӱ��
if ShadowNumber==6 and  s_util.GetSkillCN(14082) > 2 then
	if s_util.CastSkill(15040,true) then return end
	end
--���̣�DOT��
if not TargetBuff[9357] then
    if s_util.CastSkill(14065, false) then return end  
end

--���ǣ�DOT��
if not TargetBuff[9361] then
  if  s_util.CastSkill(14066, false) then return end  
end

--û���趬buff�����趬����2���ͷ���
if  not MyBuff[9353] or (MyBuff[9353] and MyBuff[9353].nLevel ==2 )then
    if s_util.CastSkill(14068, false)  then return end   --�ͷ���
end

--�趬buff1��ʱ��Ҫ2��������ϲ��ͷ��𣬱�֤����ʱ��
if  MyBuff[9353] and MyBuff[9353].nLevel ==1 and s_util.GetSkillCN(14068) >= 2 then
    if s_util.CastSkill(14068, false)  then return end   --�ͷ���
end

--��3���趬�Ҳ��ٹ�Ӱ�У�����
if MyBuff[9353] and MyBuff[9353].nLevel > 2 and not MyBuff[9284] then
  if  s_util.CastSkill(14067, false)  then return end  --������
end

--�������
if s_util.CastSkill(14064, false) then return end