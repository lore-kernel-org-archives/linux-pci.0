Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Sricharan R <sricharan@codeaurora.org>
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org,
        lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org,
        okaya@codeaurora.org
Cc: sricharan@codeaurora.org
Subject: [PATCH V8 10/11] iommu/arm-smmu: Clean up early-probing workarounds
Date: Fri,  3 Feb 2017 21:18:52 +0530
Message-Id: <1486136933-20328-11-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
References: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Robin Murphy <robin.murphy@arm.com>

Now that the appropriate ordering is enforced via probe-deferral of
masters in core code, rip it all out and bask in the simplicity.

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[Sricharan: Rebased on top of ACPI IORT SMMU series]
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/arm-smmu-v3.c | 46 ++---------------------------------
 drivers/iommu/arm-smmu.c    | 58 +++++++--------------------------------------
 2 files changed, 10 insertions(+), 94 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 7bb157c..eba4ac8 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2743,51 +2743,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
 };
+module_platform_driver(arm_smmu_driver);
 
-static int __init arm_smmu_init(void)
-{
-	static bool registered;
-	int ret = 0;
-
-	if (!registered) {
-		ret = platform_driver_register(&arm_smmu_driver);
-		registered = !ret;
-	}
-	return ret;
-}
-
-static void __exit arm_smmu_exit(void)
-{
-	return platform_driver_unregister(&arm_smmu_driver);
-}
-
-subsys_initcall(arm_smmu_init);
-module_exit(arm_smmu_exit);
-
-static int __init arm_smmu_of_init(struct device_node *np)
-{
-	int ret = arm_smmu_init();
-
-	if (ret)
-		return ret;
-
-	if (!of_platform_device_create(np, NULL, platform_bus_type.dev_root))
-		return -ENODEV;
-
-	return 0;
-}
-IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", arm_smmu_of_init);
-
-#ifdef CONFIG_ACPI
-static int __init acpi_smmu_v3_init(struct acpi_table_header *table)
-{
-	if (iort_node_match(ACPI_IORT_NODE_SMMU_V3))
-		return arm_smmu_init();
-
-	return 0;
-}
-IORT_ACPI_DECLARE(arm_smmu_v3, ACPI_SIG_IORT, acpi_smmu_v3_init);
-#endif
+IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", NULL);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 091d4a6..faea579 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2190,56 +2190,14 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
 };
-
-static int __init arm_smmu_init(void)
-{
-	static bool registered;
-	int ret = 0;
-
-	if (!registered) {
-		ret = platform_driver_register(&arm_smmu_driver);
-		registered = !ret;
-	}
-	return ret;
-}
-
-static void __exit arm_smmu_exit(void)
-{
-	return platform_driver_unregister(&arm_smmu_driver);
-}
-
-subsys_initcall(arm_smmu_init);
-module_exit(arm_smmu_exit);
-
-static int __init arm_smmu_of_init(struct device_node *np)
-{
-	int ret = arm_smmu_init();
-
-	if (ret)
-		return ret;
-
-	if (!of_platform_device_create(np, NULL, platform_bus_type.dev_root))
-		return -ENODEV;
-
-	return 0;
-}
-IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1", arm_smmu_of_init);
-IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2", arm_smmu_of_init);
-IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400", arm_smmu_of_init);
-IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401", arm_smmu_of_init);
-IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500", arm_smmu_of_init);
-IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2", arm_smmu_of_init);
-
-#ifdef CONFIG_ACPI
-static int __init arm_smmu_acpi_init(struct acpi_table_header *table)
-{
-	if (iort_node_match(ACPI_IORT_NODE_SMMU))
-		return arm_smmu_init();
-
-	return 0;
-}
-IORT_ACPI_DECLARE(arm_smmu, ACPI_SIG_IORT, arm_smmu_acpi_init);
-#endif
+module_platform_driver(arm_smmu_driver);
+
+IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1", NULL);
+IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2", NULL);
+IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400", NULL);
+IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401", NULL);
+IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500", NULL);
+IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2", NULL);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

