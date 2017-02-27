Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: 
Subject: [RFC PATCH 02/30] iommu/arm-smmu-v3: Link groups and domains
Date: Mon, 27 Feb 2017 19:54:13 +0000
Message-Id: <20170227195441.5170-3-jean-philippe.brucker@arm.com>
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

When removing a mapping from a domain, we need to send an invalidation to
all of devices that might have stored it in their Address Translation
Cache (ATC). This requires a lookup from smmu_domain to smmu_group. Add a
list of groups in each domain.

Although this domain-group link is already protected by
iommu_group->mutex, the domain-to-group lookup will be done outside of the
sections protected by that mutex. Add a spinlock for this case.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index ce8b68fe254b..69d00416990d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -651,9 +651,15 @@ struct arm_smmu_domain {
 	};
 
 	struct iommu_domain		domain;
+
+	struct list_head		groups;
+	spinlock_t			groups_lock;
 };
 
 struct arm_smmu_group {
+	struct arm_smmu_domain		*domain;
+	struct list_head		domain_head;
+
 	struct list_head		devices;
 	spinlock_t			devices_lock;
 };
@@ -1408,6 +1414,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->pgtbl_lock);
+	INIT_LIST_HEAD(&smmu_domain->groups);
+	spin_lock_init(&smmu_domain->groups_lock);
+
 	return &smmu_domain->domain;
 }
 
@@ -1641,6 +1650,7 @@ static void arm_smmu_detach_dev(struct device *dev)
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
+	unsigned long flags;
 	struct iommu_group *group;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_group *smmu_group;
@@ -1666,9 +1676,31 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -ENOMEM;
 	}
 
-	/* Already attached to a different domain? */
-	if (!ste->bypass)
+	/*
+	 * Already attached to a different domain? This happens when we're
+	 * switching from default domain to unmanaged domain, and back. We
+	 * assume here that, when switching from old domain to new domain, old
+	 * domain doesn't have any live mapping anymore. This is an important
+	 * requirement because here we remove the group-domain link when we
+	 * re-attach the first device in a group. Other devices in that group
+	 * might still be attached to the old domain, and will be reattached in
+	 * a moment.
+	 *
+	 * We also take this path when attaching for the very first time, just
+	 * after the STE is initialized.
+	 */
+	if (!ste->bypass) {
+		struct arm_smmu_domain *other_domain = smmu_group->domain;
+
+		if (other_domain) {
+			spin_lock_irqsave(&other_domain->groups_lock, flags);
+			list_del(&smmu_group->domain_head);
+			spin_unlock_irqrestore(&other_domain->groups_lock, flags);
+
+			smmu_group->domain = NULL;
+		}
 		arm_smmu_detach_dev(dev);
+	}
 
 	mutex_lock(&smmu_domain->init_mutex);
 
@@ -1688,6 +1720,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		goto out_unlock;
 	}
 
+	if (!smmu_group->domain) {
+		smmu_group->domain = smmu_domain;
+
+		spin_lock_irqsave(&smmu_domain->groups_lock, flags);
+		list_add(&smmu_group->domain_head, &smmu_domain->groups);
+		spin_unlock_irqrestore(&smmu_domain->groups_lock, flags);
+	}
+
 	ste->bypass = false;
 	ste->valid = true;
 
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
