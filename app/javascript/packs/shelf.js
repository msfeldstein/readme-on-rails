import $ from "jquery";
import jQuery from "jquery";
import { cocoonInitializer } from "cocoon/app/assets/javascripts/cocoon";
console.log("INIT");
// to initialize cocoon ...
cocoonInitializer($, jQuery);

// to catch events from cocoon ...
$(document).on("cocoon:after-insert", () => {
  // ...
});
