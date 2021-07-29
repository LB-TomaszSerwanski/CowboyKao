local receiveDmg = 
{
	Properties = 
	{
		NextEntityName = {default = ""};
	}
}

function receiveDmg:OnActivate()
	self.ScriptEventHandler = HitSE.Connect(self, self.entityId)
end

function receiveDmg:ReceiveHit(entityId, damage)
	if self.Properties.NextEntityName == "" then
		Debug.Log("No Entity selected to send")
	else
		self.entityToSend = find_game_entity(self.Properties.NextEntityName)
		Debug.Log("Sending event to entity:"..GameEntityContextRequestBus.Broadcast.GetEntityName(self.entityToSend))
		HitSE.Event.ReceiveHit(self.entityToSend,1)
	end
	GameEntityContextRequestBus.Broadcast.DeactivateGameEntity(self.entityId)
end

return receiveDmg
