ad_library {
    Automated tests for the forums-portlet package.

    @author Héctor Romojaro <hector.romojaro@gmail.com>
    @creation-date 2020-08-19
    @cvs-id $Id$
}

aa_register_case -procs {
        forums_admin_portlet::link
        forums_portlet::link
        forums_admin_portlet::get_pretty_name
        forums_portlet::get_pretty_name
    } -cats {
        api
        production_safe
    } forums_portlet_links_names {
        Test diverse link and name procs.
} {
    aa_equals "Forums admin portlet link" "[forums_admin_portlet::link]" ""
    aa_equals "Forums portlet link"       "[forums_portlet::link]" ""
    aa_equals "Forums admin portlet pretty name" "[forums_admin_portlet::get_pretty_name]" "#forums-portlet.admin_pretty_name#"
    aa_equals "Forums portlet pretty name" "[forums_portlet::get_pretty_name]" "#forums-portlet.pretty_name#"
}

aa_register_case -procs {
    forums_portlet::get_my_name
    forums_portlet::add_self_to_page
    forums_portlet::remove_self_from_page
    forums_admin_portlet::get_my_name
    forums_admin_portlet::add_self_to_page
    forums_admin_portlet::remove_self_from_page
} -cats {
    api
} forums_portlet_add_remove_from_page {
    Test add/remove portlet procs.
} {
    #
    # Helper proc to check portal elements
    #
    proc portlet_exists_p {portal_id portlet_name} {
        return [db_0or1row portlet_in_portal {
            select 1 from dual where exists (
              select 1
                from portal_element_map pem,
                     portal_pages pp
               where pp.portal_id = :portal_id
                 and pp.page_id = pem.page_id
                 and pem.name = :portlet_name
            )
        }]
    }
    #
    # Start the tests
    #
    aa_run_with_teardown -rollback -test_code {
        #
        # Create a community.
        #
        # As this is running in a transaction, it should be cleaned up
        # automatically.
        #
        set community_id [dotlrn_community::new -community_type dotlrn_community -pretty_name foo]
        if {$community_id ne ""} {
            aa_log "Community created: $community_id"
            set portal_id [dotlrn_community::get_portal_id -community_id $community_id]
            set package_id [dotlrn::instantiate_and_mount $community_id [forums_portlet::my_package_key]]
            #
            # forums_portlet
            #
            set portlet_name [forums_portlet::get_my_name]
            #
            # Add portlet.
            #
            forums_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id -param_action "" -display_group_name_p true
            aa_true "Portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Remove portlet.
            #
            forums_portlet::remove_self_from_page $portal_id $package_id
            aa_false "Portlet is in community portal after removal" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Add portlet.
            #
            forums_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id -param_action ""  -display_group_name_p true
            aa_true "Portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"

            #
            # forums_admin_portlet
            #
            set portlet_name [forums_admin_portlet::get_my_name]
            aa_log "Exists? [portlet_exists_p $portal_id $portlet_name]"
            #
            # Add portlet.
            #
            forums_admin_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id
            aa_true "Portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Remove portlet.
            #
            forums_admin_portlet::remove_self_from_page -portal_id $portal_id
            aa_false "Portlet is in community portal after removal" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Add portlet.
            #
            forums_admin_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id
            aa_true "Portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
        } else {
            aa_error "Community creation failed"
        }
    }
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
