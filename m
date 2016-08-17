Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45434 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753742AbcHQUA0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Aug 2016 16:00:26 -0400
Subject: [PATCH v6 3/4] PCI: designware: Wait for iATU enable
To: Joao Pinto <Joao.Pinto@synopsys.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: jszhang@marvell.com, jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 17 Aug 2016 15:00:10 -0500
Message-ID: <20160817200010.10418.85101.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160817195239.10418.7037.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160817195239.10418.7037.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joao Pinto <Joao.Pinto@synopsys.com>

Add a loop with timeout to make sure the iATU is really enabled before
subsequent config and I/O accesses.

[bhelgaas: split to separate patch, use dev_err() instead of dev_dbg()]
Signed-off-by: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index e99f56e..947fac3 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -31,7 +31,12 @@
 #define LINK_WAIT_USLEEP_MIN		90000
 #define LINK_WAIT_USLEEP_MAX		100000
 
-/* Synopsis specific PCIE configuration registers */
+/* Parameters for the waiting for iATU enabled routine */
+#define LINK_WAIT_MAX_IATU_RETRIES	5
+#define LINK_WAIT_IATU_MIN		9000
+#define LINK_WAIT_IATU_MAX		10000
+
+/* Synopsys-specific PCIe configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
 #define PORT_LINK_MODE_MASK		(0x3f << 16)
 #define PORT_LINK_MODE_1_LANES		(0x1 << 16)
@@ -157,7 +162,7 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
 		int type, u64 cpu_addr, u64 pci_addr, u32 size)
 {
-	u32 val;
+	u32 retries, val;
 
 	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | index,
 			  PCIE_ATU_VIEWPORT);
@@ -174,7 +179,14 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
 	 * Make sure ATU enable takes effect before any subsequent config
 	 * and I/O accesses.
 	 */
-	val = dw_pcie_readl_rc(pp, PCIE_ATU_CR2);
+	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
+		val = dw_pcie_readl_rc(pp, PCIE_ATU_CR2);
+		if (val == PCIE_ATU_ENABLE)
+			return;
+
+		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+	}
+	dev_err(pp->dev, "iATU is not being enabled\n");
 }
 
 static struct irq_chip dw_msi_irq_chip = {

