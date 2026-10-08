Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC9B3BE63F;
	Thu,  8 Oct 2026 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439325; cv=none; b=Lm7N+OzCCgY001mpqgu+JDmFBhRiNS1HpYezERiCqFdugA7gyC1da9r2rXMNQIARKiACNZLLkKZUky0rLaxvpguUT1I4ALlqZUTDAh+9BjLrZGikQNJAT0oAebLyAMZHHO2YNrYv7CwjqLo+Tq+8XIL6dIoficDtsalkK3PcY6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439325; c=relaxed/simple;
	bh=OUS3UywyPpjgGs/kNSiny5x01sF0DMQMRLkTgiatkNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJzLZ6Di6KOCioYjqg2T2XB2eRQAQ1yxKdE2FK7ZRBwk0r8eOoQYFn/V5zAbCx371dgievw80DOdy9qD+UvUa+EzsfS0FdpHPl6/6RZRSrZPTqqDE9PxqSPEi9hWOsGHN+7SLNwiR3BBNA4EyImn+6gSyMjCh2sUZ6eDTh5Bcnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1rzkyvI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1rzkyvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44621F000FF;
	Thu,  8 Oct 2026 06:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439323;
	bh=BEZXzD40atJnUUyOSSWKFJUeiwyFaWoa9ynSCzhiTzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W1rzkyvIB3rxwpXvNs1Z+Mdli0Wx4HJKCO+yHBjWr478U9l76n6K/M+SLUMBX1Yxh
	 xqEI0dvzWymDyCFn00VEz1r7lwkflR4CdKnqELgw5XSC2SA/t73VTYe+/SElbEa5Qj
	 cCgrIJ7ISG3hJJ4xk6upA3p22Ol3gayWDw/ofloO3qVDJ7eiQr3A4G/5P+xU6Z5L6t
	 SfJDiIvneKbDQsJsv97osh9o1A6eVcJ1dXDuvjKUxGN7VzTPsedyy9kqRg5RolyJ73
	 Q4YkK4n5CkY/Avfj62DKtmqEFm02AO9TTLGpXfjDjoVd7UZwBzcIcCFn61p8M8gUMz
	 U/8WcSBmTMM8Q==
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
Subject: [PATCH v7 12/16] PCI/TSM: Add vIOMMU-bound contexts for vdevices
Date: Thu,  8 Oct 2026 11:29:51 +0530
Message-ID: <20261008055955.4014342-13-aneesh.kumar@kernel.org>
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

An IOMMUFD vdevice must use the same TEE Security Manager as its vIOMMU.
Pinning the vIOMMU backend keeps its tsm_dev registered, but does not
preserve the connection between the PF0 PCI device and that TSM.

Add a per-vdevice PCI TSM context. Verify that the PCI device and the
vIOMMU use the same tsm_dev, and account active contexts on PF0. Reject
disconnect with -EBUSY until all dependent vdevices release their
contexts.

With vdevice binding handled by the backend, PCI/TSM no longer has
generic bind state to report. Remove the legacy bind and unbind
interface. The sysfs "bound" attribute reported the state maintained by
that interface. Remove the attribute and its ABI documentation as well.

Cc: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-pci |  17 +-
 drivers/pci/tsm.c                       | 230 ++++++++++--------------
 include/linux/pci-tsm.h                 |  71 +++++---
 3 files changed, 137 insertions(+), 181 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 55ea1db749a1..4c64b30544cd 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -654,6 +654,9 @@ Contact:	linux-coco@lists.linux.dev
 Description:
 		(WO) Write the name of the TSM device that was specified
 		to 'connect' to teardown the connection.
+		The write fails with EBUSY while any vdevice depends on the
+		connection. Userspace must destroy those vdevices before
+		disconnecting the link.
 
 What:		/sys/bus/pci/devices/.../tsm/dsm
 Contact:	linux-coco@lists.linux.dev
@@ -671,20 +674,6 @@ Description:	(RO) Return PCI device name of this device's DSM (Device
 		PCIe switch port. This is a "link" TSM attribute, see
 		Documentation/ABI/testing/sysfs-class-tsm.
 
-What:		/sys/bus/pci/devices/.../tsm/bound
-Contact:	linux-coco@lists.linux.dev
-Description:	(RO) Return the device name of the TSM when the device is in a
-		TDISP (TEE Device Interface Security Protocol) operational state
-		(LOCKED, RUN, or ERROR, not UNLOCKED). Bound devices consume
-		platform TSM resources and depend on the device's configuration
-		(e.g. BME (Bus Master Enable) and MSE (Memory Space Enable)
-		among other settings) to remain stable for the duration of the
-		bound state. This attribute is only visible for devices that
-		support TDISP operation, and it is only populated after
-		successful connect and TSM bind. The TSM bind operation is
-		initiated by VFIO/IOMMUFD. This is a "link" TSM attribute, see
-		Documentation/ABI/testing/sysfs-class-tsm.
-
 What:		/sys/bus/pci/devices/.../authenticated
 Contact:	linux-pci@vger.kernel.org
 Description:
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 1423c64dc9c8..dca9634f8d5e 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/pci-tsm.h>
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/tsm.h>
 #include <linux/xarray.h>
@@ -292,96 +293,94 @@ static int remove_fn(struct pci_dev *pdev, void *data)
 	return 0;
 }
 
-/*
- * Note, this helper only returns an error code and takes an argument for
- * compatibility with the pci_walk_bus() callback prototype. pci_tsm_unbind()
- * always succeeds.
- */
-static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
+bool pci_tsm_is_configured(struct pci_dev *pdev)
 {
-	struct pci_tdi *tdi;
-	struct pci_tsm_pf0 *tsm_pf0;
-
-	lockdep_assert_held(&pci_tsm_rwsem);
-
-	if (!pdev->tsm)
-		return 0;
-
-	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
-	guard(mutex)(&tsm_pf0->lock);
-
-	tdi = pdev->tsm->tdi;
-	if (!tdi)
-		return 0;
-
-	to_pci_tsm_ops(pdev->tsm)->unbind(tdi);
-	pdev->tsm->tdi = NULL;
+	guard(rwsem_read)(&pci_tsm_rwsem);
 
-	return 0;
+	return !!pdev->tsm;
 }
+EXPORT_SYMBOL_GPL(pci_tsm_is_configured);
 
-void pci_tsm_unbind(struct pci_dev *pdev)
-{
-	guard(rwsem_read)(&pci_tsm_rwsem);
-	__pci_tsm_unbind(pdev, NULL);
-}
-EXPORT_SYMBOL_GPL(pci_tsm_unbind);
+struct pci_tsm_context {
+	struct pci_tsm_pf0 *pf0;
+	struct pci_dev *pdev;
+	struct pci_dev *dsm_dev;
+};
 
-/**
- * pci_tsm_bind() - Bind @pdev as a TDI for @kvm
- * @pdev: PCI device function to bind
- * @kvm: Private memory attach context
- * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
- *
- * Returns 0 on success, or a negative error code on failure.
- *
- * Context: Caller is responsible for constraining the bind lifetime to the
- * registered state of the device. For example, pci_tsm_bind() /
- * pci_tsm_unbind() limited to the VFIO driver bound state of the device.
- */
-int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
+struct pci_tsm_context *pci_tsm_context_get(struct pci_dev *pdev,
+					    struct tsm_dev *viommu_tsm_dev)
 {
-	struct pci_tsm_pf0 *tsm_pf0;
-	struct pci_tdi *tdi;
-
-	if (!kvm)
-		return -EINVAL;
+	struct pci_tsm_context *context;
+	struct pci_tsm_pf0 *pf0;
 
 	guard(rwsem_read)(&pci_tsm_rwsem);
+	if (!pdev->tsm || !is_link_tsm(pdev->tsm->tsm_dev))
+		return ERR_PTR(-EOPNOTSUPP);
+	/*
+	 * The vdevice can use a different PCI function from VIOMMU_ALLOC. The
+	 * module pin keeps the vIOMMU's TSM registered, but does not freeze this
+	 * function's link. Match its current TSM before pinning the link below.
+	 */
+	if (pdev->tsm->tsm_dev != viommu_tsm_dev)
+		return ERR_PTR(-EXDEV);
 
-	if (!pdev->tsm)
-		return -EINVAL;
+	pf0 = to_pci_tsm_pf0(pdev->tsm);
+	if (!pf0)
+		return ERR_PTR(-ENXIO);
 
-	if (!is_link_tsm(pdev->tsm->tsm_dev))
-		return -ENXIO;
+	context = kzalloc_obj(*context);
+	if (!context)
+		return ERR_PTR(-ENOMEM);
 
-	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
-	guard(mutex)(&tsm_pf0->lock);
+	guard(mutex)(&pf0->lock);
+	pf0->context_users++;
+	context->pf0 = pf0;
+	context->pdev = pci_dev_get(pdev);
+	context->dsm_dev = pci_dev_get(pf0->base_tsm.pdev);
+	return context;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_context_get);
 
-	/* Resolve races to bind a TDI */
-	if (pdev->tsm->tdi) {
-		if (pdev->tsm->tdi->kvm != kvm)
-			return -EBUSY;
-		return 0;
-	}
+void pci_tsm_context_put(struct pci_tsm_context *context)
+{
+	struct pci_tsm_pf0 *pf0 = context->pf0;
 
-	tdi = to_pci_tsm_ops(pdev->tsm)->bind(pdev, kvm, tdi_id);
-	if (IS_ERR(tdi))
-		return PTR_ERR(tdi);
+	down_read(&pci_tsm_rwsem);
+	mutex_lock(&pf0->lock);
+	if (!WARN_ON(!pf0->context_users))
+		pf0->context_users--;
+	mutex_unlock(&pf0->lock);
+	up_read(&pci_tsm_rwsem);
 
-	pdev->tsm->tdi = tdi;
+	pci_dev_put(context->pdev);
+	pci_dev_put(context->dsm_dev);
+	kfree(context);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_context_put);
 
-	return 0;
+struct pci_tsm_pf0 *pci_tsm_context_pf0(struct pci_tsm_context *context)
+{
+	return context->pf0;
 }
-EXPORT_SYMBOL_GPL(pci_tsm_bind);
+EXPORT_SYMBOL_GPL(pci_tsm_context_pf0);
 
-static void pci_tsm_unbind_all(struct pci_dev *pdev)
+struct pci_dev *pci_tsm_context_dsm_dev(struct pci_tsm_context *context)
 {
-	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, NULL);
-	__pci_tsm_unbind(pdev, NULL);
+	return context->dsm_dev;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_context_dsm_dev);
+
+bool pci_tsm_context_match_device(struct pci_tsm_context *context,
+				  struct pci_dev *pdev)
+{
+	guard(rwsem_read)(&pci_tsm_rwsem);
+
+	return pdev->tsm && is_link_tsm(pdev->tsm->tsm_dev) &&
+	       to_pci_tsm_pf0(pdev->tsm) == context->pf0;
 }
+EXPORT_SYMBOL_GPL(pci_tsm_context_match_device);
 
-static void __pci_tsm_disconnect(struct pci_dev *pdev)
+static int __pci_tsm_disconnect(struct pci_dev *pdev)
 {
 	struct pci_tsm_pf0 *tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
 	const struct pci_tsm_ops *ops = to_pci_tsm_ops(pdev->tsm);
@@ -389,21 +388,29 @@ static void __pci_tsm_disconnect(struct pci_dev *pdev)
 	/* disconnect() mutually exclusive with subfunction pci_tsm_init() */
 	lockdep_assert_held_write(&pci_tsm_rwsem);
 
-	pci_tsm_unbind_all(pdev);
-
 	/*
-	 * disconnect() is uninterruptible as it may be called for device
-	 * teardown
+	 * A vdevice holds a context for its lifetime. Refuse to tear down the
+	 * link until userspace destroys all dependent vdevices.
+	 *
+	 * disconnect() is uninterruptible as it may also be called for device
+	 * teardown.
 	 */
 	guard(mutex)(&tsm_pf0->lock);
+	if (tsm_pf0->context_users)
+		return -EBUSY;
 	pci_tsm_walk_fns_reverse(pdev, remove_fn, NULL);
 	ops->disconnect(pdev);
+	return 0;
 }
 
-static void pci_tsm_disconnect(struct pci_dev *pdev)
+static int pci_tsm_disconnect(struct pci_dev *pdev)
 {
-	__pci_tsm_disconnect(pdev);
+	int ret = __pci_tsm_disconnect(pdev);
+
+	if (ret)
+		return ret;
 	tsm_remove(pdev->tsm);
+	return 0;
 }
 
 static ssize_t disconnect_store(struct device *dev,
@@ -425,38 +432,13 @@ static ssize_t disconnect_store(struct device *dev,
 	if (!sysfs_streq(buf, dev_name(&tsm_dev->dev)))
 		return -EINVAL;
 
-	pci_tsm_disconnect(pdev);
+	rc = pci_tsm_disconnect(pdev);
+	if (rc)
+		return rc;
 	return len;
 }
 static DEVICE_ATTR_WO(disconnect);
 
-static ssize_t bound_show(struct device *dev,
-			  struct device_attribute *attr, char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_tsm_pf0 *tsm_pf0;
-	struct pci_tsm *tsm;
-	int rc;
-
-	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
-	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
-		return rc;
-
-	tsm = pdev->tsm;
-	if (!tsm)
-		return sysfs_emit(buf, "\n");
-	tsm_pf0 = to_pci_tsm_pf0(tsm);
-
-	ACQUIRE(mutex_intr, ops_lock)(&tsm_pf0->lock);
-	if ((rc = ACQUIRE_ERR(mutex_intr, &ops_lock)))
-		return rc;
-
-	if (!tsm->tdi)
-		return sysfs_emit(buf, "\n");
-	return sysfs_emit(buf, "%s\n", dev_name(&tsm->tsm_dev->dev));
-}
-static DEVICE_ATTR_RO(bound);
-
 static ssize_t dsm_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
@@ -511,13 +493,6 @@ static umode_t pci_tsm_attr_visible(struct kobject *kobj,
 	if (pci_tsm_link_group_visible(kobj)) {
 		struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-		if (attr == &dev_attr_bound.attr) {
-			if (is_pci_tsm_pf0(pdev) && has_tee(pdev))
-				return attr->mode;
-			if (pdev->tsm && has_tee(pdev->tsm->dsm_dev))
-				return attr->mode;
-		}
-
 		if (attr == &dev_attr_dsm.attr) {
 			if (is_pci_tsm_pf0(pdev))
 				return attr->mode;
@@ -544,7 +519,6 @@ DEFINE_SYSFS_GROUP_VISIBLE(pci_tsm);
 static struct attribute *pci_tsm_attrs[] = {
 	&dev_attr_connect.attr,
 	&dev_attr_disconnect.attr,
-	&dev_attr_bound.attr,
 	&dev_attr_dsm.attr,
 	NULL
 };
@@ -634,22 +608,6 @@ static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
 	return NULL;
 }
 
-/**
- * pci_tsm_tdi_constructor() - base 'struct pci_tdi' initialization for link TSMs
- * @pdev: PCI device function representing the TDI
- * @tdi: context to initialize
- * @kvm: Private memory attach context
- * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
- */
-void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
-			     struct kvm *kvm, u32 tdi_id)
-{
-	tdi->pdev = pdev;
-	tdi->kvm = kvm;
-	tdi->tdi_id = tdi_id;
-}
-EXPORT_SYMBOL_GPL(pci_tsm_tdi_constructor);
-
 /**
  * pci_tsm_link_constructor() - base 'struct pci_tsm' initialization for link TSMs
  * @pdev: The PCI device
@@ -729,12 +687,6 @@ int pci_tsm_register(struct tsm_dev *tsm_dev)
 	return 0;
 }
 
-static void pci_tsm_fn_exit(struct pci_dev *pdev)
-{
-	__pci_tsm_unbind(pdev, NULL);
-	tsm_remove(pdev->tsm);
-}
-
 /**
  * __pci_tsm_destroy() - destroy the TSM context for @pdev
  * @pdev: device to cleanup
@@ -768,10 +720,12 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
 	else if (tsm_dev != tsm->tsm_dev)
 		return;
 
-	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev))
-		pci_tsm_disconnect(pdev);
-	else
-		pci_tsm_fn_exit(pdev);
+	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev)) {
+		if (pci_tsm_disconnect(pdev))
+			pci_warn(pdev, "TSM connection is still in use\n");
+	} else {
+		tsm_remove(pdev->tsm);
+	}
 }
 
 void pci_tsm_destroy(struct pci_dev *pdev)
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 6fe3d0ea875f..eaf0199d01f7 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -5,8 +5,8 @@
 #include <linux/pci.h>
 
 struct pci_tsm;
+struct pci_tsm_context;
 struct tsm_dev;
-struct kvm;
 
 /*
  * struct pci_tsm_ops - manage confidential links and security state
@@ -30,16 +30,12 @@ struct pci_tsm_ops {
 	 * @connect: establish / validate a secure connection (e.g. IDE)
 	 *	     with the device
 	 * @disconnect: teardown the secure link
-	 * @bind: bind a TDI in preparation for it to be accepted by a TVM
-	 * @unbind: remove a TDI from secure operation with a TVM
 	 *
 	 * Context: @probe, @remove, @connect, and @disconnect run under
 	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
 	 * mutual exclusion of @connect and @disconnect. @connect and
 	 * @disconnect additionally run under the DSM lock (struct
 	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
-	 * @bind and @unbind run under pci_tsm_rwsem held for read
-	 * and the DSM lock.
 	 */
 	struct_group_tagged(pci_tsm_link_ops, link_ops,
 		struct pci_tsm *(*probe)(struct tsm_dev *tsm_dev,
@@ -47,9 +43,6 @@ struct pci_tsm_ops {
 		void (*remove)(struct pci_tsm *tsm);
 		int (*connect)(struct pci_dev *pdev);
 		void (*disconnect)(struct pci_dev *pdev);
-		struct pci_tdi *(*bind)(struct pci_dev *pdev,
-					struct kvm *kvm, u32 tdi_id);
-		void (*unbind)(struct pci_tdi *tdi);
 	);
 
 	/*
@@ -69,25 +62,12 @@ struct pci_tsm_ops {
 	);
 };
 
-/**
- * struct pci_tdi - Core TEE I/O Device Interface (TDI) context
- * @pdev: host side representation of guest-side TDI
- * @kvm: TEE VM context of bound TDI
- * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
- */
-struct pci_tdi {
-	struct pci_dev *pdev;
-	struct kvm *kvm;
-	u32 tdi_id;
-};
-
 /**
  * struct pci_tsm - Core TSM context for a given PCIe endpoint
  * @pdev: Back ref to device function, distinguishes type of pci_tsm context
  * @dsm_dev: PCI Device Security Manager for link operations on @pdev
  * @tsm_dev: PCI TEE Security Manager device for Link Confidentiality or Device
  *	     Function Security operations
- * @tdi: TDI context established by the @bind link operation
  *
  * This structure is wrapped by low level TSM driver data and returned by
  * probe()/lock(), it is freed by the corresponding remove()/unlock().
@@ -103,18 +83,20 @@ struct pci_tsm {
 	struct pci_dev *pdev;
 	struct pci_dev *dsm_dev;
 	struct tsm_dev *tsm_dev;
-	struct pci_tdi *tdi;
 };
 
 /**
  * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
  * @base_tsm: generic core "tsm" context
  * @lock: mutual exclustion for pci_tsm_ops invocation
+ * @context_users: live per-function contexts on this PF0; a nonzero count
+ *	blocks link disconnect
  * @doe_mb: PCIe Data Object Exchange mailbox
  */
 struct pci_tsm_pf0 {
 	struct pci_tsm base_tsm;
 	struct mutex lock;
+	unsigned int context_users;
 	struct pci_doe_mb *doe_mb;
 };
 
@@ -161,10 +143,14 @@ int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
 void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
 int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
 			 size_t req_sz, void *resp, size_t resp_sz);
-int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
-void pci_tsm_unbind(struct pci_dev *pdev);
-void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
-			     struct kvm *kvm, u32 tdi_id);
+bool pci_tsm_is_configured(struct pci_dev *pdev);
+struct pci_tsm_context *pci_tsm_context_get(struct pci_dev *pdev,
+					    struct tsm_dev *viommu_tsm_dev);
+void pci_tsm_context_put(struct pci_tsm_context *context);
+struct pci_tsm_pf0 *pci_tsm_context_pf0(struct pci_tsm_context *context);
+struct pci_dev *pci_tsm_context_dsm_dev(struct pci_tsm_context *context);
+bool pci_tsm_context_match_device(struct pci_tsm_context *context,
+				  struct pci_dev *pdev);
 #else
 static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
@@ -173,12 +159,39 @@ static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 static inline void pci_tsm_unregister(struct tsm_dev *tsm_dev)
 {
 }
-static inline int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
+
+static inline bool pci_tsm_is_configured(struct pci_dev *pdev)
 {
-	return -ENXIO;
+	return false;
 }
-static inline void pci_tsm_unbind(struct pci_dev *pdev)
+
+static inline struct pci_tsm_context *
+pci_tsm_context_get(struct pci_dev *pdev, struct tsm_dev *viommu_tsm_dev)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void pci_tsm_context_put(struct pci_tsm_context *context)
+{
+}
+
+static inline struct pci_tsm_pf0 *
+pci_tsm_context_pf0(struct pci_tsm_context *context)
+{
+	return NULL;
+}
+
+static inline struct pci_dev *
+pci_tsm_context_dsm_dev(struct pci_tsm_context *context)
+{
+	return NULL;
+}
+
+static inline bool
+pci_tsm_context_match_device(struct pci_tsm_context *context,
+			     struct pci_dev *pdev)
 {
+	return false;
 }
 #endif
 #endif /*__PCI_TSM_H */
-- 
2.43.0

