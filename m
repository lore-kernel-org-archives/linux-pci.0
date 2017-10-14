Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43759 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbdJNWHt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Oct 2017 18:07:49 -0400
Received: by mail-qk0-f193.google.com with SMTP id w134so8834593qkb.0
        for <linux-pci@vger.kernel.org>; Sat, 14 Oct 2017 15:07:49 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: [PATCH 4/5] PCI: tango: Fix platform_get_irq() error handling
Date: Sat, 14 Oct 2017 19:07:30 -0300
Message-Id: <1508018851-9272-4-git-send-email-festevam@gmail.com>
In-Reply-To: <1508018851-9272-1-git-send-email-festevam@gmail.com>
References: <1508018851-9272-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When platform_get_irq() fails we should propagate the real error value
instead of always returning -ENXIO.

Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/pci/host/pcie-tango.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
index e23f738..5196583 100644
--- a/drivers/pci/host/pcie-tango.c
+++ b/drivers/pci/host/pcie-tango.c
@@ -272,9 +272,9 @@ static int tango_pcie_probe(struct platform_device *pdev)
 		writel_relaxed(0, pcie->base + SMP8759_ENABLE + offset);
 
 	virq = platform_get_irq(pdev, 1);
-	if (virq <= 0) {
+	if (virq < 0) {
 		dev_err(dev, "Failed to map IRQ\n");
-		return -ENXIO;
+		return virq;
 	}
 
 	irq_dom = irq_domain_create_linear(fwnode, MSI_MAX, &dom_ops, pcie);
-- 
2.7.4
