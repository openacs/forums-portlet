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

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
