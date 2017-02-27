Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: 
Subject: [RFC PATCH 20/30] iommu/arm-smmu-v3: Enable PCI PASID in masters
Date: Mon, 27 Feb 2017 19:54:31 +0000
Message-Id: <20170227195441.5170-21-jean-philippe.brucker@arm.com>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Harv Abdulhamid <harba@qti.qualcomm.com>,
 Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Enable PASID for PCI devices that support it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 66 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 499dc1cd07eb..37fd061405e9 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -730,6 +730,8 @@ struct arm_smmu_master_data {
 
 	struct arm_smmu_stream		*streams;
 	struct rb_root			contexts;
+
+	u32				avail_contexts;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -2954,6 +2956,47 @@ static void arm_smmu_disable_ats(struct arm_smmu_master_data *master)
 	pci_disable_ats(pdev);
 }
 
+static int arm_smmu_enable_ssid(struct arm_smmu_master_data *master)
+{
+	int ret;
+	int features;
+	int nr_ssids;
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
+	nr_ssids = pci_max_pasids(pdev);
+
+	dev_dbg(&pdev->dev, "device supports %#x SSIDs [%s%s]\n", nr_ssids,
+		(features & PCI_PASID_CAP_EXEC) ? "x" : "",
+		(features & PCI_PASID_CAP_PRIV) ? "p" : "");
+
+	ret = pci_enable_pasid(pdev, features);
+	return ret ? ret : nr_ssids;
+}
+
+static void arm_smmu_disable_ssid(struct arm_smmu_master_data *master)
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
@@ -3007,6 +3050,7 @@ static struct iommu_ops arm_smmu_ops;
 static int arm_smmu_add_device(struct device *dev)
 {
 	int i, ret;
+	int nr_ssids;
 	bool ats_enabled;
 	unsigned long flags;
 	struct arm_smmu_device *smmu;
@@ -3055,9 +3099,19 @@ static int arm_smmu_add_device(struct device *dev)
 		}
 	}
 
-	ret = arm_smmu_alloc_cd_tables(master, 1);
-	if (ret < 0)
-		return ret;
+	/* PCIe PASID must be enabled before ATS */
+	nr_ssids = arm_smmu_enable_ssid(master);
+	if (nr_ssids <= 0)
+		nr_ssids = 1;
+
+	nr_ssids = arm_smmu_alloc_cd_tables(master, nr_ssids);
+	if (nr_ssids < 0) {
+		ret = nr_ssids;
+		goto err_disable_ssid;
+	}
+
+	/* SSID0 is reserved */
+	master->avail_contexts = nr_ssids - 1;
 
 	ats_enabled = !arm_smmu_enable_ats(master);
 
@@ -3088,6 +3142,9 @@ static int arm_smmu_add_device(struct device *dev)
 
 	arm_smmu_free_cd_tables(master);
 
+err_disable_ssid:
+	arm_smmu_disable_ssid(master);
+
 	return ret;
 }
 
@@ -3129,7 +3186,10 @@ static void arm_smmu_remove_device(struct device *dev)
 
 		iommu_group_put(group);
 
+		/* PCIe PASID must be disabled after ATS */
 		arm_smmu_disable_ats(master);
+		arm_smmu_disable_ssid(master);
+
 		arm_smmu_free_cd_tables(master);
 	}
 
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
