Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:6106 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754155Ab3C3Kyy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 30 Mar 2013 06:54:54 -0400
Message-ID: <1364640886.5773.5.camel@yhuang-mobile.sh.intel.com>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
From: Huang Ying <ying.huang@intel.com>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>
Date: Sat, 30 Mar 2013 18:54:46 +0800
In-Reply-To: <5155A101.2090705@fold.natur.cuni.cz>
References: <513E7E1E.80508@fold.natur.cuni.cz>
	  <513FE7AD.2020408@huawei.com> <5141145E.4020300@fold.natur.cuni.cz>
	  <51417C28.40402@huawei.com> <5141C9D7.9040706@fold.natur.cuni.cz>
	  <51428A72.2060602@huawei.com> <51548E13.8030308@fold.natur.cuni.cz>
	 <1364545211.1817.228.camel@yhuang-dev>
	 <5155A101.2090705@fold.natur.cuni.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2013-03-29 at 15:11 +0100, Martin Mokrejs wrote:
> Hi Ying,
>   thank you for the patch. Here are the results.

Thanks for your help! It appears my previous patch does not help
much :(.  Can you try below patch?  I think this is mainly for hotplug
but may be helpful for xhci dead port bug too.

Please test this patch with laptop-mode-tool installed and enabled.  And
before/after test, please get PCI devices runtime status with:

grep . /sys/bus/pci/devices/*/power/runtime_status

And please give me the full dmesg for boot and incremental dmesg for
operations.  Could you give me the ACPI dump for your machine?

Best Regards,
Huang Ying

>From c0179956fb396fe68f2a237713c7592feea87d16 Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Fri, 8 Mar 2013 16:13:54 +0800
Subject: [PATCH] pcie_hp_disable_rtpm

---
 drivers/pci/hotplug/pci_hotplug_core.c |    8 ++++++++
 drivers/pci/pci-acpi.c                 |   15 +++++++++++++++
 drivers/pci/pci.c                      |    1 +
 drivers/pci/pcie/portdrv_pci.c         |   12 +++++++++---
 drivers/pci/slot.c                     |   18 ++++++++++++++++++
 include/acpi/acpi_bus.h                |    1 +
 include/linux/pci.h                    |    1 +
 7 files changed, 53 insertions(+), 3 deletions(-)

--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -39,6 +39,7 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
+#include <linux/pm_runtime.h>
 #include <asm/uaccess.h>
 #include "../pci.h"
 
@@ -473,6 +474,9 @@ int __pci_hp_register(struct hotplug_slo
 	dbg("Added slot %s to the list\n", name);
 out:
 	mutex_unlock(&pci_hp_mutex);
+	/* Bridge runtime PM state may be influenced by hotplug */
+	pm_runtime_resume(&bus->self->dev);
+	dev_info(&bus->self->dev, "hotplug slot added!\n");
 	return result;
 }
 
@@ -489,6 +493,7 @@ int pci_hp_deregister(struct hotplug_slo
 {
 	struct hotplug_slot *temp;
 	struct pci_slot *slot;
+	struct pci_bus *bus;
 
 	if (!hotplug)
 		return -ENODEV;
@@ -508,8 +513,11 @@ int pci_hp_deregister(struct hotplug_slo
 
 	hotplug->release(hotplug);
 	slot->hotplug = NULL;
+	bus = slot->bus;
 	pci_destroy_slot(slot);
 	mutex_unlock(&pci_hp_mutex);
+	pm_runtime_resume(&bus->self->dev);
+	dev_info(&bus->self->dev, "hotplug slot removed!\n");
 
 	return 0;
 }
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -154,9 +154,15 @@ static int pcie_port_runtime_idle(struct
 	 */
 	pci_walk_bus(pdev->subordinate, pci_dev_pme_poll, &pme_poll);
 	/* Delay for a short while to prevent too frequent suspend/resume */
-	if (!pme_poll)
-		pm_schedule_suspend(dev, 10);
-	return -EBUSY;
+	if (pme_poll)
+		return -EBUSY;
+	if (pci_bus_has_hotplug_slots(pdev->subordinate)) {
+		dev_info(&pdev->dev, "ppri: has hotplug slots, do not suspend!\n");
+		return -EBUSY;
+	}
+	dev_info(&pdev->dev, "ppri: will go suspend, is_hotplug_bridge: %d.\n",
+		 pdev->is_hotplug_bridge);
+	return pm_schedule_suspend(dev, 10);
 }
 #else
 #define pcie_port_runtime_suspend	NULL
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -345,6 +345,24 @@ out:
 }
 EXPORT_SYMBOL_GPL(pci_renumber_slot);
 
+bool pci_bus_has_hotplug_slots(struct pci_bus *bus)
+{
+	struct pci_slot *slot;
+	bool has_hotplug_slots = false;
+
+	down_read(&pci_bus_sem);
+	list_for_each_entry(slot, &bus->slots, list) {
+		if (slot->hotplug) {
+			has_hotplug_slots = true;
+			break;
+		}
+	}
+	up_read(&pci_bus_sem);
+
+	return has_hotplug_slots;
+}
+EXPORT_SYMBOL_GPL(pci_bus_has_hotplug_slots);
+
 /**
  * pci_destroy_slot - decrement refcount for physical PCI slot
  * @slot: struct pci_slot to decrement
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -722,6 +722,7 @@ struct pci_slot *pci_create_slot(struct
 void pci_destroy_slot(struct pci_slot *slot);
 void pci_renumber_slot(struct pci_slot *slot, int slot_nr);
 int pci_scan_slot(struct pci_bus *bus, int devfn);
+bool pci_bus_has_hotplug_slots(struct pci_bus *bus);
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
 unsigned int pci_scan_child_bus(struct pci_bus *bus);
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -43,10 +43,16 @@ static void pci_acpi_wake_bus(acpi_handl
 static void pci_acpi_wake_dev(acpi_handle handle, u32 event, void *context)
 {
 	struct pci_dev *pci_dev = context;
+	struct acpi_device *adev;
 
 	if (event != ACPI_NOTIFY_DEVICE_WAKE || !pci_dev)
 		return;
 
+	if (!acpi_bus_get_device(handle, &adev)) {
+		adev->wakeup.flags.run_wake_works = true;
+		dev_info(&pci_dev->dev, "run wake works!\n");
+	}
+
 	if (pci_dev->current_state == PCI_D3cold) {
 		pci_wakeup_event(pci_dev);
 		pm_runtime_resume(&pci_dev->dev);
@@ -146,6 +152,15 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(
 static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 {
 	int acpi_state, d_max;
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&pdev->dev);
+	struct acpi_device *adev;
+
+	if (pci_is_bridge(pdev) && !acpi_bus_get_device(handle, &adev)) {
+		if (!adev->wakeup.flags.run_wake_works) {
+			dev_info(&pdev->dev, "choose state, run wake not verified\n");
+			return PCI_D0;
+		}
+	}
 
 	if (pdev->no_d3cold)
 		d_max = ACPI_STATE_D3_HOT;
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -245,6 +245,7 @@ struct acpi_device_perf {
 struct acpi_device_wakeup_flags {
 	u8 valid:1;		/* Can successfully enable wakeup? */
 	u8 run_wake:1;		/* Run-Wake GPE devices */
+	u8 run_wake_works:1;	/* Run-Wake works for the device */
 	u8 notifier_present:1;  /* Wake-up notify handler has been installed */
 };
 
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1832,6 +1832,7 @@ int pci_finish_runtime_suspend(struct pc
 	__pci_enable_wake(dev, target_state, true, pci_dev_run_wake(dev));
 
 	error = pci_set_power_state(dev, target_state);
+	dev_info(&dev->dev, "pfrs: target: %d, %d\n", target_state, error);
 
 	if (error) {
 		__pci_enable_wake(dev, target_state, true, false);


