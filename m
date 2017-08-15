Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:58254 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753144AbdHOTMR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2017 15:12:17 -0400
From: Paul Burton <paul.burton@imgtec.com>
To: <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v7 2/3] PCI: xilinx: Don't enable config completion interrupts
Date: Tue, 15 Aug 2017 12:11:16 -0700
Message-ID: <20170815191117.19882-3-paul.burton@imgtec.com>
In-Reply-To: <20170815191117.19882-1-paul.burton@imgtec.com>
References: <20170815191117.19882-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Xilinx AXI bridge for PCI Express device provides interrupts
indicating the completion of config space accesses. We have previously
enabled/unmasked them but do nothing with them besides acknowledge them.

Leave the interrupts masked in order to avoid servicing a large number
of pointless interrupts during boot.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Ravikiran Gummaluri <rgummal@xilinx.com>
Cc: linux-pci@vger.kernel.org
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/host/pcie-xilinx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index a7880bed56fc..f30d03309c7f 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -60,6 +60,7 @@
 #define XILINX_PCIE_INTR_MST_SLVERR	BIT(27)
 #define XILINX_PCIE_INTR_MST_ERRP	BIT(28)
 #define XILINX_PCIE_IMR_ALL_MASK	0x1FF30FED
+#define XILINX_PCIE_IMR_ENABLE_MASK	0x1FF30F0D
 #define XILINX_PCIE_IDR_ALL_MASK	0xFFFFFFFF
 
 /* Root Port Error FIFO Read Register definitions */
@@ -554,8 +555,8 @@ static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)
 			 XILINX_PCIE_IMR_ALL_MASK,
 		   XILINX_PCIE_REG_IDR);
 
-	/* Enable all interrupts */
-	pcie_write(port, XILINX_PCIE_IMR_ALL_MASK, XILINX_PCIE_REG_IMR);
+	/* Enable all interrupts we handle */
+	pcie_write(port, XILINX_PCIE_IMR_ENABLE_MASK, XILINX_PCIE_REG_IMR);
 
 	/* Enable the Bridge enable bit */
 	pcie_write(port, pcie_read(port, XILINX_PCIE_REG_RPSC) |
-- 
2.14.1
