
---���������Լ��ֶ���û��д�����Զ����
--�ű�˵��("��Ѩ���� \n  [[Ѫ�����][��������][��ԭ�һ�][�Ʒ�����|������ʥ][�����·][��ҫ�쳾][�ƶ�����][��Ȼ����][�����¾][��Ӱ����][��������][ڤ�¶���]  \n  \n ���Ӽ���ģʽ����ģʽ��Գ�����ʥ��Ѩд�ģ������ϼ���(��������ն��ͻ�������ģʽ��������ħ�����������پͻ��л�������ͨ�����ģʽ  \n  \n �����Ҫ�ֶ����⣬�Ƽ���������������ر�����׷������Ϊ�ű����Զ����������Ч�Ļر�ĳЩְҵ�Ŀ��� \n �����ռ�  3/26 �޸�����BUG���½ű��������� ")

--��ͷ������������Ȼ�ȡ�Լ��Ķ���û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end

--��ս����
if not player.bFightState and not s_util.GetBuffInfo(player)[4052] then
    if s_util.CastSkill(3974, false) then return end
end
--------------------��������������������ʼ��������--------------------


--------------------������������������������������--------------------
--------------------��������Ŀ�괦������ʼ��������--------------------

--��ȡ��ǰĿ��,δ��սûĿ��ֱ�ӷ���,ս����ûĿ��ѡ������ж�NPC,��������
local target, targetClass = s_util.GetTarget(player)							
if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID)) and targetClass~=TARGET.PLAYER then return end
if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) or targetClass~=TARGET.PLAYER then  
local MinDistance = 20		
local MindwID = 0		    
for i,v in ipairs(GetAllPlayer()) do		--����
	if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance then
		MinDistance = s_util.GetDistance(v, player)
		MindwID = v.dwID
		end
	end
if MindwID == 0 then 
    return
else
    SetTarget(TARGET.PLAYER, MindwID)  --�趨Ŀ��
end
end
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

--����������
local CurrentSun=player.nCurrentSunEnergy/100
local CurrentMoon=player.nCurrentMoonEnergy/100

--������ͣ�ֵ�BUff �����������Ϸ����£���ɽ�ӣ�������ŭ������
local TingShouBuff = TargetBuffAll[4871] or TargetBuffAll[9934] or TargetBuffAll[377] or TargetBuffAll[682] or TargetBuffAll[8303] or TargetBuffAll[9534] or TargetBuffAll[961] or TargetBuffAll[3425] or TargetBuffAll[11151]

--�����������buff �Ƴ��,�Ƴ��2,��Ӱ,���Ĺ�,��ɽ��,��Ȼ,����
local MianKongSelf = MyBuff[2840] or MyBuff[2830] or MyBuff[12665] or MyBuff[6247] or MyBuff[377] or MyBuff[4468] or MyBuff[12492] or MyBuff[4421]

--������������BUFF 
local MianShangSelf = MyBuff[8303] or MyBuff[9534] or MyBuff[377] or MyBuff[961] or MyBuff[772] or MyBuff[9934] or MyBuff[12492]

--����Ŀ�����BUFF
local JianShangTar = TargetBuffAll[6163] or TargetBuffAll[3193] or TargetBuffAll[6264] or TargetBuffAll[6257] or TargetBuffAll[3171] or TargetBuffAll[4444] or TargetBuffAll[5744] or TargetBuffAll[6637] or TargetBuffAll[8292] or TargetBuffAll[11319] or TargetBuffAll[368] or TargetBuffAll[367] or TargetBuffAll[384] or TargetBuffAll[399] or TargetBuffAll[3068] or TargetBuffAll[122] or TargetBuffAll[1802] or TargetBuffAll[684] or TargetBuffAll[4439] or TargetBuffAll[6315] or TargetBuffAll[6240] or TargetBuffAll[5996] or TargetBuffAll[6200] or TargetBuffAll[6636] or TargetBuffAll[6262] or TargetBuffAll[2849] or TargetBuffAll[3315] or TargetBuffAll[8279] or TargetBuffAll[8300] or TargetBuffAll[8427] or TargetBuffAll[8291] or TargetBuffAll[2983] or TargetBuffAll[10014]

----�����Լ�����BUFF
local JianShangSelf = MyBuff[6163] or MyBuff[3193] or MyBuff[6264] or MyBuff[6257] or MyBuff[3171] or MyBuff[4444] or MyBuff[5744] or MyBuff[6637] or MyBuff[8292] or MyBuff[11319] or MyBuff[368] or MyBuff[367] or MyBuff[384] or MyBuff[399] or MyBuff[3068] or MyBuff[122] or MyBuff[1802] or MyBuff[684] or MyBuff[4439] or MyBuff[6315] or MyBuff[6240] or MyBuff[5996] or MyBuff[6200] or MyBuff[6636] or MyBuff[6262] or MyBuff[2849] or MyBuff[3315] or MyBuff[8279] or MyBuff[8300] or MyBuff[8427] or MyBuff[8291] or MyBuff[2983] or MyBuff[10014]
--------------------------������������������������������-------------------------

--------------------------��������Ӧ����������ʼ��������-------------------------

--�رܿ���
if not MianKongSelf and not MianShangSelf then 
    if s_util.GetTimer("tkongzhi1")>0 and s_util.GetTimer("tkongzhi1")<1000 then
        if s_util.CastSkill(9004, false) or s_util.CastSkill(9005, false) or s_util.CastSkill(9006, false) or s_util.CastSkill(9007, false) then
            return
        end
    end
    if s_util.GetTimer("tkongzhi2")>0 and s_util.GetTimer("tkongzhi2")<1000 then
        if s_util.CastSkill(3977, false) or s_util.CastSkill(3973, false) or s_util.CastSkill(9004, false) or s_util.CastSkill(9005, false) or s_util.CastSkill(9006, false) or s_util.CastSkill(9007, false) then
            return
        end
    end
end

--�ر��˺�
if not JianShangSelf and not MianShangSelf and not MyBuff[12491] and not MyBuff[4052] then
    if s_util.GetTimer("tkongzhi2")>0 and s_util.GetTimer("tkongzhi2")<1500 then
        if s_util.CastSkill(3973,true) then return end
    end
end

--�Զ���ҡ
if distance< 50 and not MyBuff[208] then
	if s_util.CastSkill(9002,true) then return end
end

--ͣ��
if TingShouBuff then return end

--------------------------��������Ӧ��������������������-------------------------


--------------------------�����������ѭ������ʼ��������-------------------------

--��ħ
if s_util.CastSkill(3967,false) then return end


--�մ�
if distance< 8 and not JianShangTa then
    if s_util.CastSkill(18626,false) then return end
end
--�´�
if distance< 12 and not JianShangTar then
    if s_util.CastSkill(18629,false) then return end
end

--��ҹ
if s_util.CastSkill(3979,false) then return end

--����ն������ѭ���ϳ�
if CurrentMoon >= CurrentSun and CurrentMoon < 61 then
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