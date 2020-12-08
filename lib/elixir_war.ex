defmodule ElixirWar do
  @moduledoc """
  Documentation for `ElixirWar`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ElixirWar.hello()
      :world

  """
  def hello do
    :world
  end

  defmodule Game do
    @moduledoc """
    Documentation for `Game`.
    """

    @doc """
    Hello world.

    ## Examples

        iex> Game.hello()
        :world

    """
    @suits ["Hearts", "Spades", "Clubs", "Diamonds"]
    @ranks [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]
    @score [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    def hello do
      :world
    end

    def suits, do: @suits
    def ranks, do: @ranks
    def score, do: @score

    @spec build_deck() :: [map()]
    def build_deck do
      score = score()
      ranks = ranks()
      suits = suits()

      build_cards(ranks, suits, score)
      |> List.flatten()
      |> Enum.shuffle()
    end

    @spec card(map(), String.t()) :: map()
    def card(%{score: score, rank: rank}, suit) do
      %{rank: rank, score: score, suit: suit, description: "#{rank} of #{suit}"}
    end

    @spec build_cards(list(), list(), list()) :: [map()]
    def build_cards(ranks, suits, score) do
      Enum.map(ranks, fn rank ->
        index = Enum.find_index(ranks, fn value -> value == rank end)
        {_, card_score} = Enum.fetch(score, index)
        score_with_rank = %{score: card_score, rank: rank}

        Enum.map(suits, fn suit ->
          card(score_with_rank, suit)
        end)
      end)
    end

    @spec deal([map()]) :: {list(), list()}
    def deal(deck) do
      {player_one, player_two} = Enum.split(deck, floor(length(deck) / 2))
      [player_one, player_two]
    end


    @spec play_round([list()]) :: any()
    def play_round([player_one, player_two] = hands) do
      [{card_one, _hand_one}, {card_two, _hand_two}] = Enum.map(hands, fn hand ->
        List.pop_at(hand, 0)
      end)

      compare_cards(card_one, card_two)
    end

    def compare_cards(%{score: score_one}, %{score: score_two}) when score_one > score_two, do: "Player One"
    def compare_cards(%{score: score_one}, %{score: score_two}) when score_one < score_two, do: "Player Two"
    def compare_cards(_, _), do: "War!"


  end
end
