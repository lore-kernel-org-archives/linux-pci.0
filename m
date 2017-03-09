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
Subject: [PATCH V9 05/11] ACPI/IORT: Add function to check SMMUs drivers presence
Date: Fri, 10 Mar 2017 00:30:55 +0530
Message-Id: <1489086061-9356-6-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

The IOMMU probe deferral implementation requires a mechanism to detect
if drivers for SMMU components are built-in in the kernel to detect
whether IOMMU configuration for a given device should be deferred (ie
SMMU drivers present but still not probed) or not (drivers not present).

Add a simple function to IORT to detect if SMMU drivers for SMMU
components managed by IORT are built-in in the kernel.

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Sricharan R <sricharan@codeaurora.org>
---
 drivers/acpi/arm64/iort.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 4a5bb96..3dd9ec3 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -523,6 +523,19 @@ static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
 	return ret;
 }
 
+static inline bool iort_iommu_driver_enabled(u8 type)
+{
+	switch (type) {
+	case ACPI_IORT_NODE_SMMU_V3:
+		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
+	case ACPI_IORT_NODE_SMMU:
+		return IS_BUILTIN(CONFIG_ARM_SMMU);
+	default:
+		pr_warn("IORT node type %u does not describe an SMMU\n", type);
+		return false;
+	}
+}
+
 static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
 					struct acpi_iort_node *node,
 					u32 streamid)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

