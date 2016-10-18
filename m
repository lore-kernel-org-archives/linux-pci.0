Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 10/16] drivers: iommu: arm-smmu-v3: split probe functions into DT/generic portions
Date: Tue, 18 Oct 2016 17:04:08 +0100
Message-Id: <20161018160414.1228-11-lorenzo.pieralisi@arm.com>
In-Reply-To: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
References: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current ARM SMMUv3 probe functions intermingle HW and DT probing in the
initialization functions to detect and programme the ARM SMMU v3 driver
features. In order to allow probing the ARM SMMUv3 with other firmwares
than DT, this patch splits the ARM SMMUv3 init functions into DT and HW
specific portions so that other FW interfaces (ie ACPI) can reuse the HW
probing functions and skip the DT portion accordingly.

This patch implements no functional change, only code reshuffling.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/arm-smmu-v3.c | 46 +++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index bbc2818..3faf348 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2381,10 +2381,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	return 0;
 }
 
-static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
+static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
-	bool coherent;
+	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
 
 	/* IDR0 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
@@ -2436,13 +2436,9 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
 		smmu->features |= ARM_SMMU_FEAT_HYP;
 
 	/*
-	 * The dma-coherent property is used in preference to the ID
+	 * The coherency feature as set by FW is used in preference to the ID
 	 * register, but warn on mismatch.
 	 */
-	coherent = of_dma_is_coherent(smmu->dev->of_node);
-	if (coherent)
-		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
-
 	if (!!(reg & IDR0_COHACC) != coherent)
 		dev_warn(smmu->dev, "IDR0.COHACC overridden by dma-coherent property (%s)\n",
 			 coherent ? "true" : "false");
@@ -2563,21 +2559,37 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-static int arm_smmu_device_dt_probe(struct platform_device *pdev)
+static int arm_smmu_device_dt_probe(struct platform_device *pdev,
+				    struct arm_smmu_device *smmu,
+				    bool *bypass)
 {
-	int irq, ret;
-	struct resource *res;
-	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
-	bool bypass = true;
 	u32 cells;
 
+	*bypass = true;
+
 	if (of_property_read_u32(dev->of_node, "#iommu-cells", &cells))
 		dev_err(dev, "missing #iommu-cells property\n");
 	else if (cells != 1)
 		dev_err(dev, "invalid #iommu-cells value (%d)\n", cells);
 	else
-		bypass = false;
+		*bypass = false;
+
+	parse_driver_options(smmu);
+
+	if (of_dma_is_coherent(smmu->dev->of_node))
+		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
+
+	return 0;
+}
+
+static int arm_smmu_device_probe(struct platform_device *pdev)
+{
+	int irq, ret;
+	struct resource *res;
+	struct arm_smmu_device *smmu;
+	struct device *dev = &pdev->dev;
+	bool bypass;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
@@ -2614,10 +2626,12 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	if (irq > 0)
 		smmu->gerr_irq = irq;
 
-	parse_driver_options(smmu);
+	ret = arm_smmu_device_dt_probe(pdev, smmu, &bypass);
+	if (ret)
+		return ret;
 
 	/* Probe the h/w */
-	ret = arm_smmu_device_probe(smmu);
+	ret = arm_smmu_device_hw_probe(smmu);
 	if (ret)
 		return ret;
 
@@ -2670,7 +2684,7 @@ static struct platform_driver arm_smmu_driver = {
 		.name		= "arm-smmu-v3",
 		.of_match_table	= of_match_ptr(arm_smmu_of_match),
 	},
-	.probe	= arm_smmu_device_dt_probe,
+	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
 };
 
-- 
2.10.0

