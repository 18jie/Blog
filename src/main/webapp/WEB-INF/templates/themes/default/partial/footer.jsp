<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<footer id="footer" class="footer bg-white">
    <div class="footer-social">
        <div class="footer-container clearfix">
            <c:import url="/WEB-INF/templates/themes/default/partial/social.jsp"></c:import>
        </div>
    </div>
    <div class="footer-meta">
        <div class="footer-container">
            <div class="meta-item meta-copyright">
                <div class="meta-copyright-info">
                    <a href="/Blog" class="info-logo">
                        <img src="/Blog/resources/static/templates/img/logo.png" alt="${options.writer}">
                    </a>
                    <div class="info-text">
                        <p>学的不仅是技术，更是梦想。</p>
                        <!-- 改成自己的地址 -->
                        <p>Powered by <a href="https://github.com/18jie/Blog" target="_blank" rel="nofollow">FengJie</a>
                        </p>
                        <p>&copy; 2017 <a href="https://github.com/18jie">18jie</a></p>
                    </div>
                </div>
            </div>

            <div class="meta-item meta-posts">
                <h3 class="meta-title">最新文章</h3>
                <!-- 这里还是要做单独的查询 -->
                <c:forEach items="${recendArticles}" var="article" begin="0" end="7" step="1">
                	<li>
                    	<a href="/Blog/article/${article.cid}">${article.title}</a>
                	</li>
                </c:forEach>
            </div>

            <div class="meta-item meta-comments">
                <h3 class="meta-title">最新评论</h3>
                <c:forEach items="${recentComments}" var="comm">
                	<li>
                    <a href="/Blog/article/${comm.cid}#comment-${comm.coid}">${comm.author}：${comm.content}</a>
                </li>
                </c:forEach>
            </div>
        </div>
    </div>
</footer>
<!-- 在进入具体的文章内容中，打开下面的js -->
<c:if test="${isPost}">
<div id="directory-content" class="directory-content">
    <div id="directory"></div>
</div>
<script>
    $('#directory').html('');
    var postDirectoryBuild = function() {
        var postChildren = function children(childNodes, reg) {
                var result = [],
                    isReg = typeof reg === 'object',
                    isStr = typeof reg === 'string',
                    node, i, len;
                for (i = 0, len = childNodes.length; i < len; i++) {
                    node = childNodes[i];
                    if ((node.nodeType === 1 || node.nodeType === 9) &&
                        (!reg ||
                        isReg && reg.test(node.tagName.toLowerCase()) ||
                        isStr && node.tagName.toLowerCase() === reg)) {
                        result.push(node);
                    }
                }
                return result;
            },
            createPostDirectory = function(article, directory, isDirNum) {
                var contentArr = [],
                    titleId = [],
                    levelArr, root, level,
                    currentList, list, li, link, i, len;
                levelArr = (function(article, contentArr, titleId) {
                    var titleElem = postChildren(article.childNodes, /^h\d$/),
                        levelArr = [],
                        lastNum = 1,
                        lastRevNum = 1,
                        count = 0,
                        guid = 1,
                        id = 'directory' + (Math.random() + '').replace(/\D/, ''),
                        lastRevNum, num, elem;
                    while (titleElem.length) {
                        elem = titleElem.shift();
                        contentArr.push(elem.innerHTML);
                        num = +elem.tagName.match(/\d/)[0];
                        if (num > lastNum) {
                            levelArr.push(1);
                            lastRevNum += 1;
                        } else if (num === lastRevNum ||
                            num > lastRevNum && num <= lastNum) {
                            levelArr.push(0);
                            lastRevNum = lastRevNum;
                        } else if (num < lastRevNum) {
                            levelArr.push(num - lastRevNum);
                            lastRevNum = num;
                        }
                        count += levelArr[levelArr.length - 1];
                        lastNum = num;
                        elem.id = elem.id || (id + guid++);
                        titleId.push(elem.id);
                    }
                    if (count !== 0 && levelArr[0] === 1) levelArr[0] = 0;

                    return levelArr;
                })(article, contentArr, titleId);
                currentList = root = document.createElement('ul');
                dirNum = [0];
                for (i = 0, len = levelArr.length; i < len; i++) {
                    level = levelArr[i];
                    if (level === 1) {
                        list = document.createElement('ul');
                        if (!currentList.lastElementChild) {
                            currentList.appendChild(document.createElement('li'));
                        }
                        currentList.lastElementChild.appendChild(list);
                        currentList = list;
                        dirNum.push(0);
                    } else if (level < 0) {
                        level *= 2;
                        while (level++) {
                            if (level % 2) dirNum.pop();
                            currentList = currentList.parentNode;
                        }
                    }
                    dirNum[dirNum.length - 1]++;
                    li = document.createElement('li');
                    link = document.createElement('a');
                    link.href = '#' + titleId[i];
                    link.innerHTML = !isDirNum ? contentArr[i] :
                        dirNum.join('.') + ' ' + contentArr[i] ;
                    li.appendChild(link);
                    currentList.appendChild(li);
                }
                directory.appendChild(root);
            };
        createPostDirectory(document.getElementById('post-content'),document.getElementById('directory'), true);
    };
    postDirectoryBuild();
</script>
</c:if>
<script src="/Blog/resources/static/templates/js/headroom.min.js"></script>
<script src="//cdn.bootcss.com/highlight.js/9.12.0/highlight.min.js"></script>
<script src="/Blog/resources/static/templates/js/instantclick.min.js"></script>
<script type="text/javascript">
    <c:if test="${isPost}">
        var postDirectory = new Headroom(document.getElementById("directory-content"), {
            tolerance: 0,
            offset : 100,
            classes: {
                initial: "initial",
                pinned: "pinned",
                unpinned: "unpinned"
            }
        });
    </c:if>
    var header = new Headroom(document.getElementById("header"), {
        tolerance: 10,
        offset : 80,
        classes: {
            initial: "animated",
            pinned: "slideDown",
            unpinned: "slideUp"
        }
    });
    header.init();
    $('#search-inp').keypress(function (e) {
        var key = e.which; //e.which是按键的值
        if (key == 13) {
            var q = $(this).val();
            if (q && q != '') {
                window.location.href = '/Blog/search/' + q;
            }
        }
    });
</script>
<script data-no-instant>
    InstantClick.on('change', function (isInitialLoad) {
        var blocks = document.querySelectorAll('pre code');
        for (var i = 0; i < blocks.length; i++) {
            hljs.highlightBlock(blocks[i]);
        }
        if (isInitialLoad === false) {
            if (typeof ga !== 'undefined') ga('send', 'pageview', location.pathname + location.search);
        }
    });
    InstantClick.init('mousedown');
</script>
</body>
</html>