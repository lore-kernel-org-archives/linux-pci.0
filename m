Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752943AbeBLScR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Feb 2018 13:32:17 -0500
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
Subject: [PATCH 14/37] iommu/arm-smmu-v3: Link domains and devices
Date: Mon, 12 Feb 2018 18:33:29 +0000
Message-Id: <20180212183352.22730-15-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When removing a mapping from a domain, we need to send an invalidation to
all devices that might have stored it in their Address Translation Cache
(ATC). In addition when updating the context descriptor of a live domain,
we'll need to send invalidations for all devices attached to it.

Maintain a list of devices in each domain, protected by a spinlock. It is
updated every time we attach or detach devices to and from domains.

It needs to be a spinlock because we'll invalidate ATC entries from
within hardirq-safe contexts, but it may be possible to relax the read
side with RCU later.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 3f2f1fc68b52..fb2507ffcdaf 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -652,6 +652,11 @@ struct arm_smmu_device {
 struct arm_smmu_master_data {
 	struct arm_smmu_device		*smmu;
 	struct arm_smmu_strtab_ent	ste;
+
+	struct arm_smmu_domain		*domain;
+	struct list_head		list; /* domain->devices */
+
+	struct device			*dev;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -675,6 +680,9 @@ struct arm_smmu_domain {
 	};
 
 	struct iommu_domain		domain;
+
+	struct list_head		devices;
+	spinlock_t			devices_lock;
 };
 
 struct arm_smmu_option_prop {
@@ -1540,6 +1548,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	}
 
 	mutex_init(&smmu_domain->init_mutex);
+	INIT_LIST_HEAD(&smmu_domain->devices);
+	spin_lock_init(&smmu_domain->devices_lock);
+
 	return &smmu_domain->domain;
 }
 
@@ -1754,7 +1765,17 @@ static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 
 static void arm_smmu_detach_dev(struct device *dev)
 {
+	unsigned long flags;
 	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
+	struct arm_smmu_domain *smmu_domain = master->domain;
+
+	if (smmu_domain) {
+		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+		list_del(&master->list);
+		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+		master->domain = NULL;
+	}
 
 	master->ste.assigned = false;
 	arm_smmu_install_ste_for_dev(dev->iommu_fwspec);
@@ -1763,6 +1784,7 @@ static void arm_smmu_detach_dev(struct device *dev)
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
+	unsigned long flags;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master_data *master;
@@ -1798,6 +1820,11 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	ste->assigned = true;
+	master->domain = smmu_domain;
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_add(&master->list, &smmu_domain->devices);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS) {
 		ste->s1_cfg = NULL;
@@ -1916,6 +1943,7 @@ static int arm_smmu_add_device(struct device *dev)
 			return -ENOMEM;
 
 		master->smmu = smmu;
+		master->dev = dev;
 		fwspec->iommu_priv = master;
 	}
 
-- 
2.15.1
