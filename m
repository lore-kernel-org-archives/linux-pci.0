Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0074.outbound.protection.outlook.com ([104.47.41.74]:40288
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751110AbdHaRwl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Aug 2017 13:52:41 -0400
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH 01/10] PCI: exynos: Fix platform_get_irq() error handling
Date: Thu, 31 Aug 2017 14:52:01 -0300
Message-ID: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

platform_get_irq() returns a negative number on failure, so
adjust the logic to detect such condition and propagate
the real error value on failure.

Cc: Jingoo Han <jingoohan1@gmail.com>
Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/dwc/pci-exynos.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
index f77f872..5596fde 100644
--- a/drivers/pci/dwc/pci-exynos.c
+++ b/drivers/pci/dwc/pci-exynos.c
@@ -607,9 +607,9 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
 	int ret;
 
 	pp->irq = platform_get_irq(pdev, 1);
-	if (!pp->irq) {
+	if (pp->irq < 0) {
 		dev_err(dev, "failed to get irq\n");
-		return -ENODEV;
+		return pp->irq;
 	}
 	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
 				IRQF_SHARED, "exynos-pcie", ep);
@@ -620,9 +620,9 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq(pdev, 0);
-		if (!pp->msi_irq) {
+		if (pp->msi_irq < 0) {
 			dev_err(dev, "failed to get msi irq\n");
-			return -ENODEV;
+			return pp->msi_irq;
 		}
 
 		ret = devm_request_irq(dev, pp->msi_irq,
-- 
2.7.4
