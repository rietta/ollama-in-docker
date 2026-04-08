require 'openai'
require 'json'

class AiBase
  attr_accessor :source_text, :response_text, 
  def initialize(ai_model: nil, source_text: nil)
      ai_server = ENV.fetch('OLLAMA_BASE_URL', "http://localhost:11434")

      @client = OpenAI::Client.new(uri_base: ai_server)

      # Use the preferred AI model, or default to llama3.1 if none specified
      @ai_model = ai_model || "llama3.1:8b"
      @response = nil
      @response_text = nil
      @source_text = source_text || ""
  end

  def chat(message_text, temperature = 0.7)
      @response = @client.chat(
          parameters: {
              model: @ai_model, # Required.
              messages: [{ role: "user", content: message_text}], # Required.
              temperature: temperature,
          }
      )
      if !@response.nil?
        @response_text = @response.dig("choices", 0, "message", "content")
      else
        @response_text = nil
      end
  end

  def submit
      chat("#{prompt}\n\n---\n\n#{source_text}")
      post_process_result
  end

  def post_process_result
    # An intentional no-op
    # Override if you need specific regex based corrections after processing
  end

  def prompt
    raise("Must be implemented by a subclass.")
  end

  def response_json
    t = @response_text
    t[0,7]="" if t[0,7]=="```json"
    t[0,3]="" if t[0,3]=="```"
    t.chomp!('```')
    JSON.parse(t)
  end

end