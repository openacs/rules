<master>
<property name="context">@context@</property>
<property name="title">Rules Properties</property>
<multiple name="rule_triggers">
<script language="JavaScript">
function go@rule_triggers.rule_def_id@(trigger) {

qs=document.form.edit_qs@rule_triggers.rule_def_id@.value;
destination="change-trigger-qs?rule_id=@rule_id@&trigger_id="+trigger+"&qs="+qs;
if (destination) location.href = destination;
      }
</script>

<script language="JavaScript">
                   function result@rule_triggers.rule_def_id@(trigger) {
                   res= document.form.edit_result@rule_triggers.rule_def_id@.value;
                   destination="change-trigger-result?rule_id=@rule_id@&trigger_id="+trigger+" &res="+res;
                   if (destination) location.href = destination;
                   }
                  </script>

</multiple>

<multiple name="rule_actions">
<script language="JavaScript">
                   function group@rule_actions.rule_action_id@() {
                   res=document.form2.res@rule_actions.rule_action_id@.value ;
                   destination="change-actions-result?rule_id=@rule_actions.rule_id@&action_id=@rule_actions.rule_action_id@&res="+res;
                   if (destination) location.href = destination;
                   }
</script>
</multiple>


<br>
<table>
 <tr>
  <td>
     <a href="add-trigger?rule_id=@rule_id@" title="Add Trigger" class="button">Add a
     Trigger to the Rule</a>
  </td>
 <td>
 </td>
 <td>
  <a href="request-notification?object_id=@rule_id@&type_id=@type_id@&return_url=one-rule?rule_id=@rule_id@" title="Notify" class="button">Add Notification</a>
 </td>
 </tr>
 <tr>
  <td>
<form name=form>
  <listtemplate name=triggers></listtemplate>
</form>
  </td>
 </tr>
</table>

<br>
<br>
<table>
 <tr>
  <td>
     <a href="add-action?rule_id=@rule_id@" title="Add action" class="button">Add an
     action to the Rule</a>
  </td>
 </tr>
 <tr>
  <td>
<form name=form2>
  <listtemplate name=actions></listtemplate>
</form2>
  </td>
  
 </tr>
</table>
