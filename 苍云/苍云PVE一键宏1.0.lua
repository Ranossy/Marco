--������Ѩ
--��Ѩ��[����][����][����][����][����][ŭ��][����][��ս][����][��ŭ][����][����]
--�ؼ���PVE�ؼ�
--�����������������漴��

--��Ѫ��Ѩ
--��Ѩ��[����][����][����][����][��Į][����][����][��ս][����][��ŭ][����][����]
--�ؼ���PVE�ؼ�

--T�괿�ܵ�ˢ110ŭ����Ѩ
--��Ѩ��[����][����][���][����][ǧɽ][����][��Ѫ][����][����][����][߳��][����]
--�ؼ���PVE�ؼ�

--T�괿�ܵ�ˢ100ŭ����Ѩ����Ҫ����˺��ϴ�Ĺ֣�
--��Ѩ��[����][����][���][����/����][ǧɽ][����][��Ѫ][����][����][����][߳��][����]
--�ؼ���PVE�ؼ�

--ս��ɽ��4wifi
--��Ѩ��[����][����][���][����][���][����][����][����][����][��ŭ][���][��Хǧ��]
--�ؼ���PVE�ؼ�

--����ǵ��4wifi
--��Ѩ��[����][����][��̤][����][���][����][����][����][����][ս��][���][��Хǧ��]
--�ؼ���PVE�ؼ�

--2.0��T��Ҳ���Ͻ�����
--1.0���Ͼ�������ѪΪ1������ȥ������ȥ���鷳�Զ����ݵڶ�����Ѩ���������������Ѫ

--��ͷ������������Ȼ�ȡ�Լ��Ķ���û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end

--��ǰѪ����ֵ
local hpRatio = player.nCurrentLife / player.nMaxLife

--��ȡ��ǰĿ�꣬����Ŀ������Ŀ������(��һ���NPC)
local target, targetClass = s_util.GetTarget(player)

--û��Ŀ�����Ŀ�겻�ǵ��ˣ�ֱ�ӷ���
if not target or not IsEnemy(player.dwID, target.dwID) then return end

--��ȡĿ���Ŀ������
local ttarget, ttargetClass = s_util.GetTarget(target)

--���Ŀ��������ֱ�ӷ���
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--��ȡ�Լ���buff��
local MyBuff = s_util.GetBuffInfo(player)

--��ȡĿ���buff��
local TargetBuff = s_util.GetBuffInfo(target)

--��ȡĿ���Ŀ���buff��
local TTargetBuff = s_util.GetBuffInfo(ttarget)

--��ȡ�Լ���Ŀ��ľ���
local distance = s_util.GetDistance(player, target)

--��ȡĿ�굱ǰѪ����ֵ
local thpRatio = target.nCurrentLife / target.nMaxLife

--��ȡĿ��Ķ�������
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)

--��ȡĿ��ǿ��
local Strength = GetNpcIntensity(target)

--��ȡ��ͼID
local GetMap = s_util.GetMapID()

--��ȡ��һ����Ѩ
local qixue1 = s_util.GetTalentIndex(1)

--��ȡ�ڶ�����Ѩ
local qixue2 = s_util.GetTalentIndex(2)

--��ȡ��������Ѩ
local qixue3 = s_util.GetTalentIndex(3)

--��ȡ���ĸ���Ѩ
local qixue4 = s_util.GetTalentIndex(4)

--��ȡ�������Ѩ
local qixue5 = s_util.GetTalentIndex(5)

--��ȡ��������Ѩ
local qixue6 = s_util.GetTalentIndex(6)

--��ȡ���߸���Ѩ
local qixue7 = s_util.GetTalentIndex(7)

--��ȡ�ڰ˸���Ѩ
local qixue8 = s_util.GetTalentIndex(8)

--��ȡ�ھŸ���Ѩ
local qixue9 = s_util.GetTalentIndex(9)

--��ȡ��ʮ����Ѩ
local qixue10 = s_util.GetTalentIndex(10)

--��ȡ��ʮһ����Ѩ
local qixue11 = s_util.GetTalentIndex(11)

--��ȡ��ʮ������Ѩ
local qixue12 = s_util.GetTalentIndex(12)

--��ʼ��Ѫŭ����
if not g_MacroVars.State_13040 then
	g_MacroVars.State_13040 = 0				
end

--���Ŀ���ͷ�����,ʹ�ñ�Ȫˮ	
if TargetBuff[7929] then
if s_util.UseItem(5,21534) then end
end

--��ս��״̬�����������������Ŀ����boss�Ż��п��ֱ���������֮��Ҳ�Ὺ������ǰ���ǵ�ͼIDΪ143��
if not player.bFightState and player.GetKungfuMount().dwSkillID==10390 then
--�ͷ�����Ѫŭ
if not MyBuff[8385] or MyBuff[8385].nStackNum < 3 then
    if s_util.CastSkill(13040, false) then return end
end
--��ս��״̬����
end	

--����ս��״̬���ҵڶ�����Ѩ�Ǿ���
if player.bFightState and qixue2 == 3 and player.GetKungfuMount().dwSkillID==10390 then

--���Ѫ��С��30���ͷŶܱ�
if hpRatio < 0.30 and s_util.CastSkill(13070, false) then return end

--����Ѫŭ�ͷ�����	
--local xuenu33 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 3
local xuenu3 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 3  --���û��Ѫŭbuff����Ѫŭ���ô���=3��
local xuenu2 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 2  --���û��Ѫŭbuff����Ѫŭ���ô���=2��	
local xuenu1 = not MyBuff[8385]                                    --���û��Ѫŭbuff

--���û��Ѫŭbuff,����Ѫŭ���ô���=3��,�ͷ�Ѫŭ���ұ��Ϊ3
    if xuenu3 then 
	if s_util.CastSkill(13040, false) then 
	g_MacroVars.State_13040 = 3 return end 
	elseif 
--���û��Ѫŭbuff������Ѫŭ���ô���=2��,�ͷ�Ѫŭ���ұ��Ϊ2
	xuenu2 then 
	if s_util.CastSkill(13040, false) then 
	g_MacroVars.State_13040 = 2 return end 
	elseif 
--���û��Ѫŭbuff,�ͷ�Ѫŭ���ұ��Ϊ1
	xuenu1 then 
	if s_util.CastSkill(13040, false) then return end
end

--���Ѫŭ���Ϊ3���ٴ��ͷ�Ѫŭ����ձ��
	if g_MacroVars.State_13040 == 3 then 
	if s_util.CastSkill(13040, false) then
	g_MacroVars.State_13040 = 0 return end
	end
	
--���Ѫŭ���Ϊ2���ٴ��ͷ�Ѫŭ����ձ��
	if g_MacroVars.State_13040 == 2 then 
	if s_util.CastSkill(13040, false) then
	g_MacroVars.State_13040 = 0 return end
	end
	

--�����̬�����
if player.nPoseState == 2 then

--����Ѫŭ�ͷ�����	
--local xuenu33 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 3
local xuenu3 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 3  --���û��Ѫŭbuff����Ѫŭ���ô���=3��
local xuenu2 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 2  --���û��Ѫŭbuff����Ѫŭ���ô���=2��	
local xuenu1 = not MyBuff[8385]                                    --���û��Ѫŭbuff

--���û��Ѫŭbuff,����Ѫŭ���ô���=3��,�ͷ�Ѫŭ���ұ��Ϊ3
    if xuenu3 then 
	if s_util.CastSkill(13040, false) then 
	g_MacroVars.State_13040 = 3 return end 
	elseif 
--���û��Ѫŭbuff������Ѫŭ���ô���=2��,�ͷ�Ѫŭ���ұ��Ϊ2
	xuenu2 then 
	if s_util.CastSkill(13040, false) then 
	g_MacroVars.State_13040 = 2 return end 
	elseif 
--���û��Ѫŭbuff,�ͷ�Ѫŭ���ұ��Ϊ1
	xuenu1 then 
	if s_util.CastSkill(13040, false) then return end
end

--���Ѫŭ���Ϊ3���ٴ��ͷ�Ѫŭ�����ñ��Ϊ2
	if g_MacroVars.State_13040 == 3 then 
	if s_util.CastSkill(13040, false) then
	g_MacroVars.State_13040 = 2 return end
	end
	
--���Ѫŭ���Ϊ2���ٴ��ͷ�Ѫŭ����ձ��
	if g_MacroVars.State_13040 == 2 then 
	if s_util.CastSkill(13040, false) then
	g_MacroVars.State_13040 = 0 return end
	end

	--���Ŀ��û������buff,����ŭ��>66����ŭ��>65,���Ҷ���CD>1,ʩ�Ŷܷ�
	if not TargetBuff[8248] and player.nCurrentRage >= 65 or ( player.nCurrentRage>= 65 and s_util.GetSkillCD(13046) > 1 ) then
		if s_util.CastSkill(13050, false) then return end
	end

    --ʩ�Ŷ���
	    if s_util.CastSkill(13046, false) then return end

    --�������CD>1,����ŭ��<65,ʩ�Ŷ�ѹ
    if s_util.GetSkillCD(13046) > 1 and player.nCurrentRage <= 65 or player.nCurrentRage >=65 and s_util.GetSkillCN(13050) < 1 then
		if s_util.CastSkill(13045, false) then return end
	end

	--�ܵ���4321��
	    if s_util.CastSkill(13119, false) then return end
	    if s_util.CastSkill(13060, false) then return end
	    if s_util.CastSkill(13059, false) then return end
	    if s_util.CastSkill(13044, false) then return end
end
--�����̬���浶
if player.nPoseState == 1 then		

    --���������ŭ��BUFF,����ŭ��BUFFʱ��<5,����ն��CD<3,���Ҷܷɴ���>0��������û�п��BUFF,����ն��CD<3,���Ҷܷɴ���>0,����ŭ��<5���߶ܷ�ʱ��<1.5,ʩ�Ŷܻ�
	if ( MyBuff[8276] and MyBuff[8276].nLeftTime < 5 and s_util.GetSkillCD(13054) < 1 and s_util.GetSkillCN(13050) > 0 ) or ( not MyBuff[8276] and s_util.GetSkillCD(13054) < 1 and s_util.GetSkillCN(13050) > 0 ) or player.nCurrentRage < 5 or MyBuff[8391].nLeftTime < 0.5 then
        if s_util.CastSkill(13051, false) then return end
	end	
	
	--���������ŭ��BUFF,���Ҿ���CD< 3.5,�ͷ�ն��
	if player.nCurrentRage > 60 and s_util.GetSkillCD(13055) < 3.5 then
	    if s_util.CastSkill(13054, false) then return end 
    end	
	
	--���������BUFF���,�ͷž���
	if MyBuff[8451] then
	    if s_util.CastSkill(13055, false) then return end 
    end
	
	--�������û��BUFF���,�ͷŽٵ�
	if not MyBuff[8451] or s_util.GetSkillCD(13055) > 0.1  then
	if s_util.CastSkill(13052, false) then return end
	end
	
end

end 

--����ս��״̬���ҵڶ�����Ѩ������
if player.bFightState and qixue2 == 1 and player.GetKungfuMount().dwSkillID==10390 then

--���Ѫ��С��30���ͷŶܱ�
if hpRatio < 0.30 and s_util.CastSkill(13070, false) then return end

--����Ѫŭ�ͷ�����	
--local xuenu33 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 3
local xuenu3 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 3  --���û��Ѫŭbuff����Ѫŭ���ô���=3��
local xuenu2 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 2  --���û��Ѫŭbuff����Ѫŭ���ô���=2��	
local xuenu1 = not MyBuff[8385]                                    --���û��Ѫŭbuff

--���û��Ѫŭbuff,����Ѫŭ���ô���=3��,�ͷ�Ѫŭ���ұ��Ϊ3
    if xuenu3 then 
	if s_util.CastSkill(13040, false) then 
	g_MacroVars.State_13040 = 3 return end 
	elseif 
--���û��Ѫŭbuff������Ѫŭ���ô���=2��,�ͷ�Ѫŭ���ұ��Ϊ2
	xuenu2 then 
	if s_util.CastSkill(13040, false) then 
	g_MacroVars.State_13040 = 2 return end 
	elseif 
--���û��Ѫŭbuff,�ͷ�Ѫŭ���ұ��Ϊ1
	xuenu1 then 
	if s_util.CastSkill(13040, false) then return end
end

--���Ѫŭ���Ϊ3���ٴ��ͷ�Ѫŭ����ձ��
	if g_MacroVars.State_13040 == 3 then 
	if s_util.CastSkill(13040, false) then
	g_MacroVars.State_13040 = 0 return end
	end
	
--���Ѫŭ���Ϊ2���ٴ��ͷ�Ѫŭ����ձ��
	if g_MacroVars.State_13040 == 2 then 
	if s_util.CastSkill(13040, false) then
	g_MacroVars.State_13040 = 0 return end
	end
	
--�����̬�����
if player.nPoseState == 2 then

    --���ŭ��<30,����Ŀ������Ѫbuff,������Ѫ����=1,������Ѫʱ��>15,û��buff����,ʩ�Ŷ�ѹ
	if player.nCurrentRage<= 30 or TargetBuff[8249] and TargetBuff[8249].nStackNum == 1 and TargetBuff[8249].nLeftTime > 15 and not MyBuff[8738] then
	if s_util.CastSkill(13045, false) then return end
    end

    --���Ŀ������Ѫbuff, �ܻ���ʹ�ô�������0, ʩ�Ŷܻ�
	if TargetBuff[8249] and s_util.GetSkillCN(13047) > 0 then 
	if s_util.CastSkill(13047, false) then return end
	end

	--2��������Ѫ�ܷ��ж�
	if not TargetBuff[8249] and player.nCurrentRage>= 40 or  --���Ŀ��û����Ѫbuff,��������ŭ��>25,����
	TargetBuff[8249] and TargetBuff[8249].nStackNum == 1 and s_util.GetSkillCN(13047) < 1 or
	s_util.GetSkillCN(13047) < 1 and player.nCurrentRage>= 40 and TargetBuff[8249] and TargetBuff[8249].nStackNum >= 2 or
	TargetBuff[8249] and TargetBuff[8249].nLeftTime < 2 then
	if s_util.CastSkill(13050, false) then return end  
	end
	
	--���ŭ��С��40,���Ҷ�ѹCD>1,���Ҷܻ������Ϊ3,�ͷŶ���
	if player.nCurrentRage<= 40 and s_util.GetSkillCD(13045) > 1 and s_util.GetSkillCN(13047) < 1 then
	if s_util.CastSkill(13046, false) then return end
	end
	
	--�ܵ���4321��
	if s_util.CastSkill(13119, false) then return end
	if s_util.CastSkill(13060, false) then return end
	if s_util.CastSkill(13059, false) then return end
	if s_util.CastSkill(13044, false) then return end
	
	--�����̬����
	end
	
--�����̬���浶
if player.nPoseState == 1 then		

	--Ŀ����Ѫʱ��>18������Ѫ����>1,ʩ������
	if TargetBuff[8249] and TargetBuff[8249].nStackNum > 1 and TargetBuff[8249].nLeftTime > 18 then
	    if s_util.CastSkill(13053, false) then return end
	end
	
    --���Ŀ��û����Ѫbuff,������Ѫ����<3,������Ѫʱ��<4,�ͷ�ն��
	if not TargetBuff[8249] or TargetBuff[8249].nStackNum < 3 or TargetBuff[8249].nLeftTime < 4 then
	    if s_util.CastSkill(13054, false) then return end 
    end	
	
	--��1����Ѫ���������ܻ���ʹ�ô���>2,���Ҷܷɿ�ʹ�ô���>0,����ն��CD>1,����Ŀ������Ѫbuff,������Ѫ����=1,������Ѫʱ��>15,ʩ�Ŷܻ�
	if  s_util.GetSkillCN(13047) > 2 and s_util.GetSkillCN(13050) > 0 and s_util.GetSkillCD(13054) > 1 and TargetBuff[8249] and TargetBuff[8249].nStackNum == 1 and TargetBuff[8249].nLeftTime > 15 then
        if s_util.CastSkill(13051, false) then
        g_MacroVars.State_13047 =0 return end
	end
	
	--��2����Ѫ���������ܻ���ʹ�ô���>2,���Ҷܷɿ�ʹ�ô���>0,����ն��CD>1,��������CD>1,����Ŀ������Ѫbuff,������Ѫ����=2,ʩ�Ŷܻ�
	if  s_util.GetSkillCN(13047) > 2 and s_util.GetSkillCN(13050) > 0 and s_util.GetSkillCD(13054) > 1 and s_util.GetSkillCD(13053) > 1 and TargetBuff[8249] and TargetBuff[8249].nStackNum == 2 then
        if s_util.CastSkill(13051, false) then
		g_MacroVars.State_13047 =0 return end
	end	
	
	--��3����Ѫ���1������ܻ���ʹ�ô���>2,���Ҷܷɿ�ʹ�ô���>0,����ն��CD>1,��������CD>1,����Ŀ������Ѫbuff,������Ѫ����=3,������Ѫʱ��<7,ʩ�Ŷܻ�
	if  s_util.GetSkillCN(13047) > 2 and s_util.GetSkillCN(13050) > 0 and s_util.GetSkillCD(13054) > 1 and s_util.GetSkillCD(13053) > 1 and TargetBuff[8249] and TargetBuff[8249].nStackNum == 3 and TargetBuff[8249].nLeftTime < 7 then
        if s_util.CastSkill(13051, false) then
		g_MacroVars.State_13047 =0 return end
	end	
	
	--��3����Ѫ���2�����ŭ��<=4,���߶ܷɿ�ʹ�ô���>0,��������CD>1,����ն��CD>1,����Ŀ������Ѫbuff,������Ѫ����=3,ʩ�Ŷܻ�
	if player.nCurrentRage<=4 then 
		if s_util.CastSkill(13051, false) then
		g_MacroVars.State_13047 =0 return end
    end
	
	--�ٵ�
	if s_util.CastSkill(13052, false) then return end
	
--�浶��̬����	
end

--ս��״̬����  
end	

--����������
if player.GetKungfuMount().dwSkillID==10389 then

--���Ŀ���ͷſ����༼�ܾ��ͷź������
	if bPrepare and ( dwSkillId == 18300 or dwSkillId == 18372 or dwSkillId == 9568 or dwSkillId == 18369 or dwSkillId == 9569 or dwSkillId == 9242 ) and s_util.GetDistance(player, target) < 6  then
	if s_util.CastSkill(9007, false) then return end
	end
	
--T�괿�ܵ�ˢ110ŭ��
if qixue10 == 4 and qixue3 == 4 then

--���Ѫ��С��30���ͷŶܱ�
if hpRatio < 0.30 and s_util.CastSkill(13070, false) then return end

--�����̬�����
if player.nPoseState == 2 then

	--ʩ�Ŷܵ�
	if player.nCurrentRage > 105 then
	if s_util.CastSkill(13391, false) then return end
	end

	--ʩ�Ŷ�ѹ
	if player.nCurrentRage < 100 then
	if s_util.CastSkill(13045, false) then return end
	end

	--ʩ�Ŷܵ���4321��
	if s_util.CastSkill(13119, false) then return end
	if s_util.CastSkill(13060, false) then return end
	if s_util.CastSkill(13059, false) then return end
	if s_util.CastSkill(13044, false) then return end
end

--�����̬���浶
if player.nPoseState == 1 then

	--�л���̬
	if s_util.CastSkill(13051, false) then return end
end

end

--T�괿�ܵ�ˢ100ŭ��
if qixue10 == 4 and qixue3 == 1 then

--���Ѫ��С��30���ͷŶܱ�
if hpRatio < 0.30 and s_util.CastSkill(13070, false) then return end

--�����̬�����
if player.nPoseState == 2 then

	--ʩ�Ŷܵ�
	if player.nCurrentRage > 95 then
	if s_util.CastSkill(13391, false) then return end
	end

	--ʩ�Ŷ�ѹ
	if player.nCurrentRage < 90 then
	if s_util.CastSkill(13045, false) then return end
	end

	--ʩ�Ŷܵ���4321��
	if s_util.CastSkill(13119, false) then return end
	if s_util.CastSkill(13060, false) then return end
	if s_util.CastSkill(13059, false) then return end
	if s_util.CastSkill(13044, false) then return end
end

--�����̬���浶
if player.nPoseState == 1 then

	--�л���̬
	if s_util.CastSkill(13051, false) then return end
end

end

--ս��ɽ��4wifi�ֶ��ܷ�
if qixue12 == 4 and qixue6 == 3 then

--���Ѫ��С��30���ͷŶܱ�
if hpRatio < 0.30 and s_util.CastSkill(13070, false) then return end

    --�����̬�����
if player.nPoseState == 2 then
	
	--�����buff����,�ͷź�Хǧ��
	if MyBuff[8253] then
    	if s_util.CastSkill(15072, false) then return end
    
	end
	--ʩ�Ŷܵ�
	if not MyBuff[8499] then
		if s_util.CastSkill(13391, false) then return end
	end

	--ʩ�Ŷ�ѹ
	if s_util.CastSkill(13045, false) then return end

	--ʩ�Ŷܵ���4321��
	if s_util.CastSkill(13119, false) then return end
	if s_util.CastSkill(13060, false) then return end
	if s_util.CastSkill(13059, false) then return end
	if s_util.CastSkill(13044, false) then return end
end

--�����̬���浶
if player.nPoseState == 1 then

    --�ٵ�
	if s_util.CastSkill(13052, false) then return end

	--���Ŀ���Ŀ�겻���Լ�,����ŭ��С��5,�ͷ�Ѫŭ
	if ttarget and ttarget.dwID ~= player.dwID and player.nCurrentRage < 5  then
    if s_util.CastSkill(13040, false) then return end
	end

	--���Ŀ�����Լ�,�ͷŶܻ�
	if ttarget and ttarget.dwID == player.dwID then
	if s_util.CastSkill(13051, false) then return end
	end
	
end 
end

--����ǵ��4wifi
if qixue12 == 4 and qixue6 == 4 then

--���Ѫ��С��30���ͷŶܱ�
if hpRatio < 0.30 and s_util.CastSkill(13070, false) then return end

--���Ŀ���ڶ���,���Ҽ���ID��13126,�ͷŶܷ�
if bPrepare and dwSkillId == 19044 then
if s_util.CastSkill(13050, false) then return end
end

--�����ΧBOSS�ͷż���ID13126,�ͷŶܷɣ�δ���ԣ�
local zy = nil	--��ʼ��Ϊnil
for _,v in ipairs(GetAllNpc()) do
	local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState = GetSkillOTActionState(v)
	if bPrepare and dwSkillId == 19044 then	--����ڶ��������Ҽ���ID��19044
		zy = v			--��¼���NPC
		break				--����ѭ��
	end
end

if zy then	--������ڶ���19044���ܵ�npc������������ж����Լ���ϼ��ܵ�CD
	s_util.SetTarget(TARGET.PLAYER, zy.dwID)		--ѡ����ΪĿ��
	s_util.CastSkill(13051, false)
	s_util.CastSkill(13050, false)			--ʹ�ô�ϼ���
	return
end

--�����̬�����
if player.nPoseState == 2 then

	--���Ŀ���Ŀ�겻���Լ�,������BUFF���������߽�����,����>1��,�ͷŶ���
	if (( target.dwTemplateID == 60133 or target.dwTemplateID == 60446 or target.dwTemplateID == 59433 ) and TTargetBuff[12862] and TTargetBuff[12862].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and ( not MyBuff[12862] or MyBuff[12862] and MyBuff[12862].nStackNum < 2 ) or
	(( target.dwTemplateID == 60134 or target.dwTemplateID == 60447 or target.dwTemplateID == 59434 ) and TTargetBuff[12861] and TTargetBuff[12861].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and ( not MyBuff[12861] or MyBuff[12861] and MyBuff[12861].nStackNum < 2 ) then
	if s_util.CastSkill(13046, false) then return end
	end

	--���Ŀ���Ŀ�겻���Լ�,������BUFF���������߽�����,����>1��,�ͷŶܷ�
	if  (( target.dwTemplateID == 60133 or target.dwTemplateID == 60446 or target.dwTemplateID == 59433 ) and TTargetBuff[12862] and TTargetBuff[12862].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and ( not MyBuff[12862] or MyBuff[12862] and MyBuff[12862].nStackNum < 2 ) or
	(( target.dwTemplateID == 60134 or target.dwTemplateID == 60447 or target.dwTemplateID == 59434 ) and TTargetBuff[12861] and TTargetBuff[12861].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and  ( not MyBuff[12861] or MyBuff[12861] and MyBuff[12861].nStackNum < 2 )  then
	if s_util.CastSkill(13050, false) then return end
	end
	
	--�����BUFF����,�ͷź�Хǧ��
	if MyBuff[8253] then
    	if s_util.CastSkill(15072, false) then return end
	end
	--���û��BUFF�ܵ�,�ͷŶܵ�
	if not MyBuff[8499] then
		if s_util.CastSkill(13391, false) then return end
	end

	--ʩ�Ŷ�ѹ
	if s_util.CastSkill(13045, false) then return end

	--ʩ�Ŷܵ���4321��
	if s_util.CastSkill(13119, false) then return end
	if s_util.CastSkill(13060, false) then return end
	if s_util.CastSkill(13059, false) then return end
	if s_util.CastSkill(13044, false) then return end
end

--�����̬���浶
if player.nPoseState == 1 then

    --���Ŀ���Ŀ�겻���Լ�,������BUFF���������߽�����,����>1��,�ͷ�ն��
	if  (( target.dwTemplateID == 60133 or target.dwTemplateID == 60446 or target.dwTemplateID == 59433 ) and TTargetBuff[12862] and TTargetBuff[12862].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and ( not MyBuff[12862] or MyBuff[12862] and MyBuff[12862].nStackNum < 2 ) or
	(( target.dwTemplateID == 60134 or target.dwTemplateID == 60447 or target.dwTemplateID == 59434 ) and TTargetBuff[12861] and TTargetBuff[12861].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and  ( not MyBuff[12861] or MyBuff[12861] and MyBuff[12861].nStackNum < 2 )  then
	if s_util.CastSkill(13054, false) then return end
    end
	
    --���Ŀ���Ŀ�겻���Լ�,������BUFF���������߽�����,����>1��,�ͷŽٵ�
	if  (( target.dwTemplateID == 60133 or target.dwTemplateID == 60446 or target.dwTemplateID == 59433 ) and TTargetBuff[12862] and TTargetBuff[12862].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and ( not MyBuff[12862] or MyBuff[12862] and MyBuff[12862].nStackNum < 2 ) or
	(( target.dwTemplateID == 60134 or target.dwTemplateID == 60447 or target.dwTemplateID == 59434 ) and TTargetBuff[12861] and TTargetBuff[12861].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and  ( not MyBuff[12861] or MyBuff[12861] and MyBuff[12861].nStackNum < 2 )  then
	if s_util.CastSkill(13052, false) then return end
	end

	--���Ŀ���Ŀ�겻���Լ�,������BUFF���������߽�����,����>1��,����ŭ��С��5,�ͷ�Ѫŭ
	if  (( target.dwTemplateID == 60133 or target.dwTemplateID == 60446 or target.dwTemplateID == 59433 ) and TTargetBuff[12862] and TTargetBuff[12862].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and player.nCurrentRage < 5 and ( not MyBuff[12862] or MyBuff[12862] and MyBuff[12862].nStackNum < 2 ) or
	(( target.dwTemplateID == 60134 or target.dwTemplateID == 60447 or target.dwTemplateID == 59434 ) and TTargetBuff[12861] and TTargetBuff[12861].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and player.nCurrentRage < 5 and  ( not MyBuff[12861] or MyBuff[12861] and MyBuff[12861].nStackNum < 2 )  then
    if s_util.CastSkill(13040, false) then return end
	end
	
	--���Ŀ�����Լ�,�ͷŶܻ�
	if ttarget and ttarget.dwID == player.dwID then
	if s_util.CastSkill(13051, false) then return end
	end
	
end 
end 
end 