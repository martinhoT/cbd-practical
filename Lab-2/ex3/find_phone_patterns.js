function find_phone_patterns() {
    var capicuas = [];
    
    var cursor = db.phones.find({}, {number: "$components.number"});

    cursor.forEach(doc => {
        let phone = doc.number.toString();
        print(phone)
        if (capicua(phone))
            capicuas.push(phone);
    })

    return capicuas;
}

function capicua(str) {
    for (var i = 0; i < Math.floor(str.length/2); i++) {
        if (str.charAt(i) != str.charAt(str.length-1-i))
            return false;
    }
    return true;
}