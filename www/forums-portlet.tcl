#
#  Copyright (C) 2001, 2002 MIT
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

array set config $cf	

set list_of_package_ids $config(package_id)
set one_instance_p [expr {[llength $list_of_package_ids] == 1}]

# get the parameter from forums-portlet to set the new-graphic correspondingly
set package_id [apm_package_id_from_key [forums_portlet::my_package_key]]
set default_new_period [parameter::get -package_id $package_id -parameter DefaultPeriodNewGraphic -default 2]

if { [acs_privacy::privacy_control_enabled_p] } {
    set private_data_restriction [db_map dbqd.forums-portlet.www.forums-portlet.restrict_by_private_data_priv]
} else {
    set private_data_restriction ""
}

set user_id [ad_conn user_id]

set useReadingInfo [forum::use_ReadingInfo_p]
if { $useReadingInfo } {
    set unread_or_new_query {
        approved_thread_count-coalesce((SELECT forums_reading_info_user.threads_read from forums_reading_info_user  WHERE
                forums_reading_info_user.forum_id=forums_forums.forum_id AND forums_reading_info_user.user_id=:user_id),0)
		as count_unread
    }
} else {
    set unread_or_new_query {
        case when last_post > (cast(current_timestamp as date)- 1) then 't' else 'f' end as new_p
    }
}

if {[llength $list_of_package_ids] > 0} {
    db_multirow -extend { url } forums select_forums [subst {
        select
            apm_packages.instance_name as parent_name,
            forums_forums.package_id,
            forums_forums.forum_id,
            forums_forums.name,
            $unread_or_new_query
        from
            forums_forums_enabled forums_forums
            INNER JOIN acs_objects ON (acs_objects.object_id=forums_forums.package_id)
            INNER JOIN apm_packages ON (apm_packages.package_id=acs_objects.context_id)
        where
            forums_forums.package_id IN ([join $list_of_package_ids ,])
            $private_data_restriction
        order by
            parent_name,
            package_id,
            forums_forums.name
    }] {
        set url [lindex [site_node::get_url_from_object_id -object_id $package_id] 0]
    }
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
