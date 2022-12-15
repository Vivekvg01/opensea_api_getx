import 'package:api_getx/controller/opensea_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OpenseaController _openSeaController = Get.put(OpenseaController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Cryptopunks'),
      ),
      body: Obx(
        () => _openSeaController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: _openSeaController
                                .openseaModel?.assets![index].imageUrl ==
                            null
                        ? const Icon(Icons.image)
                        : Image.network(
                            _openSeaController
                                .openseaModel!.assets![index].imageUrl!,
                          ),
                    title: Text(
                      _openSeaController.openseaModel?.assets![index].name ??
                          "No name",
                    ),
                    subtitle: Text(
                      _openSeaController
                              .openseaModel?.assets![index].description ??
                          'no description',
                    ),
                    onTap: () {
                      _launchInBrowser(
                        Uri.parse(_openSeaController
                            .openseaModel!.assets![index].permalink!),
                      );
                    },
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: _openSeaController.openseaModel?.assets?.length ?? 0,
              ),
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not lauch $url';
    }
  }
}
