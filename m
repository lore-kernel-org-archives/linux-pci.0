Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:42015 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbcEBOyr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2016 10:54:47 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: <kishon@ti.com>, <bhelgaas@google.com>, <jszhang@marvell.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Niklas Cassel <niklass@axis.com>
Subject: [PATCH] PCI: dra7xx: program outbound atu with correct address
Date: Mon, 2 May 2016 16:54:40 +0200
Message-ID: <1462200880-30129-1-git-send-email-niklass@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Niklas Cassel <niklas.cassel@axis.com>

commit 1488aefa37a4 ("PCI: designware: Move Root Complex
setup code to dw_pcie_setup_rc()") broke dra7xx
by moving code from dw_pcie_host_init to dw_pcie_setup_rc.

Fix this by doing the cpu to bus calculation before calling
dw_pcie_setup_rc.

Fixes: 1488aefa37a4 ("PCI: designware: Move Root Complex setup code to dw_pcie_setup_rc()")
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/host/pci-dra7xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 2ca3a1f..f441130 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -142,13 +142,13 @@ static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
 
 static void dra7xx_pcie_host_init(struct pcie_port *pp)
 {
-	dw_pcie_setup_rc(pp);
-
 	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
 	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
 	pp->cfg0_base &= DRA7XX_CPU_TO_BUS_ADDR;
 	pp->cfg1_base &= DRA7XX_CPU_TO_BUS_ADDR;
 
+	dw_pcie_setup_rc(pp);
+
 	dra7xx_pcie_establish_link(pp);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
-- 
2.1.4

