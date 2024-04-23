{
  config = {
    attributes = {
      class.enable = true;
      class.classnames = [
        "intro"
        "important"
      ];

      contenteditable.enable = true;
      contenteditable.value = true;
    };

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
        div = {
          attributes = {
            style.enable = true;
            style.definitions = "color:blue;text-align:center;";
          };
          children = [
            {
              a = {
                attributes = {
                  download.enable = true;
                  download.filename = "new-filename";

                  href.enable = true;
                  href.url = "#top";
                };
                children = [ ];
              };
            }
          ];
        };
      }
    ];
  };
}
