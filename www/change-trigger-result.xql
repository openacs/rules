<?xml version="1.0"?>

<queryset>
	<fullquery name="update_trigger_result"> 
		   <querytext>
update rules_triggers set result_id=:res where rule_id=:rule_id and rule_def_id=:trigger_id
		   </querytext>
	</fullquery>
</queryset>
