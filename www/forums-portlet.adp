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

<if @shaded_p@ false>
<if @forums:rowcount@>


<multiple name="forums">

<if @one_instance_p@ false>@forums.parent_name@</if>
  <ul>
<group column="package_id">
    <li>
      <a href="@forums.url@forum-view?forum_id=@forums.forum_id@">@forums.name@</a>
      <if @forums.new_p@ eq t><span class="new_flag"><img src="/resources/acs-subsite/new.gif" align="absmiddle" border="0" alt="#forums-portlet.New#" align="baseline"></span></if>
    </li>
</group>
  </ul>

</multiple>

  </if>
  <else>
    <small>#forums-portlet.No_Forums#</small>
  </else>
</if>
<else>
<br>
</else>
