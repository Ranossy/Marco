--��ȡ��ң�û�����˵��û������Ϸ
local player = GetClientPlayer()
if not player then return end

--��ȡ�Լ�Ѫ���ٷֱ�
local hpRatio = player.nCurrentLife / player.nMaxLife

--��ȡĿ�꣬ս����û��Ŀ��ѡ������ĵж�NPC
local target, targetClass = s_util.GetTarget(player)							
if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end 
if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
	local MinDistance = 20			--��С����
	local MindwID = 0		    --NPC��ID
	for i,v in ipairs(GetAllNpc()) do		--����NPC
		if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance then	--�ж��Ҿ������
			MinDistance = s_util.GetDistance(v, player)                             
			MindwID = v.dwID                                                                    --�滻��С�����ID
		end
	end
	if MindwID == 0 then 
		return --û�еж�NPC����
	else	
    	SetTarget(TARGET.NPC, MindwID)  --����Ŀ��Ϊ���NPC                
	end
end
if target then s_util.TurnTo(target.nX,target.nY) end  --��������

--Ŀ������ֱ�ӷ���
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--��ȡĿ��Ķ�����Ϣ
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)

--��ȡ�Լ��Ķ�����Ϣ
local bPrepareMe, dwSkillIdMe, dwLevelMe, nLeftTimeMe, nActionStateMe =  GetSkillOTActionState(player)	

--��ȡ�Լ���BUFF�б�
local MyBuff = s_util.GetBuffInfo(player)

--��ȡ�Լ���Ŀ����ɵ�BUFF�б�
local TargetBuff = s_util.GetBuffInfo(target, true)

--��ȡĿ��ȫ����BUFF�б�
local TargetBuffAll = s_util.GetBuffInfo(target)

--��ȡ�Լ���Ŀ��ľ���
local distance = s_util.GetDistance(player, target)

--DPS�ϻ�����
local laohu=s_util.GetNpc(36688,40)
if laohu then SetTarget(TARGET.NPC, laohu.dwID) s_util.TurnTo(laohu.nX,laohu.nY) end

--���볬��3.5����ǰ����Ŀ��
if distance > 3.5 then
	s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
else
	MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
end

--�ر���BOSS��������
if dwSkillId == 9241 and nLeftTime > 0.5 then if s_util.CastSkill(9007,false,true) then return end end   --Ұ�˹Ȼ�����غ���

--�ر���BOSS���ߴ���
if TargetBuffAll[7929] then if s_util.UseItem(5,21534) then return end end	--ҹ��ɽ�޵���ɢ

--�ر��������˺����
local xianjing = 0
for i,v in ipairs(GetAllNpc()) do		--������ΧNPC
	if  v.dwTemplateID==36780 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����л�Ȧ
		xianjing = 1                                                                
	end
	if  v.dwTemplateID==36774 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����еش�
		xianjing = 1                                                                
	end
end
if xianjing ==1 then
	s_util.TurnTo(target.nX, target.nY) StrafeLeftStart()
else
	StrafeLeftStop() s_util.TurnTo(target.nX, target.nY) 
end

--DPSҰ�˹�BOSS OT��ҡ
if target.dwTemplateID==36680 and s_util.GetTarget(target).dwID== player.dwID then
    s_util.CastSkill(9002,false,true)
	if(playerBuffs[208]) then Jump() end
	return
end