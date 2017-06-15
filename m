Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34341 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbdFOItx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2017 04:49:53 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: kishon@ti.com, bhelgaas@google.com
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: dwc: dra7xx: Fix compilation warning.
Date: Thu, 15 Jun 2017 14:19:20 +0530
Message-Id: <a2736e3907827e7b39dd85381101c1080012584c.1497514167.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

drivers/pci/dwc/pci-dra7xx.c: In function ‘dra7xx_pcie_enable_msi_interrupts’:
drivers/pci/dwc/pci-dra7xx.c:177:7: warning: large integer implicitly truncated to unsigned type [-Woverflow]
       ~LEG_EP_INTERRUPTS & ~MSI);
       ^
drivers/pci/dwc/pci-dra7xx.c: In function ‘dra7xx_pcie_enable_wrapper_interrupts’:
drivers/pci/dwc/pci-dra7xx.c:187:7: warning: large integer implicitly truncated to unsigned type [-Woverflow]
       ~INTERRUPTS);

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
Changes in v2:
             Add casts in the definitions.
Changes in v3:
             Change logic insted of casting.

 drivers/pci/dwc/pci-dra7xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 8decf46..668dc15 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -174,7 +174,7 @@ static int dra7xx_pcie_establish_link(struct dw_pcie *pci)
 static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
 {
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
-			   ~LEG_EP_INTERRUPTS & ~MSI);
+			   LEG_EP_INTERRUPTS | MSI);
 
 	dra7xx_pcie_writel(dra7xx,
 			   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
@@ -184,7 +184,7 @@ static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
 static void dra7xx_pcie_enable_wrapper_interrupts(struct dra7xx_pcie *dra7xx)
 {
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
-			   ~INTERRUPTS);
+			   INTERRUPTS);
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN,
 			   INTERRUPTS);
 }
-- 
1.9.1
