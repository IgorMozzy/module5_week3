from django.contrib.auth.models import Group, Permission
from django.db import connection

def create_groups():
    with connection.cursor() as cursor:
        cursor.execute("SELECT to_regclass('auth_group')")
        if cursor.fetchone()[0]:
            admin_group, created = Group.objects.get_or_create(name='Admin')
            if created:
                permissions = Permission.objects.all()
                admin_group.permissions.set(permissions)

            user_group, created = Group.objects.get_or_create(name='User')

create_groups()
