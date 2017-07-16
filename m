Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34512 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdGPW4v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Jul 2017 18:56:51 -0400
Received: by mail-qk0-f195.google.com with SMTP id q66so18811154qki.1
        for <linux-pci@vger.kernel.org>; Sun, 16 Jul 2017 15:56:51 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: svarbanov@mm-sol.com, linux-pci@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] PCI: qcom: Use gpiod_set_value_cansleep()
Date: Sun, 16 Jul 2017 19:56:38 -0300
Message-Id: <1500245798-20886-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

The reset GPIO can be connected to a I2C or SPI IO expander, which
may sleep, so it is safer to use the gpiod_set_value_cansleep()
variant instead.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/dwc/pcie-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 68c5f2a..8359de0 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -141,13 +141,13 @@ struct qcom_pcie {
 
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 {
-	gpiod_set_value(pcie->reset, 1);
+	gpiod_set_value_cansleep(pcie->reset, 1);
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
 static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 {
-	gpiod_set_value(pcie->reset, 0);
+	gpiod_set_value_cansleep(pcie->reset, 0);
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
-- 
2.7.4
