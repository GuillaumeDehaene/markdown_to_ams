local block_pattern = "&"
local newline_pattern = "\\\\"

-- Transform markdown math to ams environments
function math_to_ams(el)
  -- ignore InlineMath
  if el.mathtype == 'InlineMath' then
    return el

  -- edit only DisplayMath
  else
    -- by default, output as equation
    env = "equation"

    -- if the content starts with an environment name, use it
    -- regex parses as
    -- - string start
    -- - any number of spaces. NB: '% ' matches only space
    -- - opening bracket
    -- - any number of spaces
    -- - a sequence of non-space characters: captured
    -- - any number of spaces
    -- - closing bracket
    class_pattern = '^% *%{% *(%S+)% *%}'
    content = el.text
    match = string.match(content, class_pattern)
    if match then
      env = match
      content = string.gsub(content, class_pattern, "", 1)
    
    -- else, guess the appropriate type
    else
      
      has_blocks = string.find(content, block_pattern)
      has_lines = string.find(content, newline_pattern)
      if has_blocks then
        env = "align"
      else if has_lines then
          env = "gather"
        end
      end
      latex_block_pattern = "&"
      latex_newline_pattern = "\\\\"
      -- if using non-standard patterns, replace
      if latex_block_pattern ~= block_pattern then
        content = string.gsub(content, block_pattern, latex_block_pattern)
      end
      if latex_newline_pattern ~= newline_pattern then
        content = string.gsub(content, newline_pattern, latex_newline_pattern)
      end
    end

    new_text = string.format("\\begin{%s} %s \\end{%s}", env, content, env)
    new_el = pandoc.RawInline("tex", new_text)
    return new_el
  end
end

return {
  { Math = math_to_ams }
}