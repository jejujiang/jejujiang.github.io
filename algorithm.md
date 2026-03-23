---
title: algorithm
---

```lua
function binarySearch(array, target)
  local left, right = 1, #array
  while left < right do
      middle = math.floor((left + right) / 2)
      if array[middle] == target then
          return middle
      elseif array[middle] < target then
          middle = middle + 1
      else
          middle = middle - 1
      end
  end
  return nil
end
```
