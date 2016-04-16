Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:15856 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbcDPLEf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2016 07:04:35 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <pratyush.anand@gmail.com>, <jingoohan1@gmail.com>
CC: <gabriele.paoloni@huawei.com>, <linuxarm@huawei.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<helgaas@kernel.org>
Subject: [PATCH v2] PCI: Designware: remove wrong RC memory base/limit configuration
Date: Sat, 16 Apr 2016 12:03:39 +0100
Message-ID: <1460804619-2972-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently dw_pcie_setup_rc configures memory base and memory
limit in the type1 configuration header for the root complex.
In doing so it uses the cpu address (pp->mem_base) rather than
the bus address (pp->mem_bus_addr): this is wrong and it is
useless since the configuration is overwritten later on when
pci_bus_assign_resources() is called.

Therefore this patch just removes this configuration from
dw_pcie_setup_rc.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---

v1 -> v2 : removed unused variables in dw_pcie_setup_rc()

---
 drivers/pci/host/pcie-designware.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index a4cccd3..e3cb1f9 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -728,8 +728,6 @@ static struct pci_ops dw_pcie_ops = {
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val;
-	u32 membase;
-	u32 memlimit;
 
 	/* set the number of lanes */
 	dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL, &val);
@@ -788,12 +786,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	val |= 0x00010100;
 	dw_pcie_writel_rc(pp, val, PCI_PRIMARY_BUS);
 
-	/* setup memory base, memory limit */
-	membase = ((u32)pp->mem_base & 0xfff00000) >> 16;
-	memlimit = (pp->mem_size + (u32)pp->mem_base) & 0xfff00000;
-	val = memlimit | membase;
-	dw_pcie_writel_rc(pp, val, PCI_MEMORY_BASE);
-
 	/* setup command register */
 	dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
 	val &= 0xffff0000;
-- 
2.1.4


