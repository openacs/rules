<master>
<property name="context">@context@</property>
<property name="title">Single Rules Properties</property>
<script language="JavaScript">
function go() {
        qs = document.add_trigger.qs_id.value;
        answer=document.add_trigger.result_id.value;
        action=document.add_trigger.action_type.value;
	active=document.add_trigger.active_p.value;
	group=document.add_trigger.group_id.value;
        destination = "single-rule-add?rule_id=@rule_id@@exp_trigger;noquote@&s_qs="+qs+"&s_answer="+answer+"&s_action="+action+"&s_active="+active+"&s_group="+group;
        if (destination) location.href = destination;
      
}
</script>
<br>
<h2>@rule_name@ <a href=add-rule?rule_id=@rule_id@&return_url=single-rule?rule_id=@rule_id@><img border=0 src=images/Edit16.gif></a></h2>
Related Questionnarie: <b>@assessment_related@</b>
<br>
State:<b>@state@</b>
<br>
<br>
<br>
<table>
 <tr>
 <td>
 </td>
 <td>
  <a
  href="request-notification?object_id=@rule_id@&type_id=@type_id@&return_url=one-rule?rule_id=@rule_id@" title="Notify" class="button">Add Notification for this Rule</a>
  <a href="admin-request?rule=@rule_id@" title="Waiting List"
  class="button">Waiting List</a>
 </td>
 </tr>
</table>
<br>
<br>
<formtemplate id="add_trigger">
<table>
<tr>
<th>Question
<th>Answer
<th>Action
<th>Result
<th>Active
</tr>
<tr>
<td>
   <formwidget id="qs_id"></formwidget>
</td>
<td>
   <formwidget id="result_id"></formwidget>
</td>
<td>
   <formwidget id="action_type"></formwidget>
</td>
<td>
   <formwidget id="group_id"></formwidget>
</td>
<td>
   <formwidget id="active_p"></formwidget>
</td>
</tr>
</table>
<br>
<center>
 <formwidget id="submit"></formwidget>
</center>
</formtemplate>
 
