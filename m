Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: [PATCH 08/14] PCI/ACPI: Move _OSC stuff from acpi_pci_root_add() to
 negotiate_os_control()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Date: Fri, 06 Sep 2013 11:14:26 -0600
Message-ID: <20130906171426.11482.93212.stgit@bhelgaas-glaptop>
In-Reply-To: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
References: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This doesn't change any of the _OSC code; it just moves it out into
a new function so it doesn't clutter acpi_pci_root_add() so much.  This
also enables future simplifications.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c |  132 +++++++++++++++++++++++++----------------------
 1 file changed, 71 insertions(+), 61 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index cc87cc4..3e57f10 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -360,67 +360,13 @@ out:
 }
 EXPORT_SYMBOL(acpi_pci_osc_control_set);
 
-static int acpi_pci_root_add(struct acpi_device *device,
-			     const struct acpi_device_id *not_used)
+static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
+				 int *clear_aspm)
 {
-	unsigned long long segment, bus;
-	acpi_status status;
-	int result;
-	struct acpi_pci_root *root;
 	u32 flags, base_flags;
+	acpi_status status;
+	struct acpi_device *device = root->device;
 	acpi_handle handle = device->handle;
-	bool no_aspm = false, clear_aspm = false;
-
-	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
-	if (!root)
-		return -ENOMEM;
-
-	segment = 0;
-	status = acpi_evaluate_integer(handle, METHOD_NAME__SEG, NULL,
-				       &segment);
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		dev_err(&device->dev,  "can't evaluate _SEG\n");
-		result = -ENODEV;
-		goto end;
-	}
-
-	/* Check _CRS first, then _BBN.  If no _BBN, default to zero. */
-	root->secondary.flags = IORESOURCE_BUS;
-	status = try_get_root_bridge_busnr(handle, &root->secondary);
-	if (ACPI_FAILURE(status)) {
-		/*
-		 * We need both the start and end of the downstream bus range
-		 * to interpret _CBA (MMCONFIG base address), so it really is
-		 * supposed to be in _CRS.  If we don't find it there, all we
-		 * can do is assume [_BBN-0xFF] or [0-0xFF].
-		 */
-		root->secondary.end = 0xFF;
-		dev_warn(&device->dev,
-			 FW_BUG "no secondary bus range in _CRS\n");
-		status = acpi_evaluate_integer(handle, METHOD_NAME__BBN,
-					       NULL, &bus);
-		if (ACPI_SUCCESS(status))
-			root->secondary.start = bus;
-		else if (status == AE_NOT_FOUND)
-			root->secondary.start = 0;
-		else {
-			dev_err(&device->dev, "can't evaluate _BBN\n");
-			result = -ENODEV;
-			goto end;
-		}
-	}
-
-	root->device = device;
-	root->segment = segment & 0xFFFF;
-	strcpy(acpi_device_name(device), ACPI_PCI_ROOT_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
-	device->driver_data = root;
-
-	pr_info(PREFIX "%s [%s] (domain %04x %pR)\n",
-	       acpi_device_name(device), acpi_device_bid(device),
-	       root->segment, &root->secondary);
-
-	root->mcfg_addr = acpi_pci_root_get_mcfg_addr(handle);
 
 	/*
 	 * All supported architectures that use ACPI have support for
@@ -441,7 +387,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 		if (ACPI_FAILURE(status)) {
 			dev_info(&device->dev, "ACPI _OSC support "
 				"notification failed, disabling PCIe ASPM\n");
-			no_aspm = true;
+			*no_aspm = 1;
 			flags = base_flags;
 		}
 	}
@@ -473,7 +419,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 				 * We have ASPM control, but the FADT indicates
 				 * that it's unsupported. Clear it.
 				 */
-				clear_aspm = true;
+				*clear_aspm = 1;
 			}
 		} else {
 			dev_info(&device->dev,
@@ -489,13 +435,77 @@ static int acpi_pci_root_add(struct acpi_device *device,
 			 * flag here, to defer the action until after the ACPI
 			 * root scan.
 			 */
-			no_aspm = true;
+			*no_aspm = 1;
 		}
 	} else {
 		dev_info(&device->dev,
 			 "Unable to request _OSC control "
 			 "(_OSC support mask: 0x%02x)\n", flags);
 	}
+}
+
+static int acpi_pci_root_add(struct acpi_device *device,
+			     const struct acpi_device_id *not_used)
+{
+	unsigned long long segment, bus;
+	acpi_status status;
+	int result;
+	struct acpi_pci_root *root;
+	acpi_handle handle = device->handle;
+	int no_aspm = 0, clear_aspm = 0;
+
+	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
+	if (!root)
+		return -ENOMEM;
+
+	segment = 0;
+	status = acpi_evaluate_integer(handle, METHOD_NAME__SEG, NULL,
+				       &segment);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+		dev_err(&device->dev,  "can't evaluate _SEG\n");
+		result = -ENODEV;
+		goto end;
+	}
+
+	/* Check _CRS first, then _BBN.  If no _BBN, default to zero. */
+	root->secondary.flags = IORESOURCE_BUS;
+	status = try_get_root_bridge_busnr(handle, &root->secondary);
+	if (ACPI_FAILURE(status)) {
+		/*
+		 * We need both the start and end of the downstream bus range
+		 * to interpret _CBA (MMCONFIG base address), so it really is
+		 * supposed to be in _CRS.  If we don't find it there, all we
+		 * can do is assume [_BBN-0xFF] or [0-0xFF].
+		 */
+		root->secondary.end = 0xFF;
+		dev_warn(&device->dev,
+			 FW_BUG "no secondary bus range in _CRS\n");
+		status = acpi_evaluate_integer(handle, METHOD_NAME__BBN,
+					       NULL, &bus);
+		if (ACPI_SUCCESS(status))
+			root->secondary.start = bus;
+		else if (status == AE_NOT_FOUND)
+			root->secondary.start = 0;
+		else {
+			dev_err(&device->dev, "can't evaluate _BBN\n");
+			result = -ENODEV;
+			goto end;
+		}
+	}
+
+	root->device = device;
+	root->segment = segment & 0xFFFF;
+	strcpy(acpi_device_name(device), ACPI_PCI_ROOT_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
+	device->driver_data = root;
+
+	pr_info(PREFIX "%s [%s] (domain %04x %pR)\n",
+	       acpi_device_name(device), acpi_device_bid(device),
+	       root->segment, &root->secondary);
+
+	root->mcfg_addr = acpi_pci_root_get_mcfg_addr(handle);
+
+	negotiate_os_control(root, &no_aspm, &clear_aspm);
 
 	/*
 	 * TBD: Need PCI interface for enumeration/configuration of roots.

