Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:22849 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbcFVI33 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2016 04:29:29 -0400
From: "dongbo (E)" <dongbo4@huawei.com>
To: "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linuxarm <linuxarm@huawei.com>,
	Zhanweitao <zhanweitao@hisilicon.com>
Subject: [PATCH] Decouple CFG and IO in Designware PCIe Driver
Date: Wed, 22 Jun 2016 08:24:51 +0000
Message-ID: <BEF013ED77979042B16A827A9AC75AF820FA4C5E@SZXEMI502-MBS.china.huawei.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dong Bo <dongbo4@huawei.com>

In designware PCIe driver, the iatu0 is used for both CFG and IO accesses.
When PCIe sends CFGs to peripherals (e.g. lspci),
iatu0 frequently switches between CFG and IO alternatively.

If the LIMIT of MEMORY is a value between CFGs BASE_ADDR and IOs LIMIT, 
this probably results in a MEMORY beging matched to be an IO by mistake.

Considering the following configurations:
MEMORY          ->      BASE_ADDR: 0xb4100000, LIMIT: 0xb4100FFF, TYPE=mem
CFG             ->      BASE_ADDR: 0xb4000000, LIMIT: 0xb4000FFF, TYPE=cfg
IO              ->      BASE_ADDR: 0xFFFFFFFF, LIMIT: 0xFFFFFFFE, TYPE=io
Suppose PCIe has just completed a CFG access, to switch back to IO, it set the BASE_ADDR to 0xFFFFFFFF, LIMIT 0xFFFFFFFE and TYPE to io.
When another CFG access come,
PCIe first set BASE_ADDR to 0xb4000000 to switch to CFG.
At this moment, a MEMORY access shows up, due to `0xb4000000 <= MEMORY BASE_ADDR <= MEMORY LIMIE <= 0xFFFFFFF, it matches with iatu0.
And it is treated as an IO access by mistake, then sent to perpheral.

This patch fixes the problem by decoupling CFG and IO, reassigning iatu2 to IO.

Signed-off-by: Dong Bo <dongbo4@huawei.com>
---
 drivers/pci/host/pcie-designware.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index aafd766..1a40305 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -51,6 +51,7 @@
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
 #define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
+#define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
 #define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
 #define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
 #define PCIE_ATU_CR1			0x904
@@ -603,9 +604,6 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				  type, cpu_addr,
 				  busdev, cfg_size);
 	ret = dw_pcie_cfg_read(va_cfg_base + where, size, val);
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-				  PCIE_ATU_TYPE_IO, pp->io_base,
-				  pp->io_bus_addr, pp->io_size);
 
 	return ret;
 }
@@ -640,9 +638,6 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				  type, cpu_addr,
 				  busdev, cfg_size);
 	ret = dw_pcie_cfg_write(va_cfg_base + where, size, val);
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-				  PCIE_ATU_TYPE_IO, pp->io_base,
-				  pp->io_bus_addr, pp->io_size);
 
 	return ret;
 }
@@ -778,10 +773,15 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * uses its own address translation component rather than ATU, so
 	 * we should not program the ATU here.
 	 */
-	if (!pp->ops->rd_other_conf)
+	if (!pp->ops->rd_other_conf) {
 		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
 					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX2,
+					PCIE_ATU_TYPE_IO, pp->io_base,
+					pp->io_bus_addr, pp->io_size);
+
+	}
 
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
 
--
1.9.1

