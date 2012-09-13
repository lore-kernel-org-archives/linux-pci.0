Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39282 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758534Ab2IMQCh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Sep 2012 12:02:37 -0400
Received: by pbbrr13 with SMTP id rr13so4170633pbb.19
        for <linux-pci@vger.kernel.org>; Thu, 13 Sep 2012 09:02:37 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 1/2] PCI: introduce root bridge hotplug safe interfaces to walk root buses
Date: Fri, 14 Sep 2012 00:00:09 +0800
Message-Id: <1347552010-6718-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <CAErSpo4=cakjCQ_Z_nUa2xZQr9KV72kxtsgrW0cjeFN=ktb8zQ@mail.gmail.com>
References: <CAErSpo4=cakjCQ_Z_nUa2xZQr9KV72kxtsgrW0cjeFN=ktb8zQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch introduces two root bridge hotplug safe interfaces to walk
all root buses. Function pci_get_root_buses() takes a snopshot of the
pci_root_buses list and holds a reference count to each root buses.
pci_{get|put}_root_buses are used to replace hotplug unsafe interface
pci_find_next_bus().

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
Hi Bjorn,
	How about this solution? We could avoid the global lock by
taking a snapshot of the pci_root_buses list.
	These two patches just pass basic compilation tests on x86:)
	Regards!
	Gerry
---
 arch/ia64/hp/common/sba_iommu.c   |   10 +++++++---
 arch/ia64/sn/kernel/io_common.c   |   12 ++++++-----
 arch/sparc/kernel/pci.c           |   15 ++++++++------
 arch/x86/pci/common.c             |   10 ++++++++--
 drivers/edac/i7core_edac.c        |    9 ++++++---
 drivers/gpu/drm/drm_fops.c        |   10 +++++++---
 drivers/pci/hotplug/sgi_hotplug.c |    7 ++++++-
 drivers/pci/pci-sysfs.c           |    9 ++++++---
 drivers/pci/search.c              |   40 +++++++++++++++++++++++++++++++++++++
 include/linux/pci.h               |   11 ++++++++++
 10 files changed, 107 insertions(+), 26 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index bcda5b2..2903c58 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -2155,9 +2155,13 @@ sba_init(void)
 
 #ifdef CONFIG_PCI
 	{
-		struct pci_bus *b = NULL;
-		while ((b = pci_find_next_bus(b)) != NULL)
-			sba_connect_bus(b);
+		int i, count;
+		struct pci_bus **buses = NULL;
+
+		buses = pci_get_root_buses(&count);
+		for (i = 0; i < count; i++)
+			sba_connect_bus(buses[i]);
+		pci_put_root_buses(buses, count);
 	}
 #endif
 
diff --git a/arch/ia64/sn/kernel/io_common.c b/arch/ia64/sn/kernel/io_common.c
index 8630875..f667971 100644
--- a/arch/ia64/sn/kernel/io_common.c
+++ b/arch/ia64/sn/kernel/io_common.c
@@ -516,7 +516,8 @@ arch_initcall(sn_io_early_init);
 int __init
 sn_io_late_init(void)
 {
-	struct pci_bus *bus;
+	int i, count;
+	struct pci_bus **buses
 	struct pcibus_bussoft *bussoft;
 	cnodeid_t cnode;
 	nasid_t nasid;
@@ -530,9 +531,9 @@ sn_io_late_init(void)
 	 * PIC, TIOCP, TIOCE (TIOCA does it during bus fixup using
 	 * info from the PROM).
 	 */
-	bus = NULL;
-	while ((bus = pci_find_next_bus(bus)) != NULL) {
-		bussoft = SN_PCIBUS_BUSSOFT(bus);
+	buses = pci_get_root_buses(&count);
+	for (i = 0; i < count; i++) {
+		bussoft = SN_PCIBUS_BUSSOFT(buses[i]);
 		nasid = NASID_GET(bussoft->bs_base);
 		cnode = nasid_to_cnodeid(nasid);
 		if ((bussoft->bs_asic_type == PCIIO_ASIC_TYPE_TIOCP) ||
@@ -547,9 +548,10 @@ sn_io_late_init(void)
 				       "to find near node with CPUs for "
 				       "node %d, err=%d\n", cnode, e);
 			}
-			PCI_CONTROLLER(bus)->node = near_cnode;
+			PCI_CONTROLLER(buses[i])->node = near_cnode;
 		}
 	}
+	pci_put_root_buses(buses, count);
 
 	sn_ioif_inited = 1;	/* SN I/O infrastructure now initialized */
 
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 0e8f43a..00d2a83 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -1005,23 +1005,26 @@ static void __devinit pci_bus_slot_names(struct device_node *node,
 
 static int __init of_pci_slot_init(void)
 {
-	struct pci_bus *pbus = NULL;
+	int i, count;
+	struct pci_bus **buses;
 
-	while ((pbus = pci_find_next_bus(pbus)) != NULL) {
+	buses = pci_get_root_buses(&count);
+	for (i = 0; i < count; i++) {
 		struct device_node *node;
 
-		if (pbus->self) {
+		if (buses[i]->self) {
 			/* PCI->PCI bridge */
-			node = pbus->self->dev.of_node;
+			node = buses[i]->self->dev.of_node;
 		} else {
-			struct pci_pbm_info *pbm = pbus->sysdata;
+			struct pci_pbm_info *pbm = buses[i]->sysdata;
 
 			/* Host PCI controller */
 			node = pbm->op->dev.of_node;
 		}
 
-		pci_bus_slot_names(node, pbus);
+		pci_bus_slot_names(node, buses[i]);
 	}
+	pci_put_root_buses(buses, count);
 
 	return 0;
 }
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 720e973f..986be6e 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -446,14 +446,20 @@ void __init dmi_check_pciprobe(void)
 
 struct pci_bus * __devinit pcibios_scan_root(int busnum)
 {
-	struct pci_bus *bus = NULL;
+	int i, count;
+	struct pci_bus *bus;
+	struct pci_bus **buses;
 
-	while ((bus = pci_find_next_bus(bus)) != NULL) {
+	buses = pci_get_root_buses(&count);
+	for (i = 0; i < count; i++) {
+		bus = buses[i];
 		if (bus->number == busnum) {
+			pci_put_root_buses(buses, count);
 			/* Already scanned */
 			return bus;
 		}
 	}
+	pci_put_root_buses(buses, count);
 
 	return pci_scan_bus_on_node(busnum, &pci_root_ops,
 					get_mp_bus_to_node(busnum));
diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 3672101..4f4b221 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1294,14 +1294,17 @@ static void __init i7core_xeon_pci_fixup(const struct pci_id_table *table)
 static unsigned i7core_pci_lastbus(void)
 {
 	int last_bus = 0, bus;
-	struct pci_bus *b = NULL;
+	int i, count;
+	struct pci_bus **buses;
 
-	while ((b = pci_find_next_bus(b)) != NULL) {
-		bus = b->number;
+	buses = pci_get_root_buses(&count);
+	for (i = 0; i < count; i++) {
+		bus = buses[i]->number;
 		edac_dbg(0, "Found bus %d\n", bus);
 		if (bus > last_bus)
 			last_bus = bus;
 	}
+	pci_put_root_buses(buses, count);
 
 	edac_dbg(0, "Last bus %d\n", last_bus);
 
diff --git a/drivers/gpu/drm/drm_fops.c b/drivers/gpu/drm/drm_fops.c
index 5062eec..1a9955f 100644
--- a/drivers/gpu/drm/drm_fops.c
+++ b/drivers/gpu/drm/drm_fops.c
@@ -340,9 +340,13 @@ static int drm_open_helper(struct inode *inode, struct file *filp,
 			pci_dev_put(pci_dev);
 		}
 		if (!dev->hose) {
-			struct pci_bus *b = pci_bus_b(pci_root_buses.next);
-			if (b)
-				dev->hose = b->sysdata;
+			int count;
+			struct pci_bus **buses;
+
+			buses = pci_get_root_buses(&count);
+			if (count > 0)
+				dev->hose = buses[0]->sysdata;
+			pci_put_root_buses(buses, count);
 		}
 	}
 #endif
diff --git a/drivers/pci/hotplug/sgi_hotplug.c b/drivers/pci/hotplug/sgi_hotplug.c
index f64ca92..6ec3ecb 100644
--- a/drivers/pci/hotplug/sgi_hotplug.c
+++ b/drivers/pci/hotplug/sgi_hotplug.c
@@ -679,8 +679,10 @@ alloc_err:
 static int __init sn_pci_hotplug_init(void)
 {
 	struct pci_bus *pci_bus = NULL;
+	struct pci_bus **buses;
 	int rc;
 	int registered = 0;
+	int i, count;
 
 	if (!sn_prom_feature_available(PRF_HOTPLUG_SUPPORT)) {
 		printk(KERN_ERR "%s: PROM version does not support hotplug.\n",
@@ -690,7 +692,9 @@ static int __init sn_pci_hotplug_init(void)
 
 	INIT_LIST_HEAD(&sn_hp_list);
 
-	while ((pci_bus = pci_find_next_bus(pci_bus))) {
+	buses = pci_get_root_buses(&count);
+	for (i = 0; i < count; i++) {
+		pci_bus = buses[i];
 		if (!pci_bus->sysdata)
 			continue;
 
@@ -709,6 +713,7 @@ static int __init sn_pci_hotplug_init(void)
 			break;
 		}
 	}
+	pci_put_root_buses(buses, count);
 
 	return registered == 1 ? 0 : -ENODEV;
 }
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6869009..f8e9309 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -290,15 +290,18 @@ static ssize_t bus_rescan_store(struct bus_type *bus, const char *buf,
 				size_t count)
 {
 	unsigned long val;
-	struct pci_bus *b = NULL;
+	int i, num;
+	struct pci_bus **buses;
 
 	if (strict_strtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
 	if (val) {
 		mutex_lock(&pci_remove_rescan_mutex);
-		while ((b = pci_find_next_bus(b)) != NULL)
-			pci_rescan_bus(b);
+		buses = pci_get_root_buses(&num);
+		for (i = 0; i < num; i++)
+			pci_rescan_bus(buses[i]);
+		pci_put_root_buses(buses, num);
 		mutex_unlock(&pci_remove_rescan_mutex);
 	}
 	return count;
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 8f68dbe..8b20a33 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -140,6 +140,46 @@ pci_find_next_bus(const struct pci_bus *from)
 	return b;
 }
 
+struct pci_bus **
+pci_get_root_buses(int *bus_num)
+{
+	int count;
+	struct pci_bus *bus;
+	struct pci_bus **buses = NULL;
+
+	down_read(&pci_bus_sem);
+
+	count = 0;
+	list_for_each_entry(bus, &pci_root_buses, node)
+		count++;
+
+	if (count)
+		buses = kmalloc(sizeof(*buses) * count, GFP_KERNEL);
+
+	if (buses) {
+		count = 0;
+		list_for_each_entry(bus, &pci_root_buses, node)
+			buses[count++] = pci_bus_get(bus);
+		*bus_num = count;
+	} else
+		*bus_num = 0;
+
+	up_read(&pci_bus_sem);
+
+	return buses;
+}
+EXPORT_SYMBOL(pci_get_root_buses);
+
+void pci_put_root_buses(struct pci_bus **buses, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		pci_bus_put(buses[i]);
+	kfree(buses);
+}
+EXPORT_SYMBOL(pci_put_root_buses);
+
 /**
  * pci_get_slot - locate PCI device for a given PCI slot
  * @bus: PCI bus on which desired PCI device resides
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 98de988..bc1ab5f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -757,6 +757,8 @@ int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
 int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
+struct pci_bus ** pci_get_root_buses(int *bus_num);
+void pci_put_root_buses(struct pci_bus **buses, int count);
 
 struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
 				struct pci_dev *from);
@@ -1402,6 +1404,15 @@ static inline void pci_unblock_cfg_access(struct pci_dev *dev)
 static inline struct pci_bus *pci_find_next_bus(const struct pci_bus *from)
 { return NULL; }
 
+static inline struct pci_bus ** pci_get_root_buses(int *bus_num)
+{
+	*bus_num = 0;
+	return NULL;
+}
+
+static inline void pci_put_root_buses(struct pci_bus **buses, int count)
+{ }
+
 static inline struct pci_dev *pci_get_slot(struct pci_bus *bus,
 						unsigned int devfn)
 { return NULL; }
-- 
1.7.9.5

