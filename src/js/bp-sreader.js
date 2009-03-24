(function() {
    
    BrowserPlus.init(function(res) {  
        if (res.success) {
            BrowserPlus.require({
                services: [
                    {
                        service: "ScreenReader",
                        version: "0",
                        minversion: "0.0.1"
                    }
                ]
            }, function(r) {
                if (r.success) {
                    BrowserPlus.ScreenReader.detect({
                        callback: function(r) {
                            var res = document.getElementById('results');
                            res.innerHTML = 'Active: ' + r.active + '<br>';
                            if (r.active) {
                                res.innerHTML += 'Name: ' + r.name + '<br>Version: ' + r.version;
                            }
                        }
                        }, function(x) {
                    });
                } else {
                    alert('BP-ScreenReader failed to load..');
                }
            });
        } else {
            alert('Browser Plus failed to load...');
        }
    });

    
})();
