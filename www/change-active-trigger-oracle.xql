<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>
   <fullquery name="change_active_trigger">
   <querytext>
	update rules_triggers set active_p= :active_p where rule_def_id=:rule_def_id

   </querytext>
   </fullquery>
</queryset>
