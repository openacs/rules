ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

} {
object_id:notnull
request_id:multiple
type_id     
} 

    set request_count [llength $request_id]
    for { set i 0} { $i < $request_count } { incr i } {
	db_transaction {
            set r_id [lindex $request_id $i]
	    db_dml remove_notify { *SQL* }
	}
     }

    ad_returnredirect "request-notification?object_id=$object_id&type_id=$type_id&return_url=one-rule?rule_id=$object_id"
