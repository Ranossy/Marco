--[[
��Ѩ����ʥ���������ȱ��ġ������𡿡��¾�����������ŵ���������������������Ե��������š����ɶ�����������ͬ�ԡ�������������Ļ�̾��
1.��Ѩ������Ҫ���е�������11����Ѩ�����������Ӱ������ѭ����
2.Ĭ��ս�����Զ���Ŀ���Զ�ѡĿ�꣬�Զ�׷�����Զ����ն���Զ��ȱ�Ը������������١�
3.���ú������Ҳ๤������ֲ˵����ҵ�"����PVE�깤��"�˵��Զ�����������
--]]

--��ͷ������������Ȼ�ȡ�Լ��Ķ���û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end

--------------------------���������Զ���˵�����ʼ��������-------------------------
--����˵���ȫ�ֱ�����
if not g_MacroVars.Mingjiao_MingZun then
    g_MacroVars.Mingjiao_MingZun = {
        ["Auto_Target"] = true,   --ս�����Զ�ѡ��Ŀ�꣬Ĭ�Ͽ���
        ["Auto_Move"] = true,     --�Զ�׷����Ĭ�Ͽ���
        ["Auto_Jiehuo"] = true,   --�Զ����ն��Ĭ�Ͽ���
        ["Auto_Cibei"] = true,    --�Զ��ȱ�Ը��Ĭ�Ͽ���
        ["Mode_FullPow"] = 1,     --����ģʽ��Ĭ��˫������
    }
end

--������ֲ˵� Ϊȫ�ֱ���
if not g_MacroVars.Mingjiao_MingZun.TollMenu then
    g_MacroVars.Mingjiao_MingZun.TollMenu = {
        szOption = "����������",
        szIcon = "ui/Image/icon/mingjiao_taolu_7.UITex",
        nFrame =105,
        nMouseOverFrame = 106,
        szLayer = "ICON_RIGHT",
        {
            szOption = "�Զ�Ŀ��",
            bCheck = true, 
            bChecked =function() return g_MacroVars.Mingjiao_MingZun.Auto_Target end,
            fnAction =function() 
                g_MacroVars.Mingjiao_MingZun.Auto_Target = not g_MacroVars.Mingjiao_MingZun.Auto_Target
            end,
        },
        {
            szOption = "�Զ�׷��",
            bCheck = true, 
            bChecked =function() return g_MacroVars.Mingjiao_MingZun.Auto_Move end,
            fnAction =function() 
                g_MacroVars.Mingjiao_MingZun.Auto_Move = not g_MacroVars.Mingjiao_MingZun.Auto_Move
            end,
        },
        {
            szOption = "�Զ����",
            szIcon = "ui/Image/icon/skill_mingjiao14.UITex",
            nFrame =105,
            nMouseOverFrame = 106,
            szLayer = "ICON_RIGHT",
            bCheck = true, 
            bChecked =function() return g_MacroVars.Mingjiao_MingZun.Auto_Jiehuo end,
            fnAction =function() 
                g_MacroVars.Mingjiao_MingZun.Auto_Jiehuo = not g_MacroVars.Mingjiao_MingZun.Auto_Jiehuo
            end,
        },
        {
            szOption = "�Զ��ȱ�",
            szIcon = "ui/Image/icon/skill_mingjiao35.UITex",
            nFrame =105,
            nMouseOverFrame = 106,
            szLayer = "ICON_RIGHT",
            bCheck = true, 
            bChecked =function() return g_MacroVars.Mingjiao_MingZun.Auto_Cibei end,
            fnAction =function() 
                g_MacroVars.Mingjiao_MingZun.Auto_Cibei = not g_MacroVars.Mingjiao_MingZun.Auto_Cibei
            end,
        },
        {   szOption = "����ģʽѡ��",
            {
                szOption = "����˫��",
                szIcon = "ui/Image/icon/skill_mingjiao29.UITex",
                nFrame =105,
                nMouseOverFrame = 106,
                szLayer = "ICON_RIGHT",
                bMCheck=true,
                bCheck = true, 
                bChecked =function() return g_MacroVars.Mingjiao_MingZun.Mode_FullPow == 1 end,
                fnAction =function() 
                    g_MacroVars.Mingjiao_MingZun.Mode_FullPow = 1
                end,
            },
            {
                szOption = "����˫��",
                szIcon = "ui/Image/icon/skill_mingjiao31.UITex",
                nFrame =105,
                nMouseOverFrame = 106,
                szLayer = "ICON_RIGHT",
                bMCheck=true,
                bCheck = true, 
                bChecked =function() return g_MacroVars.Mingjiao_MingZun.Mode_FullPow == 2 end,
                fnAction =function() 
                    g_MacroVars.Mingjiao_MingZun.Mode_FullPow = 2
                end,
            },
            {
                szOption = "�½�����",
                bMCheck=true,
                bCheck = true, 
                bChecked =function() return g_MacroVars.Mingjiao_MingZun.Mode_FullPow == 3 end,
                fnAction =function() 
                    g_MacroVars.Mingjiao_MingZun.Mode_FullPow = 3
                end,
            },
            {
                szOption = "�ս�����",
                bMCheck=true,
                bCheck = true, 
                bChecked =function() return g_MacroVars.Mingjiao_MingZun.Mode_FullPow == 4 end,
                fnAction =function() 
                    g_MacroVars.Mingjiao_MingZun.Mode_FullPow = 4
                end,
            },
        },
    }
end

--�жϲ˵��Ƿ��Ѽ���
local menuisaction = false
for i,v in ipairs(TraceButton_GetAddonMenu()) do
    if type(v)=="table" then
        if v.szOption and v.szOption == "����������" then
            menuisaction = true
            break
        end
    end
end

--�ж�δ���ز˵����ڹ�����˵������˵�
if not menuisaction then
    TraceButton_AppendAddonMenu({g_MacroVars.Mingjiao_MingZun.TollMenu})
end

--�ֲ����˵�����
local Auto_Target = g_MacroVars.Mingjiao_MingZun.Auto_Target
local Auto_Move = g_MacroVars.Mingjiao_MingZun.Auto_Move
local Auto_Jiehuo = g_MacroVars.Mingjiao_MingZun.Auto_Jiehuo
local Auto_Cibei = g_MacroVars.Mingjiao_MingZun.Auto_Cibei
local Mode_FullPow = g_MacroVars.Mingjiao_MingZun.Mode_FullPow

--------------------------���������Զ���˵���������������-------------------------

--------------------------��������Ŀ�괦������ʼ��������-------------------------
--��ȡ��ǰĿ��,δ��սûĿ��ֱ�ӷ���,ս����ûĿ��ѡ������ж�NPC,��������
local target, targetClass = s_util.GetTarget(player)							
if Auto_Target and (not target or not IsEnemy(player.dwID, target.dwID))then 
    if player.bFightState then
        local MinDistance = 20			--��С����
        local MindwID = 0		    --���NPC��ID
        for i,v in ipairs(GetAllNpc()) do		--��������NPC
            if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.CanSeeName then	--����ǵжԣ����Ҿ����С
                MinDistance = s_util.GetDistance(v, player)                             
                MindwID = v.dwID     --�滻�����ID
            end
        end
        if MindwID == 0 then 
            return                  --û�еж�NPC�򷵻�
        else	
            SetTarget(TARGET.NPC, MindwID)  --�趨Ŀ��Ϊ����ĵж�NPC                
        end
    else
        return
    end
end
local target, targetClass = s_util.GetTarget(player)

--���û��Ŀ���Ŀ��������ֱ�ӷ���
if not target or target.nMoveState == MOVE_STATE.ON_DEATH then return end
--------------------------��������Ŀ�괦����������������-------------------------

--------------------------��������������������ʼ��������-------------------------
--�ж�Ŀ�����������û�������������ж϶����ļ���ID����Ӧ����(��ϡ�ӭ����ˡ�����ȵ�)
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)		--���� �Ƿ��ڶ���, ����ID���ȼ���ʣ��ʱ��(��)����������

--��ȡ�Լ���buff��
local MyBuff = s_util.GetBuffInfo(player)

--��ȡ�Լ���Ŀ����ɵ�buff��
local TargetBuff = s_util.GetBuffInfo(target, true)

--��ȡĿ��ȫ����buff��
local TargetBuffAll = s_util.GetBuffInfo(target)

--��ǰѪ����ֵ
local hpRatio = player.nCurrentLife / player.nMaxLife

--��ȡ�Լ���Ŀ��ľ���
local distance = s_util.GetDistance(player, target)

--����������
local CurrentSun=player.nCurrentSunEnergy/100
local CurrentMoon=player.nCurrentMoonEnergy/100

--��ȡ�ҵĶ�������
local bPrepareMe, dwSkillIdMe, dwLevelMe, nLeftTimeMe, nActionStateMe =  GetSkillOTActionState(player)

--------------------------��������׷��λ������ʼ��������-------------------------

if target and IsEnemy(player.dwID, target.dwID) and Auto_Move then 
    --��������
    s_util.TurnTo(target.nX,target.nY) 

    if distance > 8 and player.bFightState then if s_util.CastSkill(3970,false) then return end end --�ù�
    if distance > 8 and player.bFightState then if s_util.CastSkill(18633,false) then return end end --�ù�

    --׷��
    if not IsKeyDown("W") then
        if distance > 3.5 then
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
--ȡ���Լ����ϵ�����в����buff
if MyBuff[4487] then s_util.CancelBuff(4487) end  --���̼���
if MyBuff[917] then s_util.CancelBuff(917) end    --��ʦ��
if MyBuff[8422] then s_util.CancelBuff(8422) end  --���ƶ�ǽ
if MyBuff[926] then s_util.CancelBuff(926) end    --�����
if MyBuff[4101] then s_util.CancelBuff(4101) end  --�����Ǽ��
--------------------------��������Ӧ��������������������-------------------------

--------------------------�����������ѭ������ʼ��������-------------------------

--���ն
if Auto_Jiehuo and (not TargetBuff[4058] or TargetBuff[4058].nLeftTime < 1) then
	if s_util.CastSkill(3980,false) then return end
end

--����ǰʹ���Ļ�̾
if player.nSunPowerValue > 0 or player.nMoonPowerValue > 0 or MyBuff[9909] and MyBuff[9909].nLeftTime < 12.97 and player.nCurrentSunEnergy > player.nCurrentMoonEnergy then
    if s_util.CastSkill(14922,false) then return end
end

--����F�л�Ϊ��ħѭ��
if Mode_FullPow==1 then --����˫��
    --������
    if s_util.CastSkill(3966,false) then return end
elseif Mode_FullPow==2 then --����˫��
    --��ħ
    if s_util.CastSkill(3967,false) then return end
elseif Mode_FullPow==3 then --�½�����
    if player.nSunPowerValue > 0 then
        if s_util.CastSkill(3967,false) then return end
    end
    if player.nMoonPowerValue > 0 then
        if s_util.CastSkill(3966,false) then return end
    end
elseif Mode_FullPow==4 then --�ս�����
    if player.nMoonPowerValue > 0 then
        if s_util.CastSkill(3967,false) then return end
    end
    if player.nSunPowerValue > 0 then
        if s_util.CastSkill(3966,false) then return end
    end
end

--�ȱ�Ը
if Auto_Cibei then
    if s_util.CastSkill(3982,false) then return end
end

--����ն������ѭ���ϳ�
if CurrentMoon >= CurrentSun and CurrentMoon < 61  then
    if  s_util.CastSkill(3960,false)  then return end
end

-- ����ն������>����ʱ�ͷ�
if CurrentSun > CurrentMoon and CurrentSun < 61 then
    if  s_util.CastSkill(3963,false)  then return end
end

-- ������ڵ��������Ҳ�����ʱ�������
if CurrentSun >= CurrentMoon and CurrentSun < 100 then
    if  s_util.CastSkill(3962,false)  then return end
end

--������������Ҳ�����ʱ��������
if CurrentSun < CurrentMoon and CurrentMoon < 100 then
    if s_util.CastSkill(3959,false) then return end
end