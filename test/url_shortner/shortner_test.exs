defmodule UrlShortner.ShortnerTest do
  use UrlShortner.DataCase

  alias UrlShortner.Shortner

  describe "urls" do
    alias UrlShortner.Shortner.URL

    @valid_attrs %{long_url: "some long_url", short_url: "some short_url"}
    @update_attrs %{long_url: "some updated long_url", short_url: "some updated short_url"}
    @invalid_attrs %{long_url: nil, short_url: nil}

    def url_fixture(attrs \\ %{}) do
      {:ok, url} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shortner.create_url()

      url
    end

    test "list_urls/0 returns all urls" do
      url = url_fixture()
      assert Shortner.list_urls() == [url]
    end

    test "get_url!/1 returns the url with given id" do
      url = url_fixture()
      assert Shortner.get_url!(url.id) == url
    end

    test "create_url/1 with valid data creates a url" do
      assert {:ok, %URL{} = url} = Shortner.create_url(@valid_attrs)
      assert url.long_url == "some long_url"
      assert url.short_url == "some short_url"
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortner.create_url(@invalid_attrs)
    end

    test "update_url/2 with valid data updates the url" do
      url = url_fixture()
      assert {:ok, %URL{} = url} = Shortner.update_url(url, @update_attrs)
      assert url.long_url == "some updated long_url"
      assert url.short_url == "some updated short_url"
    end

    test "update_url/2 with invalid data returns error changeset" do
      url = url_fixture()
      assert {:error, %Ecto.Changeset{}} = Shortner.update_url(url, @invalid_attrs)
      assert url == Shortner.get_url!(url.id)
    end

    test "delete_url/1 deletes the url" do
      url = url_fixture()
      assert {:ok, %URL{}} = Shortner.delete_url(url)
      assert_raise Ecto.NoResultsError, fn -> Shortner.get_url!(url.id) end
    end

    test "change_url/1 returns a url changeset" do
      url = url_fixture()
      assert %Ecto.Changeset{} = Shortner.change_url(url)
    end
  end
end
