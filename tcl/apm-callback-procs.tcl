ad_library {

    Procedures to do a new impl and aliases in the acs-sc.
    @creation date 2004-11-24
    @author Anny Flores (annyflores@viaro.net)
}

namespace eval rules::apm_callback {}

ad_proc -private rules::apm_callback::package_install { 
} {
    Does the integration whith the notifications package. 
} {
    db_transaction {

	# Create the impl and aliases for one rule action
	set impl_id [create_rule_impl]

	# Create the notification type for one specific action
	set type_id [create_rule_type $impl_id]

	# Enable the delivery intervals and delivery methods for a specific RULE
	enable_intervals_and_methods $type_id

    }
}

ad_proc -private rules::apm_callback::package_uninstall {
} {
    Remove the integration whith the notification package
} {

    db_transaction {

        # Delete the type_id for a specific RULE
        notification::type::delete -short_name rule_notif

        # Delete the implementation for the notification of one specific RULE
        delete_rule_impl

    }
}

ad_proc -public rules::apm_callback::delete_rule_impl {} {
    Unregister the NotificationType implementation for rule_notif_type.
} {
    acs_sc::impl::delete \
        -contract_name "NotificationType" \
        -impl_name rule_notif_type
}
ad_proc -public rules::apm_callback::create_rule_impl {} {
    Register the service contract implementation and return the impl_id
    @return impl_id of the created implementation 
} {
         return [acs_sc::impl::new_from_spec -spec {
	    name rule_notif_type
	    contract_name NotificationType
	    owner rule
	    aliases {
		GetURL rules::notification::get_url
		ProcessReply rules::notification::process_reply
	    }
	 }]
}

ad_proc -public rules::apm_callback::create_rule_type {impl_id} {
    Create the notification type for one specific RULE
    @return the type_id of the created type
} {
    return [notification::type::new \
		-sc_impl_id $impl_id \
		-short_name rule_notif \
		-pretty_name "One RULE" \
		-description "Notification of execution  of one specific action in the rule"]
}

ad_proc -public rules::apm_callback::enable_intervals_and_methods {type_id} {
    Enable the intervals and delivery methods of a specific type
} {
    # Enable the various intervals and delivery method

    notification::type::interval_enable \
	-type_id $type_id \
	-interval_id [notification::interval::get_id_from_name -name hourly]

    notification::type::interval_enable \
	-type_id $type_id \
	-interval_id [notification::interval::get_id_from_name -name daily]

    notification::type::interval_enable \
	-type_id $type_id \
	-interval_id [notification::interval::get_id_from_name -name instant]
    # Enable the delivery methods
    notification::type::delivery_method_enable \
	-type_id $type_id \
	-delivery_method_id [notification::delivery::get_id -short_name email]
}


