<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <partialquery name="restrict_by_private_data_priv">
        <querytext>
            and exists (
                select 1
                from acs_object_party_privilege_map ppm
                where ppm.object_id = forums_forums.package_id
                  and ppm.party_id = :user_id
                  and ppm.privilege = 'read_private_data'
            )
        </querytext>
    </partialquery>

</queryset>
