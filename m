Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:34836 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756717AbbGQJVK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2015 05:21:10 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <rajatja@google.com>,
	<linux@roeck-us.net>, <rjw@rjwysocki.net>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 2/2] PCI: Lock pci_slot_mutex when traverse bus->slots
Date: Fri, 17 Jul 2015 17:16:32 +0800
Message-ID: <1437124592-2070-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1437124592-2070-1-git-send-email-wangyijing@huawei.com>
References: <1437124592-2070-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now we traverse bus->slots in pci_setup_device()
and other places without a lock protect. It's not
safe, if we traverse a bus->slots and free the slots
at the same time, system may crash. Now we have
pci_slot_mutex, use it to protect the bus->slots list.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/powerpc/kernel/pci_of_scan.c |    6 +-----
 arch/sparc/kernel/pci.c           |    6 +-----
 drivers/pci/probe.c               |    6 +-----
 drivers/pci/slot.c                |   11 +++++++++++
 include/linux/pci.h               |    1 +
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 42e02a2..5e2debf 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -126,7 +126,6 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 {
 	struct pci_dev *dev;
 	const char *type;
-	struct pci_slot *slot;
 
 	dev = pci_alloc_dev(bus);
 	if (!dev)
@@ -145,10 +144,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 	dev->needs_freset = 0;		/* pcie fundamental reset required */
 	set_pcie_port_type(dev);
 
-	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
-			dev->slot = slot;
-
+	pci_dev_assign_slot(dev);
 	dev->vendor = get_int_prop(node, "vendor-id", 0xffff);
 	dev->device = get_int_prop(node, "device-id", 0xffff);
 	dev->subsystem_vendor = get_int_prop(node, "subsystem-vendor-id", 0);
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index c928bc6..3a0e1a9 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -249,7 +249,6 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 					 struct pci_bus *bus, int devfn)
 {
 	struct dev_archdata *sd;
-	struct pci_slot *slot;
 	struct platform_device *op;
 	struct pci_dev *dev;
 	const char *type;
@@ -290,10 +289,7 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	dev->multifunction = 0;		/* maybe a lie? */
 	set_pcie_port_type(dev);
 
-	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
-			dev->slot = slot;
-
+	pci_dev_assign_slot(dev);
 	dev->vendor = of_getintprop_default(node, "vendor-id", 0xffff);
 	dev->device = of_getintprop_default(node, "device-id", 0xffff);
 	dev->subsystem_vendor =
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cefd636..2a9ce16 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1133,7 +1133,6 @@ int pci_setup_device(struct pci_dev *dev)
 {
 	u32 class;
 	u8 hdr_type;
-	struct pci_slot *slot;
 	int pos = 0;
 	struct pci_bus_region region;
 	struct resource *res;
@@ -1149,10 +1148,7 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->error_state = pci_channel_io_normal;
 	set_pcie_port_type(dev);
 
-	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
-			dev->slot = slot;
-
+	pci_dev_assign_slot(dev);
 	/* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
 	   set this higher, assuming the system even supports it.  */
 	dev->dma_mask = 0xffffffff;
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index a9079d9..b91d249 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -194,6 +194,17 @@ static int rename_slot(struct pci_slot *slot, const char *name)
 	return result;
 }
 
+void pci_dev_assign_slot(struct pci_dev *dev)
+{
+	struct pci_slot *slot;
+
+	mutex_lock(&pci_slot_mutex);
+	list_for_each_entry(slot, &dev->bus->slots, list)
+		if (PCI_SLOT(dev->devfn) == slot->number)
+			dev->slot = slot;
+	mutex_unlock(&pci_slot_mutex);
+}
+
 static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
 {
 	struct pci_slot *slot;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 34cc95d..0e81a6a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -798,6 +798,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 				 const char *name,
 				 struct hotplug_slot *hotplug);
 void pci_destroy_slot(struct pci_slot *slot);
+void pci_dev_assign_slot(struct pci_dev *dev);
 int pci_scan_slot(struct pci_bus *bus, int devfn);
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
-- 
1.7.1

