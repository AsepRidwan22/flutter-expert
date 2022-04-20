import 'package:proyek_awal/data/datasources/db/database_helper.dart';
import 'package:proyek_awal/data/datasources/data_source/tv_local_data_source.dart';
import 'package:proyek_awal/data/datasources/data_source/tv_remote_data_source.dart';
import 'package:proyek_awal/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
