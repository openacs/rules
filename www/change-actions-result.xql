<?xml version="1.0"?>

<queryset>
	<fullquery name="update_action_result"> 
		   <querytext>
			update rules_actions set group_id=:res where
			rule_action_id=:action_id
		   </querytext>
	</fullquery>
</queryset>
