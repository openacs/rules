<?xml version="1.0"?>
<queryset>

    <fullquery name="rules::notification_delivery::do_notification.select_rule_name">
        <querytext>
        select rule_name from 
        rules where rule_id = :rule_id
        </querytext>
    </fullquery>

    <fullquery name="rules::notification_delivery::do_notification.select_user_name">
        <querytext>
        select persons.first_names || ' ' || persons.last_name as name,
                                  parties.email        
                                  from persons, parties
                                  where person_id = :user_id
                                  and person_id = party_id
        </querytext>
    </fullquery>


</queryset>
