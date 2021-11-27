defmodule Melo.MainTest do
  use Melo.DataCase

  alias Melo.Main
  import Melo.MainFixtures

  describe "main" do
    @valid_image_attrs %{ahash: "asdfasdfasdf", ext: ".jpg", url: "https://example.com/"}
    @valid_tag_attrs %{slug: "tag", tag: "Tag"}
    
    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_image_attrs)
        |> Main.create_image()
      image
    end

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_tag_attrs)
        |> Main.create_tag()
      tag
    end

    test "newest_iamges/1 returns an image" do
      image = image_fixture()
      assert Main.newest_images() == [image]
    end

    test "count_images/0 returns accurate count" do
      # none in there yet
      assert Main.count_images() == 0
      # add one
      _image = image_fixture()
      assert Main.count_images() == 1
      # add some more and make sure the count changes
      _i2 = image_fixture()
      _i3 = image_fixture()
      assert Main.count_images() == 3      
    end

    test "get_image!/1 returns a known image" do
      image = image_fixture()
      r = Main.get_image!(image.id)
      assert r.id == image.id
      assert r.ahash == image.ahash
      assert r.ext == image.ext
    end

    test "get_random_image!/0 returns an image" do
      image = image_fixture()
      r = Main.get_random_image!()
      assert r.id == image.id
    end

    test "all_tags/0 returns tags" do
      tag = tag_fixture()
      assert Main.all_tags() == [tag]
    end

    test "get_tag!/1 returns a tag" do
      tag = tag_fixture()
      r = Main.get_tag!(tag.slug)
      assert r.slug == tag.slug
      assert r.tag == tag.tag
    end
  end
end
