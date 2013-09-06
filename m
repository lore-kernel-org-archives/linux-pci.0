Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: [PATCH 13/14] PCI/ACPI: Separate out _OSC "we don't support enough
 services" path
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Date: Fri, 06 Sep 2013 11:15:06 -0600
Message-ID: <20130906171506.11482.80881.stgit@bhelgaas-glaptop>
In-Reply-To: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
References: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Test the services we support (extended config space, ASPM, MSI) separately
so we can give a better message.  Previously we said "Unable to request
_OSC control..."; now we'll say "we support %#02x but %#02x are required".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c |   84 ++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 68e5a18..65aefcf 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -392,55 +392,55 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		return;
 	}
 
-	if ((support & ACPI_PCIE_REQ_SUPPORT) == ACPI_PCIE_REQ_SUPPORT) {
-		control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
-			| OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
-			| OSC_PCI_EXPRESS_PME_CONTROL;
-
-		if (pci_aer_available()) {
-			if (aer_acpi_firmware_first())
-				dev_dbg(&device->dev,
-					"PCIe errors handled by BIOS.\n");
-			else
-				control |= OSC_PCI_EXPRESS_AER_CONTROL;
-		}
+	if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
+		dev_info(&device->dev, "Not requesting _OSC control (we support %#02x but %#02x are required)\n",
+			 support, ACPI_PCIE_REQ_SUPPORT);
+		return;
+	}
+
+	control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
+		| OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
+		| OSC_PCI_EXPRESS_PME_CONTROL;
+
+	if (pci_aer_available()) {
+		if (aer_acpi_firmware_first())
+			dev_dbg(&device->dev,
+				"PCIe errors handled by BIOS.\n");
+		else
+			control |= OSC_PCI_EXPRESS_AER_CONTROL;
+	}
 
+	dev_info(&device->dev,
+		 "Requesting ACPI _OSC control (0x%02x)\n", control);
+
+	status = acpi_pci_osc_control_set(handle, &control,
+					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
+	if (ACPI_SUCCESS(status)) {
 		dev_info(&device->dev,
-			"Requesting ACPI _OSC control (0x%02x)\n", control);
-
-		status = acpi_pci_osc_control_set(handle, &control,
-				       OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
-		if (ACPI_SUCCESS(status)) {
-			dev_info(&device->dev,
-				"ACPI _OSC control (0x%02x) granted\n",
-				control);
-			if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
-				/*
-				 * We have ASPM control, but the FADT indicates
-				 * that it's unsupported. Clear it.
-				 */
-				*clear_aspm = 1;
-			}
-		} else {
-			dev_info(&device->dev,
-				"ACPI _OSC request failed (%s), "
-				"returned control mask: 0x%02x\n",
-				acpi_format_exception(status), control);
-			dev_info(&device->dev,
-				 "ACPI _OSC control for PCIe not granted, disabling ASPM\n");
+			 "ACPI _OSC control (0x%02x) granted\n",
+			 control);
+		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
 			/*
-			 * We want to disable ASPM here, but aspm_disabled
-			 * needs to remain in its state from boot so that we
-			 * properly handle PCIe 1.1 devices.  So we set this
-			 * flag here, to defer the action until after the ACPI
-			 * root scan.
+			 * We have ASPM control, but the FADT indicates
+			 * that it's unsupported. Clear it.
 			 */
-			*no_aspm = 1;
+			*clear_aspm = 1;
 		}
 	} else {
 		dev_info(&device->dev,
-			 "Unable to request _OSC control "
-			 "(_OSC support mask: 0x%02x)\n", support);
+			"ACPI _OSC request failed (%s), "
+			"returned control mask: 0x%02x\n",
+			acpi_format_exception(status), control);
+		dev_info(&device->dev,
+			 "ACPI _OSC control for PCIe not granted, disabling ASPM\n");
+		/*
+		 * We want to disable ASPM here, but aspm_disabled
+		 * needs to remain in its state from boot so that we
+		 * properly handle PCIe 1.1 devices.  So we set this
+		 * flag here, to defer the action until after the ACPI
+		 * root scan.
+		 */
+		*no_aspm = 1;
 	}
 }
 

