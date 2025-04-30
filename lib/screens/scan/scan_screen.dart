import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../services/material_service.dart';
import '../../models/material.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isScanning = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String code = barcodes.first.rawValue ?? '';
      _handleScannedCode(code);
    }
  }

  void _handleScannedCode(String code) {
    final materialService = Provider.of<MaterialService>(context, listen: false);
    final material = materialService.materials.firstWhere(
      (m) => m.id == code,
      orElse: () => throw Exception('Material not found'),
    );

    setState(() => _isScanning = false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(material.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${material.description}'),
            Text('Quantity: ${material.quantity} ${material.unit}'),
            Text('Unit Cost: \$${material.unitCost.toStringAsFixed(2)}'),
            Text('Raw Material Cost: \$${material.rawMaterialCost.toStringAsFixed(2)}'),
            if (material.additionalProcessingCost != null)
              Text('Processing Cost: \$${material.additionalProcessingCost!.toStringAsFixed(2)}'),
            Text('Manufacturing Cost: \$${material.manufacturingCost.toStringAsFixed(2)}'),
            if (material.desiredMargin != null) ...[
              Text('Desired Margin: ${material.desiredMargin!.toStringAsFixed(2)}%'),
              Text('Final Price: \$${material.finalProductPrice.toStringAsFixed(2)}'),
              Text('Profit Margin: ${material.profitMargin!.toStringAsFixed(2)}%'),
              Text('Suggested Price/Unit: \$${material.suggestedSellingPricePerUnit.toStringAsFixed(2)}'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _isScanning = true);
            },
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _isScanning = true);
              // TODO: Implement material consumption logging
            },
            child: const Text('Log Consumption'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Material'),
      ),
      body: _isScanning
          ? MobileScanner(
              controller: _controller,
              onDetect: _onDetect,
            )
          : const Center(
              child: Text('Scanning paused'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => _isScanning = !_isScanning);
        },
        child: Icon(_isScanning ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
} 