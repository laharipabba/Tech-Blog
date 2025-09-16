function doLike(pid, uid) {
    $.ajax({
        url: "LikeServlet",
        method: "POST",
        data: { operation: "like", uid: uid, pid: pid },
        success: function(data) {
            if (data.trim() === 'true') {
                // Find the like button for this pid and update the counter inside it
                let counter = $("button[onclick='doLike(" + pid + "," + uid + ")']").find("span");
                counter.text(parseInt(counter.text()) + 1);
            }
        }
    });
}

function doDislike(pid, uid) {
    $.ajax({
        url: "LikeServlet",
        method: "POST",
        data: { operation: "dislike", uid: uid, pid: pid },
        success: function(data) {
            if (data.trim() === 'true') {
                // Find the like button for this pid and update the counter inside it
                let counter = $("button[onclick='doLike(" + pid + "," + uid + ")']").find("span");
                counter.text(parseInt(counter.text()) - 1);
            }
        }
    });
}
