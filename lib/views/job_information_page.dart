import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

class JobInformationPage extends StatelessWidget {
  final String? title;
  final String? companyName;
  final String? companyLogo;
  final String? publishedAt;
  final String? jobType;
  final String? location;
  final String? salary;
  final String? content;
  final String? url;

  const JobInformationPage({
    Key? key,
    this.title,
    this.companyName,
    this.companyLogo,
    this.publishedAt,
    this.jobType,
    this.location,
    this.salary,
    this.content,
    this.url,
  }) : super(key: key);

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: mediaQuery.size.height * 0.12,
              child: Row(
                children: [
                  Card(
                    margin: const EdgeInsets.all(14),
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        companyLogo!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: mediaQuery.size.height * 0.022,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(height: 8),
                        Text(
                          companyName!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: mediaQuery.size.height * 0.02),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'Published At: $publishedAt',
                style: TextStyle(
                  fontSize: mediaQuery.size.height * 0.018,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Text(
                jobType!,
                style: TextStyle(
                  fontSize: mediaQuery.size.height * 0.018,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Text(
                location!,
                style: TextStyle(
                  fontSize: mediaQuery.size.height * 0.018,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Text(
                salary == '' ? 'Salary: unknown' : 'Salary: $salary',
                style: TextStyle(
                  fontSize: mediaQuery.size.height * 0.018,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: ElevatedButton(
                  onPressed: () {
                    launch(url!);
                  },
                  child: const Text('Apply')),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Text(
                _parseHtmlString(content!),
                style: TextStyle(
                  fontSize: mediaQuery.size.height * 0.018,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
