<master>
<property name="context">@context@</property>
<script language="JavaScript">
function go() {
        qs = document.add_trigger.qs_id.value;
        destination = "add-trigger?rule_id=@rule_id@&selected_qs="+qs;
        if (destination) location.href = destination;
      
}
</script>

<formtemplate id="add_trigger"></formtemplate>