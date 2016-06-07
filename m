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
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 09/15] drivers: iommu: arm-smmu-v3: split probe functions into DT/generic portions
Date: Tue,  7 Jun 2016 14:31:04 +0100
Message-Id: <1465306270-27076-10-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
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
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/arm-smmu-v3.c | 63 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 6379f0a..75f93aa 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -20,12 +20,14 @@
  * This driver is powered by bad coffee and bombay mix.
  */
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
+#include <linux/iort.h>
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
@@ -2331,10 +2333,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
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
@@ -2386,13 +2388,9 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
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
@@ -2513,7 +2511,44 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-static int arm_smmu_device_dt_probe(struct platform_device *pdev)
+#ifdef CONFIG_ACPI
+static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
+				      struct arm_smmu_device *smmu)
+{
+	struct acpi_iort_smmu_v3 *iort_smmu;
+	struct device *dev = smmu->dev;
+	struct acpi_iort_node *node;
+
+	node = *(struct acpi_iort_node **)dev_get_platdata(dev);
+
+	/* Retrieve SMMUv3 specific data */
+	iort_smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
+
+	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
+		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
+
+	return 0;
+}
+#else
+static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
+				      struct arm_smmu_device *smmu)
+{
+	return -ENODEV;
+}
+#endif
+
+static int arm_smmu_device_dt_probe(struct platform_device *pdev,
+				    struct arm_smmu_device *smmu)
+{
+	parse_driver_options(smmu);
+
+	if (of_dma_is_coherent(smmu->dev->of_node))
+		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
+
+	return 0;
+}
+
+static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
 	struct resource *res;
@@ -2555,10 +2590,16 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	if (irq > 0)
 		smmu->gerr_irq = irq;
 
-	parse_driver_options(smmu);
+	if (acpi_disabled)
+		ret = arm_smmu_device_dt_probe(pdev, smmu);
+	else
+		ret = arm_smmu_device_acpi_probe(pdev, smmu);
+
+	if (ret)
+		return ret;
 
 	/* Probe the h/w */
-	ret = arm_smmu_device_probe(smmu);
+	ret = arm_smmu_device_hw_probe(smmu);
 	if (ret)
 		return ret;
 
@@ -2593,7 +2634,7 @@ static struct platform_driver arm_smmu_driver = {
 		.name		= "arm-smmu-v3",
 		.of_match_table	= of_match_ptr(arm_smmu_of_match),
 	},
-	.probe	= arm_smmu_device_dt_probe,
+	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
 };
 
-- 
2.6.4

