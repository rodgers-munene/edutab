import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/material_model.dart';

class MaterialService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'materials';

  // Fetch all materials
  Future<List<MaterialModel>> fetchAll() async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .orderBy('uploadedAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => MaterialModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch materials: $e');
    }
  }

  // Listen to materials in real-time
  Stream<List<MaterialModel>> streamMaterials() {
    return _firestore
        .collection(_collection)
        .orderBy('uploadedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MaterialModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Add a new material
  Future<void> add(MaterialModel material) async {
    try {
      await _firestore.collection(_collection).add(material.toMap());
    } catch (e) {
      throw Exception('Failed to add material: $e');
    }
  }

  // Update a material
  Future<void> update(MaterialModel material) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(material.id)
          .update(material.toMap());
    } catch (e) {
      throw Exception('Failed to update material: $e');
    }
  }

  // Delete a material
  Future<void> delete(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete material: $e');
    }
  }

  // Fetch materials by subject
  Future<List<MaterialModel>> fetchBySubject(String subject) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('subject', isEqualTo: subject)
          .orderBy('uploadedAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => MaterialModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch materials by subject: $e');
    }
  }

  // Fetch materials by type
  Future<List<MaterialModel>> fetchByType(String type) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('type', isEqualTo: type)
          .orderBy('uploadedAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => MaterialModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch materials by type: $e');
    }
  }
}