#
#  Copyright (C) 2001, 2002 OpenForce, Inc.
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

ad_page_contract {
    The display logic for the forums admin portlet
    
    @author Ben Adida (ben@openforce)
    @cvs_id $Id$
} -properties {
    
}

array set config $cf	

set list_of_package_ids $config(package_id)

if {[llength $list_of_package_ids] > 1} {
    # We have a problem!
    return -code error "There should be only one instance of forums for admin purposes"
}

set package_id [lindex $list_of_package_ids 0]

db_multirow forums select_forums {
    select forum_id, name
    from forums_forums 
    where package_id = :package_id
}

set url [dotlrn_community::get_url_from_package_id -package_id $package_id]

set package_id [ad_conn package_id]
set default_name [db_string select_package_name {
    select instance_name from apm_packages where package_id= :package_id
}]

append default_name " Forum"

set encoded_default_name [ns_urlencode $default_name]

ad_return_template
