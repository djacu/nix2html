{
  config = {

    children = [
      {
        type = "a";
        children = [ ];
        attributes = {
          download.enable = true;
          download.filename = "some-filename";

          href.enable = true;
          href.url = "#middle";
        };
      }
      {
        type = "a";
        children = [ ];
        attributes = {
          download.enable = true;
          download.filename = "old-filename";

          href.enable = true;
          href.url = "#bottom";
        };
      }
    ];

    attributes = {
      download.enable = true;
      download.filename = "new-filename";

      href.enable = true;
      href.url = "#top";
    };
  };
}
