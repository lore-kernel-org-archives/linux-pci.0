Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45586 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbeBLScF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Feb 2018 13:32:05 -0500
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        xuzaibo@huawei.com, ilias.apalodimas@linaro.org,
        jonathan.cameron@huawei.com, shunyong.yang@hxt-semitech.com,
        nwatters@codeaurora.org, okaya@codeaurora.org,
        jcrouse@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com, christian.koenig@amd.com,
        bharatku@xilinx.com
Subject: [PATCH 12/37] iommu/of: Add stall and pasid properties to iommu_fwspec
Date: Mon, 12 Feb 2018 18:33:27 +0000
Message-Id: <20180212183352.22730-13-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add stall and pasid properties to iommu_fwspec, and fill them when
dma-can-stall and pasid-bits properties are present in the device tree.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/of_iommu.c | 12 ++++++++++++
 include/linux/iommu.h    |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c36a8b7656a..98158fc061ca 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -204,6 +204,18 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			if (err)
 				break;
 		}
+
+		fwspec = dev->iommu_fwspec;
+		if (!err && fwspec) {
+			const __be32 *prop;
+
+			if (of_get_property(master_np, "dma-can-stall", NULL))
+				fwspec->can_stall = true;
+
+			prop = of_get_property(master_np, "pasid-bits", NULL);
+			if (prop)
+				fwspec->num_pasid_bits = be32_to_cpu(*prop);
+		}
 	}
 
 	/*
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 36fcb579f5ed..37c3b9d087ce 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -632,6 +632,8 @@ struct iommu_fwspec {
 	struct fwnode_handle	*iommu_fwnode;
 	void			*iommu_priv;
 	unsigned int		num_ids;
+	unsigned int		num_pasid_bits;
+	bool			can_stall;
 	u32			ids[1];
 };
 
-- 
2.15.1
