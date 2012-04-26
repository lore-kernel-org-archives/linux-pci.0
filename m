Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:48103 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005Ab2DZKm1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 06:42:27 -0400
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A58D63EE0B5
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:42:26 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8EFFF45DE4D
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:42:26 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6D53A45DD78
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:42:26 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 596101DB8038
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:42:26 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com [10.240.81.136])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1501E1DB802C
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:42:26 +0900 (JST)
Date: Thu, 26 Apr 2012 19:42:20 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: liuj97@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Keping Chen <chenkeping@huawei.com>, ddutile@redhat.com,
	greg.pearson@hp.com
Subject: [PATCH 4/6] PCI, x86: introduce
 pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap()
Message-Id: <20120426194220.7ae3137f.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
References: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
1.7.5.4


