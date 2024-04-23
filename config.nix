{
  config = {

    children = [
      {
        a = {
          attributes = {
            download.enable = true;
            download.filename = "some-filename";

            href.enable = true;
            href.url = "#middle";
          };
          children = [ ];
        };
      }
      {
        a = {
          attributes = {
            download.enable = true;
            download.filename = "old-filename";

            href.enable = true;
            href.url = "#bottom";
          };
          children = [ ];
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
