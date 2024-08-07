import 'package:dw_barbershop/src/core/ui/helper/messages.dart';
import 'package:dw_barbershop/src/features/auth/register/user_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/helper/form_helper.dart';

class UserRegisterPage extends ConsumerStatefulWidget {
  const UserRegisterPage({super.key});

  @override
  ConsumerState<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends ConsumerState<UserRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final passwordEC = TextEditingController();
  final emailEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    passwordEC.dispose();
    emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRegisterVm = ref.watch(userRegisterVmProvider.notifier);

    ref.listen(userRegisterVmProvider, (_, state) {
      switch (state) {
        case UserRegisterStateStatus.initial:
        break;
        case UserRegisterStateStatus.success:
        Navigator.of(context).pushNamed('/auth/register/barbershop');
        case UserRegisterStateStatus.error:
        Messages.showError('Erro ao registrar usuario adm', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 30),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  onTapOutside: (event) => unfocus(context),
                  decoration: const InputDecoration(label: Text('Nome')),
                  controller: nameEC,
                  validator: Validatorless.required('Nome obrigatorio'),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  onTapOutside: (event) => unfocus(context),
                  decoration: const InputDecoration(label: Text('E-mail')),
                  controller: emailEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail obrigatorio'),
                    Validatorless.email('E-mail invalido'),
                  ]),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  onTapOutside: (event) => unfocus(context),
                  decoration: const InputDecoration(label: Text('Senha')),
                  controller: passwordEC,
                  obscureText: true,
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha obrigatorio'),
                    Validatorless.min(
                        6, 'Senha precisa ter no minimo 6 caracteres'),
                  ]),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  onTapOutside: (event) => unfocus(context),
                  decoration:
                      const InputDecoration(label: Text('Confirmar senha')),
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha obrigatorio'),
                    Validatorless.compare(passwordEC, 'Senhas não conhecidem'),
                  ]),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56)),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case false || null:
                      case true:
                        userRegisterVm.register(
                          email: emailEC.text,
                          password: passwordEC.text,
                          name: nameEC.text,
                        );
                    }
                  },
                  child: const Text('Criar conta'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
