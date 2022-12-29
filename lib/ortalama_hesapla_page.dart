import 'package:flutter/material.dart';
import 'package:notortalama/constants/app_constants.dart';
import 'package:notortalama/ders_listesi.dart';
import 'package:notortalama/harf_dropdown_widget.dart';
import 'package:notortalama/helper/data_helper.dart';
import 'package:notortalama/kredi_dropdown_widget.dart';
import 'package:notortalama/model/ders.dart';

import 'package:notortalama/ortalama_goster.dart';

class OrtalamaHesaplamaPage extends StatefulWidget {
  const OrtalamaHesaplamaPage({super.key});

  @override
  State<OrtalamaHesaplamaPage> createState() => _OrtalamaHesaplamaPageState();
}

class _OrtalamaHesaplamaPageState extends State<OrtalamaHesaplamaPage> {
  var formKey = GlobalKey<FormState>();
  double secilenDeger = 4;
  double secilenKrediDegeri = 5;
  String girilendersadi = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            Sabitler.baslikText,
            style: Sabitler.baslikStyle,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //!FormField
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildForm(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: OrtalamaGoster(
                      ortalama: DataHelper.ortalamaHesapla(),
                      dersSayisi: DataHelper.tumeklenenDersler.length),
                  color: Colors.yellow,
                ),
              ),
            ],
          ),

          //!Listeler
          Expanded(
            child: DersListesi(
              onDismiss: (index) {
                DataHelper.tumeklenenDersler.removeAt(index);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: _buildTextFormField(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: HarfDropDownWidget(
                    onHarfSecildi: (harf) {
                      secilenDeger = harf;
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: KrediDropdownWidget(onKrediSecildi: (kredi) {
                    secilenKrediDegeri = kredi;
                  }),
                ),
              ),
              IconButton(
                onPressed: _dersEkleVeOrtalamaHesapla,
                icon: Icon(Icons.arrow_forward_ios_sharp),
                color: Sabitler.anaRenk,
                iconSize: 30,
              ),
            ],
          ),
          SizedBox(
            height: 7,
          )
        ],
      ),
    );
  }

  _buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Matematik",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.2),
      ),
      onSaved: (deger) {
        setState(() {
          girilendersadi = deger!;
        });
      },
      validator: (value) {
        if (value!.length <= 0) {
          return "Ders adını giriniz";
        } else {
          return null;
        }
      },
    );
  }

  _dersEkleVeOrtalamaHesapla() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDers = Ders(
          ad: girilendersadi,
          harfDegeri: secilenDeger,
          krediDegeri: secilenKrediDegeri);
      DataHelper.derEkle(eklenecekDers);
      print(DataHelper.ortalamaHesapla());
      setState(() {});
    }
  }
}
