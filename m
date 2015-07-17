Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:59140 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756717AbbGQJUz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2015 05:20:55 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <rajatja@google.com>,
	<linux@roeck-us.net>, <rjw@rjwysocki.net>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 1/2] PCI: Use a local mutex instead of pci_bus_sem to avoid deadlock
Date: Fri, 17 Jul 2015 17:16:31 +0800
Message-ID: <1437124592-2070-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1437124592-2070-1-git-send-email-wangyijing@huawei.com>
References: <1437124592-2070-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rajat Jain reported a deadlock when a hierarchical hot plug
thread and aer recovery thread both run.
https://lkml.org/lkml/2015/3/11/861

thread 1:
pciehp_enable_slot()
	pciehp_configure_device()
		pci_bus_add_devices()
			device_attach(dev)
				device_lock(dev) //acquire device mutex successfully
			...
			pciehp_probe(dev)
				__pci_hp_register()
					pci_create_slot()
						down_write(pci_bus_sem) //deadlock here

thread 2:
aer_isr_one_error()
	aer_process_err_device()
		do_recovery()
			broadcast_error_message()
				pci_walk_bus()
					down_read(&pci_bus_sem) //acquire pci_bus_sem successfully
						report_error_detected(dev)
							device_lock(dev) // deadlock here

We use down_write(&pci_bus_sem) to protect the bus->slots list, because the
bus->slots list is only accessed in drivers/pci/slot.c, we could introduce
a new local mutex to protect bus->slots, and use down_read(&pci_bus_sem)
instead of down_write(&pci_bus_sem) to protect the bus->devices list.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/slot.c  |   15 ++++++++++-----
 include/linux/pci.h |    3 ++-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 396c200..a9079d9 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -14,6 +14,7 @@
 
 struct kset *pci_slots_kset;
 EXPORT_SYMBOL_GPL(pci_slots_kset);
+static DEFINE_MUTEX(pci_slot_mutex);
 
 static ssize_t pci_slot_attr_show(struct kobject *kobj,
 					struct attribute *attr, char *buf)
@@ -106,9 +107,11 @@ static void pci_slot_release(struct kobject *kobj)
 	dev_dbg(&slot->bus->dev, "dev %02x, released physical slot %s\n",
 		slot->number, pci_slot_name(slot));
 
+	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list)
 		if (PCI_SLOT(dev->devfn) == slot->number)
 			dev->slot = NULL;
+	up_read(&pci_bus_sem);
 
 	list_del(&slot->list);
 
@@ -195,7 +198,7 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
 {
 	struct pci_slot *slot;
 	/*
-	 * We already hold pci_bus_sem so don't worry
+	 * We already hold pci_slot_mutex so don't worry
 	 */
 	list_for_each_entry(slot, &parent->slots, list)
 		if (slot->number == slot_nr) {
@@ -253,7 +256,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	int err = 0;
 	char *slot_name = NULL;
 
-	down_write(&pci_bus_sem);
+	mutex_lock(&pci_slot_mutex);
 
 	if (slot_nr == -1)
 		goto placeholder;
@@ -301,16 +304,18 @@ placeholder:
 	INIT_LIST_HEAD(&slot->list);
 	list_add(&slot->list, &parent->slots);
 
+	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
 		if (PCI_SLOT(dev->devfn) == slot_nr)
 			dev->slot = slot;
+	up_read(&pci_bus_sem);
 
 	dev_dbg(&parent->dev, "dev %02x, created physical slot %s\n",
 		slot_nr, pci_slot_name(slot));
 
 out:
 	kfree(slot_name);
-	up_write(&pci_bus_sem);
+	mutex_unlock(&pci_slot_mutex);
 	return slot;
 err:
 	kfree(slot);
@@ -332,9 +337,9 @@ void pci_destroy_slot(struct pci_slot *slot)
 	dev_dbg(&slot->bus->dev, "dev %02x, dec refcount to %d\n",
 		slot->number, atomic_read(&slot->kobj.kref.refcount) - 1);
 
-	down_write(&pci_bus_sem);
+	mutex_lock(&pci_slot_mutex);
 	kobject_put(&slot->kobj);
-	up_write(&pci_bus_sem);
+	mutex_unlock(&pci_slot_mutex);
 }
 EXPORT_SYMBOL_GPL(pci_destroy_slot);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8a0321a..34cc95d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -446,7 +446,8 @@ struct pci_bus {
 	struct list_head children;	/* list of child buses */
 	struct list_head devices;	/* list of devices on this bus */
 	struct pci_dev	*self;		/* bridge device as seen by parent */
-	struct list_head slots;		/* list of slots on this bus */
+	struct list_head slots;		/* list of slots on this bus, we use a local pci_slot_mutex instead of
+		                           pci_bus_sem to protect this list to fix a potential ABBA deadlock */
 	struct resource *resource[PCI_BRIDGE_RESOURCE_NUM];
 	struct list_head resources;	/* address space routed to this bus */
 	struct resource busn_res;	/* bus numbers routed to this bus */
-- 
1.7.1

