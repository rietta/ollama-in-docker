#!/usr/bin/env pry

require "./core/ai_base.rb"


puts "Have Fun: You have an object called ai, which is a class that can be used to interact with Ollama."

@ai = AiBase.new()

def chat(message, temperature = 0.7)
    @ai.chat(message, temperature)
    puts @ai.response_text
end

chat("Hello, World. Please hold for a call from the programmer.")

binding.pry

