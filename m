Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 05/11] drivers: iommu: arm-smmu: split probe functions into DT/generic portions
Date: Thu, 14 Apr 2016 18:25:37 +0100
Message-Id: <1460654743-7896-6-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current ARM SMMU probe functions intermingle HW and DT probing
in the initialization functions to detect and programme the ARM SMMU
driver features. In order to allow probing the ARM SMMU with other
firmwares than DT, this patch splits the ARM SMMU init functions into
DT and HW specific portions so that other FW interfaces (ie ACPI) can
reuse the HW probing functions and skip the DT portion accordingly.

This patch implements no functional change, only code reshuffling.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 80 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2d65de4..6c42770 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1551,7 +1551,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	unsigned long size;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	u32 id;
-	bool cttw_dt, cttw_reg;
+	bool cttw_reg, cttw_fw = smmu->features & ARM_SMMU_FEAT_COHERENT_WALK;
 
 	dev_notice(smmu->dev, "probing hardware configuration...\n");
 	dev_notice(smmu->dev, "SMMUv%d with:\n", smmu->version);
@@ -1593,20 +1593,18 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 
 	/*
 	 * In order for DMA API calls to work properly, we must defer to what
-	 * the DT says about coherency, regardless of what the hardware claims.
+	 * the FW says about coherency, regardless of what the hardware
+	 * claims.
 	 * Fortunately, this also opens up a workaround for systems where the
 	 * ID register value has ended up configured incorrectly.
 	 */
-	cttw_dt = of_dma_is_coherent(smmu->dev->of_node);
 	cttw_reg = !!(id & ID0_CTTW);
-	if (cttw_dt)
-		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
-	if (cttw_dt || cttw_reg)
+	if (cttw_fw || cttw_reg)
 		dev_notice(smmu->dev, "\t%scoherent table walk\n",
-			   cttw_dt ? "" : "non-");
-	if (cttw_dt != cttw_reg)
+			   cttw_fw ? "" : "non-");
+	if (cttw_fw != cttw_reg)
 		dev_notice(smmu->dev,
-			   "\t(IDR0.CTTW overridden by dma-coherent property)\n");
+			   "\t(IDR0.CTTW overridden by FW configuration)\n");
 
 	if (id & ID0_SMS) {
 		u32 smr, sid, mask;
@@ -1827,30 +1825,17 @@ static int arm_smmu_probe_mmu_masters(struct arm_smmu_device *smmu)
 	return err;
 }
 
-static int arm_smmu_device_dt_probe(struct platform_device *pdev)
+static int arm_smmu_dt_probe(struct platform_device *pdev,
+			     struct arm_smmu_device *smmu)
 {
 	const struct of_device_id *of_id;
 	struct resource *res;
-	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
 	int num_irqs, i, err;
 
-	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
-	if (!smmu) {
-		dev_err(dev, "failed to allocate arm_smmu_device\n");
-		return -ENOMEM;
-	}
-	smmu->dev = dev;
-
 	of_id = of_match_node(arm_smmu_of_match, dev->of_node);
 	smmu->version = (enum arm_smmu_arch_version)of_id->data;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	smmu->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(smmu->base))
-		return PTR_ERR(smmu->base);
-	smmu->size = resource_size(res);
-
 	if (of_property_read_u32(dev->of_node, "#global-interrupts",
 				 &smmu->num_global_irqs)) {
 		dev_err(dev, "missing #global-interrupts property\n");
@@ -1887,12 +1872,54 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
+	/*
+	 * In order for DMA API calls to work properly, we must defer to what
+	 * the DT says about coherency, regardless of what the hardware detect
+	 * through probing in arm_smmu_device_cfg_probe(). Check the DT dma
+	 * coherent property and initialize the corresponding SMMU feature
+	 * so that arm_smmu_device_cfg_probe() can check the FW reported value.
+	 */
+	if (of_dma_is_coherent(smmu->dev->of_node))
+		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
+
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
 
 	parse_driver_options(smmu);
 
+	/* Check first to avoid of_parse_phandle_with_args complaining */
+	if (of_property_read_bool(dev->of_node, "mmu-masters"))
+		arm_smmu_probe_mmu_masters(smmu);
+
+	return 0;
+}
+
+static int arm_smmu_device_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct arm_smmu_device *smmu;
+	struct device *dev = &pdev->dev;
+	int i, err;
+
+	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
+	if (!smmu) {
+		dev_err(dev, "failed to allocate arm_smmu_device\n");
+		return -ENOMEM;
+	}
+	smmu->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	smmu->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(smmu->base))
+		return PTR_ERR(smmu->base);
+	smmu->size = resource_size(res);
+
+	err = arm_smmu_dt_probe(pdev, smmu);
+
+	if (err)
+		return err;
+
 	if (smmu->version > ARM_SMMU_V1 &&
 	    smmu->num_context_banks != smmu->num_context_irqs) {
 		dev_err(dev,
@@ -1915,9 +1942,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, smmu);
-	/* Check first to avoid of_parse_phandle_with_args complaining */
-	if (of_property_read_bool(dev->of_node, "mmu-masters"))
-		arm_smmu_probe_mmu_masters(smmu);
 	arm_smmu_device_reset(smmu);
 	return 0;
 
@@ -1953,7 +1977,7 @@ static struct platform_driver arm_smmu_driver = {
 		.name		= "arm-smmu",
 		.of_match_table	= of_match_ptr(arm_smmu_of_match),
 	},
-	.probe	= arm_smmu_device_dt_probe,
+	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
 };
 
-- 
2.6.4

