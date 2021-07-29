local unlockBar = 
{
}

function unlockBar:OnActivate()
	self.ScriptEventHandler = HitSE.Connect(self, self.entityId)
	self.health = 2
end

function unlockBar:ReceiveHit(entityId, damage)
	self.health = self.health -1
	Debug.Log("gate health: "..tostring(self.health))
	if self.health <= 0 then
		if String.EndsWith(GameEntityContextRequestBus.Broadcast.GetEntityName(self.entityId), "Left",0) then
			Debug.Log("Hit: "..GameEntityContextRequestBus.Broadcast.GetEntityName(self.entityId)..". Opening Left Gate")
			TransformBus.Event.RotateAroundLocalZ(self.entityId, 1.57)
		else 
			Debug.Log("Opening Right Gate")
			TransformBus.Event.RotateAroundLocalZ(self.entityId, -1.57)
		end
	end
end

return unlockBar
