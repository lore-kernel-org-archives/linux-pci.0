Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44432 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbdJNWHp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Oct 2017 18:07:45 -0400
Received: by mail-qt0-f193.google.com with SMTP id 8so25456372qtv.1
        for <linux-pci@vger.kernel.org>; Sat, 14 Oct 2017 15:07:44 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/5] PCI: v3-semi: Fix platform_get_irq() error handling
Date: Sat, 14 Oct 2017 19:07:28 -0300
Message-Id: <1508018851-9272-2-git-send-email-festevam@gmail.com>
In-Reply-To: <1508018851-9272-1-git-send-email-festevam@gmail.com>
References: <1508018851-9272-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When platform_get_irq() fails we should propagate the real error value
instead of always returning -ENODEV.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/pci/host/pci-v3-semi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-v3-semi.c b/drivers/pci/host/pci-v3-semi.c
index a544d72..01017af 100644
--- a/drivers/pci/host/pci-v3-semi.c
+++ b/drivers/pci/host/pci-v3-semi.c
@@ -806,9 +806,9 @@ static int v3_pci_probe(struct platform_device *pdev)
 
 	/* Get and request error IRQ resource */
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
+	if (irq < 0) {
 		dev_err(dev, "unable to obtain PCIv3 error IRQ\n");
-		return -ENODEV;
+		return irq;
 	}
 	ret = devm_request_irq(dev, irq, v3_irq, 0,
 			"PCIv3 error", v3);
-- 
2.7.4
