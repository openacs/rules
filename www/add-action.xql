<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>
   <fullquery name="communities"> 
   <querytext>
      select group_id as community_id,group_name as pretty_name from groups
   </querytext>
   </fullquery>
</queryset>