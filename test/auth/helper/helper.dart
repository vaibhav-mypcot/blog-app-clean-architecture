import 'package:mockito/annotations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@GenerateNiceMocks([
  MockSpec<SupabaseClient>(),
  MockSpec<SupabaseQueryBuilder>(),
  MockSpec<PostgrestFilterBuilder<List<Map<String, dynamic>>>>(),
  MockSpec<PostgrestResponse<List<Map<String, dynamic>>>>()
])
void main() {}
