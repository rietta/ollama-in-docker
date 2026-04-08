#!/usr/bin/env pry

require "./core/ai_base.rb"


puts "Have Fun: You have an object called ai, which is a class that can be used to interact with Ollama."

ai = AiBase.new()


ai.chat("Hello, World. Please hold for a call from the programmer.")


binding.pry

