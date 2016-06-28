Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:30935 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbcF1IQD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2016 04:16:03 -0400
Subject: [PATCH] Exchange the Assignments of `MEMORYs' and `CFGs/IOs' in
 Designware PCIe Driver
References: <1467100302-221983-1-git-send-email-zhaonenglong@hisilicon.com>
To: Pratyush Anand <pratyush.anand@gmail.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
From: "dongbo (E)" <dongbo4@huawei.com>
CC: Linuxarm <linuxarm@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Zhanweitao <zhanweitao@hisilicon.com>
Message-ID: <c72d2b44-a5d2-bd8f-16a7-2a80ae2b71eb@huawei.com>
Date: Tue, 28 Jun 2016 16:12:29 +0800
MIME-Version: 1.0
In-Reply-To: <1467100302-221983-1-git-send-email-zhaonenglong@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dong Bo <dongbo4@huawei.com>

In designware PCIe driver, the iatu0 is used for both CFG and IO accesses.
When sending CFGs to peripherals (e.g. lspci), iatu0 frequently switches
between CFG and IO alternatively.

A MEMORY probably be sent as an IOs by mistake. Considering the following
configurations:
MEMORY          ->      BASE_ADDR: 0xb4100000, LIMIT: 0xb4100FFF, TYPE=mem
CFG             ->      BASE_ADDR: 0xb4000000, LIMIT: 0xb4000FFF, TYPE=cfg
IO              ->      BASE_ADDR: 0xFFFFFFFF, LIMIT: 0xFFFFFFFE, TYPE=io

Suppose PCIe has just completed a CFG access, to switch back to IO, it set
the BASE_ADDR to 0xFFFFFFFF, LIMIT 0xFFFFFFFE and TYPE to io. When another
CFG comes, the BASE_ADDR is set to 0xb4000000 to switch to CFG. At this
moment, a MEMORY access shows up, since it matches with iatu0
(due to 0xb4000000 <= MEMORY BASE_ADDR <= MEMORY LIMIE <= 0xFFFFFFF), it
is treated as an IO access by mistake, then sent to perpheral.

This patch fixes the problem by exchanging the assignments of `MEMORYs'
and `CFGs/IOs', which assigning MEMEORYs to iatu0, CFGs and IOs to iatu1.

Signed-off-by: Dong Bo <dongbo4@huawei.com>
---
 drivers/pci/host/pcie-designware.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index aafd766..1bd88d9 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -599,11 +599,11 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		va_cfg_base = pp->va_cfg1_base;
 	}
 -	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
 				  type, cpu_addr,
 				  busdev, cfg_size);
 	ret = dw_pcie_cfg_read(va_cfg_base + where, size, val);
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
 				  PCIE_ATU_TYPE_IO, pp->io_base,
 				  pp->io_bus_addr, pp->io_size);
 @@ -636,11 +636,11 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		va_cfg_base = pp->va_cfg1_base;
 	}
 -	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
 				  type, cpu_addr,
 				  busdev, cfg_size);
 	ret = dw_pcie_cfg_write(va_cfg_base + where, size, val);
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
 				  PCIE_ATU_TYPE_IO, pp->io_base,
 				  pp->io_bus_addr, pp->io_size);
 @@ -779,7 +779,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * we should not program the ATU here.
 	 */
 	if (!pp->ops->rd_other_conf)
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
 					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
 -- 1.9.1


.


