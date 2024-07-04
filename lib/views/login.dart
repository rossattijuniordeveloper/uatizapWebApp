//simport 'dart:io';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:uatizap/utils/meu_snackbar.dart';
import '../services/autenticacao_service.dart';
import '../utils/paleta_cores.dart';

//File Picker
import 'package:file_picker/file_picker.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerNome =
      TextEditingController(text: 'Rossatti Junior');
  final TextEditingController _controllerEmail =
      TextEditingController(text: 'rossattijuniordeveloper@gmail.com');
  final TextEditingController _controllerSenha =
      TextEditingController(text: '123456789');
  bool queroAcessar = true;
  final _formkey = GlobalKey<FormState>();
  Uint8List? _arquivoImagemSelecionado;

  _selecionarImage() async {
    print('selecionar imagens');
    FilePickerResult? resultado =
        await FilePicker.platform.pickFiles(type: FileType.image);

    setState(() {
      _arquivoImagemSelecionado = resultado?.files.single.bytes;
    });
  }

  AutenticacaoService _autenticacao = AutenticacaoService();

  @override
  Widget build(BuildContext context) {
    double telaLargura = MediaQuery.of(context).size.width;
    double telaAltura = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: PaletaCores.corFundo,
        width: telaLargura,
        height: telaAltura,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: telaLargura,
                height: telaAltura * 0.5,
                color: PaletaCores.corPrimaria,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formkey,
                    child: Card(
                      elevation: 4,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Container(
                        width: 500,
//                      height: 400,
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            children: [
                              Visibility(
                                visible: !queroAcessar,
                                child: ClipOval(
                                  child: _arquivoImagemSelecionado != null
                                      ? Image.memory(
                                          _arquivoImagemSelecionado!,
                                          width: 120.0,
                                          height: 180.0,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'images/perfil.png',
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              Visibility(
                                visible: !queroAcessar,
                                child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      print('imagem');
                                      _selecionarImage();
                                    });
                                  },
                                  child: const Text('Selecionar Foto'),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Visibility(
                                visible: !queroAcessar,
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _controllerNome,
                                  obscureText: false,
                                  decoration: const InputDecoration(
                                    hintText: 'Nome',
                                    labelText: 'Nome',
                                    suffixIcon: Icon(
                                      Icons.person_2_outlined,
                                    ),
                                  ),
                                ),
                              ),
                              //E-mail
                              TextFormField(
                                validator: (String? value) {
                                  if (value == null) {
                                    return 'o E-mail não pode ser vazio!';
                                  }
                                  if (!value.contains('@')) {
                                    return 'formato de E-mail INVÁLIDO!';
                                  }
                                  if (value.length < 6) {
                                    return 'o e-mail é muito curto (INVÁLIDO!)';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller: _controllerEmail,
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  labelText: 'Email',
                                  suffixIcon: Icon(Icons.mail_outline),
                                ),
                              ),
                              // Caixa de texto senha
                              TextFormField(
                                validator: (String? value) {
                                  if (value == null) {
                                    return 'A Senha não pode ser vazia (INVÁLIDA!) ';
                                  }
                                  if (value.length < 8) {
                                    return 'Senha muito curta (INVÁLIDA!) ';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                controller: _controllerSenha,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Senha',
                                  labelText: 'Senha',
                                  suffixIcon: Icon(Icons.lock_outline),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    botaoPrincipalClicado();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: PaletaCores.corPrimaria,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      queroAcessar ? 'Acessar' : 'Cadastrar',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Acessar',
                                    style: TextStyle(
//                                      color: PaletaCores.corFundo,
                                        fontSize: 12),
                                  ),
                                  Switch(
                                      value: !queroAcessar,
                                      onChanged: (bool value) {
                                        setState(() {
//                                          print(
//                                              'setState value antes ${value} e queroAcessar ${queroAcessar}');
                                          queroAcessar = !queroAcessar;
//                                          print(
//                                              'setState value depois ${value} e queroAcessar ${queroAcessar}');
                                        });
                                      }),
                                  const Text(
                                    'Cadastrar',
                                    style: TextStyle(
//                                      color: PaletaCores.corFundo,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  botaoPrincipalClicado() {
    String email = _controllerEmail.text;
    String nome = _controllerNome.text;
    String senha = _controllerSenha.text;

    if (_formkey.currentState!.validate()) {
//      print('Form Valido ! tentando logar');
      if (queroAcessar) {
        _autenticacao.logarUsuarios(email: email, senha: senha).then(
          (String? erro) {
            if (erro != null) {
              showSnackbar(context: context, texto: erro);
            }
          },
        );
      } else if (_arquivoImagemSelecionado != null) {
//        print('Cadastro Validado !');
        _autenticacao
            .cadastrarUsuario(
          email: email,
          senha: senha,
          nome: nome,
          imagemSelecionada: _arquivoImagemSelecionado!,
        )
            .then(
          (String? erro) {
            if (erro != null) {
              // voltou com erro
              showSnackbar(context: context, texto: erro);
            }
          },
        );
      } else {
        showSnackbar(
            context: context, texto: 'Selecione uma Imagem para o Usuário !');
      }
    } else {
//      print('Form Inválido');
    }
  }
}
