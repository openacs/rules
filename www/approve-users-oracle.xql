<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>
   <fullquery name="community"> 
	      <querytext>
	      select group_id from rule_history_actions where rha_id=:r_id
	      </querytext>
   </fullquery>
   <fullquery name="user"> 
	      <querytext>
	      select user_id from rule_history_actions where rha_id=:r_id
	      </querytext>
   </fullquery>
   <fullquery name="today"> 
	      <querytext>
	      select to_date (sysdate,'YYYY-MM-DD') from dual
	      </querytext>
   </fullquery>
   <fullquery name="add_history"> 
	      <querytext>
	      update rule_history_actions set processing_date=:today, approved_p='y' where rha_id=:r_id
	      </querytext>
   </fullquery>

</queryset>
