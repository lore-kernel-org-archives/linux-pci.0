Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35747 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752528AbdFUIcj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2017 04:32:39 -0400
Received: by mail-lf0-f47.google.com with SMTP id p189so89395046lfe.2
        for <linux-pci@vger.kernel.org>; Wed, 21 Jun 2017 01:32:38 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] pci: ftpci100: Make clocks compulsory
Date: Wed, 21 Jun 2017 10:32:28 +0200
Message-Id: <20170621083228.30631-1-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fixes a regression on the FTPCI100 PCI driver.

When the clock controller was augmented to probe clocks
from the platform device except to the most basic clocks
pertaining to timers, clocks may return an error pointer
containing -EPROBE_DEFER.

This hit the PCI driver which would try to continue
without the clocks, but the actual clocks appeared later,
so we did not pick them up properly, and in the end of
the boot, these clocks get gated off if no users register,
so the PCI host became numbed off and silently nonworking.

The clocks for this PCI bus are defined properly for all
platforms implementing it, so we should make them compulsory
before new users arrive so we have our resources under
control.

This makes the driver bail out of probe with any error
code from the clock, including -EPROBE_DEFER so that we
again have a clean boot.

Fixes: cea186ac1e45 ("pci: ftpci100: Add clock handling")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pci/host/pci-ftpci100.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index d3bf153a2ab2..da62224e8e04 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -463,24 +463,20 @@ static int faraday_pci_probe(struct platform_device *pdev)
 
 	/* Retrieve and enable optional clocks */
 	clk = devm_clk_get(dev, "PCLK");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "no PCLK available\n");
-	} else {
-		ret = clk_prepare_enable(clk);
-		if (ret) {
-			dev_err(dev, "could not prepare PCLK\n");
-			return ret;
-		}
+	if (IS_ERR(clk))
+		return ERR_PTR(clk);
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(dev, "could not prepare PCLK\n");
+		return ret;
 	}
 	p->bus_clk = devm_clk_get(dev, "PCICLK");
-	if (IS_ERR(p->bus_clk)) {
-		dev_err(dev, "no PCICLK available\n");
-	} else {
-		ret = clk_prepare_enable(p->bus_clk);
-		if (ret) {
-			dev_err(dev, "could not prepare PCICLK\n");
-			return ret;
-		}
+	if (IS_ERR(p->bus_clk))
+		return ERR_PTR(clk);
+	ret = clk_prepare_enable(p->bus_clk);
+	if (ret) {
+		dev_err(dev, "could not prepare PCICLK\n");
+		return ret;
 	}
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.9.4
