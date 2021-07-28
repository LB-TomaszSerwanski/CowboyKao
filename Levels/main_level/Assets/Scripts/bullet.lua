local bullet = 
{
	Properties = 
	{
		Speed = {default = 30}
	}
}

function bullet:OnActivate()
	self.tickHandler = TickBus.Connect(self)
	self.Speed = self.Properties.Speed
	self.forward = EntityTransform_VM.GetEntityRight(self.entityId, 1)
	
--[[
	self.collisionCount = 0
	
--________________________________________________TRIGGER_____________________________________________
	self.triggerEnterBusId = SimulatedBody.GetOnTriggerEnterEvent(self.entityId);
	self.triggerEnterBus = self.triggerEnterBusId:Connect(
		function(...)
			self.collisionCount = self.collisionCount + 1
			log("Bullet Entered Trigger " .. tostring(self.collisionCount))
			
		end)

	self.triggerExitBusId = SimulatedBody.GetOnTriggerExitEvent(self.entityId);
	self.triggerExitBus = self.triggerExitBusId:Connect(
		function(...)
			self.collisionCount = self.collisionCount - 1
			log(" Bullet Exited Trigger " .. tostring(self.collisionCount))
		end)
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--]]

end

function bullet:OnDeactivate()
	self.tickHandler:Disconnect()
end

function bullet:OnTick(dt, stp)
	TransformBus.Event.RotateAroundLocalX(self.entityId, 30*dt)
	
--	self.forward = EntityTransform_VM.GetEntityForward(self.entityId, 1)
	TransformBus.Event.MoveEntity(self.entityId,self.forward * self.Speed * dt) -- Vector3(self.Speed * dt,0,0)
	
end

return bullet