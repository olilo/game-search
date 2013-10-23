<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<body>
	<h1>${message}</h1>
    <form:form method="POST" modelAttribute="newGame">
        <form:label path="name">Name</form:label>
        <form:input path="name" />
        <br/>
        <form:label path="year">Jahr</form:label>
        <form:input path="year" />
        <br/>
        <form:label path="genre">Genre</form:label>
        <form:input path="genre" />
        <input type="submit" value="Neues Spiel"/>
    </form:form>

    <ul>
        <c:forEach items="${games}" var="game">
            <li>
                Game: ${game.name}<br />
                Jahr: ${game.year}<br />
                Genre: ${game.genre}
            </li>
        </c:forEach>
    </ul>
</body>
</html>