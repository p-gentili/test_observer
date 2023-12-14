import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import '../../models/artefact.dart';
import '../../providers/artefact_builds.dart';
import 'artefact_build_expandable.dart';

class ArtefactDialogBody extends ConsumerWidget {
  const ArtefactDialogBody({super.key, required this.artefact});

  final Artefact artefact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artefactBuilds = ref.watch(artefactBuildsProvider(artefact.id));

    return artefactBuilds.when(
      data: (artefactBuilds) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Environments', style: Theme.of(context).textTheme.titleLarge),
          Expanded(
            child: ListView.builder(
              itemCount: artefactBuilds.length,
              itemBuilder: (_, i) =>
                  ArtefactBuildExpandable(artefactBuild: artefactBuilds[i]),
            ),
          ),
        ],
      ),
      loading: () => const Center(child: YaruCircularProgressIndicator()),
      error: (error, stackTrace) {
        return Center(child: Text('Error: $error'));
      },
    );
  }
}
