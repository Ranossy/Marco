--���������������������۱�д�����ѭ���ϸ�ִ�С���ն����ն���ơ�����������ӯ�ڼ佻���ֵ�����
--��Ѩ���������â�����������񡿡������ۻ𡿡�����ҵ�𡿡�������ա�����ҫ�쳾���������š�������ͬ�ԡ��������¾��������ٻҡ��������������������𷨡�
--���ԣ����������С�����Ҫ��318�����ٵ��˻�Ӱ������bug�����ʣ��ٸ�һ�λ�����մ���
--�ؼ�����Ҫ�κλ����ؼ���������������飬��DPSû�������������ѭ��
--�ӳ٣������ӳ����С��100����Ȼ���������ӳٿ��ܻ��̵�����

--��ͷ������������Ȼ�ȡ�Լ��Ķ���û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end

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
		MindwID = v.dwID                                                                    --�滻�����ID
		end
	end
if MindwID == 0 then 
    return --û�еж�NPC�򷵻�
else	
    SetTarget(TARGET.NPC, MindwID)  --�趨Ŀ��Ϊ����ĵж�NPC                
end
end
local target, targetClass = s_util.GetTarget(player)
if target then s_util.TurnTo(target.nX,target.nY) end  --��������

--�ж϶���B�Ƿ��ڶ���A������������
--����������A,����B,�����(�Ƕ���)
local function Is_B_in_A_FaceDirection(pA, pB, agl)
	local rd = (pA.nFaceDirection%256)*math.pi/128
    local dx = pB.nX - pA.nX;
    local dy = pB.nY - pA.nY;
	local length = math.sqrt(dx*dx+dy*dy);
    return math.acos(dx/length*math.cos(rd)+dy/length*math.sin(rd)) < agl*math.pi/360;
end



--���Ŀ��������ֱ�ӷ���
if not target or target.nMoveState == MOVE_STATE.ON_DEATH then return end

--��ȡ�Լ���Ŀ��ľ���
local distance = s_util.GetDistance(player, target)

--��ȡ�Լ��Ķ�������
local bPrepareMe, dwSkillIdMe, dwLevelMe, nLeftTimeMe, nActionStateMe =  GetSkillOTActionState(player)	

--��ȡ�Լ���buff��
local MyBuff = s_util.GetBuffInfo(player)

--��ȡ�Լ���Ŀ����ɵ�buff��11
local TargetBuff = s_util.GetBuffInfo(target, true)

--��ȡĿ��ȫ����buff��
local TargetBuffAll = s_util.GetBuffInfo(target)

--�ж�Ŀ�����������û�������������ж϶����ļ���ID����Ӧ����(��ϡ�ӭ����ˡ�����ȵ�)
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)		--���� �Ƿ��ڶ���, ����ID���ȼ���ʣ��ʱ��(��)����������
if target.dwTemplateID == 58340 and dwSkillId ==18387 and not TargetBuffAll[12348] then
    s_util.Cast(3961,false)
end
--����������
local CurrentSun=player.nCurrentSunEnergy/100
local CurrentMoon=player.nCurrentMoonEnergy/100

--��Ŀ�����>8��ʹ�����⣬����CDʹ�ûùⲽ
if distance > 8 then s_util.Cast(3977,false) end --����
if distance > 8 then s_util.Cast(3970,false) end --�ù�
--�ж�player�Ƿ���target��180������������
if (Is_B_in_A_FaceDirection(target, player, 180) and s_util.GetTarget(target).dwID ~= player.dwID) or distance > 3.5 then
	s_util.TurnTo(target.nX,target.nY) 
	MoveForwardStart()
end
if (not Is_B_in_A_FaceDirection(target, player, 180) or s_util.GetTarget(target).dwID == player.dwID) and distance < 3.5 then 
	MoveForwardStop()
	s_util.TurnTo(target.nX,target.nY)
end

--������û��ͬ�ԣ�������
if player.nSunPowerValue > 0 and (not MyBuff[4937] or MyBuff[4937] and MyBuff[4937].nLevel ~= 2)   then
	s_util.Cast(3969,true)
end

--��60���մ�
if CurrentSun > 59 and CurrentSun <=79 then s_util.Cast(18626,true) end

--��ħ
s_util.Cast(3967,false)

--��0 ��0,�����֣���80 ��40��������
if (CurrentMoon <= 19 and CurrentSun <= 19 ) or (CurrentSun >79 and CurrentSun <=99 and CurrentMoon >39 and CurrentMoon <=59 ) then 
    s_util.Cast(3959,false)
end
--��0 ��20 ����ӯ�У�������
if CurrentSun <= 19 and CurrentMoon >19 and CurrentMoon <=39 and MyBuff[12487] then 
    s_util.Cast(3959,false)
end

--��0 ��40 �ҷ���ӯ�У���ն
if  CurrentSun <= 19 and CurrentMoon >39 and CurrentMoon <=59 and not MyBuff[12487] then
    s_util.Cast(3963,false)
end
--��20 ��20 �ҷ���ӯ�У���ն
if CurrentSun >19 and CurrentSun <=39 and CurrentMoon >19 and CurrentMoon <=39 and not MyBuff[12487] then 
    s_util.Cast(3963,false)
end

--��0 ��20 �ҷ���ӯ�У�������
if CurrentSun <= 18 and CurrentMoon >19 and CurrentMoon <=39 and not MyBuff[12487] then 
    s_util.Cast(3962,false)
end
--��60 ��60 �ҷ���ӯ�У�������
if CurrentSun >59 and CurrentSun <=79 and CurrentMoon >59 and CurrentMoon <=79 and not MyBuff[12487] then
    s_util.Cast(3962,false)
end


--��60 ��20����ҹ
if  CurrentSun >59 and CurrentSun <=79 and CurrentMoon >19 and CurrentMoon <=39 then
    s_util.Cast(3979,false)
end
--��40 ��40����ҹ
if  CurrentSun >39 and CurrentSun <=59 and CurrentMoon >39 and CurrentMoon <=59 then
	s_util.Cast(3979,false)
end

--��80 ��60����ն
if CurrentSun >79 and CurrentSun <=99 and CurrentMoon >59 and CurrentMoon <=79 then
    s_util.Cast(3960,false) 
end 

--���겹����
if CurrentSun < 100 and CurrentMoon < 100 and player.nSunPowerValue <= 0 and player.nMoonPowerValue <= 0 then
    s_util.Cast(3959,false)
end