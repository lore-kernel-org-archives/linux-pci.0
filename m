Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:54728 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbdJNWHr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Oct 2017 18:07:47 -0400
Received: by mail-qk0-f195.google.com with SMTP id n5so8836492qke.11
        for <linux-pci@vger.kernel.org>; Sat, 14 Oct 2017 15:07:47 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/5] PCI: mediatek: Check for platform_get_irq() error
Date: Sat, 14 Oct 2017 19:07:29 -0300
Message-Id: <1508018851-9272-3-git-send-email-festevam@gmail.com>
In-Reply-To: <1508018851-9272-1-git-send-email-festevam@gmail.com>
References: <1508018851-9272-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

platform_get_irq() may fail and in the case of failure the error value
should be propagated.

Cc: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/pci/host/pcie-mediatek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index db93efd..05f8c33 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -642,6 +642,8 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 	int err, irq;
 
 	irq = platform_get_irq(pdev, port->slot);
+	if (irq < 0)
+		return irq;
 	err = devm_request_irq(dev, irq, mtk_pcie_intr_handler,
 			       IRQF_SHARED, "mtk-pcie", port);
 	if (err) {
-- 
2.7.4
