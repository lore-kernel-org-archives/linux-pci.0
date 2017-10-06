Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752270AbdJFN3A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Oct 2017 09:29:00 -0400
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
Subject: [RFCv2 PATCH 13/36] iommu/of: Add stall and pasid properties to iommu_fwspec
Date: Fri,  6 Oct 2017 14:31:40 +0100
Message-Id: <20171006133203.22803-14-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add stall and pasid properties to iommu_fwspec, and fill them when
dma-can-stall and pasid-bits properties are present in the device tree.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/of_iommu.c | 10 ++++++++++
 include/linux/iommu.h    |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 50947ebb6d17..345286bfdbfc 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -204,6 +204,16 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			if (err)
 				break;
 		}
+
+		if (!err && dev->iommu_fwspec) {
+			const __be32 *prop;
+			if (of_get_property(master_np, "dma-can-stall", NULL))
+				dev->iommu_fwspec->can_stall = true;
+
+			prop = of_get_property(master_np, "pasid-bits", NULL);
+			if (prop)
+				dev->iommu_fwspec->num_pasid_bits = be32_to_cpu(*prop);
+		}
 	}
 
 	/*
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a6d417785c7b..2eb65d4724bb 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -535,6 +535,8 @@ struct iommu_fwspec {
 	struct fwnode_handle	*iommu_fwnode;
 	void			*iommu_priv;
 	unsigned int		num_ids;
+	unsigned int		num_pasid_bits;
+	bool			can_stall;
 	u32			ids[1];
 };
 
-- 
2.13.3
