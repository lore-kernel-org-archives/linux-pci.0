Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33496 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbdHTAGw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Aug 2017 20:06:52 -0400
Received: by mail-qt0-f196.google.com with SMTP id 57so2414585qtu.0
        for <linux-pci@vger.kernel.org>; Sat, 19 Aug 2017 17:06:52 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: heiko@sntech.de, linux-pci@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] PCI: rockchip: Use gpiod_set_value_cansleep() to allow reset via expanders
Date: Sat, 19 Aug 2017 21:07:14 -0300
Message-Id: <1503187634-3823-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The reset GPIO can be connected to a I2C or SPI IO expander, which may
sleep, so it is safer to use the gpiod_set_value_cansleep() variant
instead.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/pci/host/pcie-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 2eccd53..124b280 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -537,7 +537,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	int err, i;
 	u32 status;
 
-	gpiod_set_value(rockchip->ep_gpio, 0);
+	gpiod_set_value_cansleep(rockchip->ep_gpio, 0);
 
 	err = reset_control_assert(rockchip->aclk_rst);
 	if (err) {
@@ -682,7 +682,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
-	gpiod_set_value(rockchip->ep_gpio, 1);
+	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
 
 	/* 500ms timeout value should be enough for Gen1/2 training */
 	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
-- 
2.7.4
