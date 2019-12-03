import $ from "jquery";
import jQuery from "jquery";
import { cocoonInitializer } from "cocoon/app/assets/javascripts/cocoon";

// to initialize cocoon for nested forms (notes and quotes)
cocoonInitializer($, jQuery);

// to catch events from cocoon ...
$(document).on("cocoon:after-insert", () => {
  // ...
});
