class MatchPoint
  POINT_CHART = {
    (0..12) => { expected: 8, upset: 8 },
    (13..37) => { expected: 7, upset: 10 },
    (38..62) => { expected: 6, upset: 13 },
    (63..87) => { expected: 5, upset: 16 },
    (88..112) => { expected: 4, upset: 20 },
    (113..137) => { expected: 3, upset: 25 },
    (138..162) => { expected: 2, upset: 30 },
    (163..187) => { expected: 2, upset: 35 },
    (188..212) => { expected: 1, upset: 40 },
    (213..237) => { expected: 1, upset: 45 },
    (238..1000000) => { expected: 0, upset: 50 }
  }

  class << self
    def rankings
      players_points = Hash.new(0)

      Match.find_each { |match|
        winner_points, loser_points = players_points.values_at match.winner_id, match.loser_id

        spread = (winner_points - loser_points).abs
        result = winner_points > loser_points ? :expected : :upset
        points_exchange = points_exchanged spread, result

        players_points[match.winner_id] += points_exchange
      }

      players_points.to_a.map { |player_id, points| [Player.find(player_id), points] }.sort_by { |_,pts| pts }.reverse
    end

    def points_exchanged spread, result
      @ratings ||= POINT_CHART.inject({}) { |acc, (k,v)|
        [*k].map { |i| acc[i] = v }
        acc
      }

      @ratings[spread][result]
    end
  end
end

