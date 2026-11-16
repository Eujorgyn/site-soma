const express = require('express');
const path = require('path');

const app = express();
const port = 3001;

// O Express já interpreta JSON no corpo da requisição (substitui o body-parser)
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Página de teste das requisições POST (http://localhost:3001/teste)
app.use(express.static(path.join(__dirname, 'public')));

// ---------- Funções das operações ----------
function soma(a, b) {
  return a + b;
}

function subtracao(a, b) {
  return a - b;
}

function multiplicacao(a, b) {
  return a * b;
}

function divisao(a, b) {
  if (b === 0) {
    throw new Error('Não é possível dividir por zero');
  }
  return a / b;
}

// Lê e valida os valores "a" e "b" enviados no corpo da requisição
function lerValores(req) {
  console.log('Corpo recebido:', req.body);
  const a = Number(req.body.a);
  const b = Number(req.body.b);
  if (req.body.a === undefined || req.body.b === undefined || Number.isNaN(a) || Number.isNaN(b)) {
    throw new Error('Envie os campos "a" e "b" com valores numéricos');
  }
  return { a, b };
}

// Cria uma rota POST para cada operação
function criarRotaPost(caminho, nome, simbolo, operacao) {
  app.post(caminho, (req, res) => {
    try {
      const { a, b } = lerValores(req);
      const resultado = operacao(a, b);
      res.json({
        operacao: nome,
        a,
        b,
        resultado,
        mensagem: `A ${nome} de ${a} ${simbolo} ${b} é ${resultado}`,
      });
    } catch (erro) {
      res.status(400).json({ erro: erro.message });
    }
  });
}

// ---------- Rotas GET ----------
app.get('/', (req, res) => {
  res.send(`
    <h1>Servidor Node.js rodando! 🚀</h1>
    <p>Requisição <strong>GET</strong> recebida com sucesso na porta ${port}.</p>
    <p>Rotas POST disponíveis: <code>/soma</code>, <code>/subtracao</code>,
       <code>/multiplicacao</code> e <code>/divisao</code>.</p>
    <p><a href="/teste">Abrir página de teste das requisições POST</a></p>
  `);
});

app.get('/teste', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'teste.html'));
});

// ---------- Rotas POST ----------
criarRotaPost('/soma', 'soma', '+', soma);
criarRotaPost('/subtracao', 'subtração', '-', subtracao);
criarRotaPost('/multiplicacao', 'multiplicação', '×', multiplicacao);
criarRotaPost('/divisao', 'divisão', '÷', divisao);

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
