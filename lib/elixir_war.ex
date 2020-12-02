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

    def build_deck do
      scores = score()
      ranks = ranks()
      suits = suits()

      Enum.map(ranks, fn rank ->
        index = Enum.find_index(ranks, fn value -> value == rank end)
        {_, card_score} = Enum.fetch(scores, index)
        score_with_rank = %{score: card_score, rank: rank}
        Enum.map(suits, fn suit ->
          card(score_with_rank, suit)
        end)
      end)
      |> List.flatten()
      |> Enum.shuffle()
    end

    def card(%{score: score, rank: rank}, suit) do
      %{rank: rank, score: score, suit: suit, description: "#{rank} of #{suit}"}
    end
  end

end
