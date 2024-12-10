function PromptInput(promptDescription)
  local input_text
  Snacks.input.input({ prompt = string.format("%s", promptDescription) }, function(input)
    input_text = input
  end)
  return input_text
end
