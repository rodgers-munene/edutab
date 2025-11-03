import 'package:flutter/foundation.dart';
import '../models/material_model.dart';
import '../services/material_service.dart';

class MaterialProvider extends ChangeNotifier {
  final MaterialService _materialService = MaterialService();

  List<MaterialModel> _materials = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<MaterialModel> get materials => _materials;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  // Fetch materials
  Future<void> fetchMaterials() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _materials = await _materialService.fetchAll();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Listen to materials in real-time
  void listenToMaterials() {
    _materialService.streamMaterials().listen(
      (materials) {
        _materials = materials;
        _errorMessage = null;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }

  // Add a material
  Future<void> addMaterial(MaterialModel material) async {
    try {
      await _materialService.add(material);
      await fetchMaterials();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Update a material
  Future<void> updateMaterial(MaterialModel material) async {
    try {
      await _materialService.update(material);
      await fetchMaterials();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Delete a material
  Future<void> deleteMaterial(String id) async {
    try {
      await _materialService.delete(id);
      await fetchMaterials();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Get materials by subject
  Future<List<MaterialModel>> getMaterialsBySubject(String subject) async {
    try {
      return await _materialService.fetchBySubject(subject);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return [];
    }
  }

  // Get materials by type
  Future<List<MaterialModel>> getMaterialsByType(String type) async {
    try {
      return await _materialService.fetchByType(type);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return [];
    }
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}