Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: [PATCH 06/14] PCI/ACPI: Name _OSC #defines more consistently
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Date: Fri, 06 Sep 2013 11:14:10 -0600
Message-ID: <20130906171410.11482.77908.stgit@bhelgaas-glaptop>
In-Reply-To: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
References: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make PCI Host Bridge _OSC #defines more consistent.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c          |   19 +++++++++----------
 drivers/pci/hotplug/acpi_pcihp.c |    2 +-
 drivers/pci/hotplug/shpchp.h     |    2 +-
 include/linux/acpi.h             |   12 ++++++------
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 323afd7..28dd555 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -49,10 +49,10 @@ static int acpi_pci_root_add(struct acpi_device *device,
 			     const struct acpi_device_id *not_used);
 static void acpi_pci_root_remove(struct acpi_device *device);
 
-#define ACPI_PCIE_REQ_SUPPORT (OSC_EXT_PCI_CONFIG_SUPPORT \
-				| OSC_ACTIVE_STATE_PWR_SUPPORT \
-				| OSC_CLOCK_PWR_CAPABILITY_SUPPORT \
-				| OSC_MSI_SUPPORT)
+#define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
+				| OSC_PCI_ASPM_SUPPORT \
+				| OSC_PCI_CLOCK_PM_SUPPORT \
+				| OSC_PCI_MSI_SUPPORT)
 
 static const struct acpi_device_id root_device_ids[] = {
 	{"PNP0A03", 0},
@@ -439,13 +439,12 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	acpi_pci_osc_support(root, flags);
 
 	if (pci_ext_cfg_avail())
-		flags |= OSC_EXT_PCI_CONFIG_SUPPORT;
+		flags |= OSC_PCI_EXT_CONFIG_SUPPORT;
 	if (pcie_aspm_support_enabled()) {
-		flags |= OSC_ACTIVE_STATE_PWR_SUPPORT |
-		OSC_CLOCK_PWR_CAPABILITY_SUPPORT;
+		flags |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
 	}
 	if (pci_msi_enabled())
-		flags |= OSC_MSI_SUPPORT;
+		flags |= OSC_PCI_MSI_SUPPORT;
 	if (flags != base_flags) {
 		status = acpi_pci_osc_support(root, flags);
 		if (ACPI_FAILURE(status)) {
@@ -458,7 +457,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 
 	if (!pcie_ports_disabled
 	    && (flags & ACPI_PCIE_REQ_SUPPORT) == ACPI_PCIE_REQ_SUPPORT) {
-		flags = OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL
+		flags = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
 			| OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
 			| OSC_PCI_EXPRESS_PME_CONTROL;
 
@@ -474,7 +473,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 			"Requesting ACPI _OSC control (0x%02x)\n", flags);
 
 		status = acpi_pci_osc_control_set(handle, &flags,
-				       OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
+				       OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
 		if (ACPI_SUCCESS(status)) {
 			dev_info(&device->dev,
 				"ACPI _OSC control (0x%02x) granted\n", flags);
diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index 2a47e82..f814016 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -338,7 +338,7 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev, u32 flags)
 	acpi_handle chandle, handle;
 	struct acpi_buffer string = { ACPI_ALLOCATE_BUFFER, NULL };
 
-	flags &= OSC_SHPC_NATIVE_HP_CONTROL;
+	flags &= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
 	if (!flags) {
 		err("Invalid flags %u specified!\n", flags);
 		return -EINVAL;
diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index e260f20..d876e4b 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -191,7 +191,7 @@ static inline const char *slot_name(struct slot *slot)
 #include <linux/pci-acpi.h>
 static inline int get_hp_hw_control_from_firmware(struct pci_dev *dev)
 {
-	u32 flags = OSC_SHPC_NATIVE_HP_CONTROL;
+	u32 flags = OSC_PCI_SHPC_NATIVE_HP_CONTROL;
 	return acpi_get_hp_hw_control_from_firmware(dev, flags);
 }
 #else
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 7bda6a2..9974a49 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -325,19 +325,19 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 extern bool osc_sb_apei_support_acked;
 
 /* PCI Host Bridge _OSC: Capabilities DWORD 2: Support Field */
-#define OSC_EXT_PCI_CONFIG_SUPPORT		0x00000001
-#define OSC_ACTIVE_STATE_PWR_SUPPORT 		0x00000002
-#define OSC_CLOCK_PWR_CAPABILITY_SUPPORT	0x00000004
+#define OSC_PCI_EXT_CONFIG_SUPPORT		0x00000001
+#define OSC_PCI_ASPM_SUPPORT			0x00000002
+#define OSC_PCI_CLOCK_PM_SUPPORT		0x00000004
 #define OSC_PCI_SEGMENT_GROUPS_SUPPORT		0x00000008
-#define OSC_MSI_SUPPORT				0x00000010
+#define OSC_PCI_MSI_SUPPORT			0x00000010
 #define OSC_PCI_SUPPORT_MASKS			0x0000001f
 
 /* PCI Host Bridge _OSC: Capabilities DWORD 3: Control Field */
 #define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	0x00000001
-#define OSC_SHPC_NATIVE_HP_CONTROL 		0x00000002
+#define OSC_PCI_SHPC_NATIVE_HP_CONTROL 		0x00000002
 #define OSC_PCI_EXPRESS_PME_CONTROL		0x00000004
 #define OSC_PCI_EXPRESS_AER_CONTROL		0x00000008
-#define OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL	0x00000010
+#define OSC_PCI_EXPRESS_CAPABILITY_CONTROL	0x00000010
 #define OSC_PCI_CONTROL_MASKS			0x0000001f
 
 extern acpi_status acpi_pci_osc_control_set(acpi_handle handle,

