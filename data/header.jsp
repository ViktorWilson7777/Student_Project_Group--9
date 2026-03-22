<c:if test="${sessionScope.account != null}">
    Welcome ${sessionScope.account.name} |
    Role: ${sessionScope.account.role} |
    
    <a href="app-user-edit?id=${sessionScope.account.userId}">
        Edit My Profile
    </a> |
    
    <a href="logout">Logout</a>

    <hr>
</c:if>