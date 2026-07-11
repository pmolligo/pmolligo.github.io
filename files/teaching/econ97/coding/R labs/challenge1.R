rm(list = ls())
library(dplyr)

#-------------------------------------------------------------------------------
# User Input 
#------------------------------------------------------------------------------- 
set.seed(1408)
n_hands   <- 100000 # Number of simulated hands
#hand_size <- 5     # Number of cards per hand
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Helper Functions
#-------------------------------------------------------------------------------

# Function to draw from a standard 52-card deck 
draw_hand <- function(n_cards = 5) {
  
  #suits       <- c("C", "D", "H", "S")
  #face_values <- c(seq(2, 10), "J", "K", "Q", "A")
  
  suits       <- c("Club", "Diamond", "Heart", "Spade")
  face_values <- 2:14
  deck        <- c(outer(face_values, suits, paste))
  
  hand <- sample(deck, n_cards)
  
  hand_values <- as.integer(lapply(strsplit(hand, " "), `[`, 1)) |> sort() # "\\s+" is more robust 
  hand_suits  <- as.character(lapply(strsplit(hand, " "), `[`, 2)) |> sort()
  
  flush_check    <- length(unique(hand_suits)) == 1
  
  # all(diff(hand_values)==1)
  straight_check <- identical(diff(hand_values), rep(1L, length(hand_values)-1)) | identical(hand_values, as.integer(c(2,3,4,5,14)))
  
  pair_freq <- table(hand_values) |> as.integer() |> sort()
  
  # Royal Flush     (10, J, Q, K, A same suit)
  # Straight Flush  (5, 6, 7, 8, 9, 10 same suit)
  # Four of a Kind  (J, J, J, J, 3)
  # Full House      (10, 10, 10, Q, Q)
  # Flush           (All same suit)
  # Straight        (3, 4, 5, 6, 7 any suit)
  # Three of a Kind (4, 4, 4, 7, 8)
  # Two Pair        (2, 2, 10, 10, J)
  # One Pair        (3, 3, J, Q, K)
  # High Card       (A, 2, 5, 8, J)
  
  hand_rank <- case_when(
    flush_check & straight_check & max(hand_values) == 14L ~ "Royal Flush",
    flush_check & straight_check                           ~ "Straight Flush",
    identical(pair_freq, c(1L,4L))                         ~ "Four of a Kind",
    identical(pair_freq, c(2L,3L))                         ~ "Full House",
    flush_check & !straight_check                          ~ "Flush",
    !flush_check & straight_check                          ~ "Straight",
    identical(pair_freq, c(1L,1L,3L))                      ~ "Three of a Kind",
    identical(pair_freq, c(1L,2L,2L))                      ~ "Two Pair",
    identical(pair_freq, c(1L,1L,1L,2L))                   ~ "Pair",
    identical(pair_freq, c(1L,1L,1L,1L,1L))                 ~ "High Card"
  )
  
  return(c(hand, hand_rank))
}
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Run simulations
#-------------------------------------------------------------------------------

# Draw many hands
hand_sims <- data.frame(card = t(replicate(n_hands, draw_hand())))
names(hand_sims)[ncol(hand_sims)] <- "rank"

# Compute frequencies of hand ranks
hand_probs <- data.frame(prop.table(table(hand_sims$rank))*100) |> 
  rename(rank = Var1, simulated = Freq) |> 
  mutate(rank = as.character(rank),
         simulated = paste0(round(simulated, 5), "%"))

# Compare simulated and actual probabilities
actual_probs <- data.frame(rank = c("Royal Flush", "Straight Flush", "Four of a Kind",
                                    "Full House", "Flush", "Straight", "Three of a Kind",
                                    "Two Pair", "Pair", "High Card"),
                           actual = c("0.000154%", "0.00139%", "0.0240%", "0.1441%",  
                                      "0.1965%", "0.3925%", "2.1128%", "4.7539%",  
                                      "42.2569%", "50.1177%" ))


hand_probs <- left_join(hand_probs, actual_probs, by = "rank") |> 
  arrange(simulated)



# ranks_raw <- NULL
# suits_raw <- NULL
# 
# for(ii in 1:length(x)){
#   ranks_raww[ii] <- strsplit(x[ii], " ")[[1]][1]
#   suits_raww[ii] <- strsplit(x[ii], " ")[[1]][2]
# }