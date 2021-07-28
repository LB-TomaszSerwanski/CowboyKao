local bullet = 
{
	Properties = 
	{
		Speed = {default = 30};
	}
}

function bullet:OnActivate()
	self.Speed = self.Properties.Speed
	self.forward = EntityTransform_VM.GetEntityRight(self.entityId, 1)
	
--________________________________________________TRIGGER_____________________________________________
	self.triggerEnterBusId = SimulatedBody.GetOnTriggerEnterEvent(self.entityId);
	self.triggerEnterBus = self.triggerEnterBusId:Connect(
		function(x, y)
			self.children = TransformBus.Event.GetChildren(self.entityId)
			for i = 0,#self.children,1 do
				GameEntityContextRequestBus.Broadcast.DeactivateGameEntity(self.children[i])
			end
			GameEntityContextRequestBus.Broadcast.DeactivateGameEntity(self.entityId)
			self.body1 = TriggerEvent.GetOtherEntityId(y)
			HitSE.Event.ReceiveHit(self.body1, 40)
		end)
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--]]

	self.tickHandler = TickBus.Connect(self)
end

function bullet:OnDeactivate()
	self.tickHandler:Disconnect()
end

function bullet:OnTick(dt, stp)
	TransformBus.Event.RotateAroundLocalX(self.entityId, 30*dt)
	TransformBus.Event.MoveEntity(self.entityId,self.forward * self.Speed * dt)
end

return bullet