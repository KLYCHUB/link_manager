import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'link.dart';

class StorageService {
  static const String _linksKey = 'links';

  Future<List<Link>> getLinks() async {
    final prefs = await SharedPreferences.getInstance();
    final linksJson = prefs.getStringList(_linksKey) ?? [];
    return linksJson.map((json) => Link.fromJson(jsonDecode(json))).toList();
  }

  Future<void> saveLinks(List<Link> links) async {
    final prefs = await SharedPreferences.getInstance();
    final linksJson = links.map((link) => jsonEncode(link.toJson())).toList();
    await prefs.setStringList(_linksKey, linksJson);
  }
}