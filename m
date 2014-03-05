Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33540 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572AbaCEN0g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Mar 2014 08:26:36 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Shawn Guo <shawn.guo@linaro.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de
Subject: [PATCH v2 6/6] PCI: designware: use new OF interrupt mapping when possible
Date: Wed,  5 Mar 2014 14:25:51 +0100
Message-Id: <1394025951-32438-7-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is the recommended method of doing the IRQ
mapping. For old devicetrees we fall back to the
previous practice.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2: pass in parent dev to relevant functions, to make DT parsing
    work (spotted by Tim Harvey <tharvey@gateworks.com>)
---
 drivers/pci/host/pcie-designware.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 17ce88f79d2b..98c118e04dba 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
+#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/types.h>
@@ -492,7 +493,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	dw_pci.nr_controllers = 1;
 	dw_pci.private_data = (void **)&pp;
 
-	pci_common_init(&dw_pci);
+	pci_common_init_dev(pp->dev, &dw_pci);
 	pci_assign_unassigned_resources();
 #ifdef CONFIG_PCI_DOMAINS
 	dw_pci.domain++;
@@ -725,7 +726,7 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 
 	if (pp) {
 		pp->root_bus_nr = sys->busnr;
-		bus = pci_scan_root_bus(NULL, sys->busnr, &dw_pcie_ops,
+		bus = pci_scan_root_bus(pp->dev, sys->busnr, &dw_pcie_ops,
 					sys, &sys->resources);
 	} else {
 		bus = NULL;
@@ -738,8 +739,13 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
+	int irq;
 
-	return pp->irq;
+	irq = of_irq_parse_and_map_pci(dev, slot, pin);
+	if (!irq)
+		irq = pp->irq;
+
+	return irq;
 }
 
 static void dw_pcie_add_bus(struct pci_bus *bus)
-- 
1.9.0

