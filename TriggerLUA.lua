local trigger = 
{


}

function trigger:OnActivate()
	self.triggerBusId = SimulatedBody.GetOnTriggerEnterEvent(self.entityId);
	self.triggerBus = self.triggerBusId:Connect(
	function(SimulatedBodyHandle, TriggerEvent)
		Debug.Log("Entered Trigger");
		Debug.Log(tostring(GameEntityContextRequestBus.Broadcast.GetEntityName(TriggerEvent.GetOtherEntityId( TriggerEvent))))
		end);
end


return trigger;