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

set shaded_p $config(shaded_p)
set list_of_package_ids $config(package_id)
set one_instance_p [ad_decode [llength $list_of_package_ids] 1 1 0]

# get the parameter from forums-portlet to set the new-graphic correspondingly
set package_id [apm_package_id_from_key [forums_portlet::my_package_key]]
set default_new_period [parameter::get -package_id $package_id -parameter DefaultPeriodNewGraphic -default 2]

set query select_forums

if { [acs_privacy::privacy_control_enabled_p] } {
    set private_data_restriction [db_map dbqd.forums-portlet.www.forums-portlet.restrict_by_private_data_priv]
} else {
    set private_data_restriction ""
}

set user_id [ad_conn user_id]

template::list::create -name forums -multirow forums -key forum_id -pass_properties {
} -elements {
    item {
        label ""
        display_template {
        <b>@forums.parent_name@</b><br/>
          <group column="package_id">
              <if @forums.new_p@ eq t>
	        &raquo; <a href="@forums.url@forum-view?forum_id=@forums.forum_id@">@forums.name@</a>
                <span class="new_flag">
                  #forums-portlet.resources_acs-subsite_new_gif#<br/>
                </span>
              </if>
              <else>
	        &raquo; <a href="@forums.url@forum-view?forum_id=@forums.forum_id@">@forums.name@</a><br/>
	      </else>
          </group>
        }
    }
}

db_multirow forums $query {}
