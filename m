Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tomasz Nowicki <tn@semihalf.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 07/11] drivers: iommu: arm-smmu: allow ACPI based streamid translation
Date: Thu, 14 Apr 2016 18:25:39 +0100
Message-Id: <1460654743-7896-8-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The ACPI IORT table provides data to ARM IOMMU drivers to carry out
streamid mappings and the kernel has the infrastructure to implement
it through the fw_xlate() struct iommu_ops hook.

By relying on the DT agnostic struct iommu_fwspec fields, this
patch adds code in the ARM SMMU fw_xlate() callback that allows
streamid translation on ACPI based ARM system.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 84bcff7..0f1e784 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1440,6 +1440,20 @@ out_unlock:
 	return ret;
 }
 
+static int arm_smmu_dev_node_match(struct device *dev, void *data)
+{
+	return is_fwnode_iommu(dev->fwnode) && dev->fwnode == data;
+}
+
+static struct platform_device *arm_smmu_get_dev(struct fwnode_handle *fwnode)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&platform_bus_type, NULL, fwnode,
+			      arm_smmu_dev_node_match);
+	return dev ? to_platform_device(dev) : NULL;
+}
+
 static int arm_smmu_fw_xlate(struct device *dev, struct iommu_fwspec *args)
 {
 	struct arm_smmu_device *smmu;
@@ -1447,6 +1461,8 @@ static int arm_smmu_fw_xlate(struct device *dev, struct iommu_fwspec *args)
 
 	if (is_of_node(args->fwnode))
 		smmu_pdev = of_find_device_by_node(to_of_node(args->fwnode));
+	else if (is_fwnode_iommu(args->fwnode))
+		smmu_pdev = arm_smmu_get_dev(args->fwnode);
 
 	if (!smmu_pdev)
 		return -ENODEV;
-- 
2.6.4

