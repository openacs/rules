<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>
   <fullquery name="change_notify">
   <querytext>
	update rules_actions set notify_p= :notify_p where rule_action_id=:action_id

   </querytext>
   </fullquery>
</queryset>
