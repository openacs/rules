<master src="admin/admin-master">
<property name="title">@rule_name@ Waiting List</property>
<property name="context_bar">@context@</property>
<script language="JavaScript">

function get_interval() {
        interval=document.interval.date.value; 
        destination = "admin-request?return_url=@return_url@&community=@default_community@&state=@default_state@&rule=@default_rule@&interval="+interval;
        if (destination) location.href = destination;
      
}
</script>
<script language="JavaScript">
function get_specific_date() {
        date=document.specific_date.specific_date.value; 
        destination ="admin-request?return_url=@return_url@&community=@default_community@&state=@default_state@&rule=@default_rule@&interval=@default_interval@&specific_date="+date;
             if (destination) location.href = destination;
      
}
</script>
<script language="JavaScript">
function get_community() {
        community=document.communities.community_id.value;
        destination = "admin-request?return_url=@return_url@&state=@default_state@&interval=@default_interval@&rule=@default_rule@&specific_date=@default_specific_date@&community="+community;
        if (destination) location.href = destination;
      
}
</script>

<script language="JavaScript">
function get_state() {
        state=document.communities.approved_p.value; 
        destination = "admin-request?return_url=@return_url@&community=@default_community@&interval=@default_interval@&specific_date=@default_specific_date@&rule=@default_rule@&state="+state;
         if (destination) location.href = destination;
      
}
</script>
      <table bgcolor="#cccccc" cellpadding="5" width="95%">
	<tr bgcolor="#eeeeee">
       	  <th align="left" width="50%">
           <formtemplate id="communities"></formtemplate>
          </th>
          <th>
           <formtemplate id="interval"></formtemplate>
           <formtemplate id="specific_date"></formtemplate>
          </th>
        </tr>
      </table>
<br>

<listtemplate name="requests"></listtemplate>

