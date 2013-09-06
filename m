Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:64504 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab3IFROj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 13:14:39 -0400
Received: by mail-yh0-f52.google.com with SMTP id v1so1341505yhn.11
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2013 10:14:39 -0700 (PDT)
Subject: [PATCH 09/14] PCI/ACPI: Split _OSC "support" and "control" flags
 into separate variables
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Date: Fri, 06 Sep 2013 11:14:36 -0600
Message-ID: <20130906171436.11482.21353.stgit@bhelgaas-glaptop>
In-Reply-To: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
References: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously we used "flags" for both:

  - the bitmask of features we support (segments, ASPM, MSI, etc.), and
  - the bitmask of features we want to control (native hotplug, AER, etc.)

To reduce confusion, this patch splits this into two variables:
"support" is the bitmask of features we support, and "control" is the
bitmask of features we want to control.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c |   35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 3e57f10..3e06d4e 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -363,7 +363,7 @@ EXPORT_SYMBOL(acpi_pci_osc_control_set);
 static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 				 int *clear_aspm)
 {
-	u32 flags, base_flags;
+	u32 support, base_support, control;
 	acpi_status status;
 	struct acpi_device *device = root->device;
 	acpi_handle handle = device->handle;
@@ -372,29 +372,29 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	 * All supported architectures that use ACPI have support for
 	 * PCI domains, so we indicate this in _OSC support capabilities.
 	 */
-	flags = base_flags = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
-	acpi_pci_osc_support(root, flags);
+	support = base_support = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
+	acpi_pci_osc_support(root, support);
 
 	if (pci_ext_cfg_avail())
-		flags |= OSC_PCI_EXT_CONFIG_SUPPORT;
+		support |= OSC_PCI_EXT_CONFIG_SUPPORT;
 	if (pcie_aspm_support_enabled()) {
-		flags |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
+		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
 	}
 	if (pci_msi_enabled())
-		flags |= OSC_PCI_MSI_SUPPORT;
-	if (flags != base_flags) {
-		status = acpi_pci_osc_support(root, flags);
+		support |= OSC_PCI_MSI_SUPPORT;
+	if (support != base_support) {
+		status = acpi_pci_osc_support(root, support);
 		if (ACPI_FAILURE(status)) {
 			dev_info(&device->dev, "ACPI _OSC support "
 				"notification failed, disabling PCIe ASPM\n");
 			*no_aspm = 1;
-			flags = base_flags;
+			support = base_support;
 		}
 	}
 
 	if (!pcie_ports_disabled
-	    && (flags & ACPI_PCIE_REQ_SUPPORT) == ACPI_PCIE_REQ_SUPPORT) {
-		flags = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
+	    && (support & ACPI_PCIE_REQ_SUPPORT) == ACPI_PCIE_REQ_SUPPORT) {
+		control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
 			| OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
 			| OSC_PCI_EXPRESS_PME_CONTROL;
 
@@ -403,17 +403,18 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 				dev_dbg(&device->dev,
 					"PCIe errors handled by BIOS.\n");
 			else
-				flags |= OSC_PCI_EXPRESS_AER_CONTROL;
+				control |= OSC_PCI_EXPRESS_AER_CONTROL;
 		}
 
 		dev_info(&device->dev,
-			"Requesting ACPI _OSC control (0x%02x)\n", flags);
+			"Requesting ACPI _OSC control (0x%02x)\n", control);
 
-		status = acpi_pci_osc_control_set(handle, &flags,
+		status = acpi_pci_osc_control_set(handle, &control,
 				       OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
 		if (ACPI_SUCCESS(status)) {
 			dev_info(&device->dev,
-				"ACPI _OSC control (0x%02x) granted\n", flags);
+				"ACPI _OSC control (0x%02x) granted\n",
+				control);
 			if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
 				/*
 				 * We have ASPM control, but the FADT indicates
@@ -425,7 +426,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 			dev_info(&device->dev,
 				"ACPI _OSC request failed (%s), "
 				"returned control mask: 0x%02x\n",
-				acpi_format_exception(status), flags);
+				acpi_format_exception(status), control);
 			dev_info(&device->dev,
 				 "ACPI _OSC control for PCIe not granted, disabling ASPM\n");
 			/*
@@ -440,7 +441,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	} else {
 		dev_info(&device->dev,
 			 "Unable to request _OSC control "
-			 "(_OSC support mask: 0x%02x)\n", flags);
+			 "(_OSC support mask: 0x%02x)\n", support);
 	}
 }
 

