Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809131;
	b=OR/94wfHhp/quxR+YofYQ+SBLX5czNqJVy0qoLDYjxPOBfa2YGWgkxWqIMBvY9QvPN4k
	 cR++xBKULYObs/RUomPZ/IR4rlxr6E1oOlUsBx9UggUkItCCSwBj3hP+TQfDfxNsc7ttW
	 bqjdKOLQll0T0BJdQAu30UvoRh+mIzmVRw44NdB6YpIgxW1B7bIg+JLUf653LFYyETAID
	 356AV4uLsWsW+k0CKHKx4D/qCr+b3T+q5q7qx9RoBPThmdcH0F/yqzdVJ2ocayIP1Z+Un
	 bAiy9Kv4BASLe02gUmAW+28WAU75ivfKndvtKcNoXK73XsVRCkrDKBi2noAZF1TJRBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809131;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=quK0jel7dWmSMFhyEie7+nnJ/+ISdxaqzgj2R+8T8wg=;
	b=clD4ZZe6TKKz2bkVBWl+KAieNXoO99EwMUppZsR2qIN1QHmBwkUb5a0Qpn/9u9+o07wF
	 pcPom2wVSVcRrkDeowlAIyIsJvSIDEiP+33KDD7KbhCGRaI6HVfpIaflnXA6QOTDkdka2
	 vV51xxVh5I9fOmHzNeGWZNfTARt+30gvqbsBKjncY8hvhbnno6p0pssNopp5OZQqj5Ebj
	 iYHbU8eCrtjGUPUl7wBW5RlGZjCEWow90+eIrT0P7bZq0w9Y80eqNCQpqFwsSCLZS6lGE
	 4UdnFH121ZmIIUGQI8WlavMOuCn7H5bETfmKL2feckM18Wq8xNccjpOYjHv7pxbmWGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtZ7mlzR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E89606EE82;
	Wed,  4 Nov 2026 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtZ7mlzR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371761F00919;
	Wed,  4 Nov 2026 16:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809130;
	bh=quK0jel7dWmSMFhyEie7+nnJ/+ISdxaqzgj2R+8T8wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HtZ7mlzRyijryDi5Gbp7iL08iNC4xPNv2E8gkpt/dKjg3I6DfWFy8Sj0RrPyQuYou
	 M4Iq92ia/vjIAdNP1vSJfexUkBCQ9bCNKAFQcQl/fxUcckiqYqPYe8oc34uDoWXL4m
	 l3PouSx2gR3NIybM0GNniBnQJy6cXD7DiznqRxxH5hrBMQF6DVK1Q/rDTJt9aWOvqH
	 cuA6TthDunmCC/67OVkT2XceDNKp0hRA1fsBRcOSSmTyxz5o/7vesqXWrijNmNJYOp
	 Odv72AcWvtccEkJJjFuGgE/CNoNh+nZdOdDWrfLIvQwwAJozRFGsR4cNoTVXAO1G/L
	 hMmgEQs2+MwiA==
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
Subject: [PATCH v8 12/15] iommufd/viommu: Allow PCI TSM backends to provide vIOMMU operations
Date: Wed,  4 Nov 2026 21:46:29 +0530
Message-ID: <20261104161632.3547423-13-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In confidential-computing configurations, a vIOMMU may be implemented by
a TEE Security Manager rather than by the physical IOMMU driver. Such an
implementation also needs the TSM identity when creating and validating
vdevices.

Allow VIOMMU_ALLOC to first query the TSM associated with the target PCI
device for vIOMMU operations. Fall back to the physical IOMMU driver
when the TSM does not provide operations for the requested vIOMMU type.

Resolve the PCI TSM association under pci_tsm_rwsem, pin the module
providing the operations, and take a TSM device reference. Store the TSM
device in the vIOMMU and release both references on allocation failure,
fallback to the physical IOMMU driver, or vIOMMU destruction. Keep the
module pinned until after dropping the device reference, since the final
put may release the TSM device.

The device reference preserves the TSM allocation. Backends providing
vIOMMU operations must not unregister their TSM while the module is pinned,
since the reference does not prevent backend resource teardown.

This enables the Realm vIOMMU implementation to provide its operations
through the PCI TSM backend and retain the TSM identity needed by its
vdevices.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: iommu@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/viommu.c | 35 +++++++++++++++++++++++++++-----
 drivers/pci/tsm/core.c         | 22 ++++++++++++++++++++
 drivers/virt/coco/tsm-core.c   | 37 ++++++++++++++++++++++++++++++++++
 include/linux/iommufd.h        |  2 ++
 include/linux/pci-tsm.h        | 24 ++++++++++++++++++++++
 include/linux/tsm.h            | 25 +++++++++++++++++++++++
 6 files changed, 140 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 16e8b6421f1f..1686f19c5060 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -15,6 +15,8 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 
 	if (viommu->ops && viommu->ops->destroy)
 		viommu->ops->destroy(viommu);
+	if (viommu->tsm_dev)
+		tsm_put_device(viommu->tsm_dev);
 	refcount_dec(&viommu->hwpt->common.obj.users);
 	if (viommu->kvm_file)
 		fput(viommu->kvm_file);
@@ -30,6 +32,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		.len = cmd->data_len,
 	};
 	struct iommufd_hwpt_paging *hwpt_paging;
+	struct tsm_dev *tsm_dev = NULL;
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
 	struct iommu_device *iommu_dev;
@@ -49,15 +52,33 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
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
@@ -95,6 +116,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		viommu->kvm_file = get_file(idev->kvm_file);
 	viommu->type = cmd->type;
 	viommu->ictx = ucmd->ictx;
+	viommu->tsm_dev = tsm_dev;
+	tsm_dev = NULL;
 	viommu->hwpt = hwpt_paging;
 	refcount_inc(&viommu->hwpt->common.obj.users);
 	INIT_LIST_HEAD(&viommu->veventqs);
@@ -119,6 +142,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 out_put_hwpt:
 	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
 out_put_idev:
+	if (tsm_dev)
+		tsm_put_device(tsm_dev);
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
index 96ba5a8be8af..5ded1a5a4f7e 100644
--- a/drivers/pci/tsm/core.c
+++ b/drivers/pci/tsm/core.c
@@ -9,6 +9,8 @@
 #define dev_fmt(fmt) "PCI/TSM: " fmt
 
 #include <linux/bitfield.h>
+#include <linux/iommufd.h>
+#include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/pci-tsm.h>
@@ -36,6 +38,26 @@ static const struct pci_tsm_ops *to_pci_tsm_ops(struct pci_tsm *tsm)
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
+	get_device(&tsm_dev->dev);
+	return tsm_dev;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_get_device);
+
 static inline bool is_dsm(struct pci_dev *pdev)
 {
 	return pdev->tsm && pdev->tsm->dsm_dev == pdev;
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index e7807dc94807..92ce3337f1ea 100644
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
@@ -16,6 +26,33 @@ static const struct class tsm_class = {
 };
 static DEFINE_IDA(tsm_ida);
 
+/**
+ * tsm_get_device() - Pin the TSM attached to a device
+ * @dev: device whose TSM is to be pinned
+ *
+ * A successful lookup takes a TSM device reference and pins the backend
+ * module. Release both with tsm_put_device(). Backends providing vIOMMU
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
+	struct module *owner = tsm_dev->pci_ops->owner;
+
+	put_device(&tsm_dev->dev);
+	module_put(owner);
+}
+EXPORT_SYMBOL_GPL(tsm_put_device);
+
 static int match_id(struct device *dev, const void *data)
 {
 	struct tsm_dev *tsm_dev = container_of(dev, struct tsm_dev, dev);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 5f5c67b24134..a4b29915d0ca 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -23,6 +23,7 @@ struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
 struct iommufd_viommu_ops;
+struct tsm_dev;
 struct page;
 
 enum iommufd_object_type {
@@ -104,6 +105,7 @@ struct iommufd_viommu {
 	struct iommu_device *iommu_dev;
 	struct iommufd_hwpt_paging *hwpt;
 	struct file *kvm_file;
+	struct tsm_dev *tsm_dev;
 
 	const struct iommufd_viommu_ops *ops;
 
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index eaf0199d01f7..19e9e0ef3bbb 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -3,7 +3,10 @@
 #define __PCI_TSM_H
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <uapi/linux/iommufd.h>
 
+struct iommufd_viommu_ops;
+struct module;
 struct pci_tsm;
 struct pci_tsm_context;
 struct tsm_dev;
@@ -16,12 +19,27 @@ struct tsm_dev;
  * @devsec_ops: Lock, unlock, and interrogate the security state of the
  *		function via the platform TSM (typically virtual function
  *		operations).
+ * @viommu_get_ops: Return operations for a supported TSM-owned vIOMMU type,
+ *		  or NULL if unsupported
+ * @owner: Module providing the vIOMMU operations, if built as a module
+ *
+ * The vIOMMU owner holds a TSM device reference and pins the backend module
+ * before querying @viommu_get_ops, releasing both after vIOMMU destruction.
+ * A backend providing this callback must not unregister its TSM while the
+ * module is pinned.
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
@@ -151,6 +169,7 @@ struct pci_tsm_pf0 *pci_tsm_context_pf0(struct pci_tsm_context *context);
 struct pci_dev *pci_tsm_context_dsm_dev(struct pci_tsm_context *context);
 bool pci_tsm_context_match_device(struct pci_tsm_context *context,
 				  struct pci_dev *pdev);
+struct tsm_dev *pci_tsm_get_device(struct pci_dev *pdev);
 #else
 static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
@@ -165,6 +184,11 @@ static inline bool pci_tsm_is_configured(struct pci_dev *pdev)
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
index 19dedf971f14..3d5286aeaa42 100644
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
@@ -124,4 +126,27 @@ int tsm_report_unregister(const struct tsm_report_ops *ops);
 struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_dev *tsm_dev);
 struct tsm_dev *find_tsm_dev(int id);
+
+#ifdef CONFIG_TSM
+struct tsm_dev *tsm_get_device(struct device *dev);
+void tsm_put_device(struct tsm_dev *tsm_dev);
+const struct iommufd_viommu_ops *tsm_viommu_get_ops(struct tsm_dev *tsm_dev,
+		struct device *dev, enum iommu_viommu_type type);
+#else
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
+#endif
 #endif /* __TSM_H */
-- 
2.43.0

