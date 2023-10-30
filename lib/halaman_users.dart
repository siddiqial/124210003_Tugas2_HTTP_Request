import 'package:flutter/material.dart';
import 'package:httprequest/api_datasource.dart';
import 'package:httprequest/halaman_detail.dart';
import 'users_model.dart';


class HalamanUsers extends StatelessWidget {
  const HalamanUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ('List Users'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
          future: ApiDataSource.instance.loadUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError){
              return Text('ERROR');
            }
            if (snapshot.hasData) {
              UsersModel users = UsersModel.fromJson(snapshot.data!);
              return ListView.builder(
                itemCount: users.data!.length,
                itemBuilder: (context, index) {
                  var user= users.data![index];
                  return ListTile(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HalamanDetail(id: user.id!))
                      );
                    },
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(user.avatar!),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text('${user.email}'),
                  );
                }
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
      ),
    );
  }
}
