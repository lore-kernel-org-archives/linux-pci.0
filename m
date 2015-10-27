Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35506 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402AbbJ0XmM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2015 19:42:12 -0400
Received: by vkfw189 with SMTP id w189so131516333vkf.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2015 16:42:12 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: l.stach@pengutronix.de, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] PCI: imx6: Use gpio_set_value_cansleep()
Date: Tue, 27 Oct 2015 21:41:58 -0200
Message-Id: <1445989318-26461-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

We are in a context where we can sleep, and the PCIe reset gpio may be
on an I2C expander.  Use the cansleep() variant when setting the GPIO
value.

Based on a patch from Russell King for pci-mvebu.c.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/pci/host/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 6f43086..e73b7f2 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -289,9 +289,9 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 
 	/* Some boards don't have PCIe reset GPIO. */
 	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		gpio_set_value(imx6_pcie->reset_gpio, 0);
+		gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0);
 		msleep(100);
-		gpio_set_value(imx6_pcie->reset_gpio, 1);
+		gpio_set_value_cansleep(imx6_pcie->reset_gpio, 1);
 	}
 	return 0;
 
-- 
1.9.1

