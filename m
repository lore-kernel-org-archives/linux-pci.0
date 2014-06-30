Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:62738 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752209AbaF3IhI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jun 2014 04:37:08 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Phil Edworthy <phil.edworthy@renesas.com>
In-Reply-To: <1404114864-17330-4-git-send-email-phil.edworthy@renesas.com>
References: <1404114864-17330-4-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1404117421-17557-1-git-send-email-phil.edworthy@renesas.com>
Date: Mon, 30 Jun 2014 09:37:01 +0100
Subject: [PATCH v2 3/3] PCI: host: pcie-rcar: Replace arg passed into a func with
 local var
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
With SoB this time...

 drivers/pci/host/pcie-rcar.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 758e2b4..efdea07 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -319,9 +319,10 @@ static struct pci_ops rcar_pcie_ops = {
 	.write	= rcar_pcie_write_conf,
 };
 
-static void rcar_pcie_setup_window(int win, struct resource *res,
-				   struct rcar_pcie *pcie)
+static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie)
 {
+	struct resource *res = &pcie->res[win];
+
 	/* Setup PCIe address space mappings for each resource */
 	resource_size_t size;
 	u32 mask;
@@ -362,7 +363,7 @@ static int rcar_pcie_setup(int nr, struct pci_sys_data *sys)
 		if (!res->flags)
 			continue;
 
-		rcar_pcie_setup_window(i, res, pcie);
+		rcar_pcie_setup_window(i, pcie);
 
 		if (res->flags & IORESOURCE_IO)
 			pci_ioremap_io(nr * SZ_64K, res->start);
-- 
2.0.0

