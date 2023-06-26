import 'package:flutter/material.dart';
import '../services.dart/list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    void addToHabitList(String habitName, String habitDescription) {
      habitList.add([false, habitName, habitDescription, Icon(Icons.abc)]);
    }

    void addHabit(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController habitNameController =
                TextEditingController(text: "Habit Name");
            TextEditingController habitDescriptionController =
                TextEditingController(text: "Habit Description");
            return AlertDialog(
              title: Text("Add a Habit"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: habitNameController,
                  ),
                  TextFormField(
                    controller: habitDescriptionController,
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurple),
                        surfaceTintColor:
                            MaterialStateProperty.all(Colors.purpleAccent)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurple),
                        surfaceTintColor:
                            MaterialStateProperty.all(Colors.purpleAccent)),
                    onPressed: () {
                      setState(() {
                        addToHabitList(habitNameController.text,
                            habitDescriptionController.text);
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Save")),
              ],
            );
          });
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.purple,
        onPressed: (() {
          addHabit(context);
        }),
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(children: [
                  Image.asset('assets/MainBackground.png'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 140, 0, 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(children: [
                        const Text(
                          "Hello User!",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "You have ${habitList.length - counter} habits left for today",
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ]),
                    ),
                  )
                ]),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Keep Going!",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 16),
                          ),
                          Text(
                            "${((counter / habitList.length) * 100).round()}%",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                            minHeight: 12,
                            color: Colors.deepPurpleAccent,
                            backgroundColor:
                                const Color.fromARGB(255, 192, 170, 250),
                            value: (counter / habitList.length)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Divider(),
                    ),
                    SizedBox(
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: habitList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, int index) {
                            return ListTile(
                              title: Text(habitList[index][1]),
                              subtitle: Text(habitList[index][2]),
                              trailing: habitList[index][3],
                              leading: Checkbox(
                                value: habitList[index][0],
                                onChanged: ((value) {
                                  setState(() {
                                    if (value == false) {
                                      counter -= 1;
                                      print(counter.toString());
                                      habitList[index][0] = value;
                                    } else {
                                      counter += 1;
                                    }
                                    print(counter.toString());
                                    habitList[index][0] = value;
                                  });
                                }),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}