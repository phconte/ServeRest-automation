*** Settings ***
Documentation       Arquivo de testes para o Endpoint /usuarios

Library             RequestsLibrary
Resource            ../support/base.robot

Test Setup          Criar Sessao


*** Test Cases ***
Cenário 04: GET Listar usuários cadastrados com Sucesso 200
    [Tags]    users
    GET On Session /Usuarios
    Validar Status Code "200"
    Gerar Json "${response.content}"
    Gerar CSV "${response.content}"
    Converter string "${response.content}" para sha256

Cenário 05: POST Cadastrar Usuario com sucesso 201
    [Tags]    adduser
    Pegar Dados Usuario Estatico Valido "user_valido"
    Converter dict "${payload}" para sha256
    POST On Session /Usuarios
    Validar Status Code "201"
    Validar se Mensagem Contem "Cadastro realizado com sucesso"
    DELETE On Session /Usuarios "${id}"

Cenário 06: POST Tentar Cadastrar Usuario existente 400
    [Tags]    userexist
    Criar Usuario Estatico Invalido
    POST On Session /Usuarios
    Validar Status Code "400"
    Validar se Mensagem Contem "Este email já está sendo usado"

Cenário 07: GET Buscar Usuario por ID com sucesso 200
    [Tags]    userid
    ${id_user}    Criar Usuario Dinamico Valido
    GETid On Session /Usuarios
    Validar Status Code "200"

Cenário 08: GET Buscar Usuario por ID sem sucesso 400
    [Tags]    usersemid
    Set Test Variable    ${id_user}    0uxuPY0cbmQhpEzA
    GETid On Session /Usuarios
    Validar Status Code "400"
    Validar se Mensagem Contem "Usuário não encontrado"

Cenário 09: DELETE Usuario por ID com sucesso 200
    [Tags]    deluser
    Criar Usuario Dinamico Valido
    POST On Session /Usuarios
    DELETE On Session /Usuarios "${id}"
    Validar Status Code "200"
    Validar se Mensagem Contem "Registro excluído com sucesso"

Cenário 41: DELETE Usuario por ID sem sucesso 400
    [Tags]    delusersemsucesso
    DELETE On Session /Usuarios "oUb7aGkMtSEPf6BZ"
    Validar Status Code "400"
    Validar se Mensagem Contem "Não é permitido excluir usuário com carrinho cadastrado"

Cenário 10: PUT Alterar Usuario com Sucesso 200
    [Tags]    putuser
    Criar Usuario Dinamico Valido
    POST On Session /Usuarios
    PUT On Session /Usuarios "${id}"
    Validar Status Code "200"
    Validar se Mensagem Contem "Registro alterado com sucesso"
    DELETE On Session /Usuarios "${id}"

Cenário 11: PUT Cadastrar Usuario com Sucesso 201
    [Tags]    putusernovo
    Criar Usuario Dinamico Valido
    PUT On Session /Usuarios "123456"
    Validar Status Code "201"
    Validar se Mensagem Contem "Cadastro realizado com sucesso"

Cenário 12: PUT Cadastrar Usuario sem Sucesso 400
    [Tags]    putemailexist
    Criar Usuario Dinamico Valido
    POST On Session /Usuarios
    PUT On Session /Usuarios "${id_user}"
    Validar Status Code "400"
    Validar se Mensagem Contem "Este email já está sendo usado"
    DELETE On Session /Usuarios "${id}"

Cenário 39: POST Criar Usuario de Massa Dinamica 201
    [Tags]    postuserdinamico
    Criar Usuario Dinamico Valido
    POST On Session /Usuarios
    Validar Status Code "201"
    Validar se Mensagem Contem "Cadastro realizado com sucesso"
    DELETE On Session /Usuarios "${id}"

Cenário 41: POST Cadastrar Usuario sem dados 400
    [Tags]    postsemdados
    Pegar Dados Usuario Estatico Valido "user_vazio"
    POST On Session /Usuarios
    Validar Status Code "400"

Cenário 42: POST Cadastrar Usuario sem não booleano 400
    [Tags]    postnaobooleano
    Pegar Dados Usuario Estatico Valido "user_adm_error"
    POST On Session /Usuarios
    Validar Status Code "400"
