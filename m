Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64665 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbbCYGim (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Mar 2015 02:38:42 -0400
Message-ID: <55125792.5060101@intel.com>
Date: Wed, 25 Mar 2015 14:37:06 +0800
From: Aaron Lu <aaron.lu@intel.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH v3 3/3] PCI / ACPI: PCI delay optimization from ACPI
References: <54FD4FB9.2060802@intel.com> <55125611.8040507@intel.com>
In-Reply-To: <55125611.8040507@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

An ECN meant to specify possible delay optimization is available on
the PCI website:
https://www.pcisig.com/specifications/conventional/pci_firmware/ECN_fw_latency_optimization_final.pdf
where it has defined two functions for an UUID specified _DSM:
Function 8: If system firmware assumes the responsibility of post
Conventional Reset delay (and informs the Operating System via this DSM
function) on Sx Resume (such as boot from ACPI S5, or resume from ACPI
S4 or S3 states), the Operating System may assume sufficient time has
elapsed since the end of reset, and devices within the PCI subsystem are
ready for Configuration Access.
If the system firmware supports runtime power gating on any of the
device within PCI subsystem covered by this DSM function, the system
firmware is responsible for covering the necessary post power-on reset
delay.

Function 9: Specify various smaller delay values than required by the
SPEC for individual PCI devices like shorter delay values after
conventional reset, D3hot to D0 transition, functional level reset, etc.

This patch adds support for function 8 and part of function 9. For
function 8, the patch will check if the required _DSM function satisfies
the requirement and if so, the d3cold_delay of all PCI devices will be
updated to zero. For function 9, the values affecting delays after
conventional reset and D3hot->D0 are examined and the per PCI device's
d3cold_delay and d3_delay are updated if the _DSM's return value is
smaller than what the SPEC requires. Function 9's value takes precedence
over function 8.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/pci/pci-acpi.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |  2 ++
 include/linux/pci.h      |  1 +
 3 files changed, 77 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e0afc94aca01..0fea8179857d 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -537,11 +537,32 @@ static struct pci_platform_pm_ops acpi_pci_platform_pm = {
 
 void acpi_pci_add_bus(struct pci_bus *bus)
 {
+	union acpi_object *obj;
+	struct pci_host_bridge *bridge;
+
 	if (acpi_pci_disabled || !bus->bridge)
 		return;
 
 	acpi_pci_slot_enumerate(bus);
 	acpiphp_enumerate_slots(bus);
+
+	/*
+	 * For a host bridge, check its _DSM for function 8 and if
+	 * that is available, mark it in pci_host_bridge.
+	 */
+	if (!pci_is_root_bus(bus))
+		return;
+
+	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), pci_acpi_dsm_uuid, 3,
+				RESET_DELAY_DSM, NULL);
+	if (!obj)
+		return;
+
+	if (obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 1) {
+		bridge = pci_find_host_bridge(bus);
+		bridge->ignore_reset_delay = 1;
+	}
+	ACPI_FREE(obj);
 }
 
 void acpi_pci_remove_bus(struct pci_bus *bus)
@@ -567,6 +588,57 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev)
 				      check_children);
 }
 
+/**
+ * pci_acpi_delay_optimize - optimize PCI D3 and D3cold delay from ACPI
+ * @pdev: the PCI device whose delay is to be updated
+ * @adev: the companion ACPI device of this PCI device
+ *
+ * Update the d3_delay and d3cold_delay of a PCI device from the ACPI _DSM
+ * control method of either its own or PCI host bridge.
+ *
+ * The UUID of the _DSM control method, together with other information like
+ * which delay values can be optimized, etc. is defined in a ECN available on
+ * PCIsig.com titled as: ACPI additions for FW latency optimizations.
+ * Function 9 of the ACPI _DSM control method, if available for a specific PCI
+ * device, provides various possible delay values that are less than what the
+ * SPEC requires. Here, we only deal with d3_delay and d3cold_delay. Others
+ * can be added later.
+ * Function 8 of the ACPI _DSM control method, if available for the PCI host
+ * bridge, means devices in the entire PCI hierachy do not need the reset delay
+ * when leaving from D3cold state. However, if function 9 also specify the reset
+ * delay value, it will take precedence over function 8.
+ */
+static void pci_acpi_delay_optimize(struct pci_dev *pdev,
+				    acpi_handle handle)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
+	int value;
+	union acpi_object *obj, *elements;
+
+	if (bridge->ignore_reset_delay)
+		pdev->d3cold_delay = 0;
+
+	obj = acpi_evaluate_dsm(handle, pci_acpi_dsm_uuid, 3,
+				FUNCTION_DELAY_DSM, NULL);
+	if (!obj)
+		return;
+
+	if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 5) {
+		elements = obj->package.elements;
+		if (elements[0].type == ACPI_TYPE_INTEGER) {
+			value = (int)elements[0].integer.value / 1000;
+			if (value < PCI_PM_D3COLD_WAIT)
+				pdev->d3cold_delay = value;
+		}
+		if (elements[3].type == ACPI_TYPE_INTEGER) {
+			value = (int)elements[3].integer.value / 1000;
+			if (value < PCI_PM_D3_WAIT)
+				pdev->d3_delay = value;
+		}
+	}
+	ACPI_FREE(obj);
+}
+
 static void pci_acpi_setup(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -575,6 +647,8 @@ static void pci_acpi_setup(struct device *dev)
 	if (!adev)
 		return;
 
+	pci_acpi_delay_optimize(pci_dev, adev->handle);
+
 	pci_acpi_add_pm_notifier(adev, pci_dev);
 	if (!adev->wakeup.flags.valid)
 		return;
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 3801c704a945..a965efa52152 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -79,6 +79,8 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
 
 extern const u8 pci_acpi_dsm_uuid[];
 #define DEVICE_LABEL_DSM	0x07
+#define RESET_DELAY_DSM		0x08
+#define FUNCTION_DELAY_DSM	0x09
 
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a379513bddef..c87cb563a90d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -406,6 +406,7 @@ struct pci_host_bridge {
 	struct list_head windows;	/* resource_entry */
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
+	unsigned int ignore_reset_delay:1;
 };
 
 #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
-- 
2.1.0

