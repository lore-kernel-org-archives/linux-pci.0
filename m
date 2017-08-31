Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0085.outbound.protection.outlook.com ([104.47.41.85]:64224
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751040AbdHaRwp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Aug 2017 13:52:45 -0400
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
        Niklas Cassel <niklas.cassel@axis.com>
Subject: [PATCH 04/10] PCI: artpec6: Fix platform_get_irq() error handling
Date: Thu, 31 Aug 2017 14:52:04 -0300
Message-ID: <1504201930-3617-4-git-send-email-fabio.estevam@nxp.com>
In-Reply-To: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
References: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

platform_get_irq() returns a negative number on failure, so
adjust the logic to detect such condition and propagate
the real error value on failure.

Cc: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/dwc/pcie-artpec6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 5d81f1d..83d6ee0 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -209,9 +209,9 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
-		if (pp->msi_irq <= 0) {
+		if (pp->msi_irq < 0) {
 			dev_err(dev, "failed to get MSI irq\n");
-			return -ENODEV;
+			return pp->msi_irq;
 		}
 
 		ret = devm_request_irq(dev, pp->msi_irq,
-- 
2.7.4
