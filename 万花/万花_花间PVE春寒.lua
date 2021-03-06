--奇穴：弹指 雪中行 倚天 焚玉 青歌 青冠 春寒 雪弃 生息 梦歌 踏歌 涓流
--属性：加速要求249
--秘籍：3毒持续时间+3S，阳明、钟林、兰催减读条时间，兰催至少1本减调息时间
--优化补dot处理，减少卡宏概率

--开头必须是这个，先获取自己的对象，没有的话说明还没进入游戏，直接返回
local player = GetClientPlayer()
if not player then return end

--自己没有清心补清心
if not s_util.GetBuffInfo(player)[112] then
    if s_util.Cast(130,true) then return end
end
--------------------------↓↓↓↓目标处理区开始↓↓↓↓-------------------------

--获取当前目标,未进战没目标直接返回,战斗中没目标选择最近敌对NPC,调整面向
local target, targetClass = s_util.GetTarget(player)							
if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then g_MacroVars.State_714 = 0 return end 
if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
    g_MacroVars.State_714 = 0
    local MinDistance=20	--最小距离
    local MindwID=0		    --最近NPC的ID
    for i,v in ipairs(GetAllNpc()) do		--遍历所有NPC
        --如果敌对并且距离更近则替换距离和ID
	    if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player)<MinDistance and v.nLevel>0 then
		    MinDistance = s_util.GetDistance(v, player)                             
	    	MindwID = v.dwID    
	    	end
	    end
    if MindwID == 0 then 
        return                          --没有敌对NPC则返回
    else	
        SetTarget(TARGET.NPC, MindwID)  --设定目标为最近的敌对NPC                
    end
end
if target then s_util.TurnTo(target.nX,target.nY) end  --调整面向

--如果目标死亡，直接返回
if target.nMoveState == MOVE_STATE.ON_DEATH then g_MacroVars.State_714 = 0 return end
--------------------------↑↑↑↑目标处理区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓变量定义区开始↓↓↓↓-------------------------

--定义自己和目标的距离
local distance = s_util.GetDistance(player, target)	

--定义自己的buff表
local MyBuff = s_util.GetBuffInfo(player)

--定义自己对目标造成的buff列表
local TargetBuff = s_util.GetBuffInfo(target, true)

--定义目标的全部buff列表
local TargetBuffAll = s_util.GetBuffInfo(target)

--定义目标读条数据，是否在读条, 技能ID，等级，读条百分比，动作类型
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)

--定义自己读条数据，是否在读条, 技能ID，等级，读条百分比，动作类型
local bPrepareMe, dwSkillIdMe, dwLevelMe, nLeftTimeMe, nActionStateMe =  GetSkillOTActionState(player)

--定义自己的血量比
local hpRatio = player.nCurrentLife / player.nMaxLife

--定义自己的蓝量比
local ManaRatio = player.nCurrentMana / player.nMaxMana

--初始化钟林全局变量，不在战斗状态重置为0
if not g_MacroVars.State_714 or not player.bFightState then
    g_MacroVars.State_714 = 0
    g_MacroVars.State_tar = target.dwID
end
--切换目标重置钟林全局变量
if g_MacroVars.State_tar then
    if g_MacroVars.State_tar ~= target.dwID then
        g_MacroVars.State_tar = target.dwID
        g_MacroVars.State_714 = 0
    end
end
--------------------------↑↑↑↑变量定义区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓应急技能区开始↓↓↓↓-------------------------

--血量小于30%对自己释放春泥护花
if hpRatio < 0.3 then 
    if s_util.Cast(132,true) then return end
end

--蓝量小于30%对自己释放碧水
if ManaRatio < 0.3 then
    if s_util.Cast(131,true) then return end
end

--按下"Alt"+"Q" 蹑云
if(IsAltKeyDown() and IsKeyDown("Q")) then
	s_util.Cast(9003,false,true)
end

--按下“Alt”+“E” 扶摇跳
if(IsAltKeyDown() and IsKeyDown("E")) then
	s_util.Cast(9002,true,false)
	if MyBuff[208] then Jump() end
end

--后跳躲珈罗兰猎物
if MyBuff[13034] and MyBuff[13034].nLeftTime > 2.5 then
	if s_util.Cast(9007,false,true) then return end    --后跳
end

--按下"Alt"停手
if IsAltKeyDown() then g_MacroVars.State_714 = 0 return end

--取消水月buff，防止阳明瞬发造成dot判定问题
if MyBuff[412] then s_util.CancelBuff(412) end

--------------------------↑↑↑↑应急技能区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓自动位移区开始↓↓↓↓-------------------------
--[[
--与目标距离超过15尺自动靠近目标（影响走位控制，团本慎用）
if distance > 15 then
	s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
else
	MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
end
--]]
--------------------------↑↑↑↑自动位移区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓输出循环区开始↓↓↓↓-------------------------

--处理dot延迟双钟林问题
if dwSkillIdMe == 189 and nLeftTimeMe > 0.8 then   --如果在读条钟林
    g_MacroVars.State_714 = 1 	                   --设置钟林刷新标志
end
if dwSkillIdMe == 179 and nLeftTimeMe > 0.8 then   --如果在读条阳明
    g_MacroVars.State_714 = 2                      --设置钟林兰催刷新标志
end

--没有商阳或钟林dot后则在4跳快雪后补兰催
if (not TargetBuff[666] or not TargetBuff[714]) and dwSkillIdMe == 2636 and nLeftTimeMe <= 0.2 then
    if s_util.Cast(190,false,true) then return end
end

--乱洒后阳明补dot
if not TargetBuff[714] and g_MacroVars.State_714 == 0 and MyBuff[2719] then 
    if s_util.Cast(179,false) then return end
end

--补兰催dot
if not TargetBuff[711] and not TargetBuff[666] and g_MacroVars.State_714 ~= 2 then  --目标无dot且兰催未刷新
    if s_util.Cast(190,false) then return end
end

--补钟林dot
if not TargetBuff[714] and g_MacroVars.State_714 == 0 then  --目标无dot且钟林未刷新
    if s_util.Cast(189,false) then return end
end

--补商阳dot
if not TargetBuff[666] then
    if s_util.Cast(180, false) then return end
end

--有乱洒BUFF 水月
if MyBuff[2719] then 
    if s_util.Cast(136,false) then return end
end

--商阳持续时间>11S且玉石CD 乱洒
if TargetBuff[666] and TargetBuff[666].nLeftTime > 11 and s_util.GetSkillCD(182) > 2 and s_util.GetSkillCD(182) <=15 then
    if s_util.Cast(2645,false) then return end
end

--商阳持续时间>11S且乱洒CD小于9S 玉石俱焚
if TargetBuff[666] and TargetBuff[666].nLeftTime > 11 and s_util.GetSkillCD(2645) < 9 then
    if s_util.Cast(182,false) then g_MacroVars.State_714 = 0  return end
end

--乱洒BUFF<7S则3跳快雪后 玉石
if MyBuff[2719] and MyBuff[2719].nLeftTime < 7 and dwSkillIdMe == 2636 and nLeftTimeMe <= 0.4 then
    if s_util.Cast(182,false,true) then g_MacroVars.State_714 = 0  return end
end

--乱洒BUFF>4S 断读条打3跳快雪
if MyBuff[2719] and MyBuff[2719].nLeftTime > 4 and dwSkillIdMe == 2636 and nLeftTimeMe <= 0.4 then
    if s_util.Cast(2636,false,true) then g_MacroVars.State_714 = 0 return end       
end

--有钟林+商阳dot 快雪时晴
if TargetBuff[666] and TargetBuff[714] then
    if s_util.Cast(2636,false) then g_MacroVars.State_714 = 0 return end  
end