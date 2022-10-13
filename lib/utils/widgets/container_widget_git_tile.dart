import 'package:flutter/material.dart';
import 'package:jake_wharton_github/utils/widgets/icon_widget.dart';

class ContainerGitTile extends StatelessWidget {
  final String title;
  final String desc;
  final String language;
  final String bugs;
  final String commit;

  const ContainerGitTile(
      {Key? key,
      required this.title,
      required this.desc,
      required this.language,
      required this.bugs,
      required this.commit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Icon(
              Icons.book,
              color: Colors.black,
              size: 50,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, bottom: 5, right: 10),
                  child: Text(
                    desc,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.code,
                      color: Colors.black,
                      size: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 10.0),
                      child: Text(
                        language,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Icon(
                      Icons.bug_report,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 10.0),
                      child: Text(
                        bugs,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Icon(
                      Icons.face,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 8.0),
                      child: Text(
                        commit,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
