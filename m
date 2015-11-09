Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52427 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972AbbKIS4r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Nov 2015 13:56:47 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH] drivers: pci: remove unused pci_sys_data structures
Date: Mon,  9 Nov 2015 18:57:39 +0000
Message-Id: <1447095459-21777-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit b3a72384fe29 ("ARM/PCI: Replace pci_sys_data->align_resource
with global function pointer") removed the struct pci_sys_data
dependency from the ARM pcibios functions that are part of the
common ARM PCI arch back-end (eg pcibios_align_resource()), so that
struct pci_sys_data has now become data that is only used internally
by the ARM bios32 layer (ie pci_common_init_dev()) and by host
controllers drivers callbacks (eg pci_sys_data.setup) that rely on the
ARM bios32 API to probe.

PCI host controller drivers that do not rely on ARM bios32 calls to
probe do not need to have the pci_bus.sysdata pointer field pointing
at a struct pci_sys_data anymore, therefore it can be removed from the
respective drivers data structures.

This patch removes the pci_sys_data structures from the host
controller drivers that do not rely on ARM bios32 interface to
scan the PCI bus, completing the pci_sys_data clean-up and removing
the related dependency on arch/arm specific data.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>
---
Rob,

I could not test it on versatile, only compile tested, so
please have an additional look.

Tested the PCI host generic on 32-bit and 64-bit guests,
through kvmtool.

Thanks,
Lorenzo

 drivers/pci/host/pci-host-generic.c | 9 ---------
 drivers/pci/host/pci-versatile.c    | 5 +----
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 5434c90..1652bc7 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -38,16 +38,7 @@ struct gen_pci_cfg_windows {
 	struct gen_pci_cfg_bus_ops		*ops;
 };
 
-/*
- * ARM pcibios functions expect the ARM struct pci_sys_data as the PCI
- * sysdata.  Add pci_sys_data as the first element in struct gen_pci so
- * that when we use a gen_pci pointer as sysdata, it is also a pointer to
- * a struct pci_sys_data.
- */
 struct gen_pci {
-#ifdef CONFIG_ARM
-	struct pci_sys_data			sys;
-#endif
 	struct pci_host_bridge			host;
 	struct gen_pci_cfg_windows		cfg;
 	struct list_head			resources;
diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index 0863d9c..f843a72 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -125,9 +125,6 @@ out_release_res:
 	return err;
 }
 
-/* Unused, temporary to satisfy ARM arch code */
-struct pci_sys_data sys;
-
 static int versatile_pci_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -208,7 +205,7 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	pci_add_flags(PCI_ENABLE_PROC_DOMAINS);
 	pci_add_flags(PCI_REASSIGN_ALL_BUS | PCI_REASSIGN_ALL_RSRC);
 
-	bus = pci_scan_root_bus(&pdev->dev, 0, &pci_versatile_ops, &sys, &pci_res);
+	bus = pci_scan_root_bus(&pdev->dev, 0, &pci_versatile_ops, NULL, &pci_res);
 	if (!bus)
 		return -ENOMEM;
 
-- 
2.5.1

