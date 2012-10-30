Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:51304 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab2J3G0Y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Oct 2012 02:26:24 -0400
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A2FF73EE0BC
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:26:23 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8993745DE55
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:26:23 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6E85E45DE53
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:26:23 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5F8FAE38003
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:26:23 +0900 (JST)
Received: from m003.s.css.fujitsu.com (m003.s.css.fujitsu.com [10.23.4.33])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1A0541DB803C
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:26:23 +0900 (JST)
Date: Tue, 30 Oct 2012 15:26:18 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 4/5] PCI: Change the signature of pci_ext_cfg_avail function
Message-Id: <20121030152618.511c41de.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20121030062124.BE34D2E0805@m003.s.css.fujitsu.com>
References: <20121030062124.BE34D2E0805@m003.s.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


PCI: change the signature of pci_ext_cfg_avail function

The default implementation of pci_ext_cfg_avail and
its only overridden function for x86 architecture doesn't
use passed *pci_dev. This patch ommits the parameter of
pci_ext_cfg_avail function.


Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 arch/x86/pci/common.c   |    2 +-
 drivers/acpi/pci_root.c |    2 +-
 drivers/pci/pci.c       |    5 ++---
 include/linux/pci.h     |    2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

Index: pci/arch/x86/pci/common.c
===================================================================
--- pci.orig/arch/x86/pci/common.c
+++ pci/arch/x86/pci/common.c
@@ -626,7 +626,7 @@ void pcibios_disable_device (struct pci_
 		pcibios_disable_irq(dev);
 }
 
-int pci_ext_cfg_avail(struct pci_dev *dev)
+int pci_ext_cfg_avail(void)
 {
 	if (raw_pci_ext_ops)
 		return 1;
Index: pci/drivers/acpi/pci_root.c
===================================================================
--- pci.orig/drivers/acpi/pci_root.c
+++ pci/drivers/acpi/pci_root.c
@@ -564,7 +564,7 @@ static int __devinit acpi_pci_root_add(s
 		acpi_pci_bridge_scan(child);
 
 	/* Indicate support for various _OSC capabilities. */
-	if (pci_ext_cfg_avail(root->bus->self))
+	if (pci_ext_cfg_avail())
 		flags |= OSC_EXT_PCI_CONFIG_SUPPORT;
 	if (pcie_aspm_support_enabled())
 		flags |= OSC_ACTIVE_STATE_PWR_SUPPORT |
Index: pci/drivers/pci/pci.c
===================================================================
--- pci.orig/drivers/pci/pci.c
+++ pci/drivers/pci/pci.c
@@ -3833,14 +3833,13 @@ static void __devinit pci_no_domains(voi
 }
 
 /**
- * pci_ext_cfg_enabled - can we access extended PCI config space?
- * @dev: The PCI device of the root bridge.
+ * pci_ext_cfg_avail - can we access extended PCI config space?
  *
  * Returns 1 if we can access PCI extended config space (offsets
  * greater than 0xff). This is the default implementation. Architecture
  * implementations can override this.
  */
-int __weak pci_ext_cfg_avail(struct pci_dev *dev)
+int __weak pci_ext_cfg_avail(void)
 {
 	return 1;
 }
Index: pci/include/linux/pci.h
===================================================================
--- pci.orig/include/linux/pci.h
+++ pci/include/linux/pci.h
@@ -1623,7 +1623,7 @@ static inline void pci_mmcfg_early_init(
 static inline void pci_mmcfg_late_init(void) { }
 #endif
 
-int pci_ext_cfg_avail(struct pci_dev *dev);
+int pci_ext_cfg_avail(void);
 
 void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
 

