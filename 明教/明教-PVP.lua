
---���������Լ��ֶ���û��д�����Զ����
--�ű�˵��("��Ѩ���� \n  [[Ѫ�����][��������][��ԭ�һ�][�Ʒ�����|������ʥ][�����·][��ҫ�쳾][�ƶ�����][��Ȼ����][�����¾][��Ӱ����][��������][ڤ�¶���]  \n  \n ���Ӽ���ģʽ����ģʽ��Գ�����ʥ��Ѩд�ģ������ϼ���(��������ն��ͻ�������ģʽ��������ħ�����������پͻ��л�������ͨ�����ģʽ  \n  \n �����Ҫ�ֶ����⣬�Ƽ���������������ر�����׷������Ϊ�ű����Զ����������Ч�Ļر�ĳЩְҵ�Ŀ��� \n �����ռ�  3/26 �޸�����BUG���½ű��������� ")
--todo ������ Ԥ�к��� �ı�������

--��ͷ������������Ȼ�ȡ�Լ��Ķ���û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end

--��ս����
if (not player.bFightState and not s_util.GetBuffInfo(player)[4052]) or IsKeyDown("Z") then
    if s_util.CastSkill(3974, false) then return end
end

--̰ħ����ֹͣ׷��
if s_util.GetBuffInfo(player)[4439] then return end

if IsKeyDown("T") then
    SetTarget(TARGET.PLAYER, player.dwID)
    if s_util.CastSkill(18633,false) then return end 
end
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
if target then s_util.TurnTo(target.nX,target.nY) end  --��������

--���Ŀ��������ֱ�ӷ���
if target.nMoveState == MOVE_STATE.ON_DEATH then return end
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
local tfengche = s_tBuffFunc.FengChe(target)
local mefengche = s_tBuffFunc.FengChe(player)
--------------------------������������������������������-------------------------

--------------------------��������׷��λ������ʼ��������-------------------------

--��Ŀ�����>8��,ս������Ŀ�긽���޷糵 ʹ�����⣬����CDʹ�ûùⲽ
if not tfengche and not mefengche and IsEnemy(player.dwID, target.dwID) and not WuDi(target) then
    if distance > 8 and player.bFightState then if s_util.CastSkill(3977,false) then return end end --����
    if distance > 8 and player.bFightState then if s_util.CastSkill(3970,false) then return end end --�ù�

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
--------------------------��������׷��λ����������������-------------------------

--------------------------��������Ӧ����������ʼ��������-------------------------

--�رܿ���
if not MianKong(player) and not WuDi(player) then 
    if s_util.GetTimer("tkongzhi1")>0 and s_util.GetTimer("tkongzhi1")<1000 then
        if s_util.CastSkill(9004, false) or s_util.CastSkill(9005, false) or s_util.CastSkill(9006, false) or s_util.CastSkill(9007, false) then
            s_Output("�رܿ���")
            return
        end
    end
    if s_util.GetTimer("tkongzhi2")>0 and s_util.GetTimer("tkongzhi2")<1000 and not tfengche then
        if s_util.CastSkill(3977, false) then s_Output("�رܿ���") return end
    end
    if s_util.GetTimer("tkongzhi2")>0 and s_util.GetTimer("tkongzhi2")<1000 then
        if s_util.CastSkill(3973, false) or s_util.CastSkill(3977, false) or s_util.CastSkill(3973, false) or s_util.CastSkill(9004, false) or s_util.CastSkill(9005, false) or s_util.CastSkill(9006, false) or s_util.CastSkill(9007, false) then
            s_Output("�رܿ���")
            return
        end
    end
end

--�ر��˺�
if not JianShang(player) and not WuDi(player) and not MyBuff[12491] and not MyBuff[4052] then
    --���´�����������������
    if s_util.GetTimer("tbaofa1")>0 and hpRatio < 0.7 and thpRatio>0.3 and s_util.GetTimer("tbaofa1")<1500 then
        if s_util.CastSkill(3973,true) then s_Output("�ر��˺�") return end
    end
    --������׷��
    if s_util.GetTimer("tbaofa3")>3000 and s_util.GetTimer("tbaofa3")<5000 then
        if s_util.CastSkill(3973,true) then s_Output("�ر��˺�") return end
    end
    --������
    if s_util.GetTimer("tbaofa2")>0 and s_util.GetTimer("tbaofa2")<5000 and thpRatio>0.3 and MyBuff[2920] then
        if s_util.CastSkill(3973,true) then s_Output("�ر��˺�") return end
    end
    --�з��޵�ʱ������
    if WuDi(target) and hpRatio < 0.75 then
        if s_util.CastSkill(3973,true) then s_Output("�ر��˺�") return end
    end
end

--�رܷ糵�������糵���ȷ�ҡ�������ַ糵ֱ������̰ī
if mefengche==2 and not WuDi(player) then
    if MyBuff[208] then 
        s_util.Jump()
    else
        if s_util.CastSkill(9003,false) or s_util.CastSkill(3973,true) then return end
    end
end
if mefengche==1 and not WuDi(player) then
        if s_util.CastSkill(9003,false) or s_util.CastSkill(3973,true) then return end
end

--�����ں�ת������
if ChenMo(player) and  ChenMo(player).nLeftTime > 2000 then 
    ChFace(128)
    if MyBuff[208] then 
        s_util.Jump()
    else
        if s_util.CastSkill(9003,false) then return end
    end
end

--�Զ���ҡ
if distance< 50 and not MyBuff[208] then
	if s_util.CastSkill(9002,true) then return end
end

--��������
if player.nMoveState == MOVE_STATE.ON_SKILL_MOVE_DST then
    if s_util.CastSkill(9003,false) then return end
end 	

--�Զ��Լ���ҩ
if hpRatio < 0.4 and s_util.GetItemCount(5, 29036) > 1 and s_util.GetItemCD (5, 29036, true) < 0.5 then
    s_util.UseItem(5,29036)
end
--�ж϶���buffˢ��ͣ��
if s_util.GetTimer("dunli") > 0 and s_util.GetTimer("dunli") <= 1500 then OutputWarningMessage("MSG_WARNING_RED", "����ͣ��") s_util.StopSkill() return end

--ͣ��
if WuDi(target) then OutputWarningMessage("MSG_WARNING_RED", "Ŀ���޵�") s_util.StopSkill() return end

--�´���
if distance< 12 and hpRatio < 0.7 then
    if s_util.CastSkill(18629,false) then return end
end

--------------------------��������Ӧ��������������������-------------------------


--------------------------�����������ѭ������ʼ��������-------------------------

--������߻�
if not MianKong(target) and not WuDi(target) and TargetBuffAll[203] and  thpRatio<0.2 and not MyBuff[12491] then
    if s_util.CastSkill(4910,false) then return end 
end

--��������Ŀ��
if not MianKong(target) and not WuDi(target) and TargetBuffAll[244] then
    if s_util.CastSkill(4910,false) then return end 
end

--���������
if s_util.GetSkillCD(3978) > 115 and not MyBuff[4052] then
    if s_util.CastSkill(3974, false) then return end
end

--������ҹ����еȫ��CDʱ����
if  s_util.GetSkillCD(3974) > 10 and  s_util.GetSkillCD(3979) > 2 and s_util.GetSkillCD(3975) > 2 and not ChenMo(target) then
    if s_util.CastSkill(3978, false) then return end
end

--����� ��Ĭ ѣ�� �޵о��ͷŽ�е
if not MianKong(target) and not ChenMo(target) and not XuanYun(target) and not WuDi(target) and not IsKeyDown("F") then
    if s_util.CastSkill(3975,false) then return end 
end

--���ջ�������û��ͬ�ԣ�������
if (player.nSunPowerValue>0) then
	if s_util.CastSkill(3969,true) then return end
end

--����"F"���������٣���ħ����
if not IsKeyDown("F") and s_util.GetTalentIndex(7)==4 then
    --�սټ���
    if player.nSunPowerValue >0 and not JianLiao(target) and not JinLiao(target) then
        if s_util.CastSkill(3966,false) then return end 
    end
end

--�ս�ѣ��
if player.nSunPowerValue >0 and not MianKong(target) and not ChenMo(target) and not XuanYun(target) and not SuoZu(target) and not DingShen(target) and not IsKeyDown("F") then
    if s_util.CastSkill(3966,false) then return end 
end

--�մ�
if distance< 6 and not JianShang(target) and CurrentMoon < 100 then
    if s_util.CastSkill(18626,false) then return end
end

--�´�
if distance< 12 and not JianShang(target) and player.nMoonPowerValue >0 then
    if s_util.CastSkill(18629,false) then return end
end

--��ħ
if s_util.CastSkill(3967,false) then return end

--��ҹ
if CurrentMoon < 100 and CurrentSun < 100 then
    if s_util.CastSkill(3979,false) then return end
end

--����ն
if CurrentMoon < 100 and CurrentSun < 100 then
    if s_util.CastSkill(3960,false) then return end
end
--����ն
if CurrentMoon < 100 and CurrentSun < 100 then
    if s_util.CastSkill(3963,false) then return end
end

--������ڵ��������Ҳ�����ʱ��������
if CurrentSun <= CurrentMoon and CurrentMoon < 100 then
    if s_util.CastSkill(3959,false) then return end
end

--������������Ҳ�����ʱ�������
if CurrentSun > CurrentMoon and CurrentSun < 100 then
    if  s_util.CastSkill(3962,false)  then return end
end