let writer, title, passwd, contents, writebtn, resetbtn;

function mInit() {
    writer =  document.getElementById("writer").value="";
    passwd =  document.getElementById("passwd").value="";
    title =  document.getElementById("title").value="";
    contents =  document.getElementById("contents").value="";
}

function line(obj) {
    writer =  document.getElementById("writer");
    title =  document.getElementById("title");
	passwd =  document.getElementById("passwd");
    contents = document.getElementById("contents");
    writebtn = document.getElementById("write");
    resetbtn = document.getElementById("reset");

    if(obj.id == "title") {
        writer.focus();
    }else if (obj.id == "writer") {
        contents.focus();
    }else if (obj.id == "contents") {
        writebtn.focus();
        alert("write 완료");
    }else if (obj.id == "write") {
        resetbtn.focus();
    }
}
