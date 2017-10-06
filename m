Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        gabriele.paoloni@huawei.com, nwatters@codeaurora.org,
        okaya@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com
Subject: [RFCv2 PATCH 36/36] iommu/arm-smmu-v3: Add support for PCI PASID
Date: Fri,  6 Oct 2017 14:32:03 +0100
Message-Id: <20171006133203.22803-37-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enable PASID for PCI devices that support it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 852714f35010..42c8378624ed 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3012,6 +3012,50 @@ static void arm_smmu_disable_pri(struct arm_smmu_master_data *master)
 	master->can_fault = false;
 }
 
+static int arm_smmu_enable_pasid(struct arm_smmu_master_data *master)
+{
+	int ret;
+	int features;
+	int num_ssids;
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return -ENOSYS;
+
+	pdev = to_pci_dev(master->dev);
+
+	features = pci_pasid_features(pdev);
+	if (features < 0)
+		return -ENOSYS;
+
+	num_ssids = pci_max_pasids(pdev);
+
+	dev_dbg(&pdev->dev, "device supports %#x SSIDs [%s%s]\n", num_ssids,
+		(features & PCI_PASID_CAP_EXEC) ? "x" : "",
+		(features & PCI_PASID_CAP_PRIV) ? "p" : "");
+
+	num_ssids = clamp_val(num_ssids, 1, 1 << master->smmu->ssid_bits);
+	num_ssids = rounddown_pow_of_two(num_ssids);
+
+	ret = pci_enable_pasid(pdev, features);
+	return ret ? ret : num_ssids;
+}
+
+static void arm_smmu_disable_pasid(struct arm_smmu_master_data *master)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return;
+
+	pdev = to_pci_dev(master->dev);
+
+	if (!pdev->pasid_enabled)
+		return;
+
+	pci_disable_pasid(pdev);
+}
+
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master_data *master)
 {
@@ -3134,6 +3178,11 @@ static int arm_smmu_add_device(struct device *dev)
 		master->ste.can_stall = true;
 	}
 
+	/* PASID must be enabled before ATS */
+	ret = arm_smmu_enable_pasid(master);
+	if (ret > 0)
+		master->num_ssids = ret;
+
 	if (!arm_smmu_enable_ats(master))
 		arm_smmu_enable_pri(master);
 
@@ -3152,6 +3201,7 @@ static int arm_smmu_add_device(struct device *dev)
 err_disable_pri:
 	arm_smmu_disable_pri(master);
 	arm_smmu_disable_ats(master);
+	arm_smmu_disable_pasid(master);
 
 	return ret;
 }
@@ -3172,7 +3222,9 @@ static void arm_smmu_remove_device(struct device *dev)
 	arm_smmu_remove_master(smmu, master);
 
 	arm_smmu_disable_pri(master);
+	/* PASID must be disabled after ATS */
 	arm_smmu_disable_ats(master);
+	arm_smmu_disable_pasid(master);
 
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
-- 
2.13.3

