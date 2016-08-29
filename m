Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32775 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755468AbcH2VOm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2016 17:14:42 -0400
Received: by mail-pf0-f182.google.com with SMTP id y134so48333pfg.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Aug 2016 14:14:41 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: <linux-kernel@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PCI: rockchip: Correct the register value for clearing client interrupts
Date: Mon, 29 Aug 2016 14:14:11 -0700
Message-Id: <1472505251-122204-1-git-send-email-briannorris@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm pretty sure the bitwise 'or' was meant for the value parameter, not
the register parameter.

This resolves an interrupt storm, where if we receive any client IRQs
(e.g., correctable errors), we fail to ever clear them properly, so they
reoccur indefinitely.

Fixes: 199410f6270e ("PCI: rockchip: Add Rockchip PCIe controller support")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
---
Patched against git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-rockchip

 drivers/pci/host/pcie-rockchip.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 8fb47ee9eaee..e77aec3cc869 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -689,9 +689,10 @@ static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
 			      PCIE_CLIENT_INT_MSG | PCIE_CLIENT_INT_HOT_RST |
 			      PCIE_CLIENT_INT_DPA | PCIE_CLIENT_INT_FATAL_ERR |
 			      PCIE_CLIENT_INT_NFATAL_ERR |
-			      PCIE_CLIENT_INT_CORR_ERR),
-			      PCIE_CLIENT_INT_STATUS |
-			      PCIE_CLIENT_INT_PHY);
+			      PCIE_CLIENT_INT_CORR_ERR |
+			      PCIE_CLIENT_INT_PHY),
+		   PCIE_CLIENT_INT_STATUS);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.8.0.rc3.226.g39d4020

