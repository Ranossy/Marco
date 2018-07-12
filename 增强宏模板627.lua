--��Ҷ���
local player = GetClientPlayer()
--Ŀ�����
local target = s_util.GetTarget(player)


-- #���Ժ���������ʼ#

--���Table
--����(��:����)
--����ֵ:��
local function outputTable(t)
    local s_Output_r_cache={}
    local function sub_s_Output_r(t,indent)
        if (s_Output_r_cache[tostring(t)]) then
            s_Output(indent.."*"..tostring(t))
        else
            s_Output_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        s_Output(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_s_Output_r(val,indent..string.rep(" ",string.len(pos)+8))
                        s_Output(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        s_Output(indent.."["..pos..'] => "'..val..'"')
                    else
                        s_Output(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                s_Output(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        s_Output(tostring(t).." {")
        sub_s_Output_r(t,"  ")
        s_Output("}")
    else
        sub_s_Output_r(t,"  ")
    end
    s_Output()
end

--�ָ��ַ���
--����(��ʼ�ı�:�ַ���,�ָ��ı�:�ַ���)
--����ֵ:{sub1,sub2,...}
function Split(s, sp)  
    local res = {}  
    local temp = s  
    local len = 0  
    while true do  
        len = string.find(temp, sp)  
        if len ~= nil then  
            local result = string.sub(temp, 1, len-1)  
            temp = string.sub(temp, len+1)  
            table.insert(res, result)  
        else  
            table.insert(res, temp)  
            break  
        end  
    end  
  
    return res  
end  

--��ȡ����
--����(��:����)
--����ֵ:����(������)
local function getTableLength(t)
	local length = 0
	for k,v in pairs(getTableLength) do
		length = length + 1
	end
	return(length)
end

--ɸѡ��
--����(��:����,ɸѡ����:����)
--����ֵ:����ɸѡ������(����)
local function filtTable(t,filter,reIndex)
	if(reIndex == nil) then reIndex = true end
	local newT = {}
	for key,value in pairs(t) do
		if(filter(value)) then 
			if(reIndex) then table.insert(newT,value)
			else newT[key] = value end
		end
	end
	return(newT)
end

-- #���Ժ�����������#


-- #��������������ʼ#

--��ȡ���ְҵ����
--����(���:����)
--����ֵ:���ְҵ����(�ַ���)
local function getPlayerForceName(playerObject)
	if(not playerObject) then return ("�޶���") end
	if(not IsPlayer(playerObject.dwID)) then
		return("�����")
	end
	local forceNames = {'����','����','��','���','����','����','�嶾','����','�ؽ�','ؤ��','����',[22]='����',[23]='����',[24]='�Ե�'}
	return(forceNames[playerObject.dwForceID+1])
end

--��ȡ����ķ�����
--����:(���:����)
--����ֵ:����ķ�����(�ַ���)
local function getPlayerMountName(playerObject)
	if(not playerObject) then return ("�޶���") end
	if(not IsPlayer(playerObject.dwID)) then
		return("�����")
	end
	local mountObject = playerObject.GetKungfuMount()
	if(mountObject) then
		return(mountObject.szSkillName)
	else
		return("δ֪")
	end
end

--��ȡ�嶾���＼��
--����(���:����)
--����ֵ:{{name = ��������,id = ����ID}...}
local function getWuduPetSkills(playerObject)
	local petObject = playerObject.GetPet()
	local skills = {}
	if(petObject) then
		petSkills = Table_GetPetSkill(petObject.dwTemplateID)
		for key,value in pairs(petSkills) do
			local skillName = Table_GetSkillName(value[1],value[2])
			local skillInfo = {}
			skillInfo.name = skillName
			skillInfo.id = value[1]
			table.insert(skills,skillInfo)
		end
		return(skills)
	else
		return(skills)
	end
end

--��ȡ���Ż��ؼ���
--����(���:����)
--����ֵ:{[��������]:{����ID}}
local function getTangmenPuppetSkills()
	local tempID = s_util.GetPuppet()
	local tianLuoSkills = {}
	local skills = {}
	--ǧ���������̬
	if(tempID == 16174) then
		tianLuoSkills = {['������̬']=3368,['������̬']=3369,['��ɲ��̬']=3370}
	elseif(tempID == 16175 or tempId == 16176) then
		tianLuoSkills = {['����']=3360,['ֹͣ']=3382,['����']=3110}
	elseif(tempID == 16177) then
		tianLuoSkills = {['��ɲ��̬']=3370}
	end
	for key,value in pairs(tianLuoSkills) do
		local skillInfo = {}
		skillInfo.name = key
		skillInfo.id = value
		table.insert(skills,skillInfo)
	end
	return(skills)
end

--��ȡ��Ҽ����б�
local function getPlayerSkillTable(playerObject)
	local skills = {}
	for key,value in pairs(playerObject.GetAllSkillList()) do
		local skillInfo = {}
		skillInfo.name = Table_GetSkillName(key,value)
		skillInfo.id = key
		table.insert(skills,skillInfo)
	end
	--�嶾���＼�ܻ�ȡ
	if(getPlayerForceName(playerObject) == "�嶾") then
		for key,value in pairs(getWuduPetSkills(playerObject)) do
			table.insert(skills,value)
		end
	end
	--���Ż��ؼ��ܻ�ȡ
	if(getPlayerForceName(playerObject) ==  "����") then
		for key,value in pairs(getTangmenPuppetSkills(playerObject)) do
			table.insert(skills,value)
		end
	end
	return(skills)
end

--��ȡ���Buff�б�
--����(���:����)
--����ֵ:{[buff����]:{id = BuffID,leftTime = ʣ��ʱ��,stackNum = ����,level:Buff�ȼ�,srcId:Buff��Դ����}}
local function getPlayerBuffTable(playerObject)
	local playerBuff = {}
	local buffTable = s_util.GetBuffInfo(playerObject)
	for key,value in pairs(buffTable) do
		local buffInfo = Table_GetBuff(value.dwID,value.nLevel)
		if(buffInfo) then
			local infoTable = {}
			infoTable.id = value.dwID
			infoTable.level = value.nLevel
			infoTable.leftTime = value.nLeftTime
			infoTable.stackNum = value.nStackNum
			infoTable.srcId = value.dwSkillSrcID
			playerBuff[buffInfo["szName"]] = infoTable
		end
	end
	return(playerBuff)
end

--��ȡ��ΧNPC�б�
--����(��)
--����ֵ:({[npc����]:{id = NpcID,tempId = Npcģ��ID,distance = npc����}})
local function getNearbyNpcTable()
	local npcList = GetAllNpc()
	local npcInfoTable = {}
	for key,npcObject in pairs(npcList) do 
		if(npcObject) then
			local npcInfo = {}
			npcInfo.id = npcObject.dwID
			npcInfo.tempId = npcObject.dwTemplateID
			npcInfo.distance = s_util.GetDistance(player,npcObject)
			npcInfoTable[npcObject.szName] = npcInfo
		end
	end
	return(npcInfoTable)
end

--��ȡ��Χ����б�
--����(��)
--����ֵ:{[�������]:{id = ���ID,life=���Ѫ������,force=�������,mount=����ķ�,distance=��Ҿ���}}
local function getNearbyPlayerTable()
	local playerList = GetAllPlayer()
	local playerInfoTable = {}
	for key,playerObject in pairs(playerList) do 
		if(playerObject) then
			local playerInfo = {}
			playerInfo.id = playerObject.dwID
			playerInfo.life = playerObject.nCurrentLife/playerObject.nMaxLife
			playerInfo.force = getPlayerForceName(playerObject)
			playerInfo.mount = getPlayerMountName(playerObject)
			playerInfo.distance = s_util.GetDistance(player,playerObject)
			playerInfoTable[playerObject.szName] = playerInfo
		end
	end
	return(PlayerInfoTable)
end

--����ID�ͷż���
--����(����ID:����,��������:�ַ���,�Ƿ��첽�ͷż���:����)
--����ֵ:�����ͷųɹ�(����)
local function castSkillById(skill,skillName,async)
	--��Ŀ��Ϊ�����Ҽ���Ϊ��������ʱ,���ȶ��Լ��ͷ�
	if(target and IsEnemy(player.dwID,target.dwID)) then
		if(skillName == "��̫��" or skillName == "�Ʋ��" or skillName == "���ǳ�" or skillName == "ǧ����") then
			return(s_util.CastSkill(skill,true,async))
		end
	end
	--������Ϊ�Ƴ��׼��ҳ��ﲻ����ʱ,ȡ���ͷż���
	if(skillName == "�Ƴ��׼�" and player.GetPet() == nil) then return(false) end
	--���Զ�Ŀ���ͷż���,�ͷ�ʧ������Լ��ͷ�
	local res = s_util.CastSkill(skill,false,async)
	if(res) then return(res) else return(s_util.CastSkill(skill,true,async)) end
end

-- #����������������#


-- $��������������ʼ$

buffs = getPlayerBuffTable(player)
tbuffs = getPlayerBuffTable(target)
skills = getPlayerSkillTable(player)
tbuffsm = filtTable(tbuffs,function(buffo) return(buffo.srcId == player.dwID) end,false)
nearbyNpcs = getNearbyNpcTable()
nearbyPlayers = getNearbyPlayerTable()

-- $����������������$


-- #��װ����������ʼ#

--�����Ϣ
--����(��Ϣ:�ַ���)
--����ֵ:��
local function msg(message)
	s_util.OutputTip(message)
end

--ʹ����Ʒ
--����(��Ʒ����:�ַ���)
--����ֵ:�Ƿ�ʹ�óɹ�(����)
local function use(itemName)
	local item =  g_ItemNameToID[itemName]
	if(item) then
		return(s_util.UseItem(item[1],item[2]))
	else
		return(false)
	end
end

--�ͷż���
--����(��������:�ַ���)
--����ֵ:�Ƿ��ͷųɹ�(����)
local function cast(skillName)
	local skillList = filtTable(skills,function(sobject) return(sobject.name == skillName) end)
	for key,value in pairs(skillList) do
		local res = castSkillById(value.id,value.name,false)
		if(res) then return(res) end
	end
	return(false)
end

--�첽�ͷż���
--����(��������:�ַ���)
--����ֵ:�Ƿ��ͷųɹ�(����)
local function fcast(skillName)
	local skillList = filtTable(skills,function(sobject) return(sobject.name == skillName) end)
	for key,value in pairs(skillList) do
		local res = castSkillById(value.id,value.name,true)
		if(res) then return(res) end
	end
	return(false)
end

--����������
--����(��)
--����ֵ:��
local function stopcast()
	s_util.StopSkill()
end

--ѡ�����
--����(�������:�ַ���)
--����ֵ:�Ƿ�ѡ��ɹ�(����)
local function selectP(playerName)
	local player = nearbyPlayers[playerName]
	if(player) then SetTarget(TARGET.PLAYER,player.id) return true else return false end
end

--ѡ��NPC
--����(NPC����:�ַ���)
--����ֵ:�Ƿ�ѡ��ɹ�(����)
local function selectN(npcName)
	local npc = nearbyNpcs[npcName]
	if(npc.id) then SetTarget(TARGET.NPC,npc.id) return true else return false end
end

--��ȡ����Buff����
--����(Buff����:�ַ���)
--����ֵ:����Buff����(����)
local function buff(buffName)
	if(buffs[buffName]) then 
		return(buffs[buffName]['stackNum'])
	else 
		return(0) end
end

--��ȡ����Buffʣ��ʱ��
--����(Buff����:�ַ���)
--����ֵ:����Buffʣ��ʱ��(������)
local function bufftime(buffName)
	if(buffs[buffName]) then 
		return(buffs[buffName]['leftTime'])
	else 
		return(0) end
end

--��ȡĿ��Buff����
--����(Buff����:�ַ���)
--����ֵ:Ŀ��Buff����(����)
local function tbuff(buffName)
	if(tbuffs[buffName]) then 
		return(tbuffs[buffName]['stackNum'])
	else 
		return(0) end
end

--��ȡĿ��Buffʣ��ʱ��
--����(Buff����:�ַ���)
--����ֵ:Ŀ��Buffʣ��ʱ��(������)
local function tbufftime(buffName)
	if(tbuffs[buffName]) then 
		return(tbuffs[buffName]['leftTime'])
	else 
		return(0) end
end

--�ж�����״̬
--����(״̬����:�ַ���)
--����ֵ:�����Ƿ���״̬(����)
local function state(stateName)
	local buffTypes = {
	['�޵�']= {'�뷨', '����', '����', '��ɽ��', '������ŭ', '̫��', 'ɢ��ϼ', 'ˮ��', 'ڤ��', '�Ϸ�����', 'ƽɳ����', 'α������ɽ'},
	['����']= {'�޺�����', '�����', '����', '�����'},
	['ƽɳ']= {'ƽɳ����'},
	['����']= {'��ľ����', '����', '��������', '������', '��ľ����', '���', '��������', '��������', 'ݺ����', '������', '��ɢ', '����', '����', '������', '��ʥ', '�����׼�', '�����', '�ؼ�', 'Ԩ', '�屡����', '����', '��������', '��ˮ', '��ɽ��ˮ', '����', 'ݺ��', '�����-��', '�������'},
	['���']= {'�������', '��Ȼ', '��Ӱ', '����', '����֮��', '���Ĺ�', '�۹�', '��Ԩ����', 'ʥ������', '�����׼�', '����', '����', '����', '����Χ', 'ͻ', '�޾�', '�Ƴ��׼�', '��������', '������', '����', '��Ȫ����', 'ǧ������', '����', 'ʯ����', '��̫��', 'ˮ���޼�', '��Ծ��Ԩ', '��������', 'ʥ��', 'Ц���', '��Ȫ��Ծ', '̰ħ��', 'Х��', '���', 'ǧ��', '��Ұ', '��¥��Ӱ', '������Ⱥ', '������', '��ǽ', '����', '�Ƴ��', '����', '�����', 'תǬ��', '�ٻ�', '��Ӱ', '������', '�������', '����', 'ȵ̤֦', '̽÷', '����'},
	['����']= {'�ֻ�', '����', '������ɢ', '����', '�����', '��Ӱ', '����Ϸˮ', 'ҷ��', '����', '�Ͻ���ӡ', 'Ц������', '��ˮ��', '����֪��', '��������', '��صͰ�', '̰ħ��', '��ˮ', 'Ů洲���', '��÷', '����ɽ', '����', '�����', '����', 'ʥ��֯��', '��Ϸˮ', 'תǬ��', '���໤��', '��Ӱ', 'ɢӰ', '��Х����', 'յө'},
	['����']= {'����', '��Ӱ', '������', '����', '�������', '�ȱ�Ը', '��������', '�紵��', '����', '����ң'},
	['����']= {'̤������', '��ɱ'},
	['��Ĭ']= {'��������', '����', '�ݳ�ǹ��˺��', '����', '����', '����', '���ɾ���'},
	['��е']= {'ϼ��', '��η����', 'ϼ����ʯ'},
	['���Ṧ'] = {'���Ṧ'},
	['����']= {'���Զ���', '����ͨ��', '�������', '�Х����', '����ʽ', '÷����', '����', '������Х', '����ָ'},
	['����']= {'�̳�', '��������', '����', '����Ϲǻ�', '�½�', '�ܻ�', '����', '��Ϣ', '����ݲ�', '��һ', '������'},
	['����']= {'Ϣ��', '���'},
	['ѣ��']= {'�ͻ�', '�ùⲽ', '�ϻ��', '����ع�', '��ħ', '����', 'ͻ', '�ս�', 'ǧ��׹', 'Σ¥', '���̽Կ�', '���ǡ���׼', '��', '����', '����', '��ʨ�Ӻ�', '����', '��ҹ����', '���ǡ�����', '��������', '�ض�ɽҡ', '����', '�׹��ɽ', '������', '�ù�', '��', '��ä', 'Ы������ ', '���ƹ���', '��������', '������ħ��', '�������', '����', '����', '��Ӱ', '����'},
	['����']= {'�ù�', '����', '��Ӱ', '���ǹ���', 'ǧ�밵��', 'ͬ��', '��������', '��ҹ����', '����', '����', 'ܽ�ز���', '�������', '�Ʊ�����', '˿ǣ', '����', '���'},
	['����']= {'���', '����ع�', '����', '����ع��', '��ȸ��', '�ٲ���˿��', '�巽�о�', '�Ͻ�', '�¹�����', 'ת������', '����', '����', '��ҹ����', '����ܹ�', '����', '������', '���', '���Ǽ�', '̫��ָ', '��������', '��', 'Ӱ��', '��צ', '����', '���Ż���', '����', '�����׼�'},
	['����']= {'����', '�������', 'ҵ��', '����', '����', '����', '���', '��̫��', '��צ����', '����', '����', '����', '����', '����', 'ҵ���︿', '���ǡ��Ϲ�', '����', '����', '��', '����ָ', '��ҹ����', '����', '��һ', '����', 'ǧ˿', '��', '����ʽ', '������', '����޼', '����', '�����滨��'}
	}
	for btype,buffs in pairs(buffTypes) do
		for i,v in pairs(buffs) do 
			if(buff(v) > 0) then
				if(btype == stateName) then return true end
			end
		end
	end
	return false
end

--�ж�������״̬
--����(״̬����:�ַ���)
--����ֵ:�����Ƿ񲻴���״̬(����)
local function nostate(stateName)
	return(not state(skillName))
end

--�ж�Ŀ��״̬
--����(״̬����:�ַ���)
--����ֵ:Ŀ���Ƿ���״̬(����)
local function tstate(stateName)
	local buffTypes = {
	['�޵�']= {'�뷨', '����', '����', '��ɽ��', '������ŭ', '̫��', 'ɢ��ϼ', 'ˮ��', 'ڤ��', '�Ϸ�����', 'ƽɳ����', 'α������ɽ'},
	['����']= {'�޺�����', '�����', '����', '�����'},
	['ƽɳ']= {'ƽɳ����'},
	['����']= {'��ľ����', '����', '��������', '������', '��ľ����', '���', '��������', '��������', 'ݺ����', '������', '��ɢ', '����', '����', '������', '��ʥ', '�����׼�', '�����', '�ؼ�', 'Ԩ', '�屡����', '����', '��������', '��ˮ', '��ɽ��ˮ', '����', 'ݺ��', '�����-��', '�������'},
	['���']= {'�������', '��Ȼ', '��Ӱ', '����', '����֮��', '���Ĺ�', '�۹�', '��Ԩ����', 'ʥ������', '�����׼�', '����', '����', '����', '����Χ', 'ͻ', '�޾�', '�Ƴ��׼�', '��������', '������', '����', '��Ȫ����', 'ǧ������', '����', 'ʯ����', '��̫��', 'ˮ���޼�', '��Ծ��Ԩ', '��������', 'ʥ��', 'Ц���', '��Ȫ��Ծ', '̰ħ��', 'Х��', '���', 'ǧ��', '��Ұ', '��¥��Ӱ', '������Ⱥ', '������', '��ǽ', '����', '�Ƴ��', '����', '�����', 'תǬ��', '�ٻ�', '��Ӱ', '������', '�������', '����', 'ȵ̤֦', '̽÷', '����'},
	['����']= {'�ֻ�', '����', '������ɢ', '����', '�����', '��Ӱ', '����Ϸˮ', 'ҷ��', '����', '�Ͻ���ӡ', 'Ц������', '��ˮ��', '����֪��', '��������', '��صͰ�', '̰ħ��', '��ˮ', 'Ů洲���', '��÷', '����ɽ', '����', '�����', '����', 'ʥ��֯��', '��Ϸˮ', 'תǬ��', '���໤��', '��Ӱ', 'ɢӰ', '��Х����', 'յө'},
	['����']= {'����', '��Ӱ', '������', '����', '�������', '�ȱ�Ը', '��������', '�紵��', '����', '����ң'},
	['����']= {'̤������', '��ɱ'},
	['��Ĭ']= {'��������', '����', '�ݳ�ǹ��˺��', '����', '����', '����', '���ɾ���'},
	['��е']= {'ϼ��', '��η����', 'ϼ����ʯ'},
	['���Ṧ'] = {'���Ṧ'},
	['����']= {'���Զ���', '����ͨ��', '�������', '�Х����', '����ʽ', '÷����', '����', '������Х', '����ָ'},
	['����']= {'�̳�', '��������', '����', '����Ϲǻ�', '�½�', '�ܻ�', '����', '��Ϣ', '����ݲ�', '��һ', '������'},
	['����']= {'Ϣ��', '���'},
	['ѣ��']= {'�ͻ�', '�ùⲽ', '�ϻ��', '����ع�', '��ħ', '����', 'ͻ', '�ս�', 'ǧ��׹', 'Σ¥', '���̽Կ�', '���ǡ���׼', '��', '����', '����', '��ʨ�Ӻ�', '����', '��ҹ����', '���ǡ�����', '��������', '�ض�ɽҡ', '����', '�׹��ɽ', '������', '�ù�', '��', '��ä', 'Ы������ ', '���ƹ���', '��������', '������ħ��', '�������', '����', '����', '��Ӱ', '����'},
	['����']= {'�ù�', '����', '��Ӱ', '���ǹ���', 'ǧ�밵��', 'ͬ��', '��������', '��ҹ����', '����', '����', 'ܽ�ز���', '�������', '�Ʊ�����', '˿ǣ', '����', '���'},
	['����']= {'���', '����ع�', '����', '����ع��', '��ȸ��', '�ٲ���˿��', '�巽�о�', '�Ͻ�', '�¹�����', 'ת������', '����', '����', '��ҹ����', '����ܹ�', '����', '������', '���', '���Ǽ�', '̫��ָ', '��������', '��', 'Ӱ��', '��צ', '����', '���Ż���', '����', '�����׼�'},
	['����']= {'����', '�������', 'ҵ��', '����', '����', '����', '���', '��̫��', '��צ����', '����', '����', '����', '����', '����', 'ҵ���︿', '���ǡ��Ϲ�', '����', '����', '��', '����ָ', '��ҹ����', '����', '��һ', '����', 'ǧ˿', '��', '����ʽ', '������', '����޼', '����', '�����滨��'}
	}
	for btype,buffs in pairs(buffTypes) do
		for i,v in pairs(buffs) do 
			if(tbuff(v) > 0) then
				if(btype == stateName) then return true end
			end
		end
	end
	return false
end

--�ж�Ŀ�겻��״̬
--����(״̬����:�ַ���)
--����ֵ:Ŀ���Ƿ񲻴���״̬(����)
local function tnostate(stateName)
	return(not tstate(skillName))
end

--��ȡ������CD
--����(��������:�ַ���)
--����ֵ:ʣ����ȴʱ��(������)
local function cd(skillName)
	local skill = g_SkillNameToID[skillName]
	if(not(skill) and getPlayerForceName(player) == "�嶾") then
		skill = getWuduPetSkills(player)[skillName]
	end
	if(skill) then
		return(s_util.GetSkillCD(skill))
	else
		return(9999)
	end
end

--�ж������ܲ���CD
--����(��������:�ַ���)
--����ֵ:�Ƿ������ܲ�����CD(����)
local function nocd(skillName)
	return(cd(skillName) <= 0)
end

--��ȡ�����ܳ��ܲ���
--����(��������:�ַ���)
--����ֵ:������ʣ����ܲ���(����)
local function charge(skillName)
	local skill = getPlayerSkillTable(player)[skillName]
	if(skill) then
		return(s_util.GetSkillCN(skill))
	else
		return(-1)
	end
end

--��ȡ�����ܳ���CD
--����(��������:�ַ���)
--����ֵ:�����ܳ���CD(������)
local function chargetime(skillName)
	local skill = getPlayerSkillTable(player)[skillName]
	if(skill) then
		local ch,chtime = s_util.GetSkillCN(skill)
		return(chtime)
	else
		return(-1)
	end
end

--��ȡ������͸֧����
--����(��������:�ַ���)
--����ֵ:������ʣ��͸֧����(����)
local function stack(skillName)
	local skill = getPlayerSkillTable(player)[skillName]
	if(skill) then
		return(s_util.GetSkillOD(skill))
	else
		return(-1)
	end
end

--��ȡ�����������
--����(��������:�ַ���)
--����ֵ:����ǰ��������(������)
local function prepare(skillName)
	local bPrepare,skillId,skillLv,progress,otType =  GetSkillOTActionState(player)
	if(bPrepare) then
		if(Split(GetSkill(skillId,skillLv).szSkillName,'_')[1] == skillName) then
			return(progress)
		else
			return(0)
		end
	else
		return(0)
	end
end

--��ȡĿ���������
--����(��������:�ַ���)
--����ֵ:Ŀ�굱ǰ��������(������)
local function tprepare(skillName)
	local bPrepare,skillId,skillLv,progress,otType =  GetSkillOTActionState(target)
	if(bPrepare) then
		msg(GetSkill(skillId,skillLv).szSkillName..tostring(otType))
		if(string.find(GetSkill(skillId,skillLv).szSkillName,skillName) ~= nil) then
			return(progress)
		else
			return(0)
		end
	else
		return(0)
	end
end

--�ж������Ƿ����
--����(��������:�ַ���)
--����ֵ:����ǰ�Ƿ����(����)
local function isprepare(skillName)
	local bPrepare,skillId,skillLv,progress,otType =  GetSkillOTActionState(player)
	if(bPrepare) then
		if(string.find(GetSkill(skillId,skillLv).szSkillName,skillName) ~= nil) then
			return(true)
		else
			return(false)
		end
	else
		return(false)
	end
end

--�ж�Ŀ���Ƿ����
--����(��������:�ַ���)
--����ֵ:Ŀ�굱ǰ�Ƿ����(����)
local function tisprepare(skillName)
	local bPrepare,skillId,skillLv,progress,otType =  GetSkillOTActionState(target)
	if(bPrepare) then
		if(string.find(GetSkill(skillId,skillLv).szSkillName,skillName) ~= nil) then
			return(true)
		else
			return(false)
		end
	else
		return(false)
	end
end

-- #��װ������������#


-- $��װ����������ʼ$

--�ж�����Ŀ������
local function Ftargettype()
	if(not(target)) then return ("none") end
	if(IsPlayer(target.dwID)) then
		return("player")
	else
		return("npc")
	end
end

--�ж������Ƿ���Ŀ��
local function Fnotarget()
	return(target == nil)
end

--�ж������Ƿ���ս��״̬
local function Ffight()
	if(player) then
		return(player.bFightState)
	else
		return(false)
	end
end

--��ȡĿ�����
local function Fdistance()
	if(target) then
		return(s_util.GetDistance(player,target))
	else
		return(999)
	end
end

local force = getPlayerForceName(player)
local mount = getPlayerMountName(player)
local tforce = getPlayerForceName(target)
local tmount = getPlayerMountName(target)
local distance = Fdistance()
local targettype = Ftargettype()
local fight = Ffight()
local notarget = Fnotarget()

-- $���װ������������$