Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56384 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752340AbdLACxO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Nov 2017 21:53:14 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        linux-soc@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE
        SUBSYSTEM), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V4 5/5] dmaengine: qcom_hidma: Add identity register support
Date: Thu, 30 Nov 2017 21:52:56 -0500
Message-Id: <1512096776-22883-6-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1512096776-22883-1-git-send-email-okaya@codeaurora.org>
References: <1512096776-22883-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The location for destination event channel register has been relocated from
offset 0x28 to 0x40. Update the code accordingly.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index c146c6d..963cc52 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -107,6 +107,7 @@ static void hidma_free(struct hidma_dev *dmadev)
 
 enum hidma_cap {
 	HIDMA_MSI_CAP = 1,
+	HIDMA_IDENTITY_CAP,
 };
 
 /* process completed descriptors */
@@ -838,7 +839,10 @@ static int hidma_probe(struct platform_device *pdev)
 	if (!dmadev->nr_descriptors)
 		dmadev->nr_descriptors = HIDMA_NR_DEFAULT_DESC;
 
-	dmadev->chidx = readl(dmadev->dev_trca + 0x28);
+	if (hidma_test_capability(&pdev->dev, HIDMA_IDENTITY_CAP))
+		dmadev->chidx = readl(dmadev->dev_trca + 0x40);
+	else
+		dmadev->chidx = readl(dmadev->dev_trca + 0x28);
 
 	/* Set DMA mask to 64 bits. */
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
@@ -944,7 +948,7 @@ static int hidma_remove(struct platform_device *pdev)
 static const struct acpi_device_id hidma_acpi_ids[] = {
 	{"QCOM8061"},
 	{"QCOM8062", HIDMA_MSI_CAP},
-	{"QCOM8063", HIDMA_MSI_CAP},
+	{"QCOM8063", (HIDMA_MSI_CAP | HIDMA_IDENTITY_CAP)},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, hidma_acpi_ids);
@@ -953,7 +957,8 @@ static int hidma_remove(struct platform_device *pdev)
 static const struct of_device_id hidma_match[] = {
 	{.compatible = "qcom,hidma-1.0",},
 	{.compatible = "qcom,hidma-1.1", .data = (void *)(HIDMA_MSI_CAP),},
-	{.compatible = "qcom,hidma-1.2", .data = (void *)(HIDMA_MSI_CAP),},
+	{.compatible = "qcom,hidma-1.2",
+	 .data = (void *)(HIDMA_MSI_CAP | HIDMA_IDENTITY_CAP),},
 	{},
 };
 MODULE_DEVICE_TABLE(of, hidma_match);
-- 
1.9.1
