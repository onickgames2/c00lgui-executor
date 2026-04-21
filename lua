-- c00lgui executor
-- Configurações de Cores e Assets
local ICON_URL = "rbxassetid://134762391216503" -- Convertendo o link para formato rbx (coloque o ID correto se necessário)
local FALLING_ICON = "https://files.catbox.moe/eqgcnh.png"
local KEY = "c00lkidd"

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Criando a Interface Principal
local ScreenGui = Instance.new("ScreenGui")
local LoadingFrame = Instance.new("Frame")
local MainFrame = Instance.new("Frame")
local TextButton = Instance.new("TextButton") -- Botão de Executar
local ScrollingFrame = Instance.new("ScrollingFrame")
local TextBox = Instance.new("TextBox") -- Editor de Script
local MinimizeBtn = Instance.new("ImageButton")
local Title = Instance.new("TextLabel")

ScreenGui.Name = "c00lgui_Executor"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- --- TELA DE CARREGAMENTO ---
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Parent = ScreenGui
LoadingFrame.BackgroundColor3 = Color3.new(0, 0, 0)
LoadingFrame.BackgroundTransparency = 0.4 -- 60% opaco
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.ZIndex = 10

local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Size = UDim2.new(1, 0, 0, 50)
WelcomeLabel.Position = UDim2.new(0, 0, 0.5, -25)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
WelcomeLabel.TextSize = 30
WelcomeLabel.Font = Enum.Font.Code
WelcomeLabel.Text = "CARREGANDO..."
WelcomeLabel.Parent = LoadingFrame

-- Função para chuva de imagens
local function spawnFallingIcon()
    local img = Instance.new("ImageLabel")
    img.BackgroundTransparency = 1
    img.Image = FALLING_ICON
    img.Size = UDim2.new(0, 40, 0, 40)
    img.Position = UDim2.new(math.random(), 0, -0.1, 0)
    img.Parent = LoadingFrame
    
    local duration = math.random(2, 5)
    img:TweenPosition(UDim2.new(img.Position.X.Scale, 0, 1.1, 0), "Out", "Linear", duration, true)
    game:GetService("Debris"):AddItem(img, duration)
end

-- Simulação de Carregamento
task.spawn(function()
    for i = 1, 20 do
        spawnFallingIcon()
        task.wait(0.1)
    end
    task.wait(1)
    WelcomeLabel.Text = "b3m v1nd0 40 t1m3 c00lkidd"
    task.wait(2)
    TweenService:Create(LoadingFrame, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
    TweenService:Create(WelcomeLabel, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
    task.wait(0.8)
    LoadingFrame.Visible = false
    MainFrame.Visible = true
end)

-- --- INTERFACE PRINCIPAL ---
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0) -- Contorno Vermelho Vivo
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Visible = false
MainFrame.ClipsDescendants = true

-- Título
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Text = "c00lgui executor"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.Code
Title.TextSize = 18
Title.Parent = MainFrame

-- Botão Minimizar
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(1, -30, 0, 5)
MinimizeBtn.Image = FALLING_ICON
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Parent = MainFrame

-- Editor (TextBox)
TextBox.Size = UDim2.new(0, 380, 0, 150)
TextBox.Position = UDim2.new(0, 10, 0, 40)
TextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.ClearTextOnFocus = false
TextBox.MultiLine = true
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.Font = Enum.Font.Code
TextBox.Text = "-- Insira o script aqui"
TextBox.Parent = MainFrame

-- Botão Executar
TextButton.Size = UDim2.new(0, 100, 0, 30)
TextButton.Position = UDim2.new(0, 10, 0, 200)
TextButton.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
TextButton.TextColor3 = Color3.fromRGB(255, 0, 0)
TextButton.Text = "EXECUTAR"
TextButton.BorderSizePixel = 1
TextButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
TextButton.Parent = MainFrame

-- --- FUNCIONALIDADES ---

-- Arrastar GUI
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
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

-- Execução do Script
TextButton.MouseButton1Click:Connect(function()
    -- Verificação básica de Key simples via Variável local (já que você definiu a key)
    local code = TextBox.Text
    local success, err = pcall(function()
        loadstring(code)()
    end)
    
    if not success then
        warn("Erro ao executar: " .. err)
    end
end)

-- Minimizar (Animação Suave)
local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    if not minimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 400, 0, 35)}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 400, 0, 250)}):Play()
    end
    minimized = not minimized
end)
