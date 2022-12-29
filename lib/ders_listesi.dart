import 'package:flutter/material.dart';
import 'package:notortalama/constants/app_constants.dart';
import 'package:notortalama/helper/data_helper.dart';

import 'model/ders.dart';

class DersListesi extends StatelessWidget {
  const DersListesi({required this.onDismiss, super.key});
  final Function onDismiss;

  @override
  Widget build(BuildContext context) {
    List<Ders> tumDersler = DataHelper.tumeklenenDersler;
    return tumDersler.length > 0
        ? ListView.builder(
            itemCount: tumDersler.length,
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.startToEnd,
                key: UniqueKey(),
                onDismissed: (a) {
                  onDismiss(index);
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Card(
                    child: ListTile(
                      title: Text(tumDersler[index].ad),
                      leading: CircleAvatar(
                        backgroundColor: Sabitler.anaRenk,
                        child: Text((tumDersler[index].harfDegeri *
                                tumDersler[index].krediDegeri)
                            .toStringAsFixed(0)),
                      ),
                      subtitle: Text(
                          '${tumDersler[index].krediDegeri} Kredi, Not Değeri ${tumDersler[index].harfDegeri}'),
                    ),
                  ),
                ),
              );
            })
        : Container(
            alignment: Alignment.center,
            child: Text(
              "Lütfen Ders Ekleyiniz",
              style: Sabitler.baslikStyle,
            ),
          );
  }
}
