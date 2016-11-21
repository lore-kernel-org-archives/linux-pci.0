Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753887AbcKUKBD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Nov 2016 05:01:03 -0500
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
Subject: [PATCH v9 06/16] drivers: iommu: arm-smmu-v3: convert struct device of_node to fwnode usage
Date: Mon, 21 Nov 2016 10:01:38 +0000
Message-Id: <20161121100148.24769-7-lorenzo.pieralisi@arm.com>
In-Reply-To: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
References: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current ARM SMMU v3 driver rely on the struct device.of_node pointer for
device look-up and iommu_ops retrieval.

In preparation for ACPI probing enablement, convert the driver to use
the struct device.fwnode member for device and iommu_ops look-up so that
the driver infrastructure can be used also on systems that do not
associate an of_node pointer to a struct device (eg ACPI), making the
device look-up and iommu_ops retrieval firmware agnostic.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Tomasz Nowicki <tn@semihalf.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e6f9b2d..e6e1c87 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1723,13 +1723,14 @@ static struct platform_driver arm_smmu_driver;
 
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
@@ -1765,7 +1766,7 @@ static int arm_smmu_add_device(struct device *dev)
 		master = fwspec->iommu_priv;
 		smmu = master->smmu;
 	} else {
-		smmu = arm_smmu_get_by_node(to_of_node(fwspec->iommu_fwnode));
+		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
 		if (!smmu)
 			return -ENODEV;
 		master = kzalloc(sizeof(*master), GFP_KERNEL);
@@ -2634,7 +2635,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		return ret;
 
 	/* And we're up. Go go go! */
-	of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
+	iommu_register_instance(dev->fwnode, &arm_smmu_ops);
+
 #ifdef CONFIG_PCI
 	if (pci_bus_type.iommu_ops != &arm_smmu_ops) {
 		pci_request_acs();
-- 
2.10.0

