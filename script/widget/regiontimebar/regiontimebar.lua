Panel_RegionBar:SetShow(true, false)
Panel_TimeBar:SetShow(true, false)
Panel_TimeBar:setMaskingChild(true)

local UI_RT		 = CppEnums.RegionType
local UI_color 	 = Defines.Color

local regionType		= UI.getChildControl(Panel_RegionBar, "regionType")
local regionName		= UI.getChildControl(Panel_RegionBar, "regionName")
local timeNum			= UI.getChildControl(Panel_RegionBar, "timeNum")

local timeLine			= UI.getChildControl(Panel_TimeBar, "timeLine")
local timeElement		= UI.getChildControl(Panel_TimeBar, "timeElement")
local timeElement_right	= UI.getChildControl(Panel_TimeBar, "timeElement2")

UI.ASSERT(regionType        , "regionType        nil")
UI.ASSERT(regionName        , "regionName        nil")

UI.ASSERT(timeLine          , "timeLine          nil")
UI.ASSERT(timeElement       , "timeElement       nil")
UI.ASSERT(timeNum           , "timeNum           nil")
UI.ASSERT(timeElement_right , "timeElement_right nil")


timeNum:SetShow(false)		-- 시간 숫자는 최초에 꺼진 상태

function Minimap_updateRegion(regionData)
	-- 현재 사용하지 않는 함수
	local regionType = regionData:get():getRegionType()
	if (UI_RT.eRegionType_MinorTown == regionType) or (UI_RT.eRegionType_MainTown == regionType) then
		regionType:SetFontColor(UI_color.C_FF76CAFF)
		regionType:SetText(PAGetString( Defines.StringSheet_GAME, "PANEL_REGIONTIMERBAR_SAFETYZONE" ))		-- '안전지역'
	elseif (UI_RT.eRegionType_Hunting == regionType) then
		regionType:SetFontColor(UI_color.C_FFFF5F5F)
		regionType:SetText(PAGetString( Defines.StringSheet_GAME, "PANEL_REGIONTIMERBAR_BATTLEZONE" ))		-- '전투지역'
	elseif (UI_RT.eRegionType_Siege == regionType) or (UI_RT.eRegionType_Fortress == regionType) or (UI_RT.eRegionType_CastleInSiege == regionType) then
		if (regionData:get():isSiegeBeing()) then
			regionType:SetFontColor(UI_color.C_FFFF3BF8)
			regionType:SetText(PAGetString( Defines.StringSheet_GAME, "PANEL_REGIONTIMERBAR_SIEGEZONE" ))		-- '공성지역'
		else
			regionType:SetFontColor(UI_color.C_FFFF5F5F)
			regionType:SetText(PAGetString( Defines.StringSheet_GAME, "PANEL_REGIONTIMERBAR_BATTLEZONE" ))		-- '전투지역'
		end	
	end
		
	regionName:SetText ( tostring ( regionData:getAreaName() ) )				-- 지역명 출력
end

RegionData_IngameTime = 0
RegionData_ElementWidth = timeElement:GetSizeX()

local dayCycle = 24 * 60

function updateTime()
    local ingameTime = getIngameTime_minute()
	if ( dayCycle < ingameTime ) then
		ingameTime = ingameTime % dayCycle
	end
	
    if ( ingameTime == RegionData_IngameTime ) then
        return
    else
        RegionData_IngameTime = ingameTime
    end
	local minute = ( RegionData_IngameTime % 60 )
	local hour = math.floor( RegionData_IngameTime / 60 )

	local calcMinute = "00"
	if minute < 10 then
		calcMinute = "0" .. minute
	else
	    calcMinute = "" .. minute
	end

	if hour == 12 then
		timeNum:SetText( 'PM ' .. tostring(hour) .. ' : ' .. calcMinute )
	elseif hour == 0 then
		local calcHour = hour + 12
		timeNum:SetText( 'AM ' .. tostring(calcHour) .. ' : ' .. calcMinute )
	elseif hour == 24 then
		local calcHour = hour 
		timeNum:SetText( 'AM ' .. "0" .. ' : ' .. calcMinute )
	elseif hour > 11 then
		local calcHour = hour - 12
		timeNum:SetText( 'PM ' .. tostring(calcHour) .. ' : ' .. calcMinute )
	else
		timeNum:SetText( 'AM ' .. tostring(hour) .. ' : ' .. calcMinute )
	end

	timeElement:SetPosX( - RegionData_ElementWidth /2  - RegionData_ElementWidth * RegionData_IngameTime / dayCycle + 9 )
	timeElement_right:SetPosX( RegionData_ElementWidth /2  - RegionData_ElementWidth * RegionData_IngameTime / dayCycle  + 9)
	
	

end
function TimeBar_ShowToggle( isShow )
    timeLine   	        :SetShow(not isShow)
    timeElement		    :SetShow(not isShow)
    timeElement_right	:SetShow(not isShow)
    
    --if ( isShow ) then
    --    Panel_TimeBar:SetAlpha(0.0)
    --else
    --    Panel_TimeBar:SetAlpha(1.0)
    --end
    
    timeNum			    :SetShow(isShow)
end


--registerEvent("selfPlayer_regionChanged", "Minimap_updateRegion")
Panel_TimeBar:RegisterUpdateFunc( "updateTime" )

--Panel_TimeBar:setMaskingChild(true)

	
    Panel_Tooltip_Skill:SetIgnore(true)

    
timeLine			:SetIgnore(true)
timeElement		    :SetIgnore(true)
timeElement_right	:SetIgnore(true)
timeNum			    :SetIgnore(true)
Panel_TimeBar:addInputEvent("Mouse_On", "TimeBar_ShowToggle( true )")
Panel_TimeBar:addInputEvent("Mouse_Out", "TimeBar_ShowToggle( false )")
Panel_TimeBar:addInputEvent("Mouse_LUp", "ResetPos_WidgetButton()" )			--메인UI위젯 위치 초기화

Panel_RegionBar:SetIgnore(true)

--changePositionBySever(Panel_TimeBar, CppEnums.PAGameUIType.PAGameUIPanel_TimeBar, true, false, false)