import 'package:flutter/material.dart';
import 'package:notortalama/helper/data_helper.dart';

import 'constants/app_constants.dart';

class HarfDropDownWidget extends StatefulWidget {
  const HarfDropDownWidget({super.key, required this.onHarfSecildi});
  final Function onHarfSecildi;

  @override
  State<HarfDropDownWidget> createState() => _HarfDropDownWidgetState();
}

class _HarfDropDownWidgetState extends State<HarfDropDownWidget> {
  double secilenDeger = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: Sabitler.anaRenk.shade100.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16)),
        child: DropdownButton<double>(
          value: secilenDeger,
          elevation: 16,
          iconEnabledColor: Sabitler.anaRenk.shade200,
          onChanged: (deger) {
            setState(() {
              secilenDeger = deger!;
              widget.onHarfSecildi(secilenDeger);
            });
          },
          underline: Container(),
          items: DataHelper.tumDerslerinHarfleri(),
        ));
  }
}
