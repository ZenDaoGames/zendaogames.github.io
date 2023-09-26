---
title: Accurate Aim for 3rd Person Controller
---

My 3rd person character needed to shoot projectiles where the crosshairs pointed.

Here’s what I came up. No Raycast needed (but there is a Ray!).

    private Vector3 GetAimDirection(Vector3 sourcePosition)
    {
        var rayLength = 100f;
        var ray = Camera.main.ViewportPointToRay(new Vector3(0.5f, 0.5f));

        return (ray.GetPoint(rayLength) - sourcePosition).normalized;
    }

Notes:

- sourcePosition is the position of the spawned object as soon as it’s instantiated
- Crosshair is located in the center of the screen