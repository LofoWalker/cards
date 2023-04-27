defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck make 52 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 52
  end

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck()
    assert deck != Cards.shuffle(deck)
  end

  test "create a hand of 5 cards and return the rest of deck" do
    {hand, rest_of_deck} = Cards.create_hand(5)
    deck = Cards.create_deck()
    assert length(hand) == 5
    assert length(rest_of_deck) == length(Cards.create_deck) - 5
    for card <- hand do
      assert Cards.contains?(deck, card)
      assert !Cards.contains?(rest_of_deck, card)
    end
  end

  test "should create a file" do
    deck = Cards.create_deck()
    filename = "myFile"
    :ok = Cards.save(deck, filename)
    assert File.read!(filename) == :erlang.term_to_binary(deck)
  end

  test "should read a file" do
    deck = Cards.create_deck()
    filename = "myFile"
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
    assert Cards.load(filename) == deck
  end

  test "chargement d'un fichier inexistant" do
    filename = "deck.bin"
    assert Cards.load(filename) == "That file does not exist"
  end
end
