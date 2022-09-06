*** Settings ***
Documentation       Arquivo de testes para o Endpoint /produtos

Library             RequestsLibrary
Resource            ../support/base.robot

Test Setup          Criar Sessao


*** Test Cases ***
Cenário 13: GET Listar Produtos 200
    [Tags]    listarprodutos
    GET On Session /Produtos
    Validar Status Code "200"

Cenário 14: GET Buscar produto por ID com sucesso 200
    [Tags]    buscarproduto
    Fazer Login e Armazenar Token
    Cadastrar Produto Dinamico Valido
    GET On Session /Produtos "${id_produto}"
    Validar Status Code "200"

Cenário 15: GET Buscar produto por ID sem sucesso 400
    [Tags]    produtosemid
    GET On Session /Produtos "1111111"
    Validar Status Code "400"

Cenário 16: POST Cadastrar Produto com sucesso 201
    [Tags]    addproduto
    Fazer Login e Armazenar Token
    Cadastrar Produto Dinamico Valido
    Validar Status Code "201"
    DELETE Endpoint /produtos

Cenário 17: POST Cadastrar Produto com mesmo nome 400
    [Tags]    produtoigual
    Fazer Login e Armazenar Token
    Pegar Dados Produto Estatico Valido "produto_invalido"
    POST On Session /Produtos
    Validar Status Code "400"

Cenário 18: POST Cadastrar Produto sem token 401
    [Tags]    produtosemtoken
    Pegar Token Invalido
    POST On Session /Produtos
    Validar Status Code "401"

Cenário 19: POST Cadastrar Produto sem adm 403
    [Tags]    produtosemadm
    Fazer Login sem adm
    POST On Session /Produtos
    Validar Status Code "403"

Cenário 20: DELETE Produto com sucesso 200
    [Tags]    deletarproduto
    Fazer Login e Armazenar Token
    Cadastrar Produto Dinamico Valido
    DELETE Endpoint /produtos
    Validar Status Code "200"

Cenário 21: DELETE Produto em um carrinho 400
    [Tags]    produtocomcarrinho
    Fazer Login e Armazenar Token
    Produto ID Em carrinho
    DELETE Endpoint /produtos
    Validar Status Code "400"

Cenário 22: DELETE Produto sem token 401
    [Tags]    deletarsemtoken
    Pegar Token Invalido
    Cadastrar Produto Dinamico Valido
    Validar Status Code "401"

Cenário 23: DELETE Produto sem adm 403
    [Tags]    deletarsemadm
    Fazer Login sem adm
    DELETE Endpoint /produtos
    Validar Status Code "403"

Cenário 24: PUT Editar Produto com sucesso 200
    [Tags]    editarproduto
    Fazer Login e Armazenar Token
    Cadastrar Produto Dinamico Valido
    PUT On Session /Produtos "${id_produto}"
    Validar Status Code "200"

Cenário 25: PUT Editar Produto sem cadastro 201
    [Tags]    produtosemcadastro
    Fazer Login e Armazenar Token
    Cadastrar Produto Dinamico Valido
    Criar Produto Dinamico Valido
    PUT On Session /Produtos "0000000000"
    Validar Status Code "201"
    DELETE Endpoint /produtos

Cenário 26: PUT Editar Produto com nome existente 400
    [Tags]    produtorepetido
    Fazer Login e Armazenar Token
    Cadastrar Produto Dinamico Valido
    PUT On Session /Produtos "0000000000"
    Validar Status Code "400"

Cenário 27: PUT Editar Produto sem token 401
    [Tags]    produtosemtoken
    Pegar Token Invalido
    PUT On Session /Produtos "0000000000"
    Validar Status Code "401"

Cenário 28: PUT Editar Produto sem adm 403
    [Tags]    produtosemadm
    Fazer Login sem adm
    PUT On Session /Produtos "${id_produto}"
    Validar Status Code "403"

Cenário 40: POST Criar Produto de Massa Dinamica 201
    [Tags]    postprodutodinamico
    Cadastrar Produto Dinamico Valido
    Validar Status Code "201"
    DELETE Endpoint /produtos