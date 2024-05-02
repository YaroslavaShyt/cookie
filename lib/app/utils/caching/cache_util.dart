import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

const kReelCacheKey = "dishesVideosCacheKey";

class CacheUtil {
  final CacheManager kCacheManager = CacheManager(
    Config(
      kReelCacheKey,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
      repo: JsonCacheInfoRepository(databaseName: kReelCacheKey),
      fileService: HttpFileService(),
    ),
  );

  Future<void> cacheVideos({required List<String> videoUrls}) async {
    for (String url in videoUrls) {
      FileInfo? fileInfo = await kCacheManager.getFileFromCache(url);
      if (fileInfo == null) {
        debugPrint("-------chaching");
        await kCacheManager.downloadFile(url);
        debugPrint("-------chached");
      }
    }
  }

  Future<FileInfo?> getFileFromCache({required String key}) async {
    FileInfo? fileInfo = await kCacheManager.getFileFromCache(key);
    if(fileInfo == null){
      await downloadFile(url: key);
      fileInfo = await kCacheManager.getFileFromCache(key);
    }
    return fileInfo;
  }

  Future<void> downloadFile({required String url}) async {
    await kCacheManager.downloadFile(url);
  }
}
