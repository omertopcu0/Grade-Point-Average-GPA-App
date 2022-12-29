import 'package:flutter/material.dart';
import 'package:notortalama/constants/app_constants.dart';
import 'package:notortalama/helper/data_helper.dart';

class KrediDropdownWidget extends StatefulWidget {
  const KrediDropdownWidget({super.key, required this.onKrediSecildi});
  final Function onKrediSecildi;

  @override
  State<KrediDropdownWidget> createState() => _KrediDropdownWidgetState();
}

class _KrediDropdownWidgetState extends State<KrediDropdownWidget> {
  @override
  double secilenKrediDegeri = 5;
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: Sabitler.anaRenk.shade100.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16)),
        child: DropdownButton<double>(
          value: secilenKrediDegeri,
          elevation: 16,
          iconEnabledColor: Sabitler.anaRenk.shade200,
          onChanged: (deger) {
            setState(() {
              secilenKrediDegeri = deger!;
              widget.onKrediSecildi(secilenKrediDegeri);
              print(deger);
            });
          },
          underline: Container(),
          items: DataHelper.tumDerslerinKredileri(),
        ));
  }
}
