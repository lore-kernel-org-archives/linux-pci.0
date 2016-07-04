Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33514 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbcGDQPr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2016 12:15:47 -0400
Received: by mail-qk0-f175.google.com with SMTP id e3so67313644qkd.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Jul 2016 09:15:46 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
To: dongbo4@huawei.com, bhelgaas@google.com, jingoohan1@gmail.com
Cc: linux-pci@vger.kernel.org,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] pcie/designware: Exchange viewport of `MEMORYs' and `CFGs/IOs'
Date: Mon,  4 Jul 2016 21:44:43 +0530
Message-Id: <6d3805a5e0fbbbd73beba80c2c9151b26399ea67.1467647958.git.panand@redhat.com>
In-Reply-To: <cover.1467647958.git.panand@redhat.com>
References: <cover.1467647958.git.panand@redhat.com>
In-Reply-To: <cover.1467647958.git.panand@redhat.com>
References: <cover.1467647958.git.panand@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dong Bo <dongbo4@huawei.com>

When we have only two view ports in a designware PCIe platform, then iatu0
is used for both CFG and IO accesses.  When CFGs are sent to peripherals
(e.g. lspci), iatu0 frequently switches between CFG and IO alternatively.

For such scenarios, a MEMORY might be sent as an IOs by mistake.
Considering the following configurations:
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

We can still have issues with IO transfer, however memory transfer is used
predominantly therefore we are just minimizing the risk of failure.
Actually, we can not do much when we have only two viewports. We can either
not allow the less frequent IO transfers at all, or can live with a
remote possibility of getting it corrupted.

Signed-off-by: Dong Bo <dongbo4@huawei.com>
[pratyush.anand@gmail.com: Modified commit log to capture remote risk]
Signed-off-by: Pratyush Anand <pratyush.anand@gmail.com>
---
 drivers/pci/host/pcie-designware.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 4c17c02ad72b..fe3d48c318df 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -604,12 +604,12 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		va_cfg_base = pp->va_cfg1_base;
 	}
 
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
 				  type, cpu_addr,
 				  busdev, cfg_size);
 	ret = dw_pcie_cfg_read(va_cfg_base + where, size, val);
 	if (pp->num_viewport <= 2)
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
 					  PCIE_ATU_TYPE_IO, pp->io_base,
 					  pp->io_bus_addr, pp->io_size);
 
@@ -642,12 +642,12 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		va_cfg_base = pp->va_cfg1_base;
 	}
 
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
 				  type, cpu_addr,
 				  busdev, cfg_size);
 	ret = dw_pcie_cfg_write(va_cfg_base + where, size, val);
 	if (pp->num_viewport <= 2)
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
 					  PCIE_ATU_TYPE_IO, pp->io_base,
 					  pp->io_bus_addr, pp->io_size);
 
@@ -786,7 +786,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * we should not program the ATU here.
 	 */
 	if (!pp->ops->rd_other_conf) {
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
 					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
 		if (pp->num_viewport > 2)
-- 
2.5.5

