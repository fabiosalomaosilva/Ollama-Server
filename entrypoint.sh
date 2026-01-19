#!/bin/bash
set -e

# Inicia o servidor Ollama em background
ollama serve --host 0.0.0.0 &
OLLAMA_PID=$!

# Aguarda o servidor estar pronto
echo "Aguardando servidor Ollama iniciar..."
sleep 5

# Verifica e baixa o modelo se necessário
if ! ollama list | grep -q "qwen3:8b"; then
    echo "Baixando modelo qwen3:8b..."
    ollama pull qwen3:8b
    echo "Modelo baixado com sucesso!"
else
    echo "Modelo qwen3:8b já existe."
fi

# Mantém o processo principal rodando
wait $OLLAMA_PID
