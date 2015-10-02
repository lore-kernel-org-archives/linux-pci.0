Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:7086 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750730AbbJBK3d (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2015 06:29:33 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Phil Edworthy <phil.edworthy@renesas.com>
In-Reply-To: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1443781507-5011-5-git-send-email-phil.edworthy@renesas.com>
Date: Fri, 2 Oct 2015 11:25:07 +0100
Subject: [PATCH 4/4] PCI: rcar-pcie: Fix IO offset for multiple instances
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 8e583c2..f4fa6c5 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -108,6 +108,8 @@
 #define RCAR_PCI_MAX_RESOURCES 4
 #define MAX_NR_INBOUND_MAPS 6
 
+static unsigned long global_io_offset;
+
 struct rcar_msi {
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
@@ -357,7 +359,7 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie)
 	rcar_pci_write_reg(pcie, mask, PCIEPTCTLR(win));
 }
 
-static int rcar_pcie_setup(int nr, struct list_head *resource, struct rcar_pcie *pcie)
+static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pcie)
 {
 	struct resource *res;
 	int i;
@@ -375,7 +377,8 @@ static int rcar_pcie_setup(int nr, struct list_head *resource, struct rcar_pcie
 
 		if (res->flags & IORESOURCE_IO) {
 			phys_addr_t io_start = pci_pio_to_address(res->start);
-			pci_ioremap_io(nr * SZ_64K, io_start);
+			pci_ioremap_io(global_io_offset, io_start);
+			global_io_offset += SZ_64K;
 		}
 
 		pci_add_resource(resource, res);
@@ -390,7 +393,7 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
 	struct pci_bus *bus, *child;
 	LIST_HEAD(res);
 
-	rcar_pcie_setup(1, &res, pcie);
+	rcar_pcie_setup(&res, pcie);
 
 	/* Do not reassign resources if probe only */
 	if (!pci_has_flag(PCI_PROBE_ONLY))
-- 
1.9.1

