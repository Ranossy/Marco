
--��Ѩ��[����][����][����][����][��Į][����][����][��ս][�ߺ�][����][����][����]
--�ؼ���PVE�ؼ�



--��ͷ������������Ȼ�ȡ�Լ��Ķ���û�еĻ�˵����û������Ϸ��ֱ�ӷ���
local player = GetClientPlayer()
if not player then return end

--��ǰѪ����ֵ
local hpRatio = player.nCurrentLife / player.nMaxLife

--��ȡ��ǰĿ�꣬����Ŀ������Ŀ������(��һ���NPC)
local target, targetClass = s_util.GetTarget(player)

--û��Ŀ�����Ŀ�겻�ǵ��ˣ�ֱ�ӷ���
if not target or not IsEnemy(player.dwID, target.dwID) then return end

--���Ŀ��������ֱ�ӷ���
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--��ȡ�Լ���buff��
local MyBuff = s_util.GetBuffInfo(player)

--��ȡĿ���buff��
local TargetBuff = s_util.GetBuffInfo(target)

--��ȡ�Լ���Ŀ��ľ���
local distance = s_util.GetDistance(player, target)

--��ȡĿ�굱ǰѪ����ֵ
local thpRatio = target.nCurrentLife / target.nMaxLife

--��ȡĿ��ǿ��
local Strength = GetNpcIntensity(target)

--��ʼ��Ѫŭ����
if not g_MacroVars.State_13040 then
	g_MacroVars.State_13040 = 0				
end

--��ս��״̬
if not player.bFightState then

  --��������װ������������ӣ�
  
  --�л���׹�����������Լ��޸���׹״̬ID�Լ���׹ID�����ֻ��Ҫ�л�1����׹���Լ��޸�һ�£�

  --���û��B��׹buff,����B��׹����CD<1,����Ŀ����BOSS�л���B��׹
  if not MyBuff[3853] and s_util.GetItemCD(8,5147,true) <1 and Strength >3 then
    if s_util.UseEquip(8,5147) then end
  end
  
  --���û��B��׹buff,����B��׹����CD<1,,����Ŀ����BOSSʹ��B��׹���� 
  if not MyBuff[3853] and s_util.GetItemCD(8,5147,true) <1 and Strength >3 then
    if s_util.UseItem(8,5147) then end
  end
   
  --���û��C��׹buff,����C��׹����CD<1,,����Ŀ����BOSS�л���C��׹
  if not MyBuff[6360] and s_util.GetItemCD(8,19078,true) <1 and Strength >3 then
    if s_util.UseEquip(8,19078) then end 
  end 
  
  --���û��C��׹buff,����C��׹����CD<1,,����Ŀ����BOSSʹ��C��׹����  
  if not MyBuff[6360] and s_util.GetItemCD(8,19078,true) <1 and Strength >3 then
    if s_util.UseItem(8,19078) then end
  end	

  --�����B��׹buff��C��׹buff,����B��׹����cd>1����C��׹����cd>1,�л���A��׹
   if ( MyBuff[6360] and MyBuff[3853] ) or ( s_util.GetItemCD(8,19078,true) >1 and s_util.GetItemCD(8,5147,true) >1 ) then
    if s_util.UseEquip(8,22831) then end
  end
  
  --�ͷ�����Ѫŭ
  if not MyBuff[8385] or MyBuff[8385].nStackNum < 2 then
    if s_util.CastSkill(13040, false) then return end
  end
  
--��ս��״̬����
end	
	
--����ս��״̬
if player.bFightState then

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
