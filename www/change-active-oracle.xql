<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>
   <fullquery name="change_active_rule">
   <querytext>
	update rules set active_p= :active_p where rule_id=:rule_id

   </querytext>
   </fullquery>
</queryset>
