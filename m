Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40501 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108Ab2DIQZ6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2012 12:25:58 -0400
From: Jiang Liu <liuj97@gmail.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, x86@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH V2 4/6] PCI, x86: introduce pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap()
Date: Tue, 10 Apr 2012 00:22:46 +0800
Message-Id: <1333988568-11282-5-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1333988568-11282-1-git-send-email-jiang.liu@huawei.com>
References: <1333988568-11282-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap(), which will be used
when supporting PCI root bridge hotplug.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 arch/x86/include/asm/pci_x86.h |    2 ++
 arch/x86/pci/mmconfig_32.c     |   15 +++++++++++++++
 arch/x86/pci/mmconfig_64.c     |   22 +++++++++++++++++++++-
 3 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index b3a5317..4611294 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -135,6 +135,8 @@ struct pci_mmcfg_region {
 
 extern int __init pci_mmcfg_arch_init(void);
 extern void __init pci_mmcfg_arch_free(void);
+extern int __devinit pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
+extern void __devinit pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
 extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
 
 extern struct list_head pci_mmcfg_list;
diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.c
index 5dad04a..c2756de 100644
--- a/arch/x86/pci/mmconfig_32.c
+++ b/arch/x86/pci/mmconfig_32.c
@@ -141,3 +141,18 @@ int __init pci_mmcfg_arch_init(void)
 void __init pci_mmcfg_arch_free(void)
 {
 }
+
+int __devinit pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg)
+{
+	return 0;
+}
+
+void __devinit pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg)
+{
+	unsigned long flags;
+
+	/* Invalidate the cached mmcfg map entry. */
+	raw_spin_lock_irqsave(&pci_config_lock, flags);
+	mmcfg_last_accessed_device = 0;
+	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
+}
diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
index acc48c5..6822dd6 100644
--- a/arch/x86/pci/mmconfig_64.c
+++ b/arch/x86/pci/mmconfig_64.c
@@ -95,7 +95,7 @@ static const struct pci_raw_ops pci_mmcfg = {
 	.write =	pci_mmcfg_write,
 };
 
-static void __iomem * __init mcfg_ioremap(struct pci_mmcfg_region *cfg)
+static void __iomem * __devinit mcfg_ioremap(struct pci_mmcfg_region *cfg)
 {
 	void __iomem *addr;
 	u64 start, size;
@@ -138,3 +138,23 @@ void __init pci_mmcfg_arch_free(void)
 		}
 	}
 }
+
+int __devinit pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg)
+{
+	cfg->virt = mcfg_ioremap(cfg);
+	if (!cfg->virt) {
+		printk(KERN_ERR PREFIX "can't map MMCONFIG at %pR\n",
+		       &cfg->res);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void __devinit pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg)
+{
+	if (cfg && cfg->virt) {
+		iounmap(cfg->virt + PCI_MMCFG_BUS_OFFSET(cfg->start_bus));
+		cfg->virt = NULL;
+	}
+}
-- 
1.7.5.4

