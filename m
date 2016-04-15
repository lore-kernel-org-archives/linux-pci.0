Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <pratyush.anand@gmail.com>, <jingoohan1@gmail.com>
CC: <gabriele.paoloni@huawei.com>, <linuxarm@huawei.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<helgaas@kernel.org>
Subject: [PATCH] PCI: Designware: remove wrong RC memory base/limit configuration
Date: Sat, 16 Apr 2016 00:21:23 +0800
Message-ID: <1460737283-117495-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

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
 drivers/pci/host/pcie-designware.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index a4cccd3..e48c2cb 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -788,12 +788,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
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
1.9.1
