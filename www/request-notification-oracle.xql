<?xml version="1.0"?>
<queryset>

    <fullquery name="notify_users">
        <querytext>
        select p.first_names || ' ' || p.last_name as name,nr.request_id
                                  from persons p, notification_requests nr
                                  where p.person_id = nr.user_id and
                                  nr.object_id = :object_id
                                  
        </querytext>
    </fullquery>


</queryset>
