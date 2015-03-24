Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <551128BA.7070508@intel.com>
Date: Tue, 24 Mar 2015 17:04:58 +0800
From: Aaron Lu <aaron.lu@intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH v2 2/2] PCI / ACPI: PCI delay optimization from ACPI
References: <54FD4FB9.2060802@intel.com> <5222588.FaRe37n2T1@vostro.rjw.lan> <54FE93A4.9040908@intel.com> <20150320210354.GK26935@google.com> <550FDA38.2090505@intel.com> <20150323150955.GR26935@google.com>
In-Reply-To: <20150323150955.GR26935@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/23/2015 11:09 PM, Bjorn Helgaas wrote:
> The ECN says this function is in a host bridge scope and applies to the
> PCI subsystem beneath the bridge.  This code does not map well to that
> because:
> 
>   1) It evaluates _DSM more times than necessary (we only need to do it
>   once per host bridge, and this does it once for every PCI device
>   immediately below a host brige).
> 
>   2) The settings are only applied to immediate children of the host
>   bridge, not to devices deeper in the hierarchy.
> 
>   3) A reader of the ECN will expect the corresponding code to be in the
>   host bridge driver (pci_root.c) where we deal with other host bridge
>   properties, not in per-PCI device code like this.
> 
>   4) The ECN is not explicit about this, but if both function 8 (which
>   applies to a whole hierarchy) and function 9 (which applies to a single
>   PCI device) are implemented for the same PCI device, I would expect
>   function 9 to take precedence over function 8.  This patch does the
>   reverse, since function 8 will overwrite any d3cold_delay that was set
>   above by function 9.

I tried to do this in drivers/acpi/pci_root.c, but didn't find a proper
way to pass this information down during PCI device scan time. So
instead, I did it in the pci root bus add time: acpi_pci_add_bus, which
is used by both the x86 code and ia64 code. Suggestions are welcome and
appreciated.


>From 05b625d2444d90e37392dd835a97c0b582fd221f Mon Sep 17 00:00:00 2001
From: Aaron Lu <aaron.lu@intel.com>
Date: Fri, 14 Nov 2014 16:56:43 +0800
Subject: [PATCH v2 2/2] PCI / ACPI: PCI delay optimization from ACPI

An ECN meant to specify possible delay optimizations is available on
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

This patche adds support for function 8 and part of function 9. For
function 8, the patch will check if the required _DSM function satisfies
the requirement and then all the host bus' immediate children PCI device's
d3cold_delay variable will be updated to zero. For function 9, the values
affecting delays after conventional reset and D3hot->D0 are examined and
the per PCI device's d3cold_delay and d3_delay are updated if the _DSM's
return value is smaller than what the SPEC requires. Function 9's value
takes precedence over function 8.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/pci/pci-acpi.c   | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |  2 ++
 include/linux/pci.h      |  1 +
 3 files changed, 68 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e0afc94aca01..220371c2def4 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -537,11 +537,24 @@ static struct pci_platform_pm_ops acpi_pci_platform_pm = {
 
 void acpi_pci_add_bus(struct pci_bus *bus)
 {
+	union acpi_object *obj;
+
 	if (acpi_pci_disabled || !bus->bridge)
 		return;
 
 	acpi_pci_slot_enumerate(bus);
 	acpiphp_enumerate_slots(bus);
+
+	/*
+	 * For a host bridge, check its _DSM for function 8 and if
+	 * that is available, mark it in the corresponding pci_bus.
+	 */
+	if (bus->bridge->parent)
+		return;
+	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), pci_acpi_dsm_uuid, 3,
+				RESET_DELAY_DSM, NULL);
+	if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 1)
+		bus->ignore_reset_delay = 1;
 }
 
 void acpi_pci_remove_bus(struct pci_bus *bus)
@@ -567,6 +580,55 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev)
 				      check_children);
 }
 
+/**
+ * pci_acpi_delay_optimize - optimize PCI D3 and D3cold delay from ACPI
+ * @pdev: the PCI device whose delay is to be updated
+ * @adev: the companion ACPI device of this PCI device
+ *
+ * Update the d3_delay and d3cold_delay of a PCI device from the ACPI _DSM
+ * control method of either its own or its parent bridge.
+ *
+ * The UUID of the _DSM control method, together with other information like
+ * which delay values can be optimized, etc. is defined in a ECN available on
+ * PCIsig.com titled as: ACPI additions for FW latency optimizations.
+ * Function 9 of the ACPI _DSM control method, if available for a specific PCI
+ * device, provides various possible delay values that are less than what the
+ * SPEC requires. Here, we only deal with d3_delay and d3cold_delay. Others
+ * can be added later.
+ * Function 8 of the ACPI _DSM control method, if available for the PCI host
+ * bridge(reflected by the bus' ignore_reset_delay filed), means all its
+ * children devices do not need the reset delay when leaving from D3cold state.
+ */
+static void pci_acpi_delay_optimize(struct pci_dev *pdev,
+				    acpi_handle handle)
+{
+	int value;
+	union acpi_object *obj, *elements;
+
+	if (pdev->bus->ignore_reset_delay)
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
+	kfree(obj);
+}
+
 static void pci_acpi_setup(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -575,6 +637,9 @@ static void pci_acpi_setup(struct device *dev)
 	if (!adev)
 		return;
 
+	if (pci_dev->pm_cap)
+		pci_acpi_delay_optimize(pci_dev, adev->handle);
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
index a379513bddef..1e56c464d058 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -471,6 +471,7 @@ struct pci_bus {
 	struct bin_attribute	*legacy_io; /* legacy I/O for this bus */
 	struct bin_attribute	*legacy_mem; /* legacy mem */
 	unsigned int		is_added:1;
+	unsigned int		ignore_reset_delay:1;
 };
 
 #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
-- 
2.1.0

