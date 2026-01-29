-- HiuFire ESP System
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Hàm tạo ESP cho từng người chơi
local function createESP(player)
	if player == LocalPlayer then return end

	local function addHighlight()
		-- Chờ nhân vật load xong
		local char = player.Character or player.CharacterAdded:Wait()
		
		-- 1. Tạo Highlight (Khung viền xuyên tường)
		if not char:FindFirstChild("HiuFireESP") then
			local highlight = Instance.new("Highlight")
			highlight.Name = "HiuFireESP"
			highlight.Parent = char
			highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Màu đỏ lửa
			highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- Viền trắng
			highlight.FillTransparency = 0.5 -- Độ trong suốt
			highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		end

		-- 2. Tạo BillboardGui (Hiện tên trên đầu)
		local head = char:WaitForChild("Head", 5)
		if head and not head:FindFirstChild("HiuFireName") then
			local bgui = Instance.new("BillboardGui")
			bgui.Name = "HiuFireName"
			bgui.Adornee = head
			bgui.Size = UDim2.new(0, 100, 0, 50)
			bgui.StudsOffset = Vector3.new(0, 2, 0)
			bgui.AlwaysOnTop = true
			bgui.Parent = head

			local tl = Instance.new("TextLabel")
			tl.BackgroundTransparency = 1
			tl.Size = UDim2.new(1, 0, 1, 0)
			tl.Text = player.Name
			tl.TextColor3 = Color3.fromRGB(255, 255, 0) -- Màu vàng rực
			tl.TextScaled = true
			tl.Font = Enum.Font.BlackOpsOne -- Font chữ ngầu
			tl.Parent = bgui
		end
	end

	-- Chạy khi nhân vật hồi sinh
	player.CharacterAdded:Connect(addHighlight)
	if player.Character then addHighlight() end
end

-- Áp dụng cho tất cả người chơi hiện tại và người mới vào
for _, p in pairs(Players:GetPlayers()) do
	createESP(p)
end
Players.PlayerAdded:Connect(createESP)

print("HiuFire ESP v1.0 da kich hoat!")
