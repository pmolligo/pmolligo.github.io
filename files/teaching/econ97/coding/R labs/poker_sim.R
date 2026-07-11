rm(list = ls())
setwd("~/ucla/2025-2026/Spring/Econ97/R labs")
library(dplyr)

#-------------------------------------------------------------------------------
# User Input 
#-------------------------------------------------------------------------------
set.seed(12345)
hand_size <- 5
num_hands <- 100000
#-------------------------------------------------------------------------------
# 52 card deck, draw number of cards, no replacement
# character = string = text

#-------------------------------------------------------------------------------
# Helper Functions 
#-------------------------------------------------------------------------------

# Function to draw a hand of cards
draw_hand <- function(n_cards = 5) {
  
  # Inputs: 
  #   n_cards - number of cards to draw per hand
  # Output:
  #   A character vector of 5 cards
  
  suits       <- c("Clubs", "Diamonds", "Hearts", "Spades")
  face_values <- 2:14
  deck        <- c(outer(face_values, suits, paste))
  
  hand <- sample(deck, n_cards)
  
  # Split the suits from the face values
  
  # Face values
  hand_values <- sort(as.integer(lapply(strsplit(hand, split = " "), `[`, 1)))
  
  # Suits
  hand_suits <- as.character(lapply(strsplit(hand, split = " "), `[`, 2)) 
  
  flush_check    <- length(unique(hand_suits)) == 1
  straight_check <- all(diff(hand_values) == 1L) | identical(diff(hand_values), as.integer(c(2,3,4,5,14)))

  pair_freq <- sort(as.integer(table(hand_values)))
  
  hand_rank <- case_when(
    flush_check & straight_check & max(hand_values) == 14L ~ "Royal Flush",
    flush_check & straight_check & max(hand_values) != 14L ~ "Straight Flush",
    identical(pair_freq, c(1L, 4L))                        ~ "Four of a Kind",
    identical(pair_freq, c(2L, 3L))                        ~ "Full House",
    flush_check & !straight_check                          ~ "Flush",
    !flush_check & straight_check                          ~ "Straight",
    identical(pair_freq, c(1L, 1L, 3L))                    ~ "Three of a Kind",
    identical(pair_freq, c(1L, 2L, 2L))                    ~ "Two Pair",
    identical(pair_freq, c(1L, 1L, 1L, 2L))                ~ "Pair",
    identical(pair_freq, c(1L, 1L, 1L, 1L, 1L))            ~ "High Card",
  )
  
  return(c(hand, hand_rank))
}


#-------------------------------------------------------------------------------
# Simulations
#-------------------------------------------------------------------------------
hand_sims <- data.frame(card = t(replicate(num_hands, draw_hand(hand_size))))
names(hand_sims)[ncol(hand_sims)] <- "rank"

hand_probs <- data.frame(table(hand_sims$rank)/nrow(hand_sims)*100) |> 
  rename(rank = Var1, simulated = Freq) |> 
  mutate(rank = as.character(rank),
         simulated = paste0(simulated, "%"))

# Compare simulated and actual probabilities
actual_probs <- data.frame(rank = c("Royal Flush", "Straight Flush", "Four of a Kind",
                                    "Full House", "Flush", "Straight", "Three of a Kind",
                                    "Two Pair", "Pair", "High Card"),
                           actual = c("0.000154%", "0.00139%", "0.0240%", "0.1441%",  
                                      "0.1965%", "0.3925%", "2.1128%", "4.7539%",  
                                      "42.2569%", "50.1177%" ))


hand_probs <- left_join(hand_probs, actual_probs, by = "rank") |> 
  arrange(simulated)

