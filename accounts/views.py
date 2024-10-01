from django.contrib.auth.decorators import login_required, user_passes_test
from django.http import HttpResponse

# не используется, но можно применить для проверки доступности определенных представлений (если бы они были)
# def is_admin(user):
#     return user.groups.filter(name='Admin').exists()
#
# @login_required
# @user_passes_test(is_admin)
# def admin_view(request):
#     return HttpResponse("Admin dashboard")
#
# @login_required
# def user_view(request):
#     return HttpResponse("User dashboard")
