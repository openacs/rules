<master>
<property name="context">@context@</property>
<property name="title">Rules Properties</property>


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
  <a
  href="request-notification?object_id=@rule_id@&type_id=@type_id@&return_url=single-rule" title="Notify" class="button">Add Notification for this Rule</a>
  <a href="admin-request?return_url=single-rule&rule=@rule_id@" title="Waiting List"
  class="button">Waiting List</a>

 </td>
 </tr>
 <tr>
  <td>
  <listtemplate name=triggers></listtemplate>
</td>
<td>
</tr>
</table>
