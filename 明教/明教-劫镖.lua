
--��Ѩ���� [-][-][-][-][-][-][-][-][�����¾/�������][-][��������][ڤ�¶���]
--��֧�����ĺ˵���Ĭ��ֻ�����ʩ�ż��ܣ�Ҫ����NPC�谴��"F"��
--��7����Ѩѡ���ƶ����λ���25���еж�����ʱ�Զ����ƣ�����Ҫ�ɰ�ס"G"ȡ������ģʽ
--��ս��״̬���Զ�������ס��Alt��ȡ���Զ�����û��д�����Զ���أ���ס��Z����ǿ������
--Ĭ���Զ��ս�ѣ�ο��ƣ�����Ҫ�ɰ�ס"F"����ħ����
--Ĭ��ս��״̬���Զ�׷���Ʊ�����ס��Alt��ȡ��

--������ɡ
s_util.Cast(18876, false)

--��ͷ������������Ȼ�ȡ�Լ��Ķ���û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end

--��ս����
if (not player.bFightState and not s_util.GetBuffInfo(player)[4052] or IsKeyDown("Z")) and not IsAltKeyDown() then
    s_util.Cast(3974, false)
end

--̰ħ����ֹͣ׷��
if s_util.GetBuffInfo(player)[4439] then return end

--------------------��������������������ʼ��������--------------------
--�ж϶���B�Ƿ��ڶ���A������������
--����������A,����B,�����(�Ƕ���)
local function Is_B_in_A_FaceDirection(pA, pB, agl)
	local rd = (pA.nFaceDirection%256)*math.pi/128
    local dx = pB.nX - pA.nX;
    local dy = pB.nY - pA.nY;
	local length = math.sqrt(dx*dx+dy*dy);
    return math.acos(dx/length*math.cos(rd)+dy/length*math.sin(rd)) < agl*math.pi/360;
end

--����
local BaoFa = s_tBuffFunc.BaoFa
--����
local JianLiao = s_tBuffFunc.JianLiao
--����
local JinLiao = s_tBuffFunc.JinLiao
--�޵�
local WuDi = s_tBuffFunc.WuDi
--��Ĭ
local ChenMo = s_tBuffFunc.ChenMo
--���
local MianKong = s_tBuffFunc.MianKong
--����
local JianShang = s_tBuffFunc.JianShang
--����
local JianSu = s_tBuffFunc.JianSu
--ѣ��
local XuanYun = s_tBuffFunc.XuanYun
--����
local SuoZu = s_tBuffFunc.SuoZu
--����
local DingShen = s_tBuffFunc.DingShen
--����
local ShanBi = s_tBuffFunc.ShanBi
--���Ṧ
local FengQingGong = s_tBuffFunc.FengQingGong
--�����
local MianFengNei = s_tBuffFunc.MianFengNei
--�ı�����
local ChFace = s_tBuffFunc.ChFace
--------------------������������������������������--------------------

--------------------��������Ŀ�괦������ʼ��������--------------------
--��ȡ��ǰĿ��,δ��սûĿ��ֱ�ӷ���,ս����ûĿ��ѡ��Ѫ�����ٵ����,��������
--����"F"��ѡ��NPC
local target, targetClass = s_util.GetTarget(player)	
if IsKeyDown("F") then	
    if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end
    if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
        local MinDistance = 20			--��С����
        local MindwID = 0		    --���NPC��ID
        for i,v in ipairs(GetAllNpc()) do		--��������NPC
            if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nLevel>0 then
                MinDistance = s_util.GetDistance(v, player)   
                MindwID = v.dwID     --�滻�����ID
            end
        end
        if MindwID == 0 then 
            return --û�еж�NPC�򷵻�
        else	
            SetTarget(TARGET.NPC, MindwID)
        end
    end
else
    if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID)) and targetClass~=TARGET.PLAYER then return end
    if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) or targetClass~=TARGET.PLAYER or target.nMoveState == MOVE_STATE.ON_DEATH then  
        local MinDistance = 20		
        local MindwID = 0
        local MinHp = 80000		    
        for i,v in ipairs(GetAllPlayer()) do		--����
            if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nMoveState ~= MOVE_STATE.ON_DEATH and v.nCurrentLife < MinHp then
                MinHp = v.nCurrentLife
                MindwID = v.dwID
            end
        end
        if MindwID == 0 then 
            return
        else
            SetTarget(TARGET.PLAYER, MindwID)  --�趨Ŀ��
        end
    end
end
local target, targetClass = s_util.GetTarget(player)

--���û��Ŀ���Ŀ��������ֱ�ӷ���
if not target or target.nMoveState == MOVE_STATE.ON_DEATH then return end
--------------------------��������Ŀ�괦����������������-------------------------

--------------------------��������������������ʼ��������-------------------------

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

--����Ŀ���Ѫ����
local thpRatio = target.nCurrentLife / target.nMaxLife

--����������
local CurrentSun=player.nCurrentSunEnergy/100
local CurrentMoon=player.nCurrentMoonEnergy/100

--�糵
local tfengche = nil
local mefengche = nil

--��������
local near_zhiliao = nil
--------------------------������������������������������-------------------------

--------------------------��������������������ʼ��������-------------------------

local npc = s_util.GetNpc(57739, 30) --��ȡ30���ڵ����ַ糵
local me = GetClientPlayer()
local zhiliao_kungfu = {[10176] = "����", [10448] = "��֪", [10028] = "�뾭", [10080] = "����" }
if npc and IsEnemy(me.dwID, npc.dwID) then
    if s_util.GetDistance(me, npc) <=10 then mefengche = 1 end
    if s_util.GetDistance(target, npc) <=10 then tfengche = 1 end
end

for i,v in ipairs(GetAllPlayer()) do	--������Χ���
    local disme = s_util.GetDistance(me, v)
    if  disme < 25 and v.nMoveState ~= MOVE_STATE.ON_DEATH and IsEnemy(me.dwID, v.dwID) then
        local distar = s_util.GetDistance(target, v)
        local bPrepare,dwSkillId = GetSkillOTActionState(v)
        if dwSkillId == 1645 or dwSkillId == 16381 then --�ж϶����糵
            if disme <= 10 then mefengche = 2 end
            if distar <= 10 then tfengche = 2 end
        end
        if not near_zhiliao then --�ж�25���ڵĵз�����
            if v.dwMountKungfuID then
                if zhiliao_kungfu[v.dwMountKungfuID] then
                    near_zhiliao = 1
                end
            else
                local kungfu = v.GetKungfuMount()
                if kungfu and zhiliao_kungfu[kungfu.dwSkillID] then
                    near_zhiliao = 1
                end
            end	
        end
    end
end

--------------------------������������������������������-------------------------

--------------------------��������׷��λ������ʼ��������-------------------------

--��������
if target and not tfengche and not mefengche and IsEnemy(player.dwID, target.dwID) and not WuDi(target) and not IsAltKeyDown() then 
    s_util.TurnTo(target.nX,target.nY) 
end

--��Ŀ�����>8��,ս������Ŀ�긽���޷糵 ʹ�����⣬����CDʹ�ûùⲽ
if not s_util.GetTalentIndex(12)==2 then 
if not tfengche and not mefengche and IsEnemy(player.dwID, target.dwID) and not WuDi(target) and not IsAltKeyDown() then
    if distance > 8 and player.bFightState then if s_util.Cast(3970,false) then return end end--�ù�
    if distance > 8 and player.bFightState then if s_util.Cast(18633,false) then return end end--�ù�

    --׷��+����˹
    if not IsKeyDown("W") then
        if Is_B_in_A_FaceDirection(target, player, 180) or distance > 3.5 then
            s_util.TurnTo(target.nX,target.nY) 
            MoveForwardStart()
        else
            MoveForwardStop()
            s_util.TurnTo(target.nX,target.nY)
        end
    end
end
end
--------------------------��������׷��λ����������������-------------------------

--------------------------��������Ӧ����������ʼ��������-------------------------

--�رܿ���
if not MianKong(player) and not WuDi(player) then 
    if s_util.GetTimer("tkongzhi1")>0 and s_util.GetTimer("tkongzhi1")<1000 then
        s_util.Cast(9004, false)
		s_util.Cast(9005, false)
		s_util.Cast(9006, false)
		s_util.Cast(9007, false)
        s_Output("�رܿ���")
    end
    if s_util.GetTimer("tkongzhi2")>0 and s_util.GetTimer("tkongzhi2")<1000 and not tfengche then
        s_util.Cast(3977, false) 
        s_Output("�رܿ���")
    end
    if s_util.GetTimer("tkongzhi2")>0 and s_util.GetTimer("tkongzhi2")<1000 then
        s_util.Cast(3973, false)
		s_util.Cast(3977, false)
		s_util.Cast(3973, false)
		s_util.Cast(9004, false) 
		s_util.Cast(9005, false)
		s_util.Cast(9006, false)
		s_util.Cast(9007, false)
        s_Output("�رܿ���")
    end
end

--�ر��˺�
if not JianShang(player) and not WuDi(player) and not MyBuff[12491] and not MyBuff[4052] then
    --���´�����������������
    if s_util.GetTimer("tbaofa1")>0 and hpRatio < 0.7 and thpRatio>0.3 and s_util.GetTimer("tbaofa1")<1500 then
        s_util.Cast(3973,true) 
        s_Output("�رܱ���")
    end
    --������׷��
    if s_util.GetTimer("tbaofa3")>3000 and s_util.GetTimer("tbaofa3")<5000 then
        s_util.Cast(3973,true) 
        s_Output("�ر�����׷��")
    end
    --������
    if s_util.GetTimer("tbaofa2")>0 and s_util.GetTimer("tbaofa2")<5000 and thpRatio>0.3 and MyBuff[2920] then
        s_util.Cast(3973,true) 
        s_Output("�ر�����")
    end
    --�з��޵�ʱ������
    if WuDi(target) and hpRatio < 0.70 then
        s_util.Cast(3973,true) 
        s_Output("�ر��޵�")
    end
end

--�رܷ糵�������糵���ȷ�ҡ�������ַ糵ֱ������̰ī
if mefengche==1 and not WuDi(player) then
    ChFace(128)
    s_util.Cast(9003,false)
	s_util.Cast(3973,true)
end
if mefengche==2 and not WuDi(player) then
    if MyBuff[208] then 
        s_util.Jump()
    else
        ChFace(128)
        s_util.Cast(9003,false)
		s_util.Cast(3973,true)
    end
end

--�����ں�ת������
if ChenMo(player) and ChenMo(player).nLeftTime > 2000 and distance < 4 then 
    ChFace(128) --�ı�����180��
    if MyBuff[208] then 
        s_Output("�رܷ���")
        s_util.Jump()
        return
    else
        s_util.Cast(9003,false)
        s_Output("�رܷ���")
    end
end

--�Զ���ҡ
if not s_util.GetTalentIndex(12)==2 then 
if distance< 50 and not MyBuff[208] then
	s_util.Cast(9002,true)
end
end

--��������
if player.nMoveState == MOVE_STATE.ON_SKILL_MOVE_DST then
    s_util.Cast(9003,false)
end 	

--�Զ��Լ���ҩ
if hpRatio < 0.4 and s_util.GetItemCount(5, 29036) > 1 and s_util.GetItemCD (5, 29036, true) < 0.5 then
    s_util.UseItem(5,29036)
end

--�ж϶���buffˢ��ͣ��
if s_util.GetTimer("dunli") > 0 and s_util.GetTimer("dunli") <= 1500 then OutputWarningMessage("MSG_WARNING_RED", "����ͣ��",1) s_util.StopSkill() return end

--�޵�ͣ�ֲ��������
if WuDi(target) then 
    OutputWarningMessage("MSG_WARNING_RED", "Ŀ���޵�-"..Table_GetBuffName(WuDi(target).dwID, WuDi(target).nLevel),1)
    return 
end

--�´���
if distance< 12 and hpRatio < 0.7 then
    s_util.Cast(18629,false)
end

--------------------------��������Ӧ��������������������-------------------------


--------------------------�����������ѭ������ʼ��������-------------------------
if not  s_util.GetTalentIndex(12)==2 then 
--������߻�
if not MianKong(target) and not WuDi(target) and TargetBuffAll[203] and  thpRatio<0.2 and not MyBuff[12491] then
    s_util.Cast(4910,false)
end

--��������Ŀ��
if not MianKong(target) and not WuDi(target) and TargetBuffAll[244] then
    s_util.Cast(4910,false)
end
end

--������� �޵� ��Ĭ ѣ�� ��Ŀ���ؤ�˫���Ե����ͷŽ�е
if not MianFengNei(target) and (not ChenMo(target) or ChenMo(target).nLeftTime<500) and target.nMoveState ~= MOVE_STATE.ON_HALT and not WuDi(target) and target.dwForceID ~= FORCE_TYPE.GAI_BANG and  target.nPoseState ~= POSE_TYPE.DOUBLE_BLADE and not IsKeyDown("F") then
	s_util.Cast(3975,false)
end

--[[���Ŀ��Ѫ������50,���ҽ�еCD����5��,���ý�еcd	
if  thpRatio < 0.5 and s_util.GetSkillCD(3975) > 5 and target.dwForceID ~= FORCE_TYPE.GAI_BANG and  target.nPoseState ~= POSE_TYPE.DOUBLE_BLADE then
	s_util.Cast(3979,false)
    s_util.Cast(3978, false)
end--]]

--������ҹ����еȫ��CDʱ����
if  s_util.GetSkillCD(3974) > 10 and  s_util.GetSkillCD(3979) > 2 and s_util.GetSkillCD(3975) > 2 and not ChenMo(target) then
	s_util.Cast(3978, false)
end

--������û��ͬ�ԣ�������
if (player.nSunPowerValue>0) and player.bFightState then
	s_util.Cast(3969,true)
end

--����"F"���������٣���ħ����
--�սټ���,����G���Ҽ���
if not  s_util.GetTalentIndex(12)==2 then 
	if s_util.GetTalentIndex(7)==4 and player.nSunPowerValue >0 and not JianLiao(target) and not JinLiao(target)  and targetClass==TARGET.PLAYER and near_zhiliao and not MyBuff[4052] and (not IsKeyDown("G") or not IsKeyDown("F")) then
		s_util.Cast(3966,false)
		s_Output("�սټ���")
	end

	--�ս�ѣ��
	if player.nSunPowerValue >0 and not MianKong(target) and (not ChenMo(target) or ChenMo(target).nLeftTime<500) and (not XuanYun(target) or XuanYun(target).nLeftTime<500) and not SuoZu(target) and not DingShen(target) and not IsKeyDown("F") and targetClass==TARGET.PLAYER then
		s_util.Cast(3966,false) 
		s_Output("�ս�ѣ��")
	end
end

--�մ�
if distance< 6 then
    s_util.Cast(18626,false)
end

--�´�
if distance< 12 and not JianShang(target) and player.nMoonPowerValue >0 then
    s_util.Cast(18629,false)
end

--��ħ 
if player.nSunPowerValue >0 or player.nMoonPowerValue >0 then
    s_util.Cast(3967,false)
end

--��ҹ
if CurrentMoon < 100 and CurrentSun < 100 then
    s_util.Cast(3979,false)
end

--����ն
if CurrentMoon < 100 and CurrentSun < 100 and CurrentSun < CurrentMoon then
    s_util.Cast(3960,false)
end
--����ն
if CurrentMoon < 100 and CurrentSun < 100 and CurrentSun > CurrentMoon then
    s_util.Cast(3963,false)
end

--����ն
if CurrentMoon < 100 and CurrentSun < 100 then
    s_util.Cast(3960,false)
end
--����ն
if CurrentMoon < 100 and CurrentSun < 100 then
    s_util.Cast(3963,false)
end

--������ڵ��������Ҳ�����ʱ��������
if CurrentSun <= CurrentMoon and CurrentMoon < 100 then
    s_util.Cast(3959,false)
end

--������������Ҳ�����ʱ�������
if CurrentSun > CurrentMoon and CurrentSun < 100 then
    s_util.Cast(3962,false)
end