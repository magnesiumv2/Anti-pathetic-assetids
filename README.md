# Roblox Anti-Inappropriate Clothing (Blacklist System)

Um sistema simples, leve e de código aberto em Luau para criadores de jogos no Roblox bloquearem roupas e acessórios inapropriados que burlam os filtros iniciais do catálogo.

## Como funciona

1. **Detecção Automática:** Assim que o personagem de um jogador carrega no servidor (`CharacterAppearanceLoaded`), o script verifica camisas, calças, camisetas gráficas e acessórios 3D usando `HumanoidDescription`.
2. **Ocultação Imediata:** Se algum item estiver na lista de IDs proibidos (`prohibitedIds`), a textura da roupa é removida visualmente na mesma hora para proteger os outros jogadores na sala.
3. **Cronômetro de Tolerância:** O jogador recebe um tempo configurável (padrão de **25 segundos**) para abrir o menu de avatar e remover o item.
4. **Expulsão Automática (Kick):** Caso o jogador não remova a peça antes do fim do cronômetro, o servidor desconecta o usuário automaticamente com uma mensagem explicativa.

## Instalação

1. Abra o seu projeto no **Roblox Studio**.
2. No painel **Explorer**, localize a pasta **ServerScriptService**.
3. Clique no ícone `+` ao lado de **ServerScriptService** e insira um novo **Script**.
4. Cole o código do arquivo `.lua` deste repositório dentro do script criado.
5. Publique o jogo (`File > Publish to Roblox`) para ativar a proteção nos servidores públicos.

## Configuração

No topo do script, você pode personalizar o tempo de tolerância, a mensagem de expulsão e a lista de IDs bloqueados:

```lua
local timer = 25
local kickMessage = "You failed to remove the prohibited clothing before the timer ended. Try again."

local prohibitedIds = {
	123456789,
	987654321,
}
```

* **`timer`**: Define quantos segundos o jogador tem para trocar de roupa antes de ser desconectado.
* **`kickMessage`**: Mensagem exibida na tela do jogador caso o tempo acabe.
* **`prohibitedIds`**: Lista numérica com os IDs das roupas e acessórios proibidos, separados por vírgula.

## Segurança e Transparência

* **100% Código Aberto:** Este script não contém códigos ofuscados, `require()` externos ou portas dos fundos (*backdoors*).
* **Alta Performance:** A lista de IDs é convertida em um dicionário de busca instantânea para evitar qualquer queda de FPS ou *lag* no servidor.

## Como Contribuir

Encontrou um ID de roupa inapropriada que ainda não está na lista? Abra uma **Issue** ou envie um **Pull Request** informando apenas o número do ID para mantermos a comunidade segura.
