import 'dart:async';
import 'dart:html';
import "dart:typed_data";

import "package:archive/archive.dart";

import "../formats/BundleManifest.dart";
import "../formats/Formats.dart";
import "../includes/path_utils.dart";
import "resource.dart";

export "resource.dart";

abstract class Loader {
    static bool _initialised = false;
    static BundleManifest manifest;
    static Map<String, Resource<dynamic>> _resources = <String, Resource<dynamic>>{};
    static RegExp _slash = new RegExp("[\\/]");

    static void init() {
        if (_initialised) { return; }
        _initialised = true;

        Formats.init();
    }

    static Future<Null> preloadManifest() async {
        init();
        manifest = await Loader.getResource("manifest/manifest.txt", format: Formats.manifest, bypassManifest: true);
        //print("preloaded a manifest, its ${manifest.runtimeType} and $manifest");
    }

    static Future<T> getResource<T>(String path, {FileFormat<T, dynamic> format, bool bypassManifest = false, bool absoluteRoot = false}) async {
        init();
        if (_resources.containsKey(path)) {
            Resource<dynamic> res = _resources[path];
            if (res is Resource<T>) {
                if (res.object != null) {
                    return res.object;
                } else {
                    return res.addListener();
                }
            } else {
                throw "Requested resource ($path) is an unexpected type: ${res.object.runtimeType}.";
            }
        } else {
            if (!bypassManifest) {
                if (manifest == null) {
                    manifest = await Loader.getResource("manifest/manifest.txt", format: Formats.manifest, bypassManifest: true);
                }

                String bundle = manifest.getBundleForFile(path);

                if (bundle != null) {
                    _loadBundle(bundle);
                    return _createResource(path).addListener();
                }
            }
            return _load(path, format: format, absoluteRoot: absoluteRoot);
        }
    }

    static Resource<T> _createResource<T>(String path) {
        if (!_resources.containsKey(path)) {
            _resources[path] = new Resource<T>(path);
        }
        return _resources[path];
    }

    static Future<T> _load<T>(String path, {FileFormat<T, dynamic> format = null, bool absoluteRoot = false}) {
        if(_resources.containsKey(path)) {
            throw "Resource $path has already been requested for loading";
        }

        if (format == null) {
            String extension = path.split(".").last;
            format = Formats.getFormatForExtension(extension);
        }

        Resource<T> res = _createResource(path);

        format.requestObjectFromUrl(_getFullPath(path, absoluteRoot))..then((T item) => res.populate(item));

        return res.addListener();
    }

    static Future<bool> _loadBundle(String path) async {
        Archive bundle = await Loader.getResource("$path.bundle", bypassManifest: true);

        String dir = path.substring(0, path.lastIndexOf(_slash));

        for (ArchiveFile file in bundle.files) {
            String extension = file.name.split(".").last;
            FileFormat<dynamic, dynamic> format = Formats.getFormatForExtension(extension);

            String fullname = "$dir/${file.name}";

            Resource<dynamic> res = _createResource(fullname);

            Uint8List data = file.content as Uint8List;

            format.read(await format.fromBytes(data.buffer)).then(res.populate);
        }

        return true;
    }

    // JS loading extra special dom stuff

    static Map<String, ScriptElement> _loadedScripts = <String, ScriptElement>{};

    static Future<ScriptElement> loadJavaScript(String path, [bool absoluteRoot = false]) async {
        if (_loadedScripts.containsKey(path)) {
            return _loadedScripts[path];
        }
        Completer<ScriptElement> completer = new Completer<ScriptElement>();

        ScriptElement script = new ScriptElement();
        document.head.append(script);
        script.onLoad.listen((Event e) => completer.complete(script));
        script.src = _getFullPath(path, absoluteRoot);

        return completer.future;
    }

    //jr is testing
    static String _getFullPath(String path, [bool absoluteRoot = false]) {
        // treat leading slashes as absolute root anyway
        if (path.startsWith("/")) {
            absoluteRoot = true;
            path = path.substring(1);
        }

        if (absoluteRoot) {
            String abspath = "${window.location.protocol}//${window.location.host}/$path";
            return abspath;
        }
        return PathUtils.adjusted(path);
    }
}

class Asset<T> {
    T item;
    String path;

    Asset(String this.path);
    Asset.direct(T this.item);

    Future<T> getAsset() async {
        if (this.item != null) {
            return this.item;
        }
        else if (this.path != null) {
            return await Loader.getResource(this.path);
        }
        return null;
    }
}