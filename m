Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB42E737E;
	Thu,  8 Oct 2026 06:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439254; cv=none; b=kPvPqLchvsNVZqYtovlAsfNVp35jExCsLTVsnvQj2nme0PJYnNMEByr4ZWYZyiZKBZ9RJiW2++CMOzRPC18DuoJUBluRe7t6ITp31HMwZrFq23Ap6gsCL7uvA9T5DLDgEu68XSRENRdds6JuvvWDsR7gA2jsi7XPGs1O/jy/dXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439254; c=relaxed/simple;
	bh=+kZP75pP5aKHYzQT6ek1biYG+BzUwSKZAcZB1VVdg74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgE/unXBcI2LAk0TZ+TA2bOBQUtoBvICW/jVl2AJN8vSWagrsUAaWbqRC5FEWdmcXW8Pf55UXdvoJ3aE6ShSZievFfy3uWN08WWiNp5p4qpz+TuMMbbp3MHWvjcjYmEoYrJUj36x7LqKb8dt6bSapcxAwwRgGLV3qlv1mLZAPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShVzoEbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShVzoEbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36291F00898;
	Thu,  8 Oct 2026 06:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439252;
	bh=bXFX2VfWYqcAw7gAEwoWXkIvvvg46FvV3WHRcHVmSbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ShVzoEbvG4vjBhY7Qw6frRfU9CazTar/izRz8otisEui4JBH6Jlx8YZxFBlzr++SJ
	 DVn3g1Nk9x3N2Nx4PeBwvcdqbtqGAHUFW8rsPPkcbNUJdfXPNDpQ9tx+eBv1zahb2w
	 nZCZHPh4Bcb1wlip3DjlFUHXVEoOzmrEQIeKcnvlcPtKExOD4FazmoCHsxjaRDluES
	 FJ7CyBWSMTVJdFRtIPBjEzDhxjwkn3gQpH37cFrfgmtPPh/mSwk8ramehRz5P6W9ve
	 myO0FUkJY6BYqR1HTLPtR+mS9zPV0S8leMNKGCq64sxMTIdoaPtSBvVDKdAMIWyGjC
	 9dOtzQidygFKw==
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
	Steffen Eiden <seiden@linux.ibm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sean Christopherson <seanjc@google.com>,
	Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v7 04/16] KVM/vfio: Use file-based reference counting for KVM
Date: Thu,  8 Oct 2026 11:29:43 +0530
Message-ID: <20261008055955.4014342-5-aneesh.kumar@kernel.org>
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

From: Steffen Eiden <seiden@linux.ibm.com>

Replace manual module reference counting with file-based reference
counting for KVM integration. Previously, VFIO used symbol_get() to
obtain function pointers for kvm_get_kvm_safe() and kvm_put_kvm(),
then manually tracked module references through these symbols. This
approach required storing the put_kvm function pointer in each device
and carefully managing symbol references.

Pass struct file pointers instead of struct kvm pointers throughout the
VFIO-KVM interface, leveraging the kernel's existing file reference
counting via get_file()/get_file_active() and fput(). Convert the x86
page-track API and update s390 vfio to use file_to_kvm_<arch>(). This
simplifies the code.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_s390.h |  2 +-
 arch/s390/kvm/s390/pci.c              |  9 ++++-
 arch/x86/include/asm/kvm_page_track.h | 10 +++--
 arch/x86/kvm/mmu/page_track.c         | 22 +++++++----
 drivers/s390/crypto/vfio_ap_ops.c     | 20 +++++++---
 drivers/vfio/group.c                  | 11 +++++-
 drivers/vfio/vfio.h                   | 12 +++---
 drivers/vfio/vfio_main.c              | 57 +++++++++------------------
 include/linux/vfio.h                  |  5 +--
 virt/kvm/vfio.c                       | 13 ++++--
 10 files changed, 87 insertions(+), 74 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index 8a7eed5847e1..9519b8028b10 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -722,7 +722,7 @@ static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
 void kvm_arch_free_vm(struct kvm *kvm);
 
 struct zpci_kvm_hook {
-	int (*kvm_register)(void *opaque, struct kvm *kvm);
+	int (*kvm_register)(void *opaque, struct file *kvm_file);
 	void (*kvm_unregister)(void *opaque);
 };
 
diff --git a/arch/s390/kvm/s390/pci.c b/arch/s390/kvm/s390/pci.c
index 82892e1e03d9..d79bd3bdc68e 100644
--- a/arch/s390/kvm/s390/pci.c
+++ b/arch/s390/kvm/s390/pci.c
@@ -498,17 +498,22 @@ static void kvm_s390_pci_dev_release(struct zpci_dev *zdev)
  * available, enable them and let userspace indicate whether or not they will
  * be used (specify SHM bit to disable).
  */
-static int kvm_s390_pci_register_kvm(void *opaque, struct kvm *kvm)
+static int kvm_s390_pci_register_kvm(void *opaque, struct file *kvm_file)
 {
 	struct zpci_dev *zdev = opaque;
+	struct kvm *kvm;
 	int rc;
 
 	if (!zdev)
 		return -EINVAL;
 
+	kvm = file_to_kvm_s390(kvm_file);
+	if (!kvm)
+		return -ENOENT;
+
 	mutex_lock(&zdev->kzdev_lock);
 
-	if (zdev->kzdev || zdev->gisa != 0 || !kvm) {
+	if (zdev->kzdev || zdev->gisa != 0) {
 		mutex_unlock(&zdev->kzdev_lock);
 		return -EINVAL;
 	}
diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm/kvm_page_track.h
index 3d040741044b..ea885dd5c9af 100644
--- a/arch/x86/include/asm/kvm_page_track.h
+++ b/arch/x86/include/asm/kvm_page_track.h
@@ -44,13 +44,15 @@ struct kvm_page_track_notifier_node {
 				    struct kvm_page_track_notifier_node *node);
 };
 
-int kvm_page_track_register_notifier(struct kvm *kvm,
+struct file;
+
+int kvm_page_track_register_notifier(struct file *file,
 				     struct kvm_page_track_notifier_node *n);
-void kvm_page_track_unregister_notifier(struct kvm *kvm,
+void kvm_page_track_unregister_notifier(struct file *file,
 					struct kvm_page_track_notifier_node *n);
 
-int kvm_write_track_add_gfn(struct kvm *kvm, gfn_t gfn);
-int kvm_write_track_remove_gfn(struct kvm *kvm, gfn_t gfn);
+int kvm_write_track_add_gfn(struct file *file, gfn_t gfn);
+int kvm_write_track_remove_gfn(struct file *file, gfn_t gfn);
 #else
 /*
  * Allow defining a node in a structure even if page tracking is disabled, e.g.
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 7e8195a311bb..f12558dfcd81 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -16,6 +16,8 @@
 #include <linux/kvm_host.h>
 #include <linux/rculist.h>
 
+#include <asm/kvm_page_track.h>
+
 #include "mmu.h"
 #include "mmu_internal.h"
 #include "page_track.h"
@@ -237,10 +239,11 @@ static int kvm_enable_external_write_tracking(struct kvm *kvm)
  * register the notifier so that event interception for the tracked guest
  * pages can be received.
  */
-int kvm_page_track_register_notifier(struct kvm *kvm,
+int kvm_page_track_register_notifier(struct file *file,
 				     struct kvm_page_track_notifier_node *n)
 {
 	struct kvm_page_track_notifier_head *head;
+	struct kvm *kvm = file_to_kvm_x86(file);
 	int r;
 
 	if (!kvm || kvm->mm != current->mm)
@@ -252,7 +255,7 @@ int kvm_page_track_register_notifier(struct kvm *kvm,
 			return r;
 	}
 
-	kvm_get_kvm(kvm);
+	get_file(file);
 
 	head = &kvm->arch.track_notifier_head;
 
@@ -267,10 +270,11 @@ EXPORT_SYMBOL_GPL(kvm_page_track_register_notifier);
  * stop receiving the event interception. It is the opposed operation of
  * kvm_page_track_register_notifier().
  */
-void kvm_page_track_unregister_notifier(struct kvm *kvm,
+void kvm_page_track_unregister_notifier(struct file *file,
 					struct kvm_page_track_notifier_node *n)
 {
 	struct kvm_page_track_notifier_head *head;
+	struct kvm *kvm = file_to_kvm_x86(file);
 
 	head = &kvm->arch.track_notifier_head;
 
@@ -279,7 +283,7 @@ void kvm_page_track_unregister_notifier(struct kvm *kvm,
 	write_unlock(&kvm->mmu_lock);
 	synchronize_srcu(&head->track_srcu);
 
-	kvm_put_kvm(kvm);
+	fput(file);
 }
 EXPORT_SYMBOL_GPL(kvm_page_track_unregister_notifier);
 
@@ -336,11 +340,12 @@ void kvm_page_track_delete_slot(struct kvm *kvm, struct kvm_memory_slot *slot)
  * add guest page to the tracking pool so that corresponding access on that
  * page will be intercepted.
  *
- * @kvm: the guest instance we are interested in.
+ * @file: the VM file of the guest instance we are interested in.
  * @gfn: the guest page.
  */
-int kvm_write_track_add_gfn(struct kvm *kvm, gfn_t gfn)
+int kvm_write_track_add_gfn(struct file *file, gfn_t gfn)
 {
+	struct kvm *kvm = file_to_kvm_x86(file);
 	struct kvm_memory_slot *slot;
 	int idx;
 
@@ -366,11 +371,12 @@ EXPORT_SYMBOL_GPL(kvm_write_track_add_gfn);
  * remove the guest page from the tracking pool which stops the interception
  * of corresponding access on that page.
  *
- * @kvm: the guest instance we are interested in.
+ * @file: the VM file of the guest instance we are interested in.
  * @gfn: the guest page.
  */
-int kvm_write_track_remove_gfn(struct kvm *kvm, gfn_t gfn)
+int kvm_write_track_remove_gfn(struct file *file, gfn_t gfn)
 {
+	struct kvm *kvm = file_to_kvm_x86(file);
 	struct kvm_memory_slot *slot;
 	int idx;
 
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 4db878c18f41..373ce574c431 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1822,17 +1822,27 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
 
 /**
  * vfio_ap_mdev_set_kvm - sets all data for @matrix_mdev that are needed
- * to manage AP resources for the guest whose state is represented by @kvm
+ * to manage AP resources for the guest whose state is represented by
+ * @kvm_file
  *
  * @matrix_mdev: a mediated matrix device
- * @kvm: reference to KVM instance
+ * @kvm_file: the KVM VM file this vfio device is associated with
  *
- * Return: 0 if no other mediated matrix device has a reference to @kvm;
+ * Return: 0 if no other mediated matrix device has a reference to the VM;
  * otherwise, returns an -EPERM.
  */
 static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
-				struct kvm *kvm)
+				struct file *kvm_file)
 {
+	struct kvm *kvm;
+
+	if (!kvm_file)
+		return -ENOENT;
+
+	kvm = file_to_kvm_s390(kvm_file);
+	if (!kvm)
+		return -ENOENT;
+
 	if (kvm->arch.crypto.crycbd) {
 		get_update_locks_for_kvm(kvm);
 		if (kvm->arch.crypto.pqap_hook) {
@@ -1841,7 +1851,6 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 		}
 		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
 
-		kvm_get_kvm(kvm);
 		matrix_mdev->kvm = kvm;
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 		release_update_locks_for_kvm(kvm);
@@ -1894,7 +1903,6 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 		matrix_mdev->kvm = NULL;
 
 		release_update_locks_for_kvm(kvm);
-		kvm_put_kvm(kvm);
 	}
 }
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index b2299e5bc6df..5bf8cbdff377 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -860,11 +860,20 @@ bool vfio_group_enforced_coherent(struct vfio_group *group)
 	return ret;
 }
 
-void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
+void vfio_group_set_kvm(struct vfio_group *group, struct file *kvm)
 {
+	struct file *old;
+
+	if (kvm)
+		get_file(kvm);
+
 	spin_lock(&group->kvm_ref_lock);
+	old = group->kvm;
 	group->kvm = kvm;
 	spin_unlock(&group->kvm_ref_lock);
+
+	if (old)
+		fput(old);
 }
 
 /**
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 7728bc99b63d..9b619951a5d0 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -23,7 +23,7 @@ struct vfio_device_file {
 	u8 access_granted;
 	u32 devid; /* only valid when iommufd is valid */
 	spinlock_t kvm_ref_lock; /* protect kvm field */
-	struct kvm *kvm;
+	struct file *kvm;
 	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
 };
 
@@ -88,7 +88,7 @@ struct vfio_group {
 #endif
 	enum vfio_group_type		type;
 	struct mutex			group_lock;
-	struct kvm			*kvm;
+	struct file			*kvm;
 	struct file			*opened_file;
 	struct iommufd_ctx		*iommufd;
 	spinlock_t			kvm_ref_lock;
@@ -107,7 +107,7 @@ void vfio_device_group_unuse_iommu(struct vfio_device *device);
 void vfio_df_group_close(struct vfio_device_file *df);
 struct vfio_group *vfio_group_from_file(struct file *file);
 bool vfio_group_enforced_coherent(struct vfio_group *group);
-void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm);
+void vfio_group_set_kvm(struct vfio_group *group, struct file *kvm);
 bool vfio_device_has_container(struct vfio_device *device);
 int __init vfio_group_init(void);
 void vfio_group_cleanup(void);
@@ -165,7 +165,7 @@ static inline bool vfio_group_enforced_coherent(struct vfio_group *group)
 	return true;
 }
 
-static inline void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
+static inline void vfio_group_set_kvm(struct vfio_group *group, struct file *kvm)
 {
 }
 
@@ -429,11 +429,11 @@ static inline void vfio_virqfd_exit(void)
 #endif
 
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm);
+void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *kvm);
 void vfio_device_put_kvm(struct vfio_device *device);
 #else
 static inline void vfio_device_get_kvm_safe(struct vfio_device *device,
-					    struct kvm *kvm)
+					    struct file *kvm)
 {
 }
 
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 423ead48aafe..ed96acfa8635 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -472,36 +472,14 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
+void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *kvm)
 {
-	void (*pfn)(struct kvm *kvm);
-	bool (*fn)(struct kvm *kvm);
-	bool ret;
-
 	lockdep_assert_held(&device->dev_set->lock);
 
 	if (!kvm)
 		return;
 
-	pfn = symbol_get(kvm_put_kvm);
-	if (WARN_ON(!pfn))
-		return;
-
-	fn = symbol_get(kvm_get_kvm_safe);
-	if (WARN_ON(!fn)) {
-		symbol_put(kvm_put_kvm);
-		return;
-	}
-
-	ret = fn(kvm);
-	symbol_put(kvm_get_kvm_safe);
-	if (!ret) {
-		symbol_put(kvm_put_kvm);
-		return;
-	}
-
-	device->put_kvm = pfn;
-	device->kvm = kvm;
+	device->kvm = get_file(kvm);
 }
 
 void vfio_device_put_kvm(struct vfio_device *device)
@@ -511,14 +489,7 @@ void vfio_device_put_kvm(struct vfio_device *device)
 	if (!device->kvm)
 		return;
 
-	if (WARN_ON(!device->put_kvm))
-		goto clear;
-
-	device->put_kvm(device->kvm);
-	device->put_kvm = NULL;
-	symbol_put(kvm_put_kvm);
-
-clear:
+	fput(device->kvm);
 	device->kvm = NULL;
 }
 #endif
@@ -1544,9 +1515,13 @@ bool vfio_file_enforced_coherent(struct file *file)
 }
 EXPORT_SYMBOL_GPL(vfio_file_enforced_coherent);
 
-static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
+static void vfio_device_file_set_kvm(struct file *file, struct file *kvm)
 {
 	struct vfio_device_file *df = file->private_data;
+	struct file *old;
+
+	if (kvm)
+		get_file(kvm);
 
 	/*
 	 * The kvm is first recorded in the vfio_device_file, and will
@@ -1554,28 +1529,32 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
 	 * iommufd successfully in the vfio device cdev path.
 	 */
 	spin_lock(&df->kvm_ref_lock);
+	old = df->kvm;
 	df->kvm = kvm;
 	spin_unlock(&df->kvm_ref_lock);
+
+	if (old)
+		fput(old);
 }
 
 /**
  * vfio_file_set_kvm - Link a kvm with VFIO drivers
- * @file: VFIO group file or VFIO device file
- * @kvm: KVM to link
+ * @vfio_file: VFIO group file or VFIO device file
+ * @kvm: KVM file to link
  *
  * When a VFIO device is first opened the KVM will be available in
  * device->kvm if one was associated with the file.
  */
-void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
+void vfio_file_set_kvm(struct file *vfio_file, struct file *kvm)
 {
 	struct vfio_group *group;
 
-	group = vfio_group_from_file(file);
+	group = vfio_group_from_file(vfio_file);
 	if (group)
 		vfio_group_set_kvm(group, kvm);
 
-	if (vfio_device_from_file(file))
-		vfio_device_file_set_kvm(file, kvm);
+	if (vfio_device_from_file(vfio_file))
+		vfio_device_file_set_kvm(vfio_file, kvm);
 }
 EXPORT_SYMBOL_GPL(vfio_file_set_kvm);
 
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 45f08986359e..0cc91c6f96d2 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -54,7 +54,7 @@ struct vfio_device {
 	struct list_head dev_set_list;
 	unsigned int migration_flags;
 	u8 precopy_info_v2;
-	struct kvm *kvm;
+	struct file *kvm;
 
 	/* Members below here are private, not for driver use */
 	unsigned int index;
@@ -66,7 +66,6 @@ struct vfio_device {
 	unsigned int open_count;
 	struct completion comp;
 	struct iommufd_access *iommufd_access;
-	void (*put_kvm)(struct kvm *kvm);
 	struct inode *inode;
 #if IS_ENABLED(CONFIG_IOMMUFD)
 	struct iommufd_device *iommufd_device;
@@ -378,7 +377,7 @@ static inline bool vfio_file_has_dev(struct file *file, struct vfio_device *devi
 #endif
 bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
-void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
+void vfio_file_set_kvm(struct file *vfio_file, struct file *kvm);
 
 #define VFIO_PIN_PAGES_MAX_ENTRIES	(PAGE_SIZE/sizeof(unsigned long))
 
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 6cdc4e9a333a..19548a430942 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -35,15 +35,15 @@ struct kvm_vfio {
 	bool noncoherent;
 };
 
-static void kvm_vfio_file_set_kvm(struct file *file, struct kvm *kvm)
+static void kvm_vfio_file_set_kvm(struct file *vfio_file, struct file *kvm)
 {
-	void (*fn)(struct file *file, struct kvm *kvm);
+	void (*fn)(struct file *vfio_file, struct file *kvm);
 
 	fn = symbol_get(vfio_file_set_kvm);
 	if (!fn)
 		return;
 
-	fn(file, kvm);
+	fn(vfio_file, kvm);
 
 	symbol_put(vfio_file_set_kvm);
 }
@@ -144,6 +144,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 {
 	struct kvm_vfio *kv = dev->private;
 	struct kvm_vfio_file *kvf;
+	struct file *kvm_file __free(fput) = NULL;
 	struct file *filp __free(fput) = NULL;
 
 	filp = fget(fd);
@@ -154,6 +155,10 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 	if (!kvm_vfio_file_is_valid(filp))
 		return -EINVAL;
 
+	kvm_file = get_file_active(&dev->kvm->file);
+	if (!kvm_file)
+		return -ENOENT;
+
 	guard(mutex)(&kv->lock);
 
 	list_for_each_entry(kvf, &kv->file_list, node) {
@@ -168,7 +173,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 	kvf->file = get_file(filp);
 	list_add_tail(&kvf->node, &kv->file_list);
 
-	kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
+	kvm_vfio_file_set_kvm(kvf->file, kvm_file);
 	kvm_vfio_update_coherency(dev);
 
 	return 0;
-- 
2.43.0

