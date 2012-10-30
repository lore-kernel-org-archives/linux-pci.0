Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:42537 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866Ab2J3G1U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Oct 2012 02:27:20 -0400
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 966CD3EE0BC
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:27:19 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7E7AB45DE50
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:27:19 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 66B4545DE4E
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:27:19 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5A21D1DB802F
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:27:19 +0900 (JST)
Received: from m005.s.css.fujitsu.com (m005.s.css.fujitsu.com [10.23.4.35])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 195251DB8037
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:27:19 +0900 (JST)
Date: Tue, 30 Oct 2012 15:27:13 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 5/5] PCI,ACPI: Requesting _OSC control before scanning pci
 tree in acpi_pci_root_add()
Message-Id: <20121030152713.d33086da.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20121030062124.BE34D2E0805@m003.s.css.fujitsu.com>
References: <20121030062124.BE34D2E0805@m003.s.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Requesting _OSC control before scanning pci tree in acpi_pci_root_add()

This patch moves up the code block to request _OSC control in order to 
separate ACPI work and PCI work in acpi_pci_root_add().

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |  121 ++++++++++++++++++++++++------------------------
 1 file changed, 62 insertions(+), 59 deletions(-)

Index: pci/drivers/acpi/pci_root.c
===================================================================
--- pci.orig/drivers/acpi/pci_root.c
+++ pci/drivers/acpi/pci_root.c
@@ -454,6 +454,7 @@ static int __devinit acpi_pci_root_add(s
 	acpi_handle handle;
 	struct acpi_device *child;
 	u32 flags, base_flags;
+	bool is_osc_granted = false;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
@@ -520,6 +521,60 @@ static int __devinit acpi_pci_root_add(s
 	flags = base_flags = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
 	acpi_pci_osc_support(root, flags);
 
+	/* Indicate support for various _OSC capabilities. */
+	if (pci_ext_cfg_avail())
+		flags |= OSC_EXT_PCI_CONFIG_SUPPORT;
+	if (pcie_aspm_support_enabled()) {
+		flags |= OSC_ACTIVE_STATE_PWR_SUPPORT |
+		OSC_CLOCK_PWR_CAPABILITY_SUPPORT;
+	}
+	if (pci_msi_enabled())
+		flags |= OSC_MSI_SUPPORT;
+	if (flags != base_flags) {
+		status = acpi_pci_osc_support(root, flags);
+		if (ACPI_FAILURE(status)) {
+			dev_info(&device->dev, "ACPI _OSC support "
+				"notification failed, disabling PCIe ASPM\n");
+			pcie_no_aspm();
+			flags = base_flags;
+		}
+	}
+	if (!pcie_ports_disabled
+	    && (flags & ACPI_PCIE_REQ_SUPPORT) == ACPI_PCIE_REQ_SUPPORT) {
+		flags = OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL
+			| OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
+			| OSC_PCI_EXPRESS_PME_CONTROL;
+
+		if (pci_aer_available()) {
+			if (aer_acpi_firmware_first())
+				dev_dbg(&device->dev,
+					"PCIe errors handled by BIOS.\n");
+			else
+				flags |= OSC_PCI_EXPRESS_AER_CONTROL;
+		}
+
+		dev_info(&device->dev,
+			"Requesting ACPI _OSC control (0x%02x)\n", flags);
+
+		status = acpi_pci_osc_control_set(device->handle, &flags,
+				       OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
+		if (ACPI_SUCCESS(status)) {
+			is_osc_granted = true;
+			dev_info(&device->dev,
+				"ACPI _OSC control (0x%02x) granted\n", flags);
+		} else {
+			is_osc_granted = false;
+			dev_info(&device->dev,
+				"ACPI _OSC request failed (%s), "
+				"returned control mask: 0x%02x\n",
+				acpi_format_exception(status), flags);
+		}
+	} else {
+		dev_info(&device->dev,
+			"Unable to request _OSC control "
+			"(_OSC support mask: 0x%02x)\n", flags);
+	}
+
 	/*
 	 * TBD: Need PCI interface for enumeration/configuration of roots.
 	 */
@@ -563,66 +618,14 @@ static int __devinit acpi_pci_root_add(s
 	list_for_each_entry(child, &device->children, node)
 		acpi_pci_bridge_scan(child);
 
-	/* Indicate support for various _OSC capabilities. */
-	if (pci_ext_cfg_avail())
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
+	/* ASPM setting */
+	if (is_osc_granted) {
+		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM)
+			pcie_clear_aspm(root->bus);
 	} else {
-		dev_info(root->bus->bridge,
-			 "Unable to request _OSC control "
-			 "(_OSC support mask: 0x%02x)\n", flags);
+		pr_info("ACPI _OSC control for PCIe not granted, "
+			"disabling ASPM\n");
+		pcie_no_aspm();
 	}
 
 	pci_acpi_add_bus_pm_notifier(device, root->bus);

