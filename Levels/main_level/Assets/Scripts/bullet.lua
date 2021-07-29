local bullet = 
{
	Properties = 
	{
		Speed = {default = 30};
	}
}

function bullet:OnActivate()
	self.lifeTime = 2;
	self.Speed = self.Properties.Speed
	self.forward = EntityTransform_VM.GetEntityRight(self.entityId, 1)
	
--________________________________________________TRIGGER_____________________________________________
	self.triggerEnterBusId = SimulatedBody.GetOnTriggerEnterEvent(self.entityId);
	self.triggerEnterBus = self.triggerEnterBusId:Connect(
		function(x, y)
			self.body1 = TriggerEvent.GetOtherEntityId(y)
			Debug.Log("Sending event to Entity: "..GameEntityContextRequestBus.Broadcast.GetEntityName(self.body1))
			HitSE.Event.ReceiveHit(self.body1, 40)
			self.children = TransformBus.Event.GetChildren(self.entityId)
			for i = 1,#self.children,1 do
				GameEntityContextRequestBus.Broadcast.DeactivateGameEntity(self.children[i])
			end
			GameEntityContextRequestBus.Broadcast.DeactivateGameEntity(self.entityId)
		end)
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--]]


	self.tickHandler = TickBus.Connect(self)
end

function bullet:OnDeactivate()
	self.tickHandler:Disconnect()
end

function bullet:OnTick(dt, stp)
	self.lifeTime = self.lifeTime - dt;
	if self.lifeTime > 0 then
		TransformBus.Event.RotateAroundLocalX(self.entityId, 30*dt)
		TransformBus.Event.MoveEntity(self.entityId,self.forward * self.Speed * dt)
	else 
		self.children = TransformBus.Event.GetChildren(self.entityId)
		for i = 1,#self.children,1 do
			--Debug.Log(GameEntityContextRequestBus.Broadcast.GetEntityName(self.children[i]))
			GameEntityContextRequestBus.Broadcast.DeactivateGameEntity(self.children[i])
		end
			GameEntityContextRequestBus.Broadcast.DeactivateGameEntity(self.entityId)
	end
		
end

return bullet