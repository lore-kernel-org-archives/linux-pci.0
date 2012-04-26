Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:43700 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421Ab2DZKmG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 06:42:06 -0400
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 83D0B3EE081
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:42:04 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 67B4945DE54
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:42:04 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4EE2645DE52
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:42:04 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1C6A0E1800C
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:42:04 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.240.81.146])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id BB859E18001
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:42:03 +0900 (JST)
Date: Thu, 26 Apr 2012 19:41:57 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: liuj97@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Keping Chen <chenkeping@huawei.com>, ddutile@redhat.com,
	greg.pearson@hp.com
Subject: [PATCH 3/6] PCI, x86: use RCU list to protect mmconfig list
Message-Id: <20120426194157.61d379bb.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
References: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use RCU list to protect mmconfig list from dynamic change
when supporting PCI host bridge hotplug.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 arch/x86/pci/mmconfig-shared.c |   11 ++++++-----
 arch/x86/pci/mmconfig_32.c     |   13 +++++++++++--
 arch/x86/pci/mmconfig_64.c     |   13 +++++++++++--
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 5e2cd2a..3bcc361 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -17,6 +17,7 @@
 #include <linux/bitmap.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
+#include <linux/rculist.h>
 #include <asm/e820.h>
 #include <asm/pci_x86.h>
 #include <asm/acpi.h>
@@ -45,20 +46,20 @@ static __init void free_all_mmcfg(void)
 		pci_mmconfig_remove(cfg);
 }
 
-static __init void list_add_sorted(struct pci_mmcfg_region *new)
+static __devinit void list_add_sorted(struct pci_mmcfg_region *new)
 {
 	struct pci_mmcfg_region *cfg;
 
 	/* keep list sorted by segment and starting bus number */
-	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
+	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list) {
 		if (cfg->segment > new->segment ||
 		    (cfg->segment == new->segment &&
 		     cfg->start_bus >= new->start_bus)) {
-			list_add_tail(&new->list, &cfg->list);
+			list_add_tail_rcu(&new->list, &cfg->list);
 			return;
 		}
 	}
-	list_add_tail(&new->list, &pci_mmcfg_list);
+	list_add_tail_rcu(&new->list, &pci_mmcfg_list);
 }
 
 static __devinit struct pci_mmcfg_region *pci_mmconfig_alloc(int segment,
@@ -111,7 +112,7 @@ struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus)
 {
 	struct pci_mmcfg_region *cfg;
 
-	list_for_each_entry(cfg, &pci_mmcfg_list, list)
+	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list)
 		if (cfg->segment == segment &&
 		    cfg->start_bus <= bus && bus <= cfg->end_bus)
 			return cfg;
diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.c
index 5372e86..5dad04a 100644
--- a/arch/x86/pci/mmconfig_32.c
+++ b/arch/x86/pci/mmconfig_32.c
@@ -11,6 +11,7 @@
 
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/rcupdate.h>
 #include <asm/e820.h>
 #include <asm/pci_x86.h>
 #include <acpi/acpi.h>
@@ -60,9 +61,12 @@ err:		*value = -1;
 		return -EINVAL;
 	}
 
+	rcu_read_lock();
 	base = get_base_addr(seg, bus, devfn);
-	if (!base)
+	if (!base) {
+		rcu_read_unlock();
 		goto err;
+	}
 
 	raw_spin_lock_irqsave(&pci_config_lock, flags);
 
@@ -80,6 +84,7 @@ err:		*value = -1;
 		break;
 	}
 	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -93,9 +98,12 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 	if ((bus > 255) || (devfn > 255) || (reg > 4095))
 		return -EINVAL;
 
+	rcu_read_lock();
 	base = get_base_addr(seg, bus, devfn);
-	if (!base)
+	if (!base) {
+		rcu_read_unlock();
 		return -EINVAL;
+	}
 
 	raw_spin_lock_irqsave(&pci_config_lock, flags);
 
@@ -113,6 +121,7 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 		break;
 	}
 	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
+	rcu_read_unlock();
 
 	return 0;
 }
diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
index 915a493..acc48c5 100644
--- a/arch/x86/pci/mmconfig_64.c
+++ b/arch/x86/pci/mmconfig_64.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
+#include <linux/rcupdate.h>
 #include <asm/e820.h>
 #include <asm/pci_x86.h>
 
@@ -34,9 +35,12 @@ err:		*value = -1;
 		return -EINVAL;
 	}
 
+	rcu_read_lock();
 	addr = pci_dev_base(seg, bus, devfn);
-	if (!addr)
+	if (!addr) {
+		rcu_read_unlock();
 		goto err;
+	}
 
 	switch (len) {
 	case 1:
@@ -49,6 +53,7 @@ err:		*value = -1;
 		*value = mmio_config_readl(addr + reg);
 		break;
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -62,9 +67,12 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 	if (unlikely((bus > 255) || (devfn > 255) || (reg > 4095)))
 		return -EINVAL;
 
+	rcu_read_lock();
 	addr = pci_dev_base(seg, bus, devfn);
-	if (!addr)
+	if (!addr) {
+		rcu_read_unlock();
 		return -EINVAL;
+	}
 
 	switch (len) {
 	case 1:
@@ -77,6 +85,7 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 		mmio_config_writel(addr + reg, value);
 		break;
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
-- 
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

