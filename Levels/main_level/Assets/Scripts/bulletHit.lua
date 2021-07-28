local bulletHit = 
{
	Properties = 
	{
	}
}

function bulletHit:OnActivate()
	self.ScriptEventHandler = HitSE.Connect(self, self.entityId)
	HitSE.Event.ReceiveHit(self.entityId, 40)
end

function bulletHit:OnDeactivate()
	self.ScriptEventHandler:Disconnect()
end

function bulletHit:ReceiveHit(damage)
	Debug.Log("Received "..tostring(damage) .. " damage")
end

return bulletHit