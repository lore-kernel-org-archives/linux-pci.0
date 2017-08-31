Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0060.outbound.protection.outlook.com ([104.47.36.60]:35977
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751406AbdHaRwr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Aug 2017 13:52:47 -0400
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
        Duc Dang <dhdang@apm.com>
Subject: [PATCH 06/10] PCI: xgene-msi: Fix platform_get_irq() error handling
Date: Thu, 31 Aug 2017 14:52:06 -0300
Message-ID: <1504201930-3617-6-git-send-email-fabio.estevam@nxp.com>
In-Reply-To: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
References: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When platform_get_irq() fails we should propagate the real error
value instead of always returning -EINVAL.

Cc: Duc Dang <dhdang@apm.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/host/pci-xgene-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
index f1b633b..1f42a20 100644
--- a/drivers/pci/host/pci-xgene-msi.c
+++ b/drivers/pci/host/pci-xgene-msi.c
@@ -489,7 +489,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
 		if (virt_msir < 0) {
 			dev_err(&pdev->dev, "Cannot translate IRQ index %d\n",
 				irq_index);
-			rc = -EINVAL;
+			rc = virt_msir;
 			goto error;
 		}
 		xgene_msi->msi_groups[irq_index].gic_irq = virt_msir;
-- 
2.7.4
