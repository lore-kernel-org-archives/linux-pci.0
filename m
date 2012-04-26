Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:35376 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754850Ab2DZKkB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 06:40:01 -0400
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 908F43EE0BB
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:40:00 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 766CE45DE51
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:40:00 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5B44A45DE4E
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:40:00 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 47F52E18002
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:40:00 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 001181DB803B
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:39:59 +0900 (JST)
Date: Thu, 26 Apr 2012 19:39:53 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: liuj97@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Keping Chen <chenkeping@huawei.com>, ddutile@redhat.com,
	greg.pearson@hp.com
Subject: [PATCH 1/6] PCI, x86: split out pci_mmcfg_check_reserved() for code
 reuse
Message-Id: <20120426193953.b789bdb6.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
References: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Split out pci_mmcfg_check_reserved() for code reuse, which will be used
when supporting PCI host bridge hotplug.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 arch/x86/pci/mmconfig-shared.c |   51 ++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

Index: bjorn-next/arch/x86/pci/mmconfig-shared.c
===================================================================
--- bjorn-next.orig/arch/x86/pci/mmconfig-shared.c
+++ bjorn-next/arch/x86/pci/mmconfig-shared.c
@@ -474,39 +474,38 @@ static int __init is_mmconf_reserved(che
 	return valid;
 }
 
+static int __devinit pci_mmcfg_check_reserved(struct pci_mmcfg_region *cfg,
+					      int early)
+{
+	if (!early && !acpi_disabled) {
+		if (is_mmconf_reserved(is_acpi_reserved, cfg, 0))
+			return true;
+		else
+			printk(KERN_ERR FW_BUG PREFIX
+			       "MMCONFIG at %pR not reserved in "
+			       "ACPI motherboard resources\n",
+			       &cfg->res);
+	}
+
+	/* Don't try to do this check unless configuration
+	   type 1 is available. how about type 2 ?*/
+	if (raw_pci_ops)
+		return is_mmconf_reserved(e820_all_mapped, cfg, 1);
+
+	return false;
+}
+
 static void __init pci_mmcfg_reject_broken(int early)
 {
 	struct pci_mmcfg_region *cfg;
 
 	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
-		int valid = 0;
-
-		if (!early && !acpi_disabled) {
-			valid = is_mmconf_reserved(is_acpi_reserved, cfg, 0);
-
-			if (valid)
-				continue;
-			else
-				printk(KERN_ERR FW_BUG PREFIX
-				       "MMCONFIG at %pR not reserved in "
-				       "ACPI motherboard resources\n",
-				       &cfg->res);
+		if (pci_mmcfg_check_reserved(cfg, early) == false) {
+			printk(KERN_INFO PREFIX "not using MMCONFIG\n");
+			free_all_mmcfg();
+			return;
 		}
-
-		/* Don't try to do this check unless configuration
-		   type 1 is available. how about type 2 ?*/
-		if (raw_pci_ops)
-			valid = is_mmconf_reserved(e820_all_mapped, cfg, 1);
-
-		if (!valid)
-			goto reject;
 	}
-
-	return;
-
-reject:
-	printk(KERN_INFO PREFIX "not using MMCONFIG\n");
-	free_all_mmcfg();
 }
 
 static int __initdata known_bridge;

