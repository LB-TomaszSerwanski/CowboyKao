local spikeTrap =
{
}

function spikeTrap:OnActivate()
	self.ScriptEventHandler = HitSE.Connect(self, self.entityId)
	self.initialZ = TransformBus.Event.GetWorldTranslation(self.entityId).z
	self.moveVector = Vector3(0,0,0.1)
	self.waitTime = 1
	Debug.Log(tostring(self.initialZ))
	self.tickHandler = TickBus.Connect(self)
	self.triggerEnterBusId = SimulatedBody.GetOnTriggerEnterEvent(self.entityId);
	self.triggerEnterBus = self.triggerEnterBusId:Connect(
	function(x, y)
		self.body1 = TriggerEvent.GetOtherEntityId(y)
		if GameEntityContextRequestBus.Broadcast.GetEntityName(self.body1)~="Spikes" then
			--Debug.Log("Sending event to Entity: "..GameEntityContextRequestBus.Broadcast.GetEntityName(self.body1))
			HitSE.Event.ReceiveHit(self.body1, tonumber(50))
		end
	end)
end

function spikeTrap:OnDeactivate()
	self.tickHandler:Disconnect(self)
end


function spikeTrap:OnTick(dt, stp)
	if TransformBus.Event.GetWorldTranslation(self.entityId).z > self.initialZ + 2 then
		SimulatedBodyComponentRequestBus.Event.DisablePhysics(self.entityId)
		self.moveVector = Vector3(0,0,0-.1)
	else if TransformBus.Event.GetWorldTranslation(self.entityId).z < self.initialZ then
		self.moveVector = Vector3(0,0,0)
		self.waitTime = self.waitTime - dt
		if self.waitTime < 0 then
			SimulatedBodyComponentRequestBus.Event.EnablePhysics(self.entityId)
			self.moveVector = Vector3(0,0,0.1)
			self.waitTime = 1
		end
	end
	end
	TransformBus.Event.MoveEntity(self.entityId, self.moveVector)
end


return spikeTrap
