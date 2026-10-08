Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE77439A7EF;
	Thu,  8 Oct 2026 06:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439353; cv=none; b=X8R96eQAntRMhWJq7cbj6KBorz+OdwN3edM/5kirglQIDYlxuaYf/uuY+64dtxyYXl76sA1ICp55an/iY/Jg9jNvAFDjL/Dw5WIZjQ+tuN5l6C8/0nVJOs8LB+mer7BH7WvuXluZYoxyewwFbKP7I8CpezFFlElow7MrZlSLYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439353; c=relaxed/simple;
	bh=GFcwXsqrKNBpKdNBpR14qY6kHnVhOkaoNIzfmMWdgx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofnFDuymmrRX2qsWDSKltE/dhWAyEmWldEeduGD0rJJ6f4sR+ASHQKSDYsiehu66evu4R1UHkg8z62j6wVTYMUJplyJXgafYul/jtFqTaKXrfDVncHFRcNOMZmzXnW5527kJ/YHIOYyNEK0KI5VIA6p2aM8Rk2gIFfeX0y7r3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIsoNDzm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIsoNDzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD921F000FF;
	Thu,  8 Oct 2026 06:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439350;
	bh=EPSt4YMGK6/39DB1mPBVZyRGJldnMK0DKSdFU+vayv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AIsoNDzmprNM/HDczkRcybkOktlmBSqgwaSUIvnSEwxPVs6G+4SdZUlgyrlVBehMi
	 HYDna6jAofivvJ1fOH7URpdzO0e0lnD8LpH609NbMuKU2hThXp4FP0t/ap6j2LvENr
	 cU5f3XUMN90mOaW6nwSuVrQJTgr755h5BTEeUGmVy1segvTEQm8ZODtHdxNZjOwuzD
	 G681GzaR/euwMcFTobcaLL9yJpz35SRAWGUHJlNcc4c15affrfA5JJd7EtkqYSH1wN
	 Xl60OpNJONhdlYQhSaH//o1PA7V2nQcZKtn8fad9KJltJFMBboqO72+N/8vtNnHbCd
	 MglVh+gfwZpEA==
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
	linux-tegra@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org
Subject: [PATCH v7 15/16] iommufd: Allow vIOMMUs without a parent HWPT
Date: Thu,  8 Oct 2026 11:29:54 +0530
Message-ID: <20261008055955.4014342-16-aneesh.kumar@kernel.org>
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

VIOMMU_ALLOC currently requires a nesting parent HWPT_PAGING even when
the selected vIOMMU implementation has no use for one. This would force
implementations such as the following Arm Realm vIOMMU to create an
unused parent.

Add IOMMUFD_VIOMMU_NO_HWPT so an implementation can opt out. Require
hwpt_id to be zero in that case and pass a NULL parent domain to its
initialization callback. Keep the existing parent validation and
reference handling for implementations that require a HWPT.

Reject nested domain and hardware queue allocation for a vIOMMU without
a parent, and document the two allocation modes in the UAPI.

Cc: jgg@ziepe.ca
Cc: kevin.tian@intel.com
Cc: corbet@lwn.net
Cc: skhan@linuxfoundation.org
Cc: rdunlap@infradead.org
Cc: joro@8bytes.org
Cc: will@kernel.org
Cc: robin.murphy@arm.com
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 Documentation/userspace-api/iommufd.rst | 44 +++++++++----------
 drivers/iommu/iommufd/hw_pagetable.c    | 14 +++++--
 drivers/iommu/iommufd/viommu.c          | 56 +++++++++++++++----------
 include/linux/iommufd.h                 | 13 ++++--
 include/uapi/linux/iommufd.h            |  3 +-
 5 files changed, 77 insertions(+), 53 deletions(-)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index f1c4d21e5c5e..8e2fa3a524f0 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -82,11 +82,10 @@ Following IOMMUFD objects are exposed to userspace:
   * Direct assigned invalidation queues
   * Direct assigned interrupts
 
-  Such a vIOMMU object generally has the access to a nesting parent pagetable
-  to support some HW-accelerated virtualization features. So, a vIOMMU object
-  must be created given a nesting parent HWPT_PAGING object, and then it would
-  encapsulate that HWPT_PAGING object. Therefore, a vIOMMU object can be used
-  to allocate an HWPT_NESTED object in place of the encapsulated HWPT_PAGING.
+  A vIOMMU object may encapsulate a nesting parent HWPT_PAGING object to
+  support HW-accelerated virtualization features. Whether a parent is required
+  is determined by the selected vIOMMU implementation. Only a parent-backed
+  vIOMMU can be used to allocate an HWPT_NESTED object.
 
   .. note::
 
@@ -226,9 +225,9 @@ creating the objects and links::
      flag is set.
 
 4. IOMMUFD_OBJ_HWPT_NESTED can be only manually created via the IOMMU_HWPT_ALLOC
-   uAPI, provided an hwpt_id or a viommu_id of a vIOMMU object encapsulating a
-   nesting parent HWPT_PAGING via @pt_id to associate the new HWPT_NESTED object
-   to the corresponding HWPT_PAGING object. The associating HWPT_PAGING object
+   uAPI, provided an hwpt_id or a viommu_id of a parent-backed vIOMMU object
+   via @pt_id to associate the new HWPT_NESTED object to the corresponding
+   HWPT_PAGING object. The associating HWPT_PAGING object
    must be a nesting parent manually allocated via the same uAPI previously with
    an IOMMU_HWPT_ALLOC_NEST_PARENT flag, otherwise the allocation will fail. The
    allocation will be further validated by the IOMMU driver to ensure that the
@@ -245,25 +244,28 @@ creating the objects and links::
       of the object passed in via the @pt_id field of struct iommufd_hwpt_alloc.
 
 5. IOMMUFD_OBJ_VIOMMU can be only manually created via the IOMMU_VIOMMU_ALLOC
-   uAPI, provided a dev_id (for the device's physical IOMMU to back the vIOMMU)
-   and an hwpt_id (to associate the vIOMMU to a nesting parent HWPT_PAGING). The
-   iommufd core will link the vIOMMU object to the struct iommu_device that the
-   struct device is behind. And an IOMMU driver can implement a viommu_alloc op
-   to allocate its own vIOMMU data structure embedding the core-level structure
-   iommufd_viommu and some driver-specific data. If necessary, the driver can
-   also configure its HW virtualization feature for that vIOMMU (and thus for
-   the VM). Successful completion of this operation sets up the linkages between
-   the vIOMMU object and the HWPT_PAGING, then this vIOMMU object can be used
-   as a nesting parent object to allocate an HWPT_NESTED object described above.
+   uAPI, provided a dev_id identifying the device used to select the vIOMMU
+   implementation and, if the selected implementation requires a nesting
+   parent HWPT_PAGING, an hwpt_id. The hwpt_id must be zero for an
+   implementation that does not use a parent. A physical-IOMMU implementation
+   links the vIOMMU object to the struct iommu_device behind the device. Other
+   implementations, such as a TSM associated with the device, can provide their
+   own backing and device association. An implementation can allocate its own
+   vIOMMU data structure embedding the core-level structure iommufd_viommu and
+   some implementation-specific data. If necessary, it can also configure its
+   virtualization resources for that vIOMMU (and thus for the VM). A
+   parent-backed vIOMMU can be used as a nesting parent object to allocate an
+   HWPT_NESTED object described above.
 
 6. IOMMUFD_OBJ_VDEVICE can be only manually created via the IOMMU_VDEVICE_ALLOC
    uAPI, provided a viommu_id for an iommufd_viommu object and a dev_id for an
    iommufd_device object. The vDEVICE object will be the binding between these
    two parent objects. Another @virt_id will be also set via the uAPI providing
    the iommufd core an index to store the vDEVICE object to a vDEVICE array per
-   vIOMMU. If necessary, the IOMMU driver may choose to implement a vdevce_alloc
-   op to init its HW for virtualization feature related to a vDEVICE. Successful
-   completion of this operation sets up the linkages between vIOMMU and device.
+   vIOMMU. A physical-IOMMU implementation requires the device to be behind the
+   same iommu_device as the vIOMMU. Other implementations validate the device
+   association while initializing the vDEVICE. Successful initialization sets
+   up the linkage between the vIOMMU and device.
 
 A device can only bind to an iommufd due to DMA ownership claim and attach to at
 most one IOAS object (no support of PASID yet).
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index ef6e119c2a75..bd562bc2db48 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -306,6 +306,10 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 		return ERR_PTR(-EOPNOTSUPP);
 	if (!user_data->len)
 		return ERR_PTR(-EOPNOTSUPP);
+	if (!viommu->hwpt)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (!viommu->iommu_dev)
+		return ERR_PTR(-EOPNOTSUPP);
 	if (!viommu->ops || !viommu->ops->alloc_domain_nested)
 		return ERR_PTR(-EOPNOTSUPP);
 
@@ -404,10 +408,12 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		struct iommufd_viommu *viommu;
 
 		viommu = container_of(pt_obj, struct iommufd_viommu, obj);
-		iommu_dev = iommufd_device_get_iommu_dev(idev);
-		if (!iommu_dev || viommu->iommu_dev != iommu_dev) {
-			rc = -EINVAL;
-			goto out_unlock;
+		if (viommu->iommu_dev) {
+			iommu_dev = iommufd_device_get_iommu_dev(idev);
+			if (!iommu_dev || viommu->iommu_dev != iommu_dev) {
+				rc = -EINVAL;
+				goto out_unlock;
+			}
 		}
 		hwpt_nested = iommufd_viommu_alloc_hwpt_nested(
 			viommu, cmd->flags, &user_data);
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 8628161b37c6..9155d0dcb4b4 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -16,7 +16,8 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 		viommu->ops->destroy(viommu);
 	if (viommu->tsm_dev)
 		tsm_put_device(viommu->tsm_dev);
-	refcount_dec(&viommu->hwpt->common.obj.users);
+	if (viommu->hwpt)
+		refcount_dec(&viommu->hwpt->common.obj.users);
 	if (viommu->kvm_file)
 		fput(viommu->kvm_file);
 	xa_destroy(&viommu->vdevs);
@@ -30,11 +31,11 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		.uptr = u64_to_user_ptr(cmd->data_uptr),
 		.len = cmd->data_len,
 	};
-	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_hwpt_paging *hwpt_paging = NULL;
 	struct tsm_dev *tsm_dev = NULL;
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
-	struct iommu_device *iommu_dev;
+	struct iommu_device *iommu_dev = NULL;
 	const struct iommufd_viommu_ops *ops;
 	size_t viommu_size;
 	int rc;
@@ -46,11 +47,6 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 
-	iommu_dev = iommufd_device_get_iommu_dev(idev);
-	if (!iommu_dev) {
-		rc = -EOPNOTSUPP;
-		goto out_put_idev;
-	}
 	tsm_dev = tsm_get_device(idev->dev);
 	if (IS_ERR(tsm_dev)) {
 		rc = PTR_ERR(tsm_dev);
@@ -67,6 +63,11 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 			tsm_put_device(tsm_dev);
 			tsm_dev = NULL;
 		}
+		iommu_dev = iommufd_device_get_iommu_dev(idev);
+		if (!iommu_dev) {
+			rc = -EOPNOTSUPP;
+			goto out_put_idev;
+		}
 		if (!iommu_dev->ops->get_viommu_ops) {
 			rc = -EOPNOTSUPP;
 			goto out_put_idev;
@@ -92,15 +93,20 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
-	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
-	if (IS_ERR(hwpt_paging)) {
-		rc = PTR_ERR(hwpt_paging);
+	if ((ops->flags & IOMMUFD_VIOMMU_NO_HWPT) && cmd->hwpt_id) {
+		rc = -EINVAL;
 		goto out_put_idev;
 	}
-
-	if (!hwpt_paging->nest_parent) {
-		rc = -EINVAL;
-		goto out_put_hwpt;
+	if (!(ops->flags & IOMMUFD_VIOMMU_NO_HWPT)) {
+		hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
+		if (IS_ERR(hwpt_paging)) {
+			rc = PTR_ERR(hwpt_paging);
+			goto out_put_idev;
+		}
+		if (!hwpt_paging->nest_parent) {
+			rc = -EINVAL;
+			goto out_put_hwpt;
+		}
 	}
 
 	viommu = (struct iommufd_viommu *)_iommufd_object_alloc_ucmd(
@@ -118,7 +124,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	viommu->tsm_dev = tsm_dev;
 	tsm_dev = NULL;
 	viommu->hwpt = hwpt_paging;
-	refcount_inc(&viommu->hwpt->common.obj.users);
+	if (viommu->hwpt)
+		refcount_inc(&viommu->hwpt->common.obj.users);
 	INIT_LIST_HEAD(&viommu->veventqs);
 	init_rwsem(&viommu->veventqs_rwsem);
 	/*
@@ -129,7 +136,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	viommu->iommu_dev = iommu_dev;
 
 	rc = ops->viommu_init(viommu, idev->dev,
-			      hwpt_paging->common.domain,
+			      hwpt_paging ? hwpt_paging->common.domain : NULL,
 			      user_data.len ? &user_data : NULL);
 	if (rc)
 		goto out_put_hwpt;
@@ -139,7 +146,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
 out_put_hwpt:
-	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
+	if (hwpt_paging)
+		iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
 out_put_idev:
 	if (tsm_dev)
 		tsm_put_device(tsm_dev);
@@ -202,10 +210,12 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_viommu;
 	}
 
-	iommu_dev = iommufd_device_get_iommu_dev(idev);
-	if (!iommu_dev || viommu->iommu_dev != iommu_dev) {
-		rc = -EINVAL;
-		goto out_put_idev;
+	if (viommu->iommu_dev) {
+		iommu_dev = iommufd_device_get_iommu_dev(idev);
+		if (!iommu_dev || viommu->iommu_dev != iommu_dev) {
+			rc = -EINVAL;
+			goto out_put_idev;
+		}
 	}
 
 	mutex_lock(&idev->igroup->lock);
@@ -425,7 +435,7 @@ int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	if (IS_ERR(viommu))
 		return PTR_ERR(viommu);
 
-	if (!viommu->ops || !viommu->ops->get_hw_queue_size ||
+	if (!viommu->hwpt || !viommu->ops || !viommu->ops->get_hw_queue_size ||
 	    !viommu->ops->hw_queue_init_phys) {
 		rc = -EOPNOTSUPP;
 		goto out_put_viommu;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index fd4567940243..2e67846d6f35 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -6,6 +6,7 @@
 #ifndef __LINUX_IOMMUFD_H
 #define __LINUX_IOMMUFD_H
 
+#include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/iommu.h>
@@ -103,6 +104,7 @@ void iommufd_ctx_get(struct iommufd_ctx *ictx);
 struct iommufd_viommu {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
+	/* Physical IOMMU backing, or NULL. */
 	struct iommu_device *iommu_dev;
 	struct iommufd_hwpt_paging *hwpt;
 	struct file *kvm_file;
@@ -150,17 +152,19 @@ struct iommufd_hw_queue {
 	void (*destroy)(struct iommufd_hw_queue *hw_queue);
 };
 
+#define IOMMUFD_VIOMMU_NO_HWPT	BIT(0)
+
 /**
  * struct iommufd_viommu_ops - vIOMMU specific operations
+ * @flags: Properties needed by the core before vIOMMU initialization
  * @get_viommu_size: Get the size of a driver-level vIOMMU structure for a given
  *                   @dev corresponding to @viommu_type. Driver should return 0
  *                   if vIOMMU isn't supported accordingly. It is required for
  *                   driver to use the VIOMMU_STRUCT_SIZE macro to sanitize the
  *                   driver-level vIOMMU structure related to the core one
- * @viommu_init: Init the driver-level struct of an iommufd_viommu on a physical
- *               IOMMU instance @viommu->iommu_dev, as the set of virtualization
- *               resources shared/passed to user space IOMMU instance. Associate
- *               it with a nesting @parent_domain.
+ * @viommu_init: Initialize the selected driver-level iommufd_viommu for @dev.
+ *               @parent_domain is the nesting parent, or NULL for an
+ *               implementation that does not use a parent HWPT.
  * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
  *           of the vIOMMU will be free-ed by iommufd core after calling this op
  * @alloc_domain_nested: Allocate a IOMMU_DOMAIN_NESTED on a vIOMMU that holds a
@@ -202,6 +206,7 @@ struct iommufd_hw_queue {
  *                      does, it should set it to the @hw_queue->destroy pointer
  */
 struct iommufd_viommu_ops {
+	unsigned long flags;
 	size_t (*get_viommu_size)(struct device *dev,
 		enum iommu_viommu_type type);
 	int (*viommu_init)(struct iommufd_viommu *viommu, struct device *dev,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 9920138f9eda..3d1ebbdf3948 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1130,7 +1130,8 @@ struct iommu_viommu_tegra241_cmdqv {
  * @flags: Must be 0
  * @type: Type of the virtual IOMMU. Must be defined in enum iommu_viommu_type
  * @dev_id: The device's physical IOMMU will be used to back the virtual IOMMU
- * @hwpt_id: ID of a nesting parent HWPT to associate to
+ * @hwpt_id: ID of a nesting parent HWPT to associate to. Must be zero when the
+ *           selected vIOMMU implementation does not use a parent HWPT
  * @out_viommu_id: Output virtual IOMMU ID for the allocated object
  * @data_len: Length of the type specific data
  * @__reserved: Must be 0
-- 
2.43.0

