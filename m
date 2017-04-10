Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Sricharan R <sricharan@codeaurora.org>
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org,
        lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org,
        okaya@codeaurora.org, robh+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc: sricharan@codeaurora.org
Subject: [PATCH V11 05/11] of: device: Fix overflow of coherent_dma_mask
Date: Mon, 10 Apr 2017 16:51:00 +0530
Message-Id: <1491823266-1209-6-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1491823266-1209-1-git-send-email-sricharan@codeaurora.org>
References: <1491823266-1209-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Size of the dma-range is calculated as coherent_dma_mask + 1
and passed to arch_setup_dma_ops further. It overflows when
the coherent_dma_mask is set for full 64 bits 0xFFFFFFFFFFFFFFFF,
resulting in size getting passed as 0 wrongly. Fix this by
passsing in max(mask, mask + 1). Note that in this case
when the mask is set to full 64bits, we will be passing the mask
itself to arch_setup_dma_ops instead of the size. The real fix
for this should be to make arch_setup_dma_ops receive the
mask and handle it, to be done in the future.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/of/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 0d378c0..e1ae9e7 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -107,7 +107,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
 	if (ret < 0) {
 		dma_addr = offset = 0;
-		size = dev->coherent_dma_mask + 1;
+		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
 	} else {
 		offset = PFN_DOWN(paddr - dma_addr);
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

