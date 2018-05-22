<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="restrict_by_private_data_priv">
      <querytext>
	    and acs_permission__permission_p(forums_forums.package_id, :user_id, 'read_private_data')
        </querytext>
    </partialquery>
    
</queryset>
