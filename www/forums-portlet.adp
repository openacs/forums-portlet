<%

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

%>

<if @can_read_private_data_p@>
<if @shaded_p@ false>

  <if @forums:rowcount@ gt 0>

<%
    set new_package_id ""
    set old_package_id ""
%>

<multiple name="forums">

<% set new_package_id $forums(package_id) %>

  <if @one_instance_p@ false and @new_package_id@ ne @old_package_id@ and @old_package_id@ ne "">
    </ul>
  </if>

  <if @one_instance_p@ false and @new_package_id@ ne @old_package_id@>
    @forums.parent_name@
    <ul>
  </if>

    <li>
      <a href="@forums.url@forum-view?forum_id=@forums.forum_id@">@forums.name@</a>
<if @forums.new_p@ eq t><img src="/doc/acs-datetime/pics/new.gif" align="absmiddle" border="0" alt="New!" align="baseline"></if>
    </li>

<%
    set old_package_id $new_package_id
%>

</multiple>

  </if>
  <else>
    <small>No Forums</small>
  </else>

</if>
<else>
  &nbsp;
</else>
</if>
