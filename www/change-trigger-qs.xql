<?xml version="1.0"?>

<queryset>
	<fullquery name="update_trigger"> 
		   <querytext>
		   update rules_triggers set qs_id=:qs where rule_id=:rule_id and rule_def_id=:trigger_id
		   </querytext>
	</fullquery>
</queryset>
