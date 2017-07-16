Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33313 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbdGPVQf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Jul 2017 17:16:35 -0400
Received: by mail-qk0-f196.google.com with SMTP id a66so17589497qkb.0
        for <linux-pci@vger.kernel.org>; Sun, 16 Jul 2017 14:16:34 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: thomas.petazzoni@free-electrons.com, jason@lakedaemon.net,
        linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] PCI: mvebu: Remove unneeded gpiod NULL check
Date: Sun, 16 Jul 2017 18:16:13 -0300
Message-Id: <1500239773-15632-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

The gpiod API checks for NULL descriptors, so there is no need to
duplicate the check in the driver.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/host/pci-mvebu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index f353a6e..fa227d8 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1186,8 +1186,7 @@ static int mvebu_pcie_powerup(struct mvebu_pcie_port *port)
  */
 static void mvebu_pcie_powerdown(struct mvebu_pcie_port *port)
 {
-	if (port->reset_gpio)
-		gpiod_set_value_cansleep(port->reset_gpio, 1);
+	gpiod_set_value_cansleep(port->reset_gpio, 1);
 
 	clk_disable_unprepare(port->clk);
 }
-- 
2.7.4
