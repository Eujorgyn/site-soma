# Site Soma: requisições GET e POST com Node.js + Express

Atividade da disciplina **Desenvolvimento de Software em Nuvem e Ambientes de Desenvolvimento de Software** (UNIFOR).

O projeto segue o tutorial [Requisição POST com Express](https://gist.github.com/cmendesce/81bd5e30f2a8765f40be6485da02a8c5): um servidor Node.js com Express que responde a uma requisição **GET** e recebe dados por requisição **POST**, processa os valores e devolve o resultado. Além da soma, o exercício foi estendido para **subtração, multiplicação e divisão**.

## Tecnologias

- Node.js
- Express (o `express.json()` já interpreta o corpo JSON, então o `body-parser` não é necessário)

## Como executar

```bash
npm install
node app.js
```

O servidor sobe em `http://localhost:3001`.

## Rotas

| Método | Rota             | Descrição                                         |
|--------|------------------|---------------------------------------------------|
| GET    | `/`              | Confirma que o servidor está rodando              |
| GET    | `/teste`         | Página para testar as requisições POST no navegador |
| POST   | `/soma`          | Retorna `a + b`                                   |
| POST   | `/subtracao`     | Retorna `a - b`                                   |
| POST   | `/multiplicacao` | Retorna `a × b`                                   |
| POST   | `/divisao`       | Retorna `a ÷ b` (retorna erro 400 se `b = 0`)     |

### Exemplo de requisição POST

```http
POST http://localhost:3001/soma
Content-Type: application/json

{ "a": 10, "b": 5 }
```

Resposta:

```json
{
  "operacao": "soma",
  "a": 10,
  "b": 5,
  "resultado": 15,
  "mensagem": "A soma de 10 + 5 é 15"
}
```

## Evidências

### Requisição GET bem-sucedida

Acesso a `http://localhost:3001/` pelo navegador:

![Evidência da requisição GET](evidencias/get.png)

### Requisição POST bem-sucedida

Envio de `{ "a": 10, "b": 5 }` para a rota `/soma` e resposta do servidor:

![Evidência da requisição POST](evidencias/post.png)

## Autor

Jorge Gabriel
