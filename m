Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([58.251.152.66]:34469 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160Ab2EWDwG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2012 23:52:06 -0400
Received: from huawei.com (szxga03-in [172.24.2.9])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4G0010PIPSFL@szxga03-in.huawei.com> for
 linux-pci@vger.kernel.org; Wed, 23 May 2012 11:51:28 +0800 (CST)
Received: from szxrg02-dlp.huawei.com ([172.24.2.119])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4G00G5KIPSQM@szxga03-in.huawei.com> for
 linux-pci@vger.kernel.org; Wed, 23 May 2012 11:51:28 +0800 (CST)
Date: Wed, 23 May 2012 11:50:21 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH v6 4/9] PCI,
 x86: introduce pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap()
In-reply-to: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <liuj97@gmail.com>, Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Message-id: <1337745026-1180-5-git-send-email-jiang.liu@huawei.com>
MIME-version: 1.0
Content-type: text/plain
References: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <liuj97@gmail.com>

From: Jiang Liu <jiang.liu@huawei.com>

Introduce pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap(), which will be used
when supporting PCI root bridge hotplug.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/x86/include/asm/pci_x86.h |    2 ++
 arch/x86/pci/mmconfig_32.c     |   15 +++++++++++++++
 arch/x86/pci/mmconfig_64.c     |   22 +++++++++++++++++++++-
 3 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index b3a5317..df898ce 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -135,6 +135,8 @@ struct pci_mmcfg_region {
 
 extern int __init pci_mmcfg_arch_init(void);
 extern void __init pci_mmcfg_arch_free(void);
+extern int __devinit pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
+extern void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
 extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
 
 extern struct list_head pci_mmcfg_list;
diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.c
index 5dad04a..a22785d 100644
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
+void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg)
+{
+	unsigned long flags;
+
+	/* Invalidate the cached mmcfg map entry. */
+	raw_spin_lock_irqsave(&pci_config_lock, flags);
+	mmcfg_last_accessed_device = 0;
+	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
+}
diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
index acc48c5..4e05779 100644
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
+void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg)
+{
+	if (cfg && cfg->virt) {
+		iounmap(cfg->virt + PCI_MMCFG_BUS_OFFSET(cfg->start_bus));
+		cfg->virt = NULL;
+	}
+}
-- 
1.7.1


