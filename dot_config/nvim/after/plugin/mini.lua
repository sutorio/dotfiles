local starter = require("mini.starter")

local greeting = function()
  local hour = tonumber(vim.fn.strftime("%H"))
  -- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
  local part_id = math.floor((hour + 4) / 8) + 1
  local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
  local username = vim.loop.os_get_passwd()["username"] or "USERNAME"

  return ("Good %s, %s"):format(day_part, username)
end

local install_info = function()
  local datetime = os.date("%d-%m-%Y %H:%M:%S")
  local version = ("%s.%s.%s"):format(
    vim.version().major,
    vim.version().minor,
    vim.version().patch
  )

  return (" %s   %s"):format(version, datetime)
end

local get_strategy = function(strategies_list)
  -- selects an entry from fortune_list randomly
  math.randomseed(os.time())
  local ind = math.random(1, #strategies_list)
  return strategies_list[ind]
end

local format_strategy = function(text, target_width)
  local words = string.gmatch(text, "%S+")
  local paragraph_lines = {}

  local current_line_words = {}
  local current_line_length = 0

  for w in words do
    -- NOTE: the +1 is for spaces; this means each line will be 1 space longer than
    -- it actually is, but that's not an issue.
    local should_break = (current_line_length + string.len(w) + 1)
      > target_width

    if should_break then
      -- local horizontal_pad = string.rep(" ", target_width - current_line_length)
      -- table.insert(current_line_words, horizontal_pad)
      table.insert(paragraph_lines, table.concat(current_line_words, " "))
      current_line_words = {}
      current_line_length = string.len(w) + 1
      table.insert(current_line_words, w)
    else
      table.insert(current_line_words, w)
    end
  end
  table.insert(paragraph_lines, table.concat(current_line_words, " "))
  -- NOTE: pads to arbitrary value so always same height
  local formatted_strategy = table.concat(paragraph_lines, "\n")
  return formatted_strategy .. string.rep("\n", 4 - #paragraph_lines)
end

local oblique_strategies = function(max_width)
  max_width = max_width or 40

  local strategies_list = {
    "Abandon normal instruments",
    "Accept advice",
    "Accretion",
    "A line has two sides",
    "Allow an easement (an easement is the abandonment of a stricture)",
    "Are there sections? Consider transitions",
    "Ask people to work against their better judgement",
    "Ask your body",
    "Assemble some of the instruments in a group and treat the group",
    "Balance the consistency principle with the inconsistency principle",
    "Be dirty",
    "Breathe more deeply",
    "Bridges -build -burn",
    "Cascades",
    "Change instrument roles",
    "Change nothing and continue with immaculate consistency",
    "Children's voices -speaking -singing",
    "Cluster analysis",
    "Consider different fading systems",
    "Consult other sources -promising -unpromising",
    "Convert a melodic element into a rhythmic element",
    "Courage!",
    "Cut a vital connection",
    "Decorate, decorate",
    "Define an area as `safe' and use it as an anchor",
    "Destroy -nothing -the most important thing",
    "Discard an axiom",
    "Disconnect from desire",
    "Discover the recipes you are using and abandon them",
    "Distorting time",
    "Do nothing for as long as possible",
    "Don't be afraid of things because they're easy to do",
    "Don't be frightened of cliches",
    "Don't be frightened to display your talents",
    "Don't break the silence",
    "Don't stress one thing more than another",
    "Do something boring",
    "Do the washing up",
    "Do the words need changing?",
    "Do we need holes?",
    "Emphasize differences",
    "Emphasize repetitions",
    "Emphasize the flaws",
    "Faced with a choice, do both (given by Dieter Rot)",
    "Feedback recordings into an acoustic situation",
    "Fill every beat with something",
    "Get your neck massaged",
    "Ghost echoes",
    "Give the game away",
    "Give way to your worst impulse",
    "Go slowly all the way round the outside",
    "Honor thy error as a hidden intention",
    "How would you have done it?",
    "Humanize something free of error",
    "Imagine the music as a moving chain or caterpillar",
    "Imagine the music as a set of disconnected events",
    "Infinitesimal gradations",
    "Intentions -credibility of -nobility of -humility of",
    "Into  the impossible",
    "Is it finished?",
    "Is there something missing?",
    "Is the tuning appropriate?",
    "Just carry on",
    "Left channel, right channel, centre channel",
    "Listen in total darkness, or in a very large room, very quietly",
    "Listen to the quiet voice",
    "Look at a very small object, look at its centre",
    "Look at the order in which you do things",
    "Look closely at the most embarrassing details and amplify them",
    "Lowest common denominator check -single beat -single note -single",
    "riff",
    "Make a blank valuable by putting it in an exquisite frame",
    "Make an exhaustive list of everything you might do and do the last thing on the list",
    "Make a sudden, destructive unpredictable action; incorporate",
    "Mechanicalize something idiosyncratic",
    "Mute and continue",
    "Only one element of each kind",
    "(Organic) machinery",
    "Overtly resist change",
    "Put in earplugs",
    "Remember those quiet evenings",
    "Remove ambiguities and convert to specifics",
    "Remove specifics and convert to ambiguities",
    "Repetition is a form of change",
    "Reverse",
    "Short circuit (example: a man eating peas with the idea that they will improve his virility shovels them straight into his lap)",
    "Shut the door and listen from outside",
    "Simple subtraction",
    "Spectrum analysis",
    "Take a break",
    "Take away the elements in order of apparent non-importance",
    "Tape your mouth (given by Ritva Saarikko)",
    "The inconsistency principle",
    "The tape is now the music",
    "Think of the radio",
    "Tidy up",
    "Trust in the you of now",
    "Turn it upside down",
    "Twist the spine",
    "Use an old idea",
    "Use an unacceptable color",
    "Use fewer notes",
    "Use filters",
    'Use "unqualified" people',
    "Water",
    "What are you really thinking about just now? Incorporate",
    "What is the reality of the situation?",
    "What mistakes did you make last time?",
    "What would your closest friend do?",
    "What wouldn't you do?",
    "Work at a different speed",
    "You are an engineer",
    "You can only make one dot at a time",
    "You don't have to be ashamed of using your own ideas",
    "[blank white card]",
  }

  local strategy = get_strategy(strategies_list)
  local formatted_strategy = format_strategy(strategy, max_width)

  return formatted_strategy
end

local render_oblique_strategy = (function()
  local timer = vim.loop.new_timer()
  timer:start(
    0,
    5000,
    vim.schedule_wrap(function()
      if vim.api.nvim_buf_get_option(0, "filetype") ~= "starter" then
        timer:stop()
        return
      end
      MiniStarter.refresh()
    end)
  )
  return function()
    return oblique_strategies(40)
  end
end)()

starter.setup({
  items = {
    -- starter.sections.telescope(),
    starter.sections.recent_files(10, false, false),
    starter.sections.recent_files(10, true, false),
  },
  header = ("%s\n%s"):format(greeting(), install_info()),
  footer = render_oblique_strategy,
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.aligning("left", "center"),
    starter.gen_hook.padding(20, 0),
  },
})
