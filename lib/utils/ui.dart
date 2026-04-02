import 'package:flutter/material.dart';
import 'package:messenger/utils/db.dart';
import 'package:signals/signals_core.dart' as core;
import 'package:signals/signals_flutter.dart';

abstract class UI<T extends Widget> extends StatefulWidget {
  const UI({super.key});

  T render(BuildContext context);

  /// Optional debug label to use for devtools
  String? get debugLabel => null;

  /// List of optional dependencies to watch
  List<core.ReadonlySignal<dynamic>> get dependencies => const [];

  @override
  State<UI<T>> createState() => _WatchState<T>();

  void init(BuildContext context) {}
  void dispose() {}
}

class _WatchState<T extends Widget> extends State<UI<T>> with SignalsMixin {
  late final result = createComputed(
    () {
      return widget.render(context);
    },
    debugLabel: widget.debugLabel,
  );
  bool _init = true;

  @override
  void initState() {
    super.initState();
    for (final dep in widget.dependencies) {
      bindSignal(dep);
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    final target = core.SignalsObserver.instance;
    if (target is core.DevToolsSignalsObserver) {
      target.reassemble();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      result.recompute();
      if (mounted) setState(() {});
      result.value;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      // Called on first build (we do not need to rebuild yet)
      _init = false;
      widget.init(context);
      return;
    }
    result.recompute();
  }

  @override
  void didUpdateWidget(covariant UI<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dependencies != widget.dependencies) {
      for (final dep in oldWidget.dependencies) {
        final idx = widget.dependencies.indexOf(dep);
        if (idx == -1) unbindSignal(dep);
      }
      for (final dep in widget.dependencies) {
        bindSignal(dep);
      }
    } else if (oldWidget.render != widget.render) {
      result.recompute();
    }
  }

  @override
  Widget build(BuildContext context) {
    return result.value;
  }

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }
}

abstract class AppUI extends UI {
  const AppUI({super.key});

  @override
  Widget render(BuildContext context) {
    if (preferencesSignal() != null && hiveSignal() != null)
      return build(context);
    return const Center(child: CircularProgressIndicator());
  }

  @override
  String? get debugLabel => '$runtimeType';

  Widget build(BuildContext context);
}
