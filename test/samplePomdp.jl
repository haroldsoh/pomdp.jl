
states = ["happy", "angry"]
actions = ["do_nothing", "apologize"]
observations = ["smiling", "calm", "yelling"]
discount = 0.99


function initialStateDist()
  return BeliefParticles(states, [0.5, 0.5])
end

function emission(state)
  if state == "happy"
    return rand() < 0.8 ? "smiling" : "calm"
  elseif state == "angry"
    return rand() < 0.5 ? "yelling" : "calm"
  end
  @assert false
end

function transition(state, action)
  r = rand()
  if state == "happy"
    if action == "do_nothing"
      return r < 0.9 ? "happy": "angry"
    elseif action == "apologize"
      return r < 0.7 ? "angry": "happy"
    end
  elseif state == "angry"
    if action == "do_nothing"
      return r < 0.98 ? "angry": "happy"
    elseif action == "apologize"
      return r < 0.8 ? "happy": "angry"
    end
  end

  @assert false
end

function reward(state, action, next_state)
  return next_state == "happy" ? 1 : -1
end

# Some policies you can try
function randomPolicy(obs, actions)
  return actions[rand(1:end)]
end

function sorryPolicy(obs, actions)
  return "apologize"
end

function lazyPolicy(obs, actions)
  return "do_nothing"
end

function safePolicy(obs, action)
  if obs == "yelling"
    return "apologize"
  else
    return "do_nothing"
  end
  @assert false
end

function isTerminal(state)
  return false
end

function getActions()
  return ["do_nothing", "apologize"]
end

# create a new POMDP
my_problem = POMDP(initialStateDist, getActions, emission, reward, transition, isTerminal, discount)