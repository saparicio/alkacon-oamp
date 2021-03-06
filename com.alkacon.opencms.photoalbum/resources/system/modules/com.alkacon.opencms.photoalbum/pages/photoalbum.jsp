<%@ page session="false" import="com.alkacon.opencms.photoalbum.CmsPhotoAlbumBean, org.opencms.workplace.*" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%
	CmsPhotoAlbumBean cms = new CmsPhotoAlbumBean(pageContext, request, response);
	pageContext.setAttribute("cms", cms);
%>

<cms:include property="template" element="head" />

<c:set var="locale" value="${cms:vfs(pageContext).context.locale}" />
<fmt:setLocale value="${locale}" />
<fmt:bundle basename="com.alkacon.opencms.photoalbum.frontend">

<cms:jquery dynamic='true' />
<cms:jquery js='jquery' dynamic='true' />
<cms:jquery js='jquery.pagination' dynamic='true' />
<cms:jquery js='thickbox' css='thickbox/thickbox' dynamic='true' />

<script type='text/javascript'>
	load_script('<cms:link>/system/modules/com.alkacon.opencms.photoalbum/resources/album.css</cms:link>', 'css');
</script>

<script type='text/javascript'>
     /**
      * Insert translated strings as inline javascript code          
      **/
     var tb_msg = {
       'close': '<fmt:message key="photoalbum.image.close" />',
       'next': '<fmt:message key="photoalbum.image.next" />',
       'prev': '<fmt:message key="photoalbum.image.prev" />',
       'imageCount': '<fmt:message key="photoalbum.image.count" />'
     };
</script>

<c:set var="currentPage"><c:out value="${param.page}" default="1"/></c:set>

<cms:contentload collector="singleFile" param="%(opencms.uri)">
	<cms:contentaccess var="album" />
	<c:set var="thumbs" value="${album.value['Thumbs']}" />
	<c:set var="imageCount" value="${fn:length(cms.readImages[album.value['VfsFolder'].stringValue])}" />

	<%-- Quality --%>
	<c:set var="quality" value="50" />
	<c:if test="${thumbs.value['HighQuality'] == 'true'}">
		<c:set var="quality" value="90" />
	</c:if>

	<script type="text/javascript">
		<%@include file="%(link.strong:/system/modules/com.alkacon.opencms.photoalbum/resources/album.js)" %>
	</script>

	<%-- Title --%>
	<c:if test="${!album.value['Title'].isEmptyOrWhitespaceOnly}">
		<h1><c:out value="${album.value['Title']}" /></h1>
	</c:if>

	<%-- Pagination above top text --%>
	<c:if test="${album.value['NavigationPosition'] == 't_a' && thumbs.value['ItemsPerPage'].stringValue > 0}">
		<div class="pagination_container" style="text-align: ${album.value['AlignNavigation']};">
			<div id="Pagination" class="album-pagination"></div>
		</div>
	</c:if>

	<%-- Top Text --%>
	<c:if test="${!thumbs.value['TextTop'].isEmptyOrWhitespaceOnly}">
		<div><c:out value="${thumbs.value['TextTop']}" escapeXml="false"/></div>
	</c:if>	

	<%-- Pagination below top text --%>
	<c:if test="${album.value['NavigationPosition'] == 't_b' && thumbs.value['ItemsPerPage'].stringValue > 0}">
		<div class="pagination_container" style="text-align: ${album.value['AlignNavigation']};">
			<div id="Pagination" class="album-pagination"></div>
		</div>
	</c:if>
		
	<div id="album_pages">
		<div id="album_page_1">
			<%-- Show the images in the given vfs path --%>
			<cms:include file="../elements/albumpage.jsp">
				<cms:param name="vfsFolder" value="${album.value['VfsFolder'].stringValue}" />
				<cms:param name="background" value="${thumbs.value['Background']}" />
				<cms:param name="size" value="${thumbs.value['Size']}" />
				<cms:param name="quality" value="${quality}" />
				<cms:param name="filter" value="${thumbs.value['Filter']}" />
				<cms:param name="alignTitle" value="${thumbs.value['AlignTitle']}" />
				<cms:param name="showTitle" value="${thumbs.value['ShowTitle']}" />
				<cms:param name="showResourceNameAsTitle" value="${album.value['ShowResourceNameAsTitle']}" />
				<cms:param name="page" value="1" />
				<cms:param name="itemsPerPage" value="${thumbs.value['ItemsPerPage']}" />
				<cms:param name="maxImageSize" value="${album.value['MaxImageSize']}" />
			</cms:include>
		</div>
	</div>

	<div class="album_clear"></div>

	<%-- Pagination above bottom text --%>
	<c:if test="${album.value['NavigationPosition'] == 'b_a' && thumbs.value['ItemsPerPage'].stringValue > 0}">
		<div class="pagination_container" style="text-align: ${album.value['AlignNavigation']};">
			<div id="Pagination" class="album-pagination"></div>
		</div>
	</c:if>

	<%-- Bottom Text --%>
	<c:if test="${!thumbs.value['TextBottom'].isEmptyOrWhitespaceOnly}">
		<div style="clear: left;"><c:out value="${thumbs.value['TextBottom']}" escapeXml="false"/></div>
	</c:if>
	
	<%-- Pagination below bottom text --%>
	<c:if test="${album.value['NavigationPosition'] == 'b_b' && thumbs.value['ItemsPerPage'].stringValue > 0}">
		<div class="pagination_container" style="text-align: ${album.value['AlignNavigation']};">
			<div id="Pagination" class="album-pagination"></div>
		</div>
	</c:if>
	
</cms:contentload>
</fmt:bundle>

<cms:include property="template" element="foot" />