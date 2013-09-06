Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ye0-f178.google.com ([209.85.213.178]:33625 "EHLO
	mail-ye0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab3IFRPR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 13:15:17 -0400
Received: by mail-ye0-f178.google.com with SMTP id m5so1106114yen.9
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2013 10:15:16 -0700 (PDT)
Subject: [PATCH 14/14] PCI/ACPI: Decode _OSC bitmasks symbolically
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Date: Fri, 06 Sep 2013 11:15:14 -0600
Message-ID: <20130906171514.11482.29960.stgit@bhelgaas-glaptop>
In-Reply-To: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
References: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This updates _OSC-related messages to be more human-readable.  We now always
show the features we declare support for (this was previously invisible) as
well as the features we are granted control of.

Typical changes:

  -acpi PNP0A08:00: Requesting ACPI _OSC control (0x1d)
  -acpi PNP0A08:00: ACPI _OSC control (0x1d) granted
  +acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
  +acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c |   84 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 67 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 65aefcf..cba966e 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -127,6 +127,55 @@ static acpi_status try_get_root_bridge_busnr(acpi_handle handle,
 	return AE_OK;
 }
 
+struct pci_osc_bit_struct {
+	u32 bit;
+	char *desc;
+};
+
+static struct pci_osc_bit_struct pci_osc_support_bit[] = {
+	{ OSC_PCI_EXT_CONFIG_SUPPORT, "ExtendedConfig" },
+	{ OSC_PCI_ASPM_SUPPORT, "ASPM" },
+	{ OSC_PCI_CLOCK_PM_SUPPORT, "ClockPM" },
+	{ OSC_PCI_SEGMENT_GROUPS_SUPPORT, "Segments" },
+	{ OSC_PCI_MSI_SUPPORT, "MSI" },
+};
+
+static struct pci_osc_bit_struct pci_osc_control_bit[] = {
+	{ OSC_PCI_EXPRESS_NATIVE_HP_CONTROL, "PCIeHotplug" },
+	{ OSC_PCI_SHPC_NATIVE_HP_CONTROL, "SHPCHotplug" },
+	{ OSC_PCI_EXPRESS_PME_CONTROL, "PME" },
+	{ OSC_PCI_EXPRESS_AER_CONTROL, "AER" },
+	{ OSC_PCI_EXPRESS_CAPABILITY_CONTROL, "PCIeCapability" },
+};
+
+static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
+			    struct pci_osc_bit_struct *table, int size)
+{
+	char buf[80];
+	int i, len = 0;
+	struct pci_osc_bit_struct *entry;
+
+	buf[0] = '\0';
+	for (i = 0, entry = table; i < size; i++, entry++)
+		if (word & entry->bit)
+			len += snprintf(buf + len, sizeof(buf) - len, "%s%s",
+				        len ? " " : "", entry->desc);
+
+	dev_info(&root->device->dev, "_OSC: %s [%s]\n", msg, buf);
+}
+
+static void decode_osc_support(struct acpi_pci_root *root, char *msg, u32 word)
+{
+	decode_osc_bits(root, msg, word, pci_osc_support_bit,
+			ARRAY_SIZE(pci_osc_support_bit));
+}
+
+static void decode_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
+{
+	decode_osc_bits(root, msg, word, pci_osc_control_bit,
+			ARRAY_SIZE(pci_osc_control_bit));
+}
+
 static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
 
 static acpi_status acpi_pci_run_osc(acpi_handle handle,
@@ -340,10 +389,14 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
 			goto out;
 		if (ctrl == *mask)
 			break;
+		decode_osc_control(root, "platform does not support",
+				   ctrl & ~(*mask));
 		ctrl = *mask;
 	}
 
 	if ((ctrl & req) != req) {
+		decode_osc_control(root, "not requesting control; platform does not support",
+				   req & ~(ctrl));
 		status = AE_SUPPORT;
 		goto out;
 	}
@@ -363,7 +416,7 @@ EXPORT_SYMBOL(acpi_pci_osc_control_set);
 static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 				 int *clear_aspm)
 {
-	u32 support, control;
+	u32 support, control, requested;
 	acpi_status status;
 	struct acpi_device *device = root->device;
 	acpi_handle handle = device->handle;
@@ -379,6 +432,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
 	if (pci_msi_enabled())
 		support |= OSC_PCI_MSI_SUPPORT;
+
+	decode_osc_support(root, "OS supports", support);
 	status = acpi_pci_osc_support(root, support);
 	if (ACPI_FAILURE(status)) {
 		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
@@ -393,8 +448,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	}
 
 	if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
-		dev_info(&device->dev, "Not requesting _OSC control (we support %#02x but %#02x are required)\n",
-			 support, ACPI_PCIE_REQ_SUPPORT);
+		decode_osc_support(root, "not requesting OS control; OS requires",
+				   ACPI_PCIE_REQ_SUPPORT);
 		return;
 	}
 
@@ -404,21 +459,17 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 
 	if (pci_aer_available()) {
 		if (aer_acpi_firmware_first())
-			dev_dbg(&device->dev,
-				"PCIe errors handled by BIOS.\n");
+			dev_info(&device->dev,
+				 "PCIe AER handled by firmware\n");
 		else
 			control |= OSC_PCI_EXPRESS_AER_CONTROL;
 	}
 
-	dev_info(&device->dev,
-		 "Requesting ACPI _OSC control (0x%02x)\n", control);
-
+	requested = control;
 	status = acpi_pci_osc_control_set(handle, &control,
 					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
 	if (ACPI_SUCCESS(status)) {
-		dev_info(&device->dev,
-			 "ACPI _OSC control (0x%02x) granted\n",
-			 control);
+		decode_osc_control(root, "OS now controls", control);
 		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
 			/*
 			 * We have ASPM control, but the FADT indicates
@@ -427,12 +478,11 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 			*clear_aspm = 1;
 		}
 	} else {
-		dev_info(&device->dev,
-			"ACPI _OSC request failed (%s), "
-			"returned control mask: 0x%02x\n",
-			acpi_format_exception(status), control);
-		dev_info(&device->dev,
-			 "ACPI _OSC control for PCIe not granted, disabling ASPM\n");
+		decode_osc_control(root, "OS requested", requested);
+		decode_osc_control(root, "platform willing to grant", control);
+		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
+			acpi_format_exception(status));
+
 		/*
 		 * We want to disable ASPM here, but aspm_disabled
 		 * needs to remain in its state from boot so that we

