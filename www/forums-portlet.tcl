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

array set config $cf	

set shaded_p $config(shaded_p)
set list_of_package_ids $config(package_id)
set one_instance_p [ad_decode [llength $list_of_package_ids] 1 1 0]
set can_read_private_data_p [acs_privacy::user_can_read_private_data_p -object_id [ad_conn package_id]]

db_multirow forums select_forums "
    select forums_forums.package_id,
           acs_object.name(apm_package.parent_id(forums_forums.package_id)) as parent_name,
           (select site_node.url(site_nodes.node_id)
            from site_nodes
            where site_nodes.object_id = forums_forums.package_id) as url,
           forums_forums.forum_id,
           forums_forums.name
    from forums_forums_enabled forums_forums
    where forums_forums.package_id in ([join $list_of_package_ids ,])
    order by parent_name,
             forums_forums.name
"
