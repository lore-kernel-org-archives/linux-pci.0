Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([58.251.152.66]:34469 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933447Ab2EWDwI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2012 23:52:08 -0400
Date: Wed, 23 May 2012 11:50:24 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH v6 7/9] PCI, x86: update MMCFG information when hot-plugging
 PCI host bridges
In-reply-to: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <liuj97@gmail.com>, Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	linux-acpi <linux-acpi@vger.kernel.org>,
	linux-pci@vger.kernel.org
Message-id: <1337745026-1180-8-git-send-email-jiang.liu@huawei.com>
MIME-version: 1.0
Content-type: text/plain
References: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <liuj97@gmail.com>

From: Jiang Liu <jiang.liu@huawei.com>

This patch enhances x86 arch specific code to update MMCFG information
when PCI host bridge hotplug event happens.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/x86/include/asm/pci_x86.h |    1 +
 arch/x86/pci/acpi.c            |   71 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/pci/mmconfig-shared.c |    7 +---
 arch/x86/pci/mmconfig_32.c     |    2 +-
 arch/x86/pci/mmconfig_64.c     |    2 +-
 5 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 1a3c12f..a50e783 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -100,6 +100,7 @@ struct pci_raw_ops {
 extern const struct pci_raw_ops *raw_pci_ops;
 extern const struct pci_raw_ops *raw_pci_ext_ops;
 
+extern const struct pci_raw_ops pci_mmcfg;
 extern const struct pci_raw_ops pci_direct_conf1;
 extern bool port_cf9_safe;
 
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 2bb885a..ce29bdf 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -4,6 +4,7 @@
 #include <linux/irq.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
+#include <linux/pci-acpi.h>
 #include <asm/numa.h>
 #include <asm/pci_x86.h>
 
@@ -13,6 +14,12 @@ struct pci_root_info {
 	unsigned int res_num;
 	struct resource *res;
 	struct pci_sysdata sd;
+#ifdef	CONFIG_PCI_MMCONFIG
+	bool mcfg_added;
+	uint16_t segment;
+	uint8_t start_bus;
+	uint8_t end_bus;
+#endif
 };
 
 static bool pci_use_crs = true;
@@ -119,6 +126,63 @@ void __init pci_acpi_crs_quirks(void)
 	       pci_use_crs ? "nocrs" : "use_crs");
 }
 
+static int __devinit setup_mcfg_map(struct pci_root_info *info,
+				    uint16_t seg, uint8_t start, uint8_t end,
+				    phys_addr_t addr)
+{
+#ifdef	CONFIG_PCI_MMCONFIG
+	int result;
+
+	info->start_bus = start;
+	info->end_bus = end;
+	info->mcfg_added = false;
+
+	/* return success if MMCFG is not in use */
+	if (raw_pci_ext_ops && raw_pci_ext_ops != &pci_mmcfg)
+		return 0;
+
+	if (!(pci_probe & PCI_PROBE_MMCONF)) {
+		/* still could use raw_pci_ops for devices on segment 0 */
+		if (seg)
+			printk(KERN_WARNING
+				"MMCONFIG is disabled, can't access PCI device "
+				"configuration space on  %04x:%02x-%02x\n",
+				seg, start, end);
+		return 0;
+	}
+
+	result = pci_mmconfig_insert(seg, start, end, addr);
+	if (result == 0) {
+		/* enable MMCFG if it hasn't been enabled yet */
+		if (raw_pci_ext_ops == NULL)
+			raw_pci_ext_ops = &pci_mmcfg;
+		info->mcfg_added = true;
+	} else if (result != -EEXIST && addr) {
+		/*
+		 * Failure in adding MMCFG information is not fatal,
+		 * just can't access [extended] configuration space of
+		 * devices under this host bridge.
+		 */
+		printk(KERN_WARNING
+			"Fail to add MMCONFIG information for %04x:%02x-%02x\n",
+			seg, start, end);
+	}
+#endif
+
+	return 0;
+}
+
+static void teardown_mcfg_map(struct pci_root_info *info)
+{
+#ifdef	CONFIG_PCI_MMCONFIG
+	if (info->mcfg_added) {
+		pci_mmconfig_delete(info->segment, info->start_bus,
+				    info->end_bus);
+		info->mcfg_added = false;
+	}
+#endif
+}
+
 static acpi_status
 resource_to_addr(struct acpi_resource *resource,
 			struct acpi_resource_address64 *addr)
@@ -331,6 +395,8 @@ static void __release_pci_root_info(struct pci_root_info *info)
 
 	free_pci_root_info_res(info);
 
+	teardown_mcfg_map(info);
+
 	kfree(info);
 }
 static void release_pci_root_info(struct pci_host_bridge *bridge)
@@ -423,6 +489,11 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
 		memcpy(bus->sysdata, sd, sizeof(*sd));
 		kfree(info);
 	} else {
+		if (root->mcfg_addr)
+			setup_mcfg_map(info, root->segment,
+				       (uint8_t)root->secondary.start,
+				       root->mcfg_end_bus, root->mcfg_addr);
+
 		probe_pci_root_info(info, device, busnum, domain);
 
 		/* insert busn res at first */
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 8d0c287..4d0600b 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -707,7 +707,7 @@ int __devinit pci_mmconfig_insert(uint16_t seg, uint8_t start, uint8_t end,
 	struct resource *tmp;
 	struct pci_mmcfg_region *cfg;
 
-	if (start > end)
+	if (start > end || !addr)
 		return -EINVAL;
 
 	if (pci_mmcfg_arch_init_failed)
@@ -726,11 +726,6 @@ int __devinit pci_mmconfig_insert(uint16_t seg, uint8_t start, uint8_t end,
 		return -EEXIST;
 	}
 
-	if (!addr) {
-		mutex_unlock(&pci_mmcfg_lock);
-		return -EINVAL;
-	}
-
 	rc = -EBUSY;
 	cfg = pci_mmconfig_alloc(seg, start, end, addr);
 	if (cfg == NULL) {
diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.c
index a22785d..db63ac2 100644
--- a/arch/x86/pci/mmconfig_32.c
+++ b/arch/x86/pci/mmconfig_32.c
@@ -126,7 +126,7 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 	return 0;
 }
 
-static const struct pci_raw_ops pci_mmcfg = {
+const struct pci_raw_ops pci_mmcfg = {
 	.read =		pci_mmcfg_read,
 	.write =	pci_mmcfg_write,
 };
diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
index 4e05779..34c08dd 100644
--- a/arch/x86/pci/mmconfig_64.c
+++ b/arch/x86/pci/mmconfig_64.c
@@ -90,7 +90,7 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 	return 0;
 }
 
-static const struct pci_raw_ops pci_mmcfg = {
+const struct pci_raw_ops pci_mmcfg = {
 	.read =		pci_mmcfg_read,
 	.write =	pci_mmcfg_write,
 };
-- 
1.7.1


