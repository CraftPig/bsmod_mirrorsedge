
--IMPORTANT: Make sure this is the only custom killmove lua file for your addon since having multiple can cause conflicts and issues
if CLIENT then
    hook.Add("PopulateToolMenu", "mirrorsedge_killmove", function()
		    spawnmenu.AddToolMenuOption("Options", "BSMod", "servermirrorsedge_killmoves", "BSMOD ME Settings", "", "", function(panel)
			panel:ClearControls()
			panel:NumSlider("Chance Mirror's Edge killmove?", "bsmod_mirrorsedge_chance", 0, 4, false)
			panel:ControlHelp("Each additional number adds a 25% chance for Mirror's Edge killmoves to occur. Lower the number to allow killmoves from other packs to be used.")			
		end)
	end)
end

--This makes sure the functions in this if statement are only ran on the server since they aren't needed on the client
if SERVER then

    CreateConVar("bsmod_mirrorsedge_chance", 4, FCVAR_ARCHIVE, "Chance Mirror's Edge killmove?", 0, 4)

	--This is the hook for custom killmoves
	--IMPORTANT: Make sure to change the NeckSnap to something else to avoid conflicts with other custom killmove addons
	hook.Add("CustomKillMoves", "MirrorsEdge_Killmoves", function(ply, target, angleAround)
		
		--Setup some values for custom killmove data
		local plyKMModel = nil
		local targetKMModel = nil
		local animName = nil
		local plyKMPosition = nil
		local plyKMAngle = nil
		
		local kmData = {1, 2, 3, 4, 5} --We'll use this at the end of the hook
		
		plyKMModel = "models/weapons/bsmod_mirrorsedge_snatcher.mdl" --We set the Players killmove model to the custom one that has the animations
	
		--Use these checks for angle specific killmoves, make sure to keep the brackets when using them
		if (angleAround <= 45 or angleAround > 315) then
			--print("in front of target")
		elseif (angleAround > 45 and angleAround <= 135) then
			--print("left of target")
		elseif (angleAround > 135 and angleAround <= 225) then
			--print("behind target")
		elseif (angleAround > 225 and angleAround <= 315) then
			--print("right of target")
		end
		
	plyKMPosition = target:GetPos() + (target:GetForward() * 0)
	-- Compensate for the rotation in blender
	
		if ply:OnGround() and target:LookupBone("ValveBiped.Bip01_Spine") and (angleAround <= 45 or angleAround > 315) and math.random(1, 4) <= GetConVar("bsmod_mirrorsedge_chance"):GetFloat() then 
		
		   targetKMModel = "models/bsmod_mirrorsedge_snatched.mdl" -- 
			
			local rnd = math.random(1,4)
			
			-------------------- Unarmed Table
			    if rnd == 1 then 
                    animName = "bsmod_takedown_fwd_onehand_01"		
				elseif rnd == 2 then 
                    animName = "bsmod_takedown_fwd_onehand_02"		
				elseif rnd == 3 then 
                    animName = "bsmod_takedown_fwd_onehand_03"
                elseif rnd == 4 then 
                    animName = "bsmod_takedown_fwd_twohand_01"					
				end
		end
		
		--Positioning the Player for different killmove animations
		if animName == "bsmod_takedown_fwd_onehand_01" then
			plyKMPosition = target:GetPos() + (target:GetForward() * 1 ) --Position the player in front of the Target and x distance away
			target:SetAngles(target:GetAngles()+Angle(0,180,0))
		elseif animName == "bsmod_takedown_fwd_onehand_02" then
			plyKMPosition = target:GetPos() + (target:GetForward() * 1 ) --Position the player in front of the Target and x distance away
			target:SetAngles(target:GetAngles()+Angle(0,180,0))
		elseif animName == "bsmod_takedown_fwd_onehand_03" then
			plyKMPosition = target:GetPos() + (target:GetForward() * 1 ) --Position the player in front of the Target and x distance away
			target:SetAngles(target:GetAngles()+Angle(0,180,0))
		elseif animName == "bsmod_takedown_back_onehand_01" then
			plyKMPosition = target:GetPos() + (target:GetForward() * 1 ) --Position the player in front of the Target and x distance away
			target:SetAngles(target:GetAngles()+Angle(0,180,0))
		elseif animName == "bsmod_takedown_fwd_twohand_01" then
			plyKMPosition = target:GetPos() + (target:GetForward() * 1 ) --Position the player in front of the Target and x distance away
			target:SetAngles(target:GetAngles()+Angle(0,180,0))
		elseif animName == "bsmod_takedown_back_twohand_01" then
			plyKMPosition = target:GetPos() + (target:GetForward() * 1 ) --Position the player in front of the Target and x distance away
			target:SetAngles(target:GetAngles()+Angle(0,180,0))
		elseif animName == "bsmod_takedown_fwd_twohand_lmg" then
			plyKMPosition = target:GetPos() + (target:GetForward() * 1 ) --Position the player in front of the Target and x distance away
			target:SetAngles(target:GetAngles()+Angle(0,180,0))
		elseif animName == "bsmod_takedown_back_twohand_lmg" then
			plyKMPosition = target:GetPos() + (target:GetForward() * 1 ) --Position the player in front of the Target and x distance away
			target:SetAngles(target:GetAngles()+Angle(0,180,0))
		elseif animName == "bsmod_takedown_fwd_twohand_neo" then
			plyKMPosition = target:GetPos() + (target:GetForward() * 1 ) --Position the player in front of the Target and x distance away
			target:SetAngles(target:GetAngles()+Angle(0,180,0))
		elseif animName == "bsmod_takedown_back_twohand_neo" then
			plyKMPosition = target:GetPos() + (target:GetForward() * 1 ) --Position the player in front of the Target and x distance away
			target:SetAngles(target:GetAngles()+Angle(0,180,0))
		end

		--IMPORTANT: Make sure not to duplicate the rest of the code below, it isn't nessecary and can cause issues, just keep them at the bottom of this function
		kmData[1] = plyKMModel
		kmData[2] = targetKMModel
		kmData[3] = animName
		kmData[4] = plyKMPosition
		kmData[5] = plyKMAngle
 
		if animName != nil then return kmData end --Send the killmove data to the main addons killmove check function
	end)
	
	--This is the hook for custom killmove effects and sounds
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- This is the hook for custom killmove effects and sounds
hook.Add("CustomKMEffects", "MirrorsEdge_Killmoves", function(ply, animName, targetModel)
	local targetHeadBone = nil
		
	if IsValid (targetModel) then targetHeadBone = targetModel:GetHeadBone() end
	
----------------------------------------------------------------------------- bsmod_takedown_fwd_onehand_01

	if animName == "bsmod_takedown_fwd_onehand_01" then
	        timer.Simple(0, function()
			    if !IsValid(targetModel) then return end             				
            end)
	        -- Grab Arm
		    timer.Simple(0.0, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 4, "bsmod/mirrorsedge/GrabArm_")	  				
            end)			
			-- Grab Uniform
		    timer.Simple(0.2, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 2, "bsmod/mirrorsedge/GrabUniform_")	  				
            end)			
			-- Head Knee
		    timer.Simple(0.4, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 3, "bsmod/mirrorsedge/HeadKnee_")	  				
            end)		
			-- Break Arm
		    timer.Simple(0.4, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 8, "bsmod/mirrorsedge/BreakArm_")	  				
            end)	
            -- Grab Hair
		    timer.Simple(1.0, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 5, "bsmod/mirrorsedge/GrabHair_")	  				
            end)			
			-- Leg Swoosh
		    timer.Simple(1.6, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 4, "bsmod/mirrorsedge/LegSwoosh_")	  				
            end)
			-- Head
		    timer.Simple(1.7, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1,3, "bsmod/mirrorsedge/HeadKnee_")	
                PlayRandomSound(ply, 1,2, "bsmod/mirrorsedge/GunMelee_")	  				
            end)
			-- Bodyfall
		    timer.Simple(2.1, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1,6, "bsmod/mirrorsedge/BF_Short_Hard_")	  				
            end)
    end
	
----------------------------------------------------------------------------- bsmod_takedown_fwd_onehand_02
	
	if animName == "bsmod_takedown_fwd_onehand_02" then
	        timer.Simple(0, function()
			    if !IsValid(targetModel) then return end             				
            end)
	        -- Grab Arm
		    timer.Simple(0.0, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 4, "bsmod/mirrorsedge/GrabArm_")	  				
            end)
			-- Break Arm
		    timer.Simple(0.1, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 8, "bsmod/mirrorsedge/BreakArm_")	  				
            end)
			-- Leg Swoosh
		    timer.Simple(0.3, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 4, "bsmod/mirrorsedge/LegSwoosh_")	  				
            end)	
			-- Leg Swoosh
		    timer.Simple(0.45, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 4, "bsmod/mirrorsedge/LegSwoosh_")	  				
            end)	
            -- Leg Swoosh
		    timer.Simple(0.6, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 4, "bsmod/mirrorsedge/LegSwoosh_")	  				
            end)			
			-- Bodyfall
		    timer.Simple(0.8, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1,5, "bsmod/mirrorsedge/Bodyfall0")	  				
            end)

    end
	
----------------------------------------------------------------------------- bsmod_takedown_fwd_onehand_03
	
	if animName == "bsmod_takedown_fwd_onehand_03" then
	        timer.Simple(0, function()
			    if !IsValid(targetModel) then return end             				
            end)
	        -- Grab Arm
		    timer.Simple(0.0, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 4, "bsmod/mirrorsedge/GrabArm_")	  				
            end)
			-- Leg Swoosh
		    timer.Simple(0.0, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 4, "bsmod/mirrorsedge/LegSwoosh_")	  				
            end)
			-- Break Arm
		    timer.Simple(0.2, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 8, "bsmod/mirrorsedge/BreakArm_")	  				
            end)
			-- Grab Hair
		    timer.Simple(0.54, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 5, "bsmod/mirrorsedge/GrabHair_")	  				
            end)
			-- Leg Swoosh
		    timer.Simple(0.7, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 4, "bsmod/mirrorsedge/LegSwoosh_")	  				
            end)
			-- Head Knee
		    timer.Simple(1.0, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 3, "bsmod/mirrorsedge/HeadKnee_")	  				
            end)
			-- Grab Uniform
		    timer.Simple(1.7, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 2, "bsmod/mirrorsedge/GrabUniform_")	  				
            end)
			-- Bodyfall
		    timer.Simple(2.1, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1,6, "bsmod/mirrorsedge/BF_Short_Hard_")	  				
            end)

    end
	
----------------------------------------------------------------------------- bsmod_takedown_fwd_twohand_01
	
	if animName == "bsmod_takedown_fwd_twohand_01" then
	        timer.Simple(0, function()
			    if !IsValid(targetModel) then return end             				
            end)
	        -- Grab Arm
		    timer.Simple(0.0, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 4, "bsmod/mirrorsedge/GrabArm_")	  				
            end)
			-- Leg Swoosh
		    timer.Simple(0.2, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 4, "bsmod/mirrorsedge/LegSwoosh_")	  				
            end)
			-- Head Knee
		    timer.Simple(0.3, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 3, "bsmod/mirrorsedge/HeadKnee_")	  				
            end)
			-- Leg Swoosh
		    timer.Simple(0.7, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 4, "bsmod/mirrorsedge/LegSwoosh_")	  				
            end)
			-- Break Arm
		    timer.Simple(0.8, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1, 8, "bsmod/mirrorsedge/BreakArm_")	  				
            end)
			-- Bodyfall
		    timer.Simple(1.15, function()
			    if !IsValid(targetModel) then return end   
                PlayRandomSound(ply, 1,6, "bsmod/mirrorsedge/BF_Short_Hard_")	  				
            end)
			

    end
	
----------------------------------------------------------------------------- 

end)

hook.Add( "KMRagdoll", "MirrorsEdge_Killmoves", function(entity, ragdoll, animName)
--Define the position and angles of a bone, we'll talk about this further down
	local spinePos, spineAng = nil
	
	if ragdoll:LookupBone("ValveBiped.Bip01_Spine") then 
		spinePos, spineAng = ragdoll:GetBonePosition(ragdoll:LookupBone("ValveBiped.Bip01_Spine"))
	end
	
	--Loop through all of the ragdoll's bones that have a physics mesh attached, this will basically move the entire ragdoll
	for i = 0, ragdoll:GetPhysicsObjectCount() - 1 do
		local bone = ragdoll:GetPhysicsObjectNum(i)
		
		if bone and bone:IsValid() then
			
			--We won't be needing this but if you do then feel free to uncomment it
			--local bonepos, boneang = ragdoll:GetBonePosition(ragdoll:TranslatePhysBoneToBone(i))
			
			if animName == "bsmod_takedown_fwd_twohand_01" then
				if spineAng != nil then
					bone:SetVelocity(-spineAng:Forward() * -0)
				end
			------------------------------------------------
					--bone:SetVelocity(-spineAng:Up() * 75)
					--bone:SetVelocity(-spineAng:Right() * -65)
					--bone:SetVelocity(-spineAng:Forward() * 15)
					--bone:SetVelocity(-spineAng:Forward() * 40)
			end
			if animName == "bsmod_takedown_fwd_onehand_01" then
				if spineAng != nil then
					bone:SetVelocity(-spineAng:Forward() * -0)
				end
			------------------------------------------------
					--bone:SetVelocity(-spineAng:Up() * 75)
					--bone:SetVelocity(-spineAng:Right() * -65)
					--bone:SetVelocity(-spineAng:Forward() * 15)
					--bone:SetVelocity(-spineAng:Forward() * 40)
			end
			if animName == "bsmod_takedown_fwd_onehand_02" then
				if spineAng != nil then
					bone:SetVelocity(-spineAng:Forward() * -0)
				end
			------------------------------------------------
					--bone:SetVelocity(-spineAng:Up() * 75)
					--bone:SetVelocity(-spineAng:Right() * -65)
					--bone:SetVelocity(-spineAng:Forward() * 15)
					--bone:SetVelocity(-spineAng:Forward() * 40)
			end
			if animName == "bsmod_takedown_fwd_onehand_03" then
				if spineAng != nil then
					bone:SetVelocity(-spineAng:Forward() * -0)
				end
			------------------------------------------------
					--bone:SetVelocity(-spineAng:Up() * 75)
					--bone:SetVelocity(-spineAng:Right() * -65)
					--bone:SetVelocity(-spineAng:Forward() * 15)
					--bone:SetVelocity(-spineAng:Forward() * 40)
			end
		end
	end
	
	--You can also rotate the ragdoll by changing it's angular velocity, here's an example below
	
	--bone:SetAngleVelocity(bone:WorldToLocalVector(-spineAng:Forward() * 2500))
	
	--This basically makes the ragdoll spin like a torpedo, it's -spineAng:Forward() because again source engine bones are weird but it basically means the up direction of it
end) 