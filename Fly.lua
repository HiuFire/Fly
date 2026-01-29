local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

local flying = false
local speed = 50

local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "HiuFireFlyGui"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 120, 0, 60)
frame.Position = UDim2.new(0.5, -60, 0.75, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0

local corner = Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.4, 0)
title.Text = "Hiu Fire"
title.TextColor3 = Color3.fromRGB(255, 100, 0) -- Màu lửa
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14

local flyButton = Instance.new("TextButton", frame)
flyButton.Size = UDim2.new(0.8, 0, 0.4, 0)
flyButton.Position = UDim2. Fleming2.new(0.1, 0, 0.5, 0)
flyButton.Position = UDim2.new(0.1, 0, 0.5, 0)
flyButton.Text = "Fly: OFF"
flyButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.Font = Enum.Font.Gotham

local btnCorner = Instance.new("UICorner", flyButton)

local bg, bv
flyButton.MouseButton1Click:Connect(function()
    flying = not flying
    
    if flying then
        flyButton.Text = "Fly: ON"
        flyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        
        bg = Instance.new("BodyGyro", root)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = root.CFrame
        
        bv = Instance.new("BodyVelocity", root)
        bv.velocity = Vector3.new(0, 0, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        
        task.spawn(function()
            while flying do
                task.wait()
                bv.velocity = camera.CFrame.LookVector * speed
                bg.cframe = camera.CFrame
            end
            if bg then bg:Destroy() end
            if bv then bv:Destroy() end
        end)
    else
        flyButton.Text = "Fly: OFF"
        flyButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end
end)
