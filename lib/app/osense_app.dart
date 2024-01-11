import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osense_test/app/osense_bloc.dart';
import 'package:osense_test/app/osense_event.dart';
import 'package:osense_test/app/osense_state.dart';

class OsenseApp extends StatefulWidget {
  const OsenseApp({super.key, required this.title});

  final String title;

  @override
  State<OsenseApp> createState() => _OsenseAppState();
}

class _OsenseAppState extends State<OsenseApp> {
  late OsenseBloc bloc;
  TextEditingController objectTextController = TextEditingController();
  bool submit = false;
  bool isSelect = false;
  String? selectValue;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    bloc = OsenseBloc(OsenseState.initState());
    objectTextController.addListener(() {
      setState(() {
        submit = objectTextController.text.isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<OsenseBloc, OsenseState>(
        listener: (context, state) {
          switch (state.status) {
            case OsensePageStatus.idle:
            case OsensePageStatus.submitSuccess:
              objectTextController.text = state.name ?? "";
          }
        },
        builder: (context, state) {
          String name = state.name ?? "";
          String selectFruit = state.selectFruit ?? "";
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '你所輸入的物件名稱：',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Padding(padding: EdgeInsets.all(4)),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.red[300]),
                  ),
                  const Padding(padding: EdgeInsets.all(4)),
                  Text(
                    '你所選擇的物件類型：',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Padding(padding: EdgeInsets.all(4)),
                  Text(
                    selectFruit,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.red[300]),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return Form(
                          key: formKey,
                          child: Dialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.0))),
                            child: SizedBox(
                              width: 480,
                              height: 460,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.fromLTRB(0, 8, 8, 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(Icons.close),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "建立物件",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(fontWeight: FontWeight.w400, fontSize: 24),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(38, 30, 38, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "物件名稱",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(fontSize: 16),
                                        ),
                                        const Padding(padding: EdgeInsets.all(2)),
                                        TextFormField(
                                          onChanged: (value) {
                                            setState(() {
                                              if (objectTextController.text.isNotEmpty) {
                                                submit = true;
                                              } else {
                                                submit = false;
                                              }
                                            });
                                          },
                                          controller: objectTextController,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return '還沒輸入物件名稱喔！';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xffDADADA))),
                                            filled: false,
                                            fillColor: null,
                                            contentPadding: EdgeInsets.all(12),
                                            labelText: "物件名稱",
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontSize: 16, color: const Color(0xff8D919A)),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(6),
                                                borderSide: BorderSide()),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(38, 35, 38, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "物件類型",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(fontSize: 16),
                                        ),
                                        const Padding(padding: EdgeInsets.all(2)),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                          decoration: BoxDecoration(
                                              border:
                                                  Border.all(width: 1, color: Color(0xffDADADA)),
                                              borderRadius: BorderRadius.all(Radius.circular(6))),
                                          child: DropdownButton(
                                            hint: Text(
                                              "選擇",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(color: Color(0xff9E9E9E)),
                                            ),
                                            underline: Container(),
                                            isExpanded: true,
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              size: 20,
                                            ),
                                            padding: EdgeInsets.zero,
                                            value: selectValue,
                                            items: [
                                              DropdownMenuItem(
                                                value: "蘋果",
                                                child: Text(
                                                  "蘋果",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(color: Colors.black),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    isSelect = true;
                                                  });
                                                },
                                              ),
                                              DropdownMenuItem(
                                                value: "香蕉",
                                                child: Text(
                                                  "香蕉",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(color: Colors.black),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    isSelect = true;
                                                  });
                                                },
                                              ),
                                              DropdownMenuItem(
                                                value: "鳳梨",
                                                child: Text(
                                                  "鳳梨",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(color: Colors.black),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    isSelect = true;
                                                  });
                                                },
                                              ),
                                              DropdownMenuItem(
                                                value: "奇異果",
                                                child: Text(
                                                  "奇異果",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(color: Colors.black),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    isSelect = true;
                                                  });
                                                },
                                              ),
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                selectValue = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  isSelect
                                      ? Container()
                                      : Container(
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.fromLTRB(38, 8, 0, 0),
                                          child: Text(
                                            "必填欄位",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(color: Color(0xffF57769)),
                                          ),
                                        ),
                                  Container(
                                    width: 170,
                                    padding: EdgeInsets.fromLTRB(0, 47, 0, 12),
                                    child: ElevatedButton(
                                        onPressed: submit
                                            ? () {
                                                bool? validation = formKey.currentState?.validate();

                                                if (validation == true) {
                                                  if (selectValue != null) {
                                                    setState(() {
                                                      isSelect = true;
                                                    });
                                                    bloc.add(OsenseSubmit(
                                                        name: objectTextController.text,
                                                        selectFruit: selectValue ?? ""));
                                                    Navigator.pop(context);
                                                  } else {
                                                    setState(() {
                                                      isSelect = false;
                                                    });
                                                  }
                                                } else {
                                                  print("error");
                                                }
                                              }
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          foregroundColor: Colors.white,
                                          backgroundColor: Color(0xff8E97FD),
                                          disabledBackgroundColor:
                                              Color(0xff8E97FD).withOpacity(0.4),
                                        ),
                                        child: Text(
                                          "創建",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: Colors.white),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
