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
Subject: [PATCH v6 05/16] drivers: iommu: arm-smmu: convert struct device of_node to fwnode usage
Date: Tue, 18 Oct 2016 17:04:03 +0100
Message-Id: <20161018160414.1228-6-lorenzo.pieralisi@arm.com>
In-Reply-To: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
References: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current ARM SMMU driver rely on the struct device.of_node pointer for
device look-up and iommu_ops retrieval.

In preparation for ACPI probing enablement, convert the driver to use
the struct device.fwnode member for device and iommu_ops look-up so that
the driver infrastructure can be used also on systems that do not
associate an of_node pointer to a struct device (eg ACPI), making the
device look-up and iommu_ops retrieval firmware agnostic.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c841eb7..9b0b501 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1367,13 +1367,14 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 
 static int arm_smmu_match_node(struct device *dev, void *data)
 {
-	return dev->of_node == data;
+	return dev->fwnode == data;
 }
 
-static struct arm_smmu_device *arm_smmu_get_by_node(struct device_node *np)
+static
+struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
 {
 	struct device *dev = driver_find_device(&arm_smmu_driver.driver, NULL,
-						np, arm_smmu_match_node);
+						fwnode, arm_smmu_match_node);
 	put_device(dev);
 	return dev ? dev_get_drvdata(dev) : NULL;
 }
@@ -1391,7 +1392,7 @@ static int arm_smmu_add_device(struct device *dev)
 		if (ret)
 			goto out_free;
 	} else if (fwspec) {
-		smmu = arm_smmu_get_by_node(to_of_node(fwspec->iommu_fwnode));
+		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
 	} else {
 		return -ENODEV;
 	}
@@ -1995,7 +1996,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		}
 	}
 
-	of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
+	fwnode_iommu_set_ops(dev->fwnode, &arm_smmu_ops);
 	platform_set_drvdata(pdev, smmu);
 	arm_smmu_device_reset(smmu);
 
-- 
2.10.0

