import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import '../utils/colors.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> options;
  final String? selected;
  final Function(String) onSelect;
  final String placeholder;
  final IconData icon;
  final bool enabled;

  const CustomDropdown({
    super.key,
    required this.options,
    this.selected,
    required this.onSelect,
    required this.placeholder,
    required this.icon,
    this.enabled = true,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: widget.enabled ? () => setState(() => _isOpen = !_isOpen) : null,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  size: 16,
                  color: Colors.white.withOpacity(0.8),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.selected ?? widget.placeholder,
                    style: TextStyle(
                      color: widget.selected != null
                          ? Colors.white
                          : Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ),
                Icon(
                  LucideIcons.chevronDown,
                  size: 16,
                  color: Colors.white.withOpacity(0.7),
                ),
              ],
            ),
          ),
        ),
        if (_isOpen && widget.enabled)
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 200),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.options.length,
                  itemBuilder: (context, index) {
                    final option = widget.options[index];
                    return InkWell(
                      onTap: () {
                        widget.onSelect(option);
                        setState(() => _isOpen = false);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: index < widget.options.length - 1
                                  ? AppColors.borderGrey
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        child: Text(
                          option,
                          style: const TextStyle(
                            color: AppColors.textDark,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}

