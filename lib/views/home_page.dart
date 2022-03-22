import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jobs_app/main.dart';
import 'package:jobs_app/models/jobs_model.dart';
import 'package:jobs_app/services/api_manager.dart';
import 'package:jobs_app/views/job_information_page.dart';

Future<JobsModel> _jobsModel = APIManager().getJobs();

enum SortOptions {
  name,
  salary,
}

// typedef Sort = int Function(dynamic a, dynamic b);
// typedef SortF = Sort Function(String sortField);

// SortF name = (String sortField) => (a, b) {
//       return a[sortField].toLowerCase().compareTo(b[sortField].toLowerCase());
//     };

// SortF salary = (String sortField) => (a, b) {
//       return a[sortField].compareTo(b[sortField]);
//     };

class HomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _sortOption = '';

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: const Text('Jobs App'),
        actions: [
          PopupMenuButton(
            onSelected: (SortOptions selectedValue) {
              setState(() {
                if (selectedValue == SortOptions.name) {
                  _sortOption = 'name';
                } else {
                  _sortOption = 'salary';
                }
              });
            },
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Sort by Name'),
                value: SortOptions.name,
              ),
              const PopupMenuItem(
                child: Text('Sort by Salary'),
                value: SortOptions.salary,
              ),
            ],
          ),
          IconButton(
            icon: Icon(
                MyApp.themeNotifier.value == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              MyApp.themeNotifier.value =
                  MyApp.themeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
            },
          ),
        ],
      ),
      body: FutureBuilder<JobsModel>(
        future: _jobsModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _sortOption = '';
                  _jobsModel = APIManager().getJobs();
                });
              },
              child: ListView.builder(
                itemCount: snapshot.data?.jobCount,
                itemBuilder: (context, index) {
                  var jobs = snapshot.data!.jobs!;
                  if (_sortOption == 'name') {
                    jobs.sort((a, b) {
                      return a.title!.compareTo(b.title!);
                    });
                  } else if (_sortOption == 'salary') {
                    jobs.sort((a, b) {
                      return b.salary!.compareTo(a.salary!);
                    });
                  }
                  // snapshot.data!.jobs!.sort(name(jobs[index].title!));
                  return InkWell(
                    onTap: () {
                      Get.to(JobInformationPage(
                        title: jobs[index].title,
                        companyName: jobs[index].companyName,
                        companyLogo: jobs[index].companyLogo,
                        publishedAt: jobs[index].publicationDate,
                        jobType: jobs[index].jobType,
                        location: jobs[index].candidateRequiredLocation,
                        salary: jobs[index].salary,
                        content: jobs[index].description,
                        url: jobs[index].url,
                      ));
                    },
                    child: Container(
                      height: mediaQuery.size.height * 0.13,
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                jobs[index].companyLogo!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  jobs[index].title!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: mediaQuery.size.height * 0.023,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  jobs[index].companyName!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: mediaQuery.size.height * 0.02,
                                  ),
                                ),
                                const Divider(height: 2),
                                Text(
                                  jobs[index].jobType!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: mediaQuery.size.height * 0.017,
                                  ),
                                ),
                                Text(
                                  jobs[index].candidateRequiredLocation!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: mediaQuery.size.height * 0.017,
                                  ),
                                ),
                                Text(
                                  jobs[index].publicationDate!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: mediaQuery.size.height * 0.017,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
