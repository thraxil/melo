defmodule Melo.MainFixtures do
  alias Melo.Repo

  def insert_image(attrs \\ %{}) do
    changes =
      Dict.merge(
        %{
          ahash: "asdfasdfasd",
          ext: ".jpg",
          url: "https://example.com"
        },
        attrs
      )

    %Melo.Main.Image{}
    |> Melo.Main.Image.changeset(changes)
    |> Repo.insert!()
  end
end
