Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:43522 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbbBBFJt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 00:09:49 -0500
Received: by mail-pa0-f53.google.com with SMTP id kx10so77526086pab.12
        for <linux-pci@vger.kernel.org>; Sun, 01 Feb 2015 21:09:49 -0800 (PST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, phil.edworthy@renesas.com,
	horms+renesas@verge.net.au,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: [PATCH] PCI: rcar: Fix postion of MSI enable bit
Date: Mon,  2 Feb 2015 14:09:39 +0900
Message-Id: <1422853779-14413-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Position of MSI enable bit is 31bit, not 28bit.
This fixes position of MSI bit necessary to initialize MSI.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index bb36e27..eb12659 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -505,7 +505,7 @@ static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
 
 	/* Enable MSI */
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		rcar_pci_write_reg(pcie, 0x101f0000, PCIEMSITXR);
+		rcar_pci_write_reg(pcie, 0x801f0000, PCIEMSITXR);
 
 	/* Finish initialization - establish a PCI Express link */
 	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
-- 
2.1.3

