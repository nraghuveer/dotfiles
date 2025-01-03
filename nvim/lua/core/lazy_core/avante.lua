require("avante").setup({
  provider = "ollama",
  hvaints = {
    enabled = true,
  },
  vendors = {
    -- provider = "ollama"
    ---@type AvanteProvider
    ollama = {
      ["local"] = true,
      endpoint = "https://tgi.fw.teslamotors.com/llama3-instruct/v1",
      model = "llama3.3",
      parse_curl_args = function(opts, code_opts)
        return {
          url = opts.endpoint .. "/chat/completions",
          headers = {
            ["Accept"] = "application/json",
            ["Content-Type"] = "application/json",
          },
          body = {
            model = opts.model,
            messages = require("avante.providers").openai.parse_message(code_opts),
            temperature = 0,
            max_tokens = 8192,
            stream = true, -- this will be set by default.
          },
        }
      end,
      -- The below function is used if the vendors has specific SSE spec that is not claude or openai.
      parse_response_data = function(data_stream, event_state, opts)
        require("avante.providers").openai.parse_response(data_stream, event_state, opts)
      end,
    },
  },
})
