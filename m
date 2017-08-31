Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0057.outbound.protection.outlook.com ([104.47.41.57]:63776
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751410AbdHaRws (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Aug 2017 13:52:48 -0400
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
        Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 07/10] PCI: altera-msi: Fix platform_get_irq() error handling
Date: Thu, 31 Aug 2017 14:52:07 -0300
Message-ID: <1504201930-3617-7-git-send-email-fabio.estevam@nxp.com>
In-Reply-To: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
References: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

platform_get_irq() returns a negative number on failure, so
adjust the logic to detect such condition and propagate
the real error value on failure.

Cc: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/host/pcie-altera-msi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-altera-msi.c b/drivers/pci/host/pcie-altera-msi.c
index 2864030..d8141f4 100644
--- a/drivers/pci/host/pcie-altera-msi.c
+++ b/drivers/pci/host/pcie-altera-msi.c
@@ -265,9 +265,9 @@ static int altera_msi_probe(struct platform_device *pdev)
 		return ret;
 
 	msi->irq = platform_get_irq(pdev, 0);
-	if (msi->irq <= 0) {
+	if (msi->irq < 0) {
 		dev_err(&pdev->dev, "failed to map IRQ: %d\n", msi->irq);
-		ret = -ENODEV;
+		ret = msi->irq;
 		goto err;
 	}
 
-- 
2.7.4
