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
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 10/14] drivers: iommu: arm-smmu: split probe functions into DT/generic portions
Date: Fri,  9 Sep 2016 15:23:39 +0100
Message-Id: <20160909142343.13314-11-lorenzo.pieralisi@arm.com>
In-Reply-To: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
References: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
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
 drivers/iommu/arm-smmu.c | 65 +++++++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d453c55..bdb4e26 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1665,7 +1665,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	unsigned long size;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	u32 id;
-	bool cttw_dt, cttw_reg;
+	bool cttw_reg, cttw_fw = smmu->features & ARM_SMMU_FEAT_COHERENT_WALK;
 	int i;
 
 	dev_notice(smmu->dev, "probing hardware configuration...\n");
@@ -1710,20 +1710,17 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 
 	/*
 	 * In order for DMA API calls to work properly, we must defer to what
-	 * the DT says about coherency, regardless of what the hardware claims.
+	 * the FW says about coherency, regardless of what the hardware claims.
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
 
 	/* Max. number of entries we have for stream matching/indexing */
 	size = 1 << ((id >> ID0_NUMSIDB_SHIFT) & ID0_NUMSIDB_MASK);
@@ -1904,15 +1901,25 @@ static const struct of_device_id arm_smmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
-static int arm_smmu_device_dt_probe(struct platform_device *pdev)
+static int arm_smmu_device_dt_probe(struct platform_device *pdev,
+				    struct arm_smmu_device *smmu)
 {
 	const struct arm_smmu_match_data *data;
-	struct resource *res;
-	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
-	int num_irqs, i, err;
 	bool legacy_binding;
 
+	if (of_property_read_u32(dev->of_node, "#global-interrupts",
+				 &smmu->num_global_irqs)) {
+		dev_err(dev, "missing #global-interrupts property\n");
+		return -ENODEV;
+	}
+
+	data = of_device_get_match_data(dev);
+	smmu->version = data->version;
+	smmu->model = data->model;
+
+	parse_driver_options(smmu);
+
 	legacy_binding = of_find_property(dev->of_node, "mmu-masters", NULL);
 	if (legacy_binding && !using_generic_binding) {
 		pr_notice("deprecated \"mmu-masters\" DT property in use; DMA API support unavailable\n");
@@ -1924,6 +1931,19 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (of_dma_is_coherent(smmu->dev->of_node))
+		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
+
+	return 0;
+}
+
+static int arm_smmu_device_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct arm_smmu_device *smmu;
+	struct device *dev = &pdev->dev;
+	int num_irqs, i, err;
+
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
 		dev_err(dev, "failed to allocate arm_smmu_device\n");
@@ -1931,9 +1951,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 	smmu->dev = dev;
 
-	data = of_device_get_match_data(dev);
-	smmu->version = data->version;
-	smmu->model = data->model;
+	err = arm_smmu_device_dt_probe(pdev, smmu);
+
+	if (err)
+		return err;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	smmu->base = devm_ioremap_resource(dev, res);
@@ -1941,12 +1962,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		return PTR_ERR(smmu->base);
 	smmu->size = resource_size(res);
 
-	if (of_property_read_u32(dev->of_node, "#global-interrupts",
-				 &smmu->num_global_irqs)) {
-		dev_err(dev, "missing #global-interrupts property\n");
-		return -ENODEV;
-	}
-
 	num_irqs = 0;
 	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
 		num_irqs++;
@@ -1981,8 +1996,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	parse_driver_options(smmu);
-
 	if (smmu->version == ARM_SMMU_V2 &&
 	    smmu->num_context_banks != smmu->num_context_irqs) {
 		dev_err(dev,
@@ -2004,7 +2017,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		}
 	}
 
-	of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
+	fwspec_iommu_set_ops(&dev->of_node->fwnode, &arm_smmu_ops);
 	platform_set_drvdata(pdev, smmu);
 	arm_smmu_device_reset(smmu);
 
@@ -2044,7 +2057,7 @@ static struct platform_driver arm_smmu_driver = {
 		.name		= "arm-smmu",
 		.of_match_table	= of_match_ptr(arm_smmu_of_match),
 	},
-	.probe	= arm_smmu_device_dt_probe,
+	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
 };
 
-- 
2.10.0

