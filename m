Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42860 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761307Ab2FVG5q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 02:57:46 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so1941745dad.19
        for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 23:57:46 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v10 08/13] x86/PCI: update MMCFG information when hot-plugging PCI host bridges
Date: Fri, 22 Jun 2012 14:55:17 +0800
Message-Id: <1340348122-29021-9-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1340348122-29021-1-git-send-email-jiang.liu@huawei.com>
References: <1340348122-29021-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

This patch enhances x86 arch specific code to update MMCFG information
when PCI host bridge hotplug event happens.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/include/asm/pci_x86.h |    1 +
 arch/x86/pci/acpi.c            |   93 ++++++++++++++++++++++++++++++++++++++--
 arch/x86/pci/mmconfig_32.c     |    2 +-
 arch/x86/pci/mmconfig_64.c     |    2 +-
 4 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index af5018f..b2652e9 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -100,6 +100,7 @@ struct pci_raw_ops {
 extern const struct pci_raw_ops *raw_pci_ops;
 extern const struct pci_raw_ops *raw_pci_ext_ops;
 
+extern const struct pci_raw_ops pci_mmcfg;
 extern const struct pci_raw_ops pci_direct_conf1;
 extern bool port_cf9_safe;
 
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 2bb885a..912b54b 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -13,6 +13,12 @@ struct pci_root_info {
 	unsigned int res_num;
 	struct resource *res;
 	struct pci_sysdata sd;
+#ifdef	CONFIG_PCI_MMCONFIG
+	bool mcfg_added;
+	u16 segment;
+	u8 start_bus;
+	u8 end_bus;
+#endif
 };
 
 static bool pci_use_crs = true;
@@ -119,6 +125,81 @@ void __init pci_acpi_crs_quirks(void)
 	       pci_use_crs ? "nocrs" : "use_crs");
 }
 
+#ifdef	CONFIG_PCI_MMCONFIG
+static int __devinit check_segment(u16 seg, struct device *dev, char *estr)
+{
+	if (seg) {
+		dev_err(dev,
+			"%s can't access PCI configuration "
+			"space under this host bridge.\n",
+			estr);
+		return -EIO;
+	}
+
+	/*
+	 * Failure in adding MMCFG information is not fatal,
+	 * just can't access extended configuration space of
+	 * devices under this host bridge.
+	 */
+	dev_warn(dev,
+		 "%s can't access extended PCI configuration "
+		 "space under this bridge.\n",
+		 estr);
+
+	return 0;
+}
+
+static int __devinit setup_mcfg_map(struct pci_root_info *info,
+				    u16 seg, u8 start, u8 end,
+				    phys_addr_t addr)
+{
+	int result;
+	struct device *dev = &info->bridge->dev;
+
+	info->start_bus = start;
+	info->end_bus = end;
+	info->mcfg_added = false;
+
+	/* return success if MMCFG is not in use */
+	if (raw_pci_ext_ops && raw_pci_ext_ops != &pci_mmcfg)
+		return 0;
+
+	if (!(pci_probe & PCI_PROBE_MMCONF))
+		return check_segment(seg, dev, "MMCONFIG is disabled,");
+
+	result = pci_mmconfig_insert(dev, seg, start, end, addr);
+	if (result == 0) {
+		/* enable MMCFG if it hasn't been enabled yet */
+		if (raw_pci_ext_ops == NULL)
+			raw_pci_ext_ops = &pci_mmcfg;
+		info->mcfg_added = true;
+	} else if (result != -EEXIST)
+		return check_segment(seg, dev,
+			 "fail to add MMCONFIG information,");
+
+	return 0;
+}
+
+static void teardown_mcfg_map(struct pci_root_info *info)
+{
+	if (info->mcfg_added) {
+		pci_mmconfig_delete(info->segment, info->start_bus,
+				    info->end_bus);
+		info->mcfg_added = false;
+	}
+}
+#else
+static int __devinit setup_mcfg_map(struct pci_root_info *info,
+				    u16 seg, u8 start, u8 end,
+				    phys_addr_t addr)
+{
+	return 0;
+}
+static void teardown_mcfg_map(struct pci_root_info *info)
+{
+}
+#endif
+
 static acpi_status
 resource_to_addr(struct acpi_resource *resource,
 			struct acpi_resource_address64 *addr)
@@ -331,8 +412,11 @@ static void __release_pci_root_info(struct pci_root_info *info)
 
 	free_pci_root_info_res(info);
 
+	teardown_mcfg_map(info);
+
 	kfree(info);
 }
+
 static void release_pci_root_info(struct pci_host_bridge *bridge)
 {
 	struct pci_root_info *info = bridge->release_data;
@@ -372,7 +456,7 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
 	int domain = root->segment;
 	int busnum = root->secondary.start;
 	LIST_HEAD(resources);
-	struct pci_bus *bus;
+	struct pci_bus *bus = NULL;
 	struct pci_sysdata *sd;
 	int node;
 #ifdef CONFIG_ACPI_NUMA
@@ -438,8 +522,11 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
 			x86_pci_root_bus_resources(busnum, &resources);
 		}
 
-		bus = pci_create_root_bus(NULL, busnum, &pci_root_ops, sd,
-					  &resources);
+		if (!setup_mcfg_map(info, domain, (u8)root->secondary.start,
+				    (u8)root->secondary.end, root->mcfg_addr))
+			bus = pci_create_root_bus(NULL, busnum, &pci_root_ops,
+						  sd, &resources);
+
 		if (bus) {
 			pci_scan_child_bus(bus);
 			pci_set_host_bridge_release(
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
index ebefea5..c206521 100644
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
1.7.9.5

