Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703715665C
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496062; cv=none; b=e9BtbSu0RRIByQukSgEFfCJTbwMAln3UCn68nqKXI9YLxT5ig8mF/JsFo42RoWIfZ3iB48dUvWNA0u9uNJUAxbyZ+4G6L0X3gRIs3KOI953Cqgcu+OwxVFFwAltYj7qSBW814AxaZdE3X2g3WcAW7KlQb4V9empP4LOXj2sCPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496062; c=relaxed/simple;
	bh=8RMfTZ1VDoQNeIon0VdLPG46T+8O6Bt3DAP7Axld84s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aT+0gMsepMcXqeGsRhnXle3+MZhLaCXdSrRdE4Mo1EHa9c1xVz3es75uAluXaa3Ynvacp4kV4qv46S8u7RuzH74vKqjpgRU5DyM/7iBiJ4uWW2Bp5mK3nXvfo0VDt8LwkfNP8l9cQ6OIjbKHtgU2sTnGM54qXFR2loVf79K+iP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjrIJ1G2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjrIJ1G2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496061; x=1804032061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8RMfTZ1VDoQNeIon0VdLPG46T+8O6Bt3DAP7Axld84s=;
  b=SjrIJ1G2BfdOSSPcsSq96kUjOyrglATZapFfp8FVCUdKNo18Thldg0tC
   C6BJCkYt8q4+lDEeT0imO7EqEWonNGszrrIiNQwITeJwofT15IVTh8H7R
   JyW1MZe9DtunAoFw7RfQjtq+0nKzlEINmqkUuFRzaGCXxc2LEGsgkKBr+
   eTnjGjMcPu/sg5sxCY9rivtdd6Gnf7plWceFxjuUF3Xkbb62ghbqDbewF
   uUSPS5qFkRrwuhKX9ePsdqEFr81VTcb7kIiiPI3PcRTnYQ0X1OWlh73vN
   kGRV/mXwWVsRsQvZC6u37MBjVPrX/sidoEwRsyj+GMXdsN+VdSpftUJyR
   g==;
X-CSE-ConnectionGUID: DtNCZZYoQ2SetAr8Ck4Nmg==
X-CSE-MsgGUID: zBYjfMmRQvWDNnXqnF3Kfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73482897"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73482897"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:00:56 -0800
X-CSE-ConnectionGUID: SbJH5BmcRFORWNSi0tyZ6Q==
X-CSE-MsgGUID: JD8/jv2uTIuU6OFc0GWwsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="214967092"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2026 16:00:55 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	aik@amd.com,
	aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com,
	bhelgaas@google.com,
	alistair23@gmail.com,
	lukas@wunner.de,
	jgg@nvidia.com
Subject: [PATCH v2 06/19] PCI/TSM: Add Device Security (TVM Guest) LOCK operation support
Date: Mon,  2 Mar 2026 16:01:54 -0800
Message-ID: <20260303000207.1836586-7-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303000207.1836586-1-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCIe Trusted Execution Environment Device Interface Security Protocol
(TDISP) has two distinct sets of operations. The first, already enabled in
driver/pci/tsm.c, enables the VMM to authenticate the physical function
(PCIe Component Measurement and Authentication (CMA)), establish a secure
message passing session (DMTF SPDM), and establish physical link security
(PCIe Integrity and Data Encryption (IDE)). The second set of operations
lets a VM manage the security state of assigned devices (TEE Device
Interfaces (TDIs)). Implement the LOCK/UNLOCK operations in pci_tsm_ops, to
be followed with an ACCEPT operation.

 - lock(): Transition the device to the TDISP state. In this mode
   the device is responsible for validating that it is in a secure
   configuration and will transition to the TDISP ERROR state if those
   settings are modified. Device Security Manager (DSM) and the TEE
   Security Manager (TSM) enforce that the device is not permitted to issue
   T=1 traffic in this mode.

 - unlock(): From the RUN state the only other TDISP states that can be
   moved to are ERROR or UNLOCKED. Voluntarily move the device to the
   UNLOCKED state.

Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-pci   |  34 +++-
 Documentation/ABI/testing/sysfs-class-tsm |  19 ++
 Documentation/driver-api/pci/tsm.rst      |  44 +++++
 include/linux/device.h                    |   1 +
 include/linux/pci-tsm.h                   |  21 ++-
 drivers/pci/tsm.c                         | 213 +++++++++++++++++++++-
 drivers/virt/coco/tsm-core.c              |  41 +++++
 7 files changed, 363 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index b767db2c52cb..1ed77b9402a6 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -647,13 +647,16 @@ Description:
 		Encryption) establishment. Reads from this attribute return the
 		name of the connected TSM or the empty string if not
 		connected. A TSM device signals its readiness to accept PCI
-		connection via a KOBJ_CHANGE event.
+		connection via a KOBJ_CHANGE event. This is a "link" TSM
+		attribute, see Documentation/ABI/testing/sysfs-class-tsm.
 
 What:		/sys/bus/pci/devices/.../tsm/disconnect
 Contact:	linux-coco@lists.linux.dev
 Description:
 		(WO) Write the name of the TSM device that was specified
-		to 'connect' to teardown the connection.
+		to 'connect' to teardown the connection. This is a
+		"link" TSM attribute, see
+		Documentation/ABI/testing/sysfs-class-tsm.
 
 What:		/sys/bus/pci/devices/.../tsm/dsm
 Contact:	linux-coco@lists.linux.dev
@@ -702,3 +705,30 @@ Description:
 		When present and the tsm/ attribute directory is present, the
 		authenticated attribute is an alias for the device 'connect'
 		state. See the 'tsm/connect' attribute for more details.
+		This is a "link" TSM attribute, see
+		Documentation/ABI/testing/sysfs-class-tsm.
+
+What:		/sys/bus/pci/devices/.../tsm/lock
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RW) Write the name of a TSM (TEE Security Manager) device
+		instance to this file to request that the platform transition
+		the PCIe device configuration to the TDISP LOCKED state. This
+		puts the device in a state where security sensitive
+		configuration setting can not be changed without transitioning
+		the device the PCIe TDISP ERROR state. Reads from this attribute
+		return the name of the TSM device instance that has arranged for
+		the device to be locked, or the empty string if not locked. A
+		TSM class device signals its readiness for lock requests via a
+		KOBJ_CHANGE event. Writes fail with EBUSY if this device is
+		bound to a driver. This is a "devsec" TSM attribute, see
+		Documentation/ABI/testing/sysfs-class-tsm. See
+		Documentation/driver-api/pci/tsm.rst for more details.
+
+What:		/sys/bus/pci/devices/.../tsm/unlock
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(WO) Write the name of the TSM device that was specified to
+		'lock' to teardown the connection. Writes fail with EBUSY if
+		this device is bound to a driver. This is a "devsec" TSM
+		attribute, see Documentation/ABI/testing/sysfs-class-tsm.
diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
index 1ddb8f357961..76704501f082 100644
--- a/Documentation/ABI/testing/sysfs-class-tsm
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -20,3 +20,22 @@ Description:
 		Documentation/ABI/testing/sysfs-devices-pci-host-bridge for the
 		description of the pciDDDD:BB/streamH.R.E symlink and the
 		pciDDDD:BB/available_secure_streams attribute.
+
+What:		/sys/class/tsm/tsmN/pci_mode
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RO) A TSM with PCIe TDISP capability can be in one of two
+		modes.
+
+		    "link": typically for a hypervisor (VMM) to authenticate,
+			    establish a secure session, and setup link
+			    encryption.
+
+		    "devsec": typically for a confidential guest (TVM) to
+			      transition assigned devices through the TDISP
+			      state machine UNLOCKED->LOCKED->RUN.
+
+		See the "tsm/" entries in
+		Documentation/ABI/testing/sysfs-bus-pci for the available PCI
+		device attributes when a TSM with the given "pci_mode" is
+		registered.
diff --git a/Documentation/driver-api/pci/tsm.rst b/Documentation/driver-api/pci/tsm.rst
index 232b92bec93f..e9b7ac70b404 100644
--- a/Documentation/driver-api/pci/tsm.rst
+++ b/Documentation/driver-api/pci/tsm.rst
@@ -5,6 +5,50 @@
 PCI Trusted Execution Environment Security Manager (TSM)
 ========================================================
 
+Overview
+========
+
+A "TSM", as detailed by PCIe r7.0 section 11 "TEE Device Interface
+Security Protocol (TDISP)", is an entity within the platform's Trusted
+Computing Base (TCB) that enforces security policies on the host. It
+serves to mitigate a threat model where devices may be under the control
+of an adversary. The adversarial threats are:
+
+- Identity: Device may be mimicking a legitimate device identity / firmware
+- Physical: link may be under observation, or control (reorder / drop data)
+- Virtual: Device MMIO presented to a guest may not actually map the
+  device, device DMA may be redirected.
+
+In Linux a "tsm" is a broader concept. It is a class device interface to
+mitigate one or more of the above threats. A "tsm driver" registers a
+tsm device that publishes either the 'tsm/connect' or
+'tsm/{lock,accept}' set of attributes for the PCIe device. The typical
+expectation is that 'tsm/{lock,accept}' is published by a guest "tsm
+driver" to mitigate "Virtual" threats. The 'tsm/connect' interface is
+published by a host "tsm driver" to mitigate "Identity" and/or
+"Physical" threats.
+
+Device Interface LOCK
+=====================
+The lock operation facilitated by tsm/lock (see
+Documentation/ABI/testing/sysfs-bus-pci) places the device in a mode
+where any security sensitive changes to the device configuration results
+in the device transitioning to the ERROR state. The device presents
+signed evidence of its LOCK state to the kernel through the tsm driver.
+The relying party is responsible for verifying not only the evidence but
+that the device is trusted to maintain those attested values while
+locked. Accepting the locked configuration also asserts that device is
+trusted to cease TCB interactions (send T=1 DMA / accept T=1 MMIO TLPs)
+when it is next unlocked by STOP. The TSM is responsible for enforcing
+that the device is not unlocked within the interval between evidence
+collection and acceptance, by correlating the evidence from LOCK to the
+subsequent RUN request.
+
+While the PCIe specification allows for the device to operate outside
+the TCB when locked, depending on the TSM architecture implementation,
+T=0 DMA from the device may be blocked until the device is next
+unlocked.
+
 Subsystem Interfaces
 ====================
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 4470365d772b..f131623f39d9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -911,6 +911,7 @@ static inline void device_unlock(struct device *dev)
 }
 
 DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
+DEFINE_GUARD_COND(device, _intr, device_lock_interruptible(_T), _RET == 0)
 
 static inline void device_lock_assert(struct device *dev)
 {
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index a6435aba03f9..2a896b83bff9 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -68,7 +68,8 @@ struct pci_tsm_ops {
 	 * @unlock: destroy TSM context and return device to UNLOCKED state
 	 *
 	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
-	 * sync with TSM unregistration and each other
+	 * sync with TSM unregistration and each other. All operations run under
+	 * the device lock for mutual exclusion with driver attach and detach.
 	 */
 	struct_group_tagged(pci_tsm_devsec_ops, devsec_ops,
 		struct pci_tsm *(*lock)(struct tsm_dev *tsm_dev,
@@ -106,6 +107,13 @@ struct pci_tdi {
  * sub-function (SR-IOV virtual function, or non-function0
  * multifunction-device), or a downstream endpoint (PCIe upstream switch-port as
  * DSM).
+ *
+ * For devsec operations it serves to indicate that the function / TDI has been
+ * locked to a given TSM.
+ *
+ * The common expectation is that there is only ever one TSM, but this is not
+ * enforced. The implementation only enforces that a device can be "connected"
+ * to a TSM instance or "locked" to a different TSM.
  */
 struct pci_tsm {
 	struct pci_dev *pdev;
@@ -126,6 +134,14 @@ struct pci_tsm_pf0 {
 	struct pci_doe_mb *doe_mb;
 };
 
+/**
+ * struct pci_tsm_devsec - context for tracking private/accepted PCI resources
+ * @base_tsm: generic core "tsm" context
+ */
+struct pci_tsm_devsec {
+	struct pci_tsm base_tsm;
+};
+
 /* physical function0 and capable of 'connect' */
 static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
 {
@@ -206,6 +222,8 @@ int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
 			     struct tsm_dev *tsm_dev);
 int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
 			    struct tsm_dev *tsm_dev);
+int pci_tsm_devsec_constructor(struct pci_dev *pdev, struct pci_tsm_devsec *tsm,
+			       struct tsm_dev *tsm_dev);
 void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
 int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
 			 size_t req_sz, void *resp, size_t resp_sz);
@@ -216,6 +234,7 @@ void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
 ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
 			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
 			  size_t out_len, u64 *tsm_code);
+struct pci_tsm_devsec *to_pci_tsm_devsec(struct pci_tsm *tsm);
 #else
 static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 5fdcd7f2e820..259e75092618 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -9,6 +9,7 @@
 #define dev_fmt(fmt) "PCI/TSM: " fmt
 
 #include <linux/bitfield.h>
+#include <linux/ioport.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/pci-tsm.h>
@@ -63,6 +64,26 @@ static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *tsm)
 	return container_of(pf0->tsm, struct pci_tsm_pf0, base_tsm);
 }
 
+static inline bool is_devsec(struct pci_dev *pdev)
+{
+	return pdev->tsm && pdev->tsm->dsm_dev == NULL &&
+	       pdev->tsm->tdi == NULL;
+}
+
+/* 'struct pci_tsm_devsec' wraps 'struct pci_tsm' when ->tdi == ->dsm == NULL */
+struct pci_tsm_devsec *to_pci_tsm_devsec(struct pci_tsm *tsm)
+{
+	struct pci_dev *pdev = tsm->pdev;
+
+	if (!is_devsec(pdev) || !has_tee(pdev)) {
+		pci_WARN_ONCE(pdev, 1, "invalid context object\n");
+		return NULL;
+	}
+
+	return container_of(tsm, struct pci_tsm_devsec, base_tsm);
+}
+EXPORT_SYMBOL_GPL(to_pci_tsm_devsec);
+
 static void tsm_remove(struct pci_tsm *tsm)
 {
 	struct pci_dev *pdev;
@@ -536,6 +557,125 @@ static ssize_t dsm_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(dsm);
 
+/**
+ * pci_tsm_unlock() - Transition TDI from LOCKED/RUN to UNLOCKED
+ * @pdev: TDI device to unlock
+ *
+ * Returns void, requires all callers to have satisfied dependencies like making
+ * sure the device is locked and detached from its driver.
+ */
+static void pci_tsm_unlock(struct pci_dev *pdev)
+{
+	lockdep_assert_held_write(&pci_tsm_rwsem);
+	device_lock_assert(&pdev->dev);
+
+	if (dev_WARN_ONCE(&pdev->dev, pdev->dev.driver,
+			  "unlock attempted on driver attached device\n"))
+		return;
+
+	device_cc_reject(&pdev->dev);
+	to_pci_tsm_ops(pdev->tsm)->unlock(pdev->tsm);
+	pdev->tsm = NULL;
+}
+
+static int pci_tsm_lock(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
+{
+	const struct pci_tsm_ops *ops = tsm_dev->pci_ops;
+	struct pci_tsm *tsm;
+	int rc;
+
+	ACQUIRE(device_intr, lock)(&pdev->dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &lock)))
+		return rc;
+
+	if (pdev->dev.driver)
+		return -EBUSY;
+
+	tsm = ops->lock(tsm_dev, pdev);
+	if (IS_ERR(tsm))
+		return PTR_ERR(tsm);
+
+	pdev->tsm = tsm;
+	return 0;
+}
+
+static ssize_t lock_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int rc, id;
+
+	rc = sscanf(buf, "tsm%d\n", &id);
+	if (rc != 1)
+		return -EINVAL;
+
+	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
+		return rc;
+
+	if (pdev->tsm)
+		return -EBUSY;
+
+	struct tsm_dev *tsm_dev __free(put_tsm_dev) = find_tsm_dev(id);
+	if (!is_devsec_tsm(tsm_dev))
+		return -ENXIO;
+
+	rc = pci_tsm_lock(pdev, tsm_dev);
+	if (rc)
+		return rc;
+	return len;
+}
+
+static ssize_t lock_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct tsm_dev *tsm_dev;
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
+		return rc;
+
+	if (!pdev->tsm)
+		return sysfs_emit(buf, "\n");
+
+	tsm_dev = pdev->tsm->tsm_dev;
+	return sysfs_emit(buf, "%s\n", dev_name(&tsm_dev->dev));
+}
+static DEVICE_ATTR_RW(lock);
+
+static ssize_t unlock_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct tsm_dev *tsm_dev;
+	int rc;
+
+	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
+		return rc;
+
+	if (!pdev->tsm)
+		return -EINVAL;
+
+	tsm_dev = pdev->tsm->tsm_dev;
+	if (!sysfs_streq(buf, dev_name(&tsm_dev->dev)))
+		return -EINVAL;
+
+	ACQUIRE(device_intr, dev_lock)(&pdev->dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &dev_lock)))
+		return rc;
+
+	if (pdev->dev.driver)
+		return -EBUSY;
+
+	pci_tsm_unlock(pdev);
+
+	return len;
+}
+static DEVICE_ATTR_WO(unlock);
+
 /* The 'authenticated' attribute is exclusive to the presence of a 'link' TSM */
 static bool pci_tsm_link_group_visible(struct kobject *kobj)
 {
@@ -561,6 +701,13 @@ static bool pci_tsm_link_group_visible(struct kobject *kobj)
 }
 DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_link);
 
+static bool pci_tsm_devsec_group_visible(struct kobject *kobj)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	return pci_tsm_devsec_count && has_tee(pdev);
+}
+
 /*
  * 'link' and 'devsec' TSMs share the same 'tsm/' sysfs group, so the TSM type
  * specific attributes need individual visibility checks.
@@ -592,12 +739,19 @@ static umode_t pci_tsm_attr_visible(struct kobject *kobj,
 		}
 	}
 
+	if (pci_tsm_devsec_group_visible(kobj)) {
+		if (attr == &dev_attr_lock.attr ||
+		    attr == &dev_attr_unlock.attr)
+			return attr->mode;
+	}
+
 	return 0;
 }
 
 static bool pci_tsm_group_visible(struct kobject *kobj)
 {
-	return pci_tsm_link_group_visible(kobj);
+	return pci_tsm_link_group_visible(kobj) ||
+	       pci_tsm_devsec_group_visible(kobj);
 }
 DEFINE_SYSFS_GROUP_VISIBLE(pci_tsm);
 
@@ -606,6 +760,8 @@ static struct attribute *pci_tsm_attrs[] = {
 	&dev_attr_disconnect.attr,
 	&dev_attr_bound.attr,
 	&dev_attr_dsm.attr,
+	&dev_attr_lock.attr,
+	&dev_attr_unlock.attr,
 	NULL
 };
 
@@ -734,6 +890,29 @@ int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
 }
 EXPORT_SYMBOL_GPL(pci_tsm_link_constructor);
 
+/**
+ * pci_tsm_devsec_constructor() - devsec TSM context initialization
+ * @pdev: The PCI device
+ * @tsm: context to initialize
+ * @tsm_dev: Platform TEE Security Manager, initiator of security operations
+ */
+int pci_tsm_devsec_constructor(struct pci_dev *pdev, struct pci_tsm_devsec *tsm,
+			       struct tsm_dev *tsm_dev)
+{
+	struct pci_tsm *pci_tsm = &tsm->base_tsm;
+
+	if (!is_devsec_tsm(tsm_dev))
+		return -EINVAL;
+
+	pci_tsm->dsm_dev = NULL;
+	pci_tsm->tdi = NULL;
+	pci_tsm->pdev = pdev;
+	pci_tsm->tsm_dev = tsm_dev;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_devsec_constructor);
+
 /**
  * pci_tsm_pf0_constructor() - common 'struct pci_tsm_pf0' (DSM) initialization
  * @pdev: Physical Function 0 PCI device (as indicated by is_pci_tsm_pf0())
@@ -761,6 +940,13 @@ void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *pf0_tsm)
 }
 EXPORT_SYMBOL_GPL(pci_tsm_pf0_destructor);
 
+static void devsec_sysfs_enable(struct pci_dev *pdev)
+{
+	pci_dbg(pdev, "TEE I/O Device capability detected (TDISP)\n");
+
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
+}
+
 int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
 	struct pci_dev *pdev = NULL;
@@ -782,8 +968,10 @@ int pci_tsm_register(struct tsm_dev *tsm_dev)
 		for_each_pci_dev(pdev)
 			if (is_pci_tsm_pf0(pdev))
 				link_sysfs_enable(pdev);
-	} else if (is_devsec_tsm(tsm_dev)) {
-		pci_tsm_devsec_count++;
+	} else if (is_devsec_tsm(tsm_dev) && pci_tsm_devsec_count++ == 0) {
+		for_each_pci_dev(pdev)
+			if (has_tee(pdev))
+				devsec_sysfs_enable(pdev);
 	}
 
 	return 0;
@@ -818,6 +1006,9 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
 	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev) && !pci_tsm_link_count)
 		link_sysfs_disable(pdev);
 
+	if (is_devsec_tsm(tsm_dev) && !pci_tsm_devsec_count)
+		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
+
 	/* Nothing else to do if this device never attached to the departing TSM */
 	if (!tsm)
 		return;
@@ -828,10 +1019,18 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
 	else if (tsm_dev != tsm->tsm_dev)
 		return;
 
-	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev))
-		pci_tsm_disconnect(pdev);
-	else
-		pci_tsm_fn_exit(pdev);
+	/* Disconnect DSMs, unlock assigned TDIs, or cleanup DSM subfunctions */
+	if (is_link_tsm(tsm_dev)) {
+		if (is_pci_tsm_pf0(pdev))
+			pci_tsm_disconnect(pdev);
+		else
+			pci_tsm_fn_exit(pdev);
+	}
+
+	if (is_devsec_tsm(tsm_dev) && has_tee(pdev)) {
+		guard(device)(&pdev->dev);
+		pci_tsm_unlock(pdev);
+	}
 }
 
 void pci_tsm_destroy(struct pci_dev *pdev)
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index 3c99c38cfaa5..231462d60379 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -54,6 +54,45 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
 	return no_free_ptr(tsm_dev);
 }
 
+static ssize_t pci_mode_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct tsm_dev *tsm_dev = container_of(dev, struct tsm_dev, dev);
+	const struct pci_tsm_ops *ops = tsm_dev->pci_ops;
+
+	if (ops->connect)
+		return sysfs_emit(buf, "link\n");
+	if (ops->lock)
+		return sysfs_emit(buf, "devsec\n");
+	return sysfs_emit(buf, "none\n");
+}
+static DEVICE_ATTR_RO(pci_mode);
+
+static umode_t tsm_pci_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct tsm_dev *tsm_dev = container_of(dev, struct tsm_dev, dev);
+
+	if (tsm_dev->pci_ops)
+		return attr->mode;
+	return 0;
+}
+
+static struct attribute *tsm_pci_attrs[] = {
+	&dev_attr_pci_mode.attr,
+	NULL
+};
+
+static const struct attribute_group tsm_pci_group = {
+	.attrs = tsm_pci_attrs,
+	.is_visible = tsm_pci_visible,
+};
+
+static const struct attribute_group *tsm_pci_groups[] = {
+	&tsm_pci_group,
+	NULL
+};
+
 static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
 						 struct pci_tsm_ops *pci_ops)
 {
@@ -70,6 +109,7 @@ static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
 		device_unregister(&tsm_dev->dev);
 		return ERR_PTR(rc);
 	}
+	sysfs_update_group(&tsm_dev->dev.kobj, &tsm_pci_group);
 
 	/* Notify TSM userspace that PCI/TSM operations are now possible */
 	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
@@ -214,6 +254,7 @@ static int __init tsm_init(void)
 	if (IS_ERR(tsm_class))
 		return PTR_ERR(tsm_class);
 
+	tsm_class->dev_groups = tsm_pci_groups;
 	tsm_class->dev_release = tsm_release;
 	return 0;
 }
-- 
2.52.0

