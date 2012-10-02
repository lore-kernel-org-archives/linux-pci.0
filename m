Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:21987 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab2JBGdK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 02:33:10 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 05/10] PCI, ACPI: Separate out acpi_pci_root_osc_contorl_set
Date: Mon,  1 Oct 2012 23:33:03 -0700
Message-Id: <1349159588-15029-6-git-send-email-yinghai@kernel.org>
In-Reply-To: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

acpi_pci_root_add is too big now. We could move out root osc related code
out of it.

Only code moving.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/acpi/pci_root.c |  136 +++++++++++++++++++++++++----------------------
 1 files changed, 73 insertions(+), 63 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 085fccf..75643ce 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -430,6 +430,76 @@ out:
 }
 EXPORT_SYMBOL(acpi_pci_osc_control_set);
 
+static void acpi_pci_root_osc_control_set(struct acpi_pci_root *root)
+{
+	u32 flags, base_flags;
+	acpi_status status;
+
+	flags = base_flags = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
+
+	/* Indicate support for various _OSC capabilities. */
+	if (pci_ext_cfg_avail(root->bus->self))
+		flags |= OSC_EXT_PCI_CONFIG_SUPPORT;
+	if (pcie_aspm_support_enabled())
+		flags |= OSC_ACTIVE_STATE_PWR_SUPPORT |
+			OSC_CLOCK_PWR_CAPABILITY_SUPPORT;
+	if (pci_msi_enabled())
+		flags |= OSC_MSI_SUPPORT;
+	if (flags != base_flags) {
+		status = acpi_pci_osc_support(root, flags);
+		if (ACPI_FAILURE(status)) {
+			dev_info(root->bus->bridge, "ACPI _OSC support "
+				"notification failed, disabling PCIe ASPM\n");
+			pcie_no_aspm();
+			flags = base_flags;
+		}
+	}
+
+	if (!pcie_ports_disabled
+	    && (flags & ACPI_PCIE_REQ_SUPPORT) == ACPI_PCIE_REQ_SUPPORT) {
+		flags = OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL
+			| OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
+			| OSC_PCI_EXPRESS_PME_CONTROL;
+
+		if (pci_aer_available()) {
+			if (aer_acpi_firmware_first())
+				dev_dbg(root->bus->bridge,
+					"PCIe errors handled by BIOS.\n");
+			else
+				flags |= OSC_PCI_EXPRESS_AER_CONTROL;
+		}
+
+		dev_info(root->bus->bridge,
+			"Requesting ACPI _OSC control (0x%02x)\n", flags);
+
+		status = acpi_pci_osc_control_set(root->device->handle, &flags,
+					OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
+		if (ACPI_SUCCESS(status)) {
+			dev_info(root->bus->bridge,
+				"ACPI _OSC control (0x%02x) granted\n", flags);
+			if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
+				/*
+				 * We have ASPM control, but the FADT indicates
+				 * that it's unsupported. Clear it.
+				 */
+				pcie_clear_aspm(root->bus);
+			}
+		} else {
+			dev_info(root->bus->bridge,
+				"ACPI _OSC request failed (%s), "
+				"returned control mask: 0x%02x\n",
+				acpi_format_exception(status), flags);
+			pr_info("ACPI _OSC control for PCIe not granted, "
+				"disabling ASPM\n");
+			pcie_no_aspm();
+		}
+	} else {
+		dev_info(root->bus->bridge,
+			 "Unable to request _OSC control "
+			 "(_OSC support mask: 0x%02x)\n", flags);
+	}
+}
+
 static int __devinit acpi_pci_root_add(struct acpi_device *device)
 {
 	unsigned long long segment, bus;
@@ -437,7 +507,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	int result;
 	struct acpi_pci_root *root;
 	acpi_handle handle;
-	u32 flags, base_flags;
+	u32 flags;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
@@ -491,7 +561,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	 * All supported architectures that use ACPI have support for
 	 * PCI domains, so we indicate this in _OSC support capabilities.
 	 */
-	flags = base_flags = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
+	flags = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
 	acpi_pci_osc_support(root, flags);
 
 	/*
@@ -531,67 +601,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	if (ACPI_SUCCESS(status))
 		result = acpi_pci_irq_add_prt(device->handle, root->bus);
 
-	/* Indicate support for various _OSC capabilities. */
-	if (pci_ext_cfg_avail(root->bus->self))
-		flags |= OSC_EXT_PCI_CONFIG_SUPPORT;
-	if (pcie_aspm_support_enabled())
-		flags |= OSC_ACTIVE_STATE_PWR_SUPPORT |
-			OSC_CLOCK_PWR_CAPABILITY_SUPPORT;
-	if (pci_msi_enabled())
-		flags |= OSC_MSI_SUPPORT;
-	if (flags != base_flags) {
-		status = acpi_pci_osc_support(root, flags);
-		if (ACPI_FAILURE(status)) {
-			dev_info(root->bus->bridge, "ACPI _OSC support "
-				"notification failed, disabling PCIe ASPM\n");
-			pcie_no_aspm();
-			flags = base_flags;
-		}
-	}
-
-	if (!pcie_ports_disabled
-	    && (flags & ACPI_PCIE_REQ_SUPPORT) == ACPI_PCIE_REQ_SUPPORT) {
-		flags = OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL
-			| OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
-			| OSC_PCI_EXPRESS_PME_CONTROL;
-
-		if (pci_aer_available()) {
-			if (aer_acpi_firmware_first())
-				dev_dbg(root->bus->bridge,
-					"PCIe errors handled by BIOS.\n");
-			else
-				flags |= OSC_PCI_EXPRESS_AER_CONTROL;
-		}
-
-		dev_info(root->bus->bridge,
-			"Requesting ACPI _OSC control (0x%02x)\n", flags);
-
-		status = acpi_pci_osc_control_set(device->handle, &flags,
-					OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
-		if (ACPI_SUCCESS(status)) {
-			dev_info(root->bus->bridge,
-				"ACPI _OSC control (0x%02x) granted\n", flags);
-			if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
-				/*
-				 * We have ASPM control, but the FADT indicates
-				 * that it's unsupported. Clear it.
-				 */
-				pcie_clear_aspm(root->bus);
-			}
-		} else {
-			dev_info(root->bus->bridge,
-				"ACPI _OSC request failed (%s), "
-				"returned control mask: 0x%02x\n",
-				acpi_format_exception(status), flags);
-			pr_info("ACPI _OSC control for PCIe not granted, "
-				"disabling ASPM\n");
-			pcie_no_aspm();
-		}
-	} else {
-		dev_info(root->bus->bridge,
-			 "Unable to request _OSC control "
-			 "(_OSC support mask: 0x%02x)\n", flags);
-	}
+	acpi_pci_root_osc_control_set(root);
 
 	pci_acpi_add_bus_pm_notifier(device, root->bus);
 	if (device->wakeup.flags.run_wake)
-- 
1.7.7

