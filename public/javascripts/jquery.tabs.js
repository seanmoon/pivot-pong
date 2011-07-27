(function($) {
  $.fn.tabs = function() {
    var $this = $(this);
    var tabs = [];
    $this.data("currentTab", $("<p></p>"));

    var switchToTab = function(elem) {
      console.log(elem);
      $elem = $(elem);
      current = $this.data("currentTab");
      $(current).hide();
      $("a[href='" + current + "']").removeClass("current");
      $elem.show();
      $("a[href='" + elem + "']").addClass("current");
      $this.data("currentTab", elem);
    }

    $this.children().each(function() {
      var link = $(this).find("a").first();
      var id = link.attr("href");
      tabs.push(id);
      $(id).hide();
      link.click(function(e) {
        e.preventDefault();
        switchToTab(id);
      });
    });

    switchToTab(tabs[0]);

    return this;
  }
})(jQuery);
