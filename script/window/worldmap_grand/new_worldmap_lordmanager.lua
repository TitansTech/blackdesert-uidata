-- ��ġ �޴�(��������)
CloseButton				= UI.getChildControl( Panel_Lord_Controller, "Button_Win_Close" )
RegionName				= UI.getChildControl( Panel_Lord_Controller, "StaticText_RegionName" )
MakingRateProgressBar	= UI.getChildControl( Panel_Lord_Controller, "Progress2_MakingRate" ) 	-- ?�산??
FishRateProgressBar		= UI.getChildControl( Panel_Lord_Controller, "Progress2_FishRate" ) 	-- 물고기량
MakingRateText			= UI.getChildControl( Panel_Lord_Controller, "StaticText_MakingRate" )	-- ?�산??% ?�시
FishRateText			= UI.getChildControl( Panel_Lord_Controller, "StaticText_FishRate" )	-- 물고기량 % ?�시

-- ��ġ�޴�(���)
PlantControlButton		= UI.getChildControl( Panel_Lord_Controller, "Button_PlantControl" )	-- ?�종개량
FishControlButton		= UI.getChildControl( Panel_Lord_Controller, "Button_FishControl" )	-- 치어방류
RainControlButton		= UI.getChildControl( Panel_Lord_Controller, "Button_RainControl" )	-- 기우??

CloseButton:addInputEvent("Mouse_LUp", "FGlobal_LordManagerClose()");

function FGlobal_LordManagerClose()
		Panel_Lord_Controller:SetShow(false);
end

