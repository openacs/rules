<master>
<link rel="stylesheet" type="text/css"href="/resources/acs-templating/lists.css" media="all">
<center>
Are you sure you want to delete the following items? 
<br>
<br>
<br>
@rules_table;noquote@
<br>
<br>
<br>
<form name=delete_rule action=delete-rule-2>
<input type=hidden name=rule_id value="@rules@">
<input type=submit value=Ok></input>
<input type=button value=Cancel></input>
</form>
</center>
