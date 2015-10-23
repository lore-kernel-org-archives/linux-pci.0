Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36280 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbbJWFGI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:06:08 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 25/29] PCI: Update pci-versatile to use IRQ deferred assignment
Date: Fri, 23 Oct 2015 06:03:58 +0100
Message-Id: <1445576642-29624-26-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci-versatile platform device is using the fixup irqs code which
will be removed later in the code to migrate to deffered irq
assignment. This patch migrates it to use the new code path and
adds support for deffered irq assignment

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 drivers/pci/host/pci-versatile.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index 0863d9c..7f98f72 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -135,6 +135,7 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	u32 val;
 	void __iomem *local_pci_cfg_base;
 	struct pci_bus *bus;
+	struct pci_host_bridge *bridge;
 	LIST_HEAD(pci_res);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -211,8 +212,10 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	bus = pci_scan_root_bus(&pdev->dev, 0, &pci_versatile_ops, &sys, &pci_res);
 	if (!bus)
 		return -ENOMEM;
-
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+	
+	bridge = pci_find_host_bridge(bus);
+	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->map_irq = of_irq_parse_and_map_pci;
 	pci_assign_unassigned_bus_resources(bus);
 	pci_bus_add_devices(bus);
 
-- 
2.6.2

