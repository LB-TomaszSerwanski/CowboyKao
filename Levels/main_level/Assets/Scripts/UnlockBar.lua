local unlockBar = 
{
}

function unlockBar:OnActivate()
	self.ScriptEventHandler = HitSE.Connect(self, self.entityId)
	self.health = 3
end

function unlockBar:ReceiveHit(entityId, damage)
	self.health = self.health -1
	Debug.Log("wood bar health: "..tostring(self.health))
	if self.health <= 0 then
		TransformBus.Event.MoveEntity(self.entityId, Vector3(0,0,7))
	end
	
end

return unlockBar
