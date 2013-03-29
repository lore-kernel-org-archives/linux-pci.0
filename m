Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30275 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755393Ab3C2IUN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Mar 2013 04:20:13 -0400
Message-ID: <1364545211.1817.228.camel@yhuang-dev>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
From: Huang Ying <ying.huang@intel.com>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>
Date: Fri, 29 Mar 2013 16:20:11 +0800
In-Reply-To: <51548E13.8030308@fold.natur.cuni.cz>
References: <513E7E1E.80508@fold.natur.cuni.cz>
	 <513FE7AD.2020408@huawei.com> <5141145E.4020300@fold.natur.cuni.cz>
	 <51417C28.40402@huawei.com> <5141C9D7.9040706@fold.natur.cuni.cz>
	 <51428A72.2060602@huawei.com> <51548E13.8030308@fold.natur.cuni.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2013-03-28 at 19:38 +0100, Martin Mokrejs wrote:
> Hi Ying,
>   would you please tell me how this report relate to this patch?
> 
> [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
> 
>   Could you tell me why this PME was being flipped back and forth now?
> Actually, does that make finally some sense to you, pci/acpi devs?
> 
> 
>   Does is help to say that on the SandyBridge chip I have the following root ports
> hooked to the following end devices?:
> 
> 1.c1 -> rtl8169 05:00.0
> 1.c3 -> iwlwifi 09:00.0
> 1.c4 -> xhci_hcd 0b:00.0
> 1.c7 -> 00:11: express card slot
> 
> 
>   Why didn't I see interleraved lines with 1.c7 *and* 00:11? See the interleaving
> happening with the network card on 3.7.10 kernel (not broken kernel):
> 
> [138268.870070] r8169 0000:05:00.0 eth0: link down
> [138270.809811] r8169 0000:05:00.0 eth0: link up
> [138365.599744] r8169 0000:05:00.0 eth0: link down
> [138370.594343] r8169 0000:05:00.0: PME# enabled
> [138370.623852] pcieport 0000:00:1c.1: PME# enabled
> [169885.247386] pcieport 0000:00:1c.1: PME# disabled
> [169885.267374] r8169 0000:05:00.0: PME# disabled
> [169885.330160] r8169 0000:05:00.0 eth0: link down
> [169886.992531] r8169 0000:05:00.0 eth0: link up
> [169904.405769] r8169 0000:05:00.0 eth0: link down
> [169909.401237] r8169 0000:05:00.0: PME# enabled
> [169909.430782] pcieport 0000:00:1c.1: PME# enabled
> [170090.538980] pcieport 0000:00:1c.1: PME# disabled
> [170090.559088] r8169 0000:05:00.0: PME# disabled
> [170090.640494] r8169 0000:05:00.0: PME# enabled
> [170090.678425] pcieport 0000:00:1c.1: PME# enabled
> [170090.829959] pcieport 0000:00:1c.1: PME# disabled
> [170090.848479] r8169 0000:05:00.0: PME# disabled
> [170090.892011] r8169 0000:05:00.0 eth0: link down
> [170090.892134] r8169 0000:05:00.0 eth0: link down
> [170090.930998] r8169 0000:05:00.0 eth0: link down
> [170092.554553] r8169 0000:05:00.0 eth0: link up

I don't know exactly.  Can you give me the follow output?

grep . /sys/bus/pci/devices/*/power/control
grep . /sys/bus/pci/devices/*/power/runtime_status

And can you try the following patch?

Best Regards,
Huang Ying

-------------------------->

---
 drivers/pci/hotplug/pci_hotplug_core.c |    6 ++++++
 drivers/pci/pcie/portdrv_pci.c         |    8 +++++---
 drivers/pci/slot.c                     |   18 ++++++++++++++++++
 include/linux/pci.h                    |    1 +
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 202f4a9..7d4cf1a 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -39,6 +39,7 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
+#include <linux/pm_runtime.h>
 #include <asm/uaccess.h>
 #include "../pci.h"
 
@@ -473,6 +474,8 @@ int __pci_hp_register(struct hotplug_slot *slot, struct pci_bus *bus,
 	dbg("Added slot %s to the list\n", name);
 out:
 	mutex_unlock(&pci_hp_mutex);
+	/* Bridge runtime PM state may be influenced by hotplug */
+	pm_runtime_resume(&bus->self->dev);
 	return result;
 }
 
@@ -489,6 +492,7 @@ int pci_hp_deregister(struct hotplug_slot *hotplug)
 {
 	struct hotplug_slot *temp;
 	struct pci_slot *slot;
+	struct pci_bus *bus;
 
 	if (!hotplug)
 		return -ENODEV;
@@ -508,8 +512,10 @@ int pci_hp_deregister(struct hotplug_slot *hotplug)
 
 	hotplug->release(hotplug);
 	slot->hotplug = NULL;
+	bus = slot->bus;
 	pci_destroy_slot(slot);
 	mutex_unlock(&pci_hp_mutex);
+	pm_runtime_resume(&bus->self->dev);
 
 	return 0;
 }
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 08c243a..beb9c90 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -154,9 +154,11 @@ static int pcie_port_runtime_idle(struct device *dev)
 	 */
 	pci_walk_bus(pdev->subordinate, pci_dev_pme_poll, &pme_poll);
 	/* Delay for a short while to prevent too frequent suspend/resume */
-	if (!pme_poll)
-		pm_schedule_suspend(dev, 10);
-	return -EBUSY;
+	if (pme_poll)
+		return -EBUSY;
+	if (pci_bus_has_hotplug_slots(pdev->subordinate))
+		return -EBUSY;
+	return pm_schedule_suspend(dev, 10);
 }
 #else
 #define pcie_port_runtime_suspend	NULL
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index ac6412f..10b275b 100644
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
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2461033a..0d0cc94 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -722,6 +722,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 void pci_destroy_slot(struct pci_slot *slot);
 void pci_renumber_slot(struct pci_slot *slot, int slot_nr);
 int pci_scan_slot(struct pci_bus *bus, int devfn);
+bool pci_bus_has_hotplug_slots(struct pci_bus *bus);
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
 unsigned int pci_scan_child_bus(struct pci_bus *bus);


