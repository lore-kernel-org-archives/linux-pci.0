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
Subject: [RFCv2 PATCH 30/36] ACPI/IORT: Check ATS capability in root complex nodes
Date: Fri,  6 Oct 2017 14:31:57 +0100
Message-Id: <20171006133203.22803-31-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Root complex node in IORT has a bit telling whether it supports ATS or
not. Store this bit in the IOMMU fwspec when setting up a device, so it
can be accessed later by an IOMMU driver.

Use the negative version at the moment because it's not clear if/how the
bit needs to be integrated in other firmare descriptions. The SMMU has a
feature bit telling if it supports ATS, which might be sufficient in most
systems for deciding whether or not we should enable the ATS capability in
endpoints.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/acpi/arm64/iort.c | 11 +++++++++++
 include/linux/iommu.h     |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 9565d572f8dd..b94eac8ed21e 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -768,6 +768,14 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 	dev_dbg(dev, "dma_pfn_offset(%#08llx)\n", offset);
 }
 
+static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
+{
+	struct acpi_iort_root_complex *pci_rc;
+
+	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
+	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
+}
+
 /**
  * iort_iommu_configure - Set-up IOMMU configuration for a device.
  *
@@ -803,6 +811,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 		info.node = node;
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     iort_pci_iommu_init, &info);
+
+		if (!err && !iort_pci_rc_supports_ats(node))
+			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_NO_ATS;
 	} else {
 		int i = 0;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2eb65d4724bb..661031aed0c4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -534,12 +534,16 @@ struct iommu_fwspec {
 	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
 	void			*iommu_priv;
+	u32			flags;
 	unsigned int		num_ids;
 	unsigned int		num_pasid_bits;
 	bool			can_stall;
 	u32			ids[1];
 };
 
+/* Firmware disabled ATS in the root complex */
+#define IOMMU_FWSPEC_PCI_NO_ATS			(1 << 0)
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
 void iommu_fwspec_free(struct device *dev);
-- 
2.13.3

