Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A936195E;
	Thu,  8 Oct 2026 06:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439343; cv=none; b=joH2zAWRaDG3py5OV5TNOzMOXescrT1hUpv3AiDh3Psj74co21HZop6lgzzvfZa65rVbF8mZw1y3kfdr2kBjDk3cpI//wo+kSbCyJiJOv29eZYFwTE8wt+2TWAa2ALlhbeeub1Gv30wqjxULjgyxkJO4x6PGXmBFLDtwXwNnipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439343; c=relaxed/simple;
	bh=c4OUFOTNZICbCssPSpHxsMEk5j9t/BQyy7busirwfaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hz4hytQnl8YSCoYAk7Jw3x+tHKwDVuHmeu/JX09a3aSRsyP6mrC8NWPOBC9g0aoMXGKXiuwWivcdQdPB+i3OCnCrlZv4hjQqsbFyDQ5LtILvi/yTQXJaLBwETPktcmVqtfRzEpzB+vxQPDcKax/3Ibzw3imEa6rzDlx4ubLH2NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6JeWn8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6JeWn8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7131F00898;
	Thu,  8 Oct 2026 06:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439341;
	bh=HsFb07rZQvaCNCPLNhYnGM8BufXu5/CzxRCOplrbENc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F6JeWn8JruVOGpevDiQTYEFtZLGG2gwKW/tiLbJDzDpWPajeOcePK79xftwNDeZbv
	 Xm/KGgKjp0v3YGoPBr87AssGSSw2RR97/svZgC4b7bEEJ88sG1HqNGgMXcNDM5Izan
	 hMQVo84NWWXPBxG+uK3XKXIhOBH/mdZHm9REn+JvbH0Qm5HkAche/w2jF5Rdja1x7H
	 zWr1cXplH9HULtB5Lm10gnvhsKDcZ3K5W0Qe5BHyG4qFvUYfP8di5jlFIqwhWsNaI2
	 aZPEq4dDD5/DAYCC0ltWQo8yz3X7cDwDT9HgvtuecmiAB5hw7St4XAiP25KAiu3/04
	 Tsdfh3pwtcrIw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v7 14/16] iommufd/viommu: Allow PCI TSM backends to provide vIOMMU operations
Date: Thu,  8 Oct 2026 11:29:53 +0530
Message-ID: <20261008055955.4014342-15-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In confidential-computing configurations, a vIOMMU may be implemented by
a TEE Security Manager rather than by the physical IOMMU driver. Such an
implementation also needs the TSM identity when creating and validating
vdevices.

Allow VIOMMU_ALLOC to first query the TSM associated with the target PCI
device for vIOMMU operations. Fall back to the physical IOMMU driver
when the TSM does not provide operations for the requested vIOMMU type.

Resolve the PCI TSM association under pci_tsm_rwsem and pin the module
providing the operations. Store the TSM device in the vIOMMU so that the
backend operations and TSM identity remain valid for its lifetime.
Release the module pin when vIOMMU is destroyed.

This enables the Realm vIOMMU implementation to provide its operations
through the PCI TSM backend and retain the TSM identity needed by its
vdevices.

Cc: jgg@ziepe.ca
Cc: kevin.tian@intel.com
Cc: joro@8bytes.org
Cc: will@kernel.org
Cc: robin.murphy@arm.com
Cc: bhelgaas@google.com
Cc: iommu@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/viommu.c | 35 +++++++++++++++++++++++++++++-----
 drivers/pci/tsm.c              | 21 ++++++++++++++++++++
 drivers/virt/coco/tsm-core.c   | 33 ++++++++++++++++++++++++++++++++
 include/linux/iommufd.h        |  2 ++
 include/linux/pci-tsm.h        | 22 +++++++++++++++++++++
 include/linux/tsm.h            | 23 ++++++++++++++++++++++
 6 files changed, 131 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index e95138ae71d5..8628161b37c6 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -14,6 +14,8 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 
 	if (viommu->ops && viommu->ops->destroy)
 		viommu->ops->destroy(viommu);
+	if (viommu->tsm_dev)
+		tsm_put_device(viommu->tsm_dev);
 	refcount_dec(&viommu->hwpt->common.obj.users);
 	if (viommu->kvm_file)
 		fput(viommu->kvm_file);
@@ -29,6 +31,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		.len = cmd->data_len,
 	};
 	struct iommufd_hwpt_paging *hwpt_paging;
+	struct tsm_dev *tsm_dev = NULL;
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
 	struct iommu_device *iommu_dev;
@@ -48,15 +51,33 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		rc = -EOPNOTSUPP;
 		goto out_put_idev;
 	}
-	if (!iommu_dev->ops->get_viommu_ops) {
-		rc = -EOPNOTSUPP;
+	tsm_dev = tsm_get_device(idev->dev);
+	if (IS_ERR(tsm_dev)) {
+		rc = PTR_ERR(tsm_dev);
+		tsm_dev = NULL;
 		goto out_put_idev;
 	}
-	ops = iommu_dev->ops->get_viommu_ops(idev->dev, cmd->type);
-	if (!ops) {
-		rc = -EOPNOTSUPP;
+	ops = tsm_dev ? tsm_viommu_get_ops(tsm_dev, idev->dev, cmd->type) : NULL;
+	if (IS_ERR(ops)) {
+		rc = PTR_ERR(ops);
 		goto out_put_idev;
 	}
+	if (!ops) {
+		if (tsm_dev) {
+			tsm_put_device(tsm_dev);
+			tsm_dev = NULL;
+		}
+		if (!iommu_dev->ops->get_viommu_ops) {
+			rc = -EOPNOTSUPP;
+			goto out_put_idev;
+		}
+		ops = iommu_dev->ops->get_viommu_ops(idev->dev, cmd->type);
+		if (!ops) {
+			rc = -EOPNOTSUPP;
+			goto out_put_idev;
+		}
+	}
+
 	/*
 	 * It is a driver bug to omit the required operations or provide a size
 	 * smaller than the core vIOMMU structure.
@@ -94,6 +115,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		viommu->kvm_file = get_file(idev->kvm_file);
 	viommu->type = cmd->type;
 	viommu->ictx = ucmd->ictx;
+	viommu->tsm_dev = tsm_dev;
+	tsm_dev = NULL;
 	viommu->hwpt = hwpt_paging;
 	refcount_inc(&viommu->hwpt->common.obj.users);
 	INIT_LIST_HEAD(&viommu->veventqs);
@@ -118,6 +141,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 out_put_hwpt:
 	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
 out_put_idev:
+	if (tsm_dev)
+		tsm_put_device(tsm_dev);
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index dca9634f8d5e..c8603867e09d 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -9,6 +9,8 @@
 #define dev_fmt(fmt) "PCI/TSM: " fmt
 
 #include <linux/bitfield.h>
+#include <linux/iommufd.h>
+#include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/pci-tsm.h>
@@ -36,6 +38,25 @@ static const struct pci_tsm_ops *to_pci_tsm_ops(struct pci_tsm *tsm)
 	return tsm->tsm_dev->pci_ops;
 }
 
+struct tsm_dev *pci_tsm_get_device(struct pci_dev *pdev)
+{
+	const struct pci_tsm_ops *ops;
+	struct tsm_dev *tsm_dev;
+
+	guard(rwsem_read)(&pci_tsm_rwsem);
+	if (!pdev->tsm)
+		return NULL;
+
+	tsm_dev = pdev->tsm->tsm_dev;
+	ops = tsm_dev->pci_ops;
+	if (!ops->viommu_get_ops)
+		return NULL;
+	if (!try_module_get(ops->owner))
+		return ERR_PTR(-ENODEV);
+	return tsm_dev;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_get_device);
+
 static inline bool is_dsm(struct pci_dev *pdev)
 {
 	return pdev->tsm && pdev->tsm->dsm_dev == pdev;
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index f79135986102..2fce341ff923 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -9,6 +9,16 @@
 #include <linux/cleanup.h>
 #include <linux/pci-tsm.h>
 
+/* The caller must hold a tsm_get_device() reference for the entire use. */
+const struct iommufd_viommu_ops *tsm_viommu_get_ops(struct tsm_dev *tsm_dev,
+		struct device *dev, enum iommu_viommu_type type)
+{
+	if (!tsm_dev->pci_ops->viommu_get_ops)
+		return NULL;
+	return tsm_dev->pci_ops->viommu_get_ops(dev, type);
+}
+EXPORT_SYMBOL_GPL(tsm_viommu_get_ops);
+
 static void tsm_release(struct device *);
 static const struct class tsm_class = {
 	.name		= "tsm",
@@ -16,6 +26,29 @@ static const struct class tsm_class = {
 };
 static DEFINE_IDA(tsm_ida);
 
+/**
+ * tsm_get_device() - Pin the TSM attached to a device
+ * @dev: device whose TSM is to be pinned
+ *
+ * A successful lookup pins the backend module. Backends providing vIOMMU
+ * operations must not unregister their TSM independently of module unload.
+ * Return: NULL if no vIOMMU-capable TSM is attached, an error if the module
+ * cannot be pinned, or the TSM device associated with the pinned backend.
+ */
+struct tsm_dev *tsm_get_device(struct device *dev)
+{
+	if (!dev_is_pci(dev))
+		return NULL;
+	return pci_tsm_get_device(to_pci_dev(dev));
+}
+EXPORT_SYMBOL_GPL(tsm_get_device);
+
+void tsm_put_device(struct tsm_dev *tsm_dev)
+{
+	module_put(tsm_dev->pci_ops->owner);
+}
+EXPORT_SYMBOL_GPL(tsm_put_device);
+
 static int match_id(struct device *dev, const void *data)
 {
 	struct tsm_dev *tsm_dev = container_of(dev, struct tsm_dev, dev);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 98ac3e5e9c66..fd4567940243 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -23,6 +23,7 @@ struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
 struct iommufd_viommu_ops;
+struct tsm_dev;
 struct page;
 struct tsm_guest_req_info;
 
@@ -105,6 +106,7 @@ struct iommufd_viommu {
 	struct iommu_device *iommu_dev;
 	struct iommufd_hwpt_paging *hwpt;
 	struct file *kvm_file;
+	struct tsm_dev *tsm_dev;
 
 	const struct iommufd_viommu_ops *ops;
 
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index eaf0199d01f7..b27f7cf99f22 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -4,6 +4,8 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 
+struct iommufd_viommu_ops;
+struct module;
 struct pci_tsm;
 struct pci_tsm_context;
 struct tsm_dev;
@@ -16,12 +18,26 @@ struct tsm_dev;
  * @devsec_ops: Lock, unlock, and interrogate the security state of the
  *		function via the platform TSM (typically virtual function
  *		operations).
+ * @viommu_get_ops: Return operations for a supported TSM-owned vIOMMU type,
+ *		  or NULL if unsupported
+ * @owner: Module providing the vIOMMU operations, if built as a module
+ *
+ * The vIOMMU owner pins the backend module before querying @viommu_get_ops
+ * and releases it after vIOMMU destruction. A backend providing this callback
+ * must not unregister its TSM while the module is pinned.
  *
  * This operations are mutually exclusive either a tsm_dev instance
  * manages physical link properties or it manages function security
  * states like TDISP lock/unlock.
+ *
+ * @viommu_get_ops runs with the backend module pinned. The PCI/TSM
+ * association is checked during acquisition under pci_tsm_rwsem.
  */
 struct pci_tsm_ops {
+	struct module *owner;
+	const struct iommufd_viommu_ops *(*viommu_get_ops)(
+		struct device *dev, enum iommu_viommu_type type);
+
 	/*
 	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
 	 * @probe: establish context with the TSM (allocate / wrap 'struct
@@ -151,6 +167,7 @@ struct pci_tsm_pf0 *pci_tsm_context_pf0(struct pci_tsm_context *context);
 struct pci_dev *pci_tsm_context_dsm_dev(struct pci_tsm_context *context);
 bool pci_tsm_context_match_device(struct pci_tsm_context *context,
 				  struct pci_dev *pdev);
+struct tsm_dev *pci_tsm_get_device(struct pci_dev *pdev);
 #else
 static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
@@ -165,6 +182,11 @@ static inline bool pci_tsm_is_configured(struct pci_dev *pdev)
 	return false;
 }
 
+static inline struct tsm_dev *pci_tsm_get_device(struct pci_dev *pdev)
+{
+	return NULL;
+}
+
 static inline struct pci_tsm_context *
 pci_tsm_context_get(struct pci_dev *pdev, struct tsm_dev *viommu_tsm_dev)
 {
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 4bce4c9fa6f0..e5d14f9a23e9 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -110,6 +110,8 @@ struct tsm_report_ops {
 };
 
 struct pci_tsm_ops;
+struct iommufd_viommu_ops;
+
 struct tsm_dev {
 	struct device dev;
 	int id;
@@ -126,6 +128,11 @@ void tsm_unregister(struct tsm_dev *tsm_dev);
 struct tsm_dev *find_tsm_dev(int id);
 
 #ifdef CONFIG_TSM
+struct tsm_dev *tsm_get_device(struct device *dev);
+void tsm_put_device(struct tsm_dev *tsm_dev);
+const struct iommufd_viommu_ops *tsm_viommu_get_ops(struct tsm_dev *tsm_dev,
+		struct device *dev, enum iommu_viommu_type type);
+
 /**
  * struct tsm_guest_req_info - parameters for a guest-initiated TSM request
  * @op: operation for the guest-initiated request
@@ -144,6 +151,22 @@ struct tsm_guest_req_info {
 	u32 resp_len;
 };
 #else
+static inline struct tsm_dev *tsm_get_device(struct device *dev)
+{
+	return NULL;
+}
+
+static inline void tsm_put_device(struct tsm_dev *tsm_dev)
+{
+}
+
+static inline const struct iommufd_viommu_ops *
+tsm_viommu_get_ops(struct tsm_dev *tsm_dev, struct device *dev,
+		enum iommu_viommu_type type)
+{
+	return NULL;
+}
+
 struct tsm_guest_req_info;
 #endif
 #endif /* __TSM_H */
-- 
2.43.0

