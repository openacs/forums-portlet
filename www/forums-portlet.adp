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

    <if @one_instance_p@ false>
      <table border="0" bgcolor="white" cellpadding="2" cellspacing="0" width="100%">
        <tr class="table-header">
          <td><strong class="table-header">#forums.Forums#</strong></td>
          <td><strong class="table-header">#dotlrn.clubs_pretty_name#</strong></td>
        </tr>
    </if>

<multiple name="forums">

<% set new_package_id $forums(package_id) %>

  <if @one_instance_p@ false and @new_package_id@ ne @old_package_id@ and @old_package_id@ ne "">
    <tr>
  </if>

    <if @one_instance_p@>
		 <a href="@forums.url@forum-view?forum_id=@forums.forum_id@">@forums.name@</a>
    </if>
    <else>
      <if @forums.rownum@ odd>
        <tr class="odd">
      </if>
      <else>
        <tr class="even">
      </else>
        <td><a href="@forums.url@forum-view?forum_id=@forums.forum_id@">@forums.name@</a>
            <if @forums.new_p@ eq t><span class="new_flag"><img src="/resources/acs-subsite/new.gif" align="absmiddle" border="0" alt="#forums-portlet.New#" align="baseline"></span></if>
         </td>
        <td>@forums.parent_name@</td>
      </tr>
    </else>

<% set old_package_id $new_package_id %>

<if @one_instance_p@ false and @new_package_id@ ne @old_package_id@>
   </tr>
</if>

</multiple>

<if @one_instance_p@ false>
   </table>
</if>
    
  </if>
  <else>
    <small>#forums-portlet.No_Forums#</small>
  </else>

</if>
<else>
  &nbsp;
</else>
</if>

