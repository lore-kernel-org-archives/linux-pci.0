Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH 5/7] iommu/arm-smmu-v3: Link domains and devices
Date: Wed, 24 May 2017 19:01:41 +0100
Message-Id: <20170524180143.19855-6-jean-philippe.brucker@arm.com>
In-Reply-To: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, will.deacon@arm.com,
 joro@8bytes.org, thunder.leizhen@huawei.com, rjw@rjwysocki.net,
 okaya@codeaurora.org, robh+dt@kernel.org, hanjun.guo@linaro.org,
 sudeep.holla@arm.com, bhelgaas@google.com, tn@semihalf.com,
 sunil.kovvuri@gmail.com, robin.murphy@arm.com, lenb@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

When removing a mapping from a domain, we need to send an invalidation to
all devices that might have stored it in their Address Translation Cache
(ATC). In addition with SVM, we'll need to invalidate context descriptors
of all devices attached to a domain.

Maintain a list of devices in each domain, protected by a spinlock. It is
updated every time we attach or detach devices to and from domains.

It needs to be a spinlock because we'll invalidate ATC entries from
within hardirq-safe contexts, but it may be possible to relax the read
side with RCU later.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 380969aa60d5..524e1b051962 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -630,6 +630,9 @@ struct arm_smmu_device {
 struct arm_smmu_master_data {
 	struct arm_smmu_device		*smmu;
 	struct arm_smmu_strtab_ent	ste;
+
+	struct arm_smmu_domain		*domain;
+	struct list_head		list; /* domain->devices */
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -654,6 +657,9 @@ struct arm_smmu_domain {
 	};
 
 	struct iommu_domain		domain;
+
+	struct list_head		devices;
+	spinlock_t			devices_lock;
 };
 
 struct arm_smmu_option_prop {
@@ -1407,6 +1413,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->pgtbl_lock);
+	INIT_LIST_HEAD(&smmu_domain->devices);
+	spin_lock_init(&smmu_domain->devices_lock);
+
 	return &smmu_domain->domain;
 }
 
@@ -1609,7 +1618,17 @@ static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 
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
@@ -1618,6 +1637,7 @@ static void arm_smmu_detach_dev(struct device *dev)
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
+	unsigned long flags;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master_data *master;
@@ -1653,6 +1673,11 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	ste->assigned = true;
+	master->domain = smmu_domain;
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_add(&master->list, &smmu_domain->devices);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS) {
 		ste->s1_cfg = NULL;
-- 
2.12.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
