import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:tomato_market/constants/common_size.dart';
import 'package:tomato_market/data/address_model.dart';
import 'package:tomato_market/screens/start/address_service.dart';
import 'package:tomato_market/utils/logger.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _addressController = TextEditingController();

  AddressModel? _addressModel = AddressModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum:
          const EdgeInsets.only(left: common_padding, right: common_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _addressController,
            onFieldSubmitted: (text) async {
              _addressModel = await AddressService().searchAddressByStr(text);
              setState(() {});
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                hintText: '도로명으로 검색',
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 24, maxHeight: 24)),
          ),
          TextButton.icon(
            label: Text(
              '현재 위치 찾기',
              style: Theme.of(context).textTheme.button,
            ),
            icon: const Icon(
              CupertinoIcons.compass,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () async {
              Location location = new Location();

              bool _serviceEnabled;
              PermissionStatus _permissionGranted;
              LocationData _locationData;

              _serviceEnabled = await location.serviceEnabled();
              if (!_serviceEnabled) {
                _serviceEnabled = await location.requestService();
                if (!_serviceEnabled) {
                  return;
                }
              }

              _permissionGranted = await location.hasPermission();
              if (_permissionGranted == PermissionStatus.denied) {
                _permissionGranted = await location.requestPermission();
                if (_permissionGranted != PermissionStatus.granted) {
                  return;
                }
              }

              _locationData = await location.getLocation();
              logger.d(_locationData);
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: common_padding),
              itemBuilder: (BuildContext context, int index) {
                if (_addressModel == null ||
                    _addressModel!.result == null ||
                    _addressModel!.result!.items == null ||
                    _addressModel!.result!.items![index].address == null) {
                  return Container();
                } else {
                  return ListTile(
                    // leading: ExtendedImage.asset(
                    //   'assets/imgs/tomato_logo.png',
                    // ),
                    title: Text(
                        _addressModel!.result!.items![index].address!.road ??
                            ""),
                    subtitle: Text(
                        _addressModel!.result!.items![index].address!.parcel ??
                            ""),
                  );
                }
              },
              itemCount: (_addressModel == null ||
                      _addressModel!.result == null ||
                      _addressModel!.result!.items == null)
                  ? 0
                  : _addressModel!.result!.items!.length,
            ),
          )
        ],
      ),
    );
  }
}
