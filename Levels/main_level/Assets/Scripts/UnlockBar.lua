local unlockBar = 
{
}

function unlockBar:OnActivate()
	self.ScriptEventHandler = HitSE.Connect(self, self.entityId)
	if String.EndsWith(GameEntityContextRequestBus.Broadcast.GetEntityName(self.entityId), "2",0) then
		self.health = 2
	else 
		self.health = 3
	end
	self.timeBetweenEvents = 0
	self.tickHandler = TickBus:Connect(self)
	self.eventReceived = false
end

function unlockBar:ReceiveHit(entityId, damage)
	self.health = self.health -1
	Debug.Log("wood bar health: "..tostring(self.health))
	self.eventReceived = true
	if self.health <= 0 then
		TransformBus.Event.MoveEntity(self.entityId, Vector3(0,0,7))
	end
end


return unlockBar
