defmodule StrawHat.Map.AddressesTest do
  use StrawHat.Map.Test.DataCase, async: true
  alias StrawHat.Map.Addresses

  describe "find_address/1" do
    test "with valid id should returns the found address" do
      address = insert(:address)
      assert {:ok, _address} = Addresses.find_address(address.id)
    end

    test "with invalid id shouldn't return any address" do
      assert {:error, _reason} = Addresses.find_address(8745)
    end
  end

  test "get_addresses/1 returns a pagination of addresses" do
    insert_list(4, :address)
    address_page = Addresses.get_addresses(%{page: 2, page_size: 2})

    assert length(address_page.entries) == 2
  end

  test "create_address/1 with valid inputs creates an address" do
    params = params_with_assocs(:address)

    assert {:ok, _address} = Addresses.create_address(params)
  end

  test "update_address/2 with valid inputs updates the address" do
    address = insert(:address)
    {:ok, address} = Addresses.update_address(address, %{line_two: "PO BOX 123"})

    assert address.line_two == "PO BOX 123"
  end

  test "destroy_address/1 with a found address destroys the address" do
    address = insert(:address)

    assert {:ok, _} = Addresses.destroy_address(address)
  end

  test "get_addresses_by_ids/1 with a list of IDs returns the relative addresses" do
    available_addresses = insert_list(3, :address)

    ids =
      available_addresses
      |> Enum.take(2)
      |> Enum.map(fn address -> address.id end)

    addresses = Addresses.get_addresses_by_ids(ids)

    assert List.first(addresses).id == List.first(ids)
    assert List.last(addresses).id == List.last(ids)
  end
end
