Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:38792 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964842AbbEEB6y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2015 21:58:54 -0400
From: Jayachandran C <jchandra@broadcom.com>
To: Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"Arnd Bergmann" <arnd@arndb.de>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>
CC: Jayachandran C <jchandra@broadcom.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Ming Lei <ming.lei@canonical.com>
Subject: [PATCH v2 1/2] PCI: generic: remove dependency on hw_pci
Date: Tue, 5 May 2015 07:32:12 +0530
Message-ID: <1430791333-26013-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current code in pci-host-generic.c uses pci_common_init_dev()
from the arch/arm/ to do a part of the PCI initialization, and this
prevents it from being used on arm64.

The initialization done by pci_common_init_dev() that is really
needed by pci-host-generic.c can be done in the same file without
using the hw_pci API of ARM.

The ARM platform requires a pci_sys_data as sysdata for the PCI bus,
this is be handled by setting up 'struct gen_pci' to embed a
pci_sys_data variable as the first element on the ARM platform.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
Here's v2 of the patches, this enables use of pci-host-generic on
arm64.

This has been tested on both qemu and fast model for arm64, and on
qemu for arm32.

v1->v2
 - Address comments from Arnd Bergmann and Lorenzo Pieralisi
    - move contents of gen_pci_init to gen_pci_probe
    - assign resources only when !probe_only
 - tested on ARM32 with qemu option -M virt

Notes:
 - passing a zeroed out pci_sys_data for ARM looks ok, but I haven't
   tested it on ARM.
 - tested it on ARM64 fast model
 - Any information on how this can be tested on arm is welcome.
 - There is only one ifdef, and that can be removed when arm64 gets
   a sysdata, or when arm loses its sysdata.

 drivers/pci/host/pci-host-generic.c | 50 +++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index ba46e58..e9cc559 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -39,6 +39,9 @@ struct gen_pci_cfg_windows {
 };
 
 struct gen_pci {
+#ifdef CONFIG_ARM
+	struct pci_sys_data			sys;
+#endif
 	struct pci_host_bridge			host;
 	struct gen_pci_cfg_windows		cfg;
 	struct list_head			resources;
@@ -48,8 +51,7 @@ static void __iomem *gen_pci_map_cfg_bus_cam(struct pci_bus *bus,
 					     unsigned int devfn,
 					     int where)
 {
-	struct pci_sys_data *sys = bus->sysdata;
-	struct gen_pci *pci = sys->private_data;
+	struct gen_pci *pci = bus->sysdata;
 	resource_size_t idx = bus->number - pci->cfg.bus_range->start;
 
 	return pci->cfg.win[idx] + ((devfn << 8) | where);
@@ -64,8 +66,7 @@ static void __iomem *gen_pci_map_cfg_bus_ecam(struct pci_bus *bus,
 					      unsigned int devfn,
 					      int where)
 {
-	struct pci_sys_data *sys = bus->sysdata;
-	struct gen_pci *pci = sys->private_data;
+	struct gen_pci *pci = bus->sysdata;
 	resource_size_t idx = bus->number - pci->cfg.bus_range->start;
 
 	return pci->cfg.win[idx] + ((devfn << 12) | where);
@@ -198,13 +199,6 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
 	return 0;
 }
 
-static int gen_pci_setup(int nr, struct pci_sys_data *sys)
-{
-	struct gen_pci *pci = sys->private_data;
-	list_splice_init(&pci->resources, &sys->resources);
-	return 1;
-}
-
 static int gen_pci_probe(struct platform_device *pdev)
 {
 	int err;
@@ -214,13 +208,7 @@ static int gen_pci_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	struct hw_pci hw = {
-		.nr_controllers	= 1,
-		.private_data	= (void **)&pci,
-		.setup		= gen_pci_setup,
-		.map_irq	= of_irq_parse_and_map_pci,
-		.ops		= &gen_pci_ops,
-	};
+	struct pci_bus *bus;
 
 	if (!pci)
 		return -ENOMEM;
@@ -258,7 +246,31 @@ static int gen_pci_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	pci_common_init_dev(dev, &hw);
+	/* do not reassign resource if probe only */
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_add_flags(PCI_REASSIGN_ALL_RSRC);
+
+	bus = pci_scan_root_bus(dev, 0, &gen_pci_ops, pci, &pci->resources);
+	if (!bus) {
+		dev_err(dev, "Scanning rootbus failed");
+		return -ENODEV;
+	}
+
+	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+
+	if (!pci_has_flag(PCI_PROBE_ONLY)) {
+		pci_bus_size_bridges(bus);
+		pci_bus_assign_resources(bus);
+	}
+	pci_bus_add_devices(bus);
+
+	/* Configure PCI Express settings */
+	if (pci_has_flag(PCI_PROBE_ONLY)) {
+		struct pci_bus *child;
+
+		list_for_each_entry(child, &bus->children, node)
+			pcie_bus_configure_settings(child);
+	}
 	return 0;
 }
 
-- 
1.9.1

