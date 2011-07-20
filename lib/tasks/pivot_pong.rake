namespace :pivotpong do
  desc "Calculate the rankings based on the current set of matches and save the results onto the individual players"
  task :save_rankings_to_player => :environment do
    SaveRankingsToPlayer.run
  end
end