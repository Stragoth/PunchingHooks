modifier_vengefulspirit_magic_missile_lua = class({})

--------------------------------------------------------------------------------

function modifier_vengefulspirit_magic_missile_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_vengefulspirit_magic_missile_lua:IsStunDebuff()
	return true
end
--------------------------------------------------------------------

function modifier_vengefulspirit_magic_missile_lua:OnCreated( kv )
	if IsServer() then
		if self:ApplyHorizontalMotionController() == false then 
			self:Destroy()
		end
	end
end

--------------------------------------------------------------------------------

function modifier_vengefulspirit_magic_missile_lua:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

--------------------------------------------------------------------------------

function modifier_vengefulspirit_magic_missile_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

--------------------------------------------------------------------------------

function modifier_vengefulspirit_magic_missile_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end
--------------------------------------------------------------------------------
function modifier_vengefulspirit_magic_missile_lua:OnCreated( kv )
 
        if IsServer() then
 
                if self:ApplyHorizontalMotionController() == false then
                        self:Destroy()
                else
                        self.hVictim = self:GetAbility().hVictim
                        self.currentduration = 0
                        self.duration = self:GetAbility().duration
                end
 
        end
 
end
--------------------------------------------------------------------------------

function modifier_vengefulspirit_magic_missile_lua:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end

--------------------------------------------------------------------------------

function modifier_vengefulspirit_magic_missile_lua:CheckState()
	local state = {
	[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
function modifier_vengefulspirit_magic_missile_lua:UpdateHorizontalMotion( me, dt )
	if IsServer() then
		if self.hVictim ~= nil then
			local vec = Vector(75,75,0) * dt
			self.hVictim:SetOrigin( self.hVictim:GetOrigin() + vec )
		end
	end
end
--------------------------------------------------------------------------------
function modifier_vengefulspirit_magic_missile_lua:OnHorizontalMotionInterrupted()
	if IsServer() then
		if self:GetAbility().hVictim ~= nil then
			self:Destroy()
		end
	end	
end
--------------------------------------------------------------------------------
function modifier_vengefulspirit_magic_missile_lua:OnDestroy()
	if IsServer() then
		self:GetParent():RemoveHorizontalMotionController(self)
	end
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
