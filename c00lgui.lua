-- c00lgui executor V2
-- Configurações
local ICON_URL = "https://files.catbox.moe/eqgcnh.png"
local KEY = "c00lkidd"

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Criando a Interface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "c00lgui_v2"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- --- TELA DE CARREGAMENTO ---
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundColor3 = Color3.new(0, 0, 0)
LoadingFrame.BackgroundTransparency = 0.4 -- 60% opaco
LoadingFrame.ZIndex = 10
LoadingFrame.Parent = ScreenGui

local LoadingContent = Instance.new("Frame")
LoadingContent.Size = UDim2.new(0, 300, 0, 100)
LoadingContent.Position = UDim2.new(0.5, -150, 0.5, -50)
LoadingContent.BackgroundTransparency = 1
LoadingContent.Parent = LoadingFrame

local PercentageLabel = Instance.new("TextLabel")
PercentageLabel.Size = UDim2.new(1, 0, 0, 30)
PercentageLabel.Text = "0%"
PercentageLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
PercentageLabel.Font = Enum.Font.Code
PercentageLabel.TextSize = 25
PercentageLabel.BackgroundTransparency = 1
PercentageLabel.Parent = LoadingContent

local BarBackground = Instance.new("Frame")
BarBackground.Size = UDim2.new(1, 0, 0, 10)
BarBackground.Position = UDim2.new(0, 0, 0.7, 0)
BarBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BarBackground.BorderSizePixel = 0
BarBackground.Parent = LoadingContent

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBackground

-- --- INTERFACE PRINCIPAL ---
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Top Bar (Área de Arraste)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundTransparency = 1
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "c00lgui executor"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.Code
Title.TextSize = 18
Title.BackgroundTransparency = 1
Title.Parent = TopBar

local MinMaxBtn = Instance.new("ImageButton")
MinMaxBtn.Size = UDim2.new(0, 25, 0, 25)
MinMaxBtn.Position = UDim2.new(1, -35, 0.5, -12)
MinMaxBtn.Image = ICON_URL
MinMaxBtn.BackgroundTransparency = 1
MinMaxBtn.Parent = TopBar

-- Conteúdo (Editor e Botões)
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -35)
ContentFrame.Position = UDim2.new(0, 0, 0, 35)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -20, 0, 150)
TextBox.Position = UDim2.new(0, 10, 0, 5)
TextBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.MultiLine = true
TextBox.Text = "-- c00lkidd script executor"
TextBox.Font = Enum.Font.Code
TextBox.TextSize = 14
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.Parent = ContentFrame

local ExecuteBtn = Instance.new("TextButton")
ExecuteBtn.Size = UDim2.new(0, 120, 0, 35)
ExecuteBtn.Position = UDim2.new(0, 10, 0, 165)
ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ExecuteBtn.BorderColor3 = Color3.fromRGB(255, 0, 0)
ExecuteBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
ExecuteBtn.Text = "EXECUTAR"
ExecuteBtn.Font = Enum.Font.Code
ExecuteBtn.TextSize = 16
ExecuteBtn.Parent = ContentFrame

-- --- LÓGICA DE MOVIMENTAÇÃO (DRAGGABLE) ---
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- --- LÓGICA DE CARREGAMENTO ---
task.spawn(function()
	-- Chuva de ícones
	task.spawn(function()
		while LoadingFrame.Visible do
			local img = Instance.new("ImageLabel")
			img.Image = ICON_URL
			img.BackgroundTransparency = 1
			img.Size = UDim2.new(0, 30, 0, 30)
			img.Position = UDim2.new(math.random(), 0, -0.1, 0)
			img.Parent = LoadingFrame
			TweenService:Create(img, TweenInfo.new(math.random(2, 4)), {Position = UDim2.new(img.Position.X.Scale, 0, 1.1, 0)}):Play()
			game:GetService("Debris"):AddItem(img, 4)
			task.wait(0.2)
		end
	end)

	-- Barra de Progresso
	for i = 0, 100, 2 do
		PercentageLabel.Text = i .. "%"
		BarFill.Size = UDim2.new(i/100, 0, 1, 0)
		task.wait(0.05)
	end
	
	PercentageLabel.Text = "b3m v1nd0 40 t1m3 c00lkidd"
	task.wait(1.5)
	
	TweenService:Create(LoadingFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
	TweenService:Create(LoadingContent, TweenInfo.new(0.5), {GroupTransparency = 1}):Play()
	task.wait(0.5)
	LoadingFrame.Visible = false
	MainFrame.Visible = true
end)

-- --- MINIMIZAR / MAXIMIZAR ---
local isMinimized = false
MinMaxBtn.MouseButton1Click:Connect(function()
	if not isMinimized then
		-- Minimizar
		TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 400, 0, 35)}):Play()
		ContentFrame.Visible = false
	else
		-- Maximizar
		TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 400, 0, 250)}):Play()
		task.wait(0.4)
		ContentFrame.Visible = true
	end
	isMinimized = not isMinimized
end)

-- --- EXECUÇÃO ---
ExecuteBtn.MouseButton1Click:Connect(function()
	local success, err = pcall(function()
		loadstring(TextBox.Text)()
	end)
	if not success then warn("Erro: " .. err) end
end)
