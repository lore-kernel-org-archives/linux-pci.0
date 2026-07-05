Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47A371D02
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289318; cv=none; b=U/Wo9xITnbDhgK4Mm8m2wJ0U8X8wa0XTLo8BGG8Osji/OBriogzhi0uXEXurpUYaibz/EZwsI/4LiNloFLcFxBwTj3ahfRNiljOB3AKRb5lV7acoK0eUfJWTzVp0B9UwIXalUfdUzv1UZAvZjEWAz2tYFuXRpV5LTX0/rzF+BMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289318; c=relaxed/simple;
	bh=+L0837SdgIc+9JQpw2S89Q5vACzh3QkyrQAPfgKQ678=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXH0KlKaj3DlSRnJNVXUbAxkqCVDZnXzHHFzEBiaZtC2DK57kk/uEUKtZRaw59SvGP/BGnBctgVSlszBeLP2WxvuiOYmuCgEVFZgX46B/WDWRzOsK0yJE2N2jkzUVJ+EJ3gHLRcoV4qUxCRRXFKZwioY9pIV0uF464OyaQIZy+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEkfu1yj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEkfu1yj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E641F000E9;
	Sun,  5 Jul 2026 22:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289316;
	bh=80ZdTpzVF3k0O1sGyuurKNJhFHjcC+FcXheESOGCqgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HEkfu1yjT8FKMSNG3tzaQYhjFR3bQap0yOfY+leA98auWteaiFBBPV+T3XQos01Tv
	 mnwakTGHFfZZJ1zXCtivr+kqDkHljQU0gEUIrH+Iv11hB7ZIpoAv1ROL1uJgYFmBFK
	 3yVsYqbQp+/u7TXEwrmrnP3Mt2rOCsDgLD36jyGCbyZ/vg6h2tr06qbiZUklTv1EER
	 BW8T7Q2YBARJU1PxgkCkLr/crSs8j/gfueCMfVzwDi/ezcAUOCBtc65jqFdYabaTlb
	 PdZbhcLxD6Q+qCvoPuCf8wzlOFXeOIuH7LKPjWhwbRHqkKGDJ4jzfMsRpf1nGkNrGa
	 wjLp5UlYC3crA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id B3785F40068;
	Sun,  5 Jul 2026 18:08:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 05 Jul 2026 18:08:35 -0400
X-ME-Sender: <xms:49VKagNhDth3LGc9xJuWg12gZZEp3SW_FeSO2XdQIe6WUMJOUSk_lg>
    <xme:49VKapjgvySy1AnfIL5-OZLFN79ir1JJ493yMguQosfSY1eyWdEx4-5Lc22d-ghyT
    KmWJc5uLLDySxIxdgkKFcFSmXqAPyqctFOy8vKOqxtam1OFsGV1qCA>
X-ME-Received: <xmr:49VKaq4FuWw01KC7hk-I6vhaTP_Nvi5m4693wTsk0_qpB12VSyZDrdMKtN83HhxHH-aOtJa5F_RJkUubB2dKe7574P96BoizLDQ>
X-ME-Proxy-Cause: dmFkZTG0CP0dZmdNcV8rsEn3S06MMs4XQ44MiZG4ZCs2XrFV7lXiuhlneABQQTaICxUcMc
    P+1ODA6MGYz0784hsjgTsV05YmgkywfdQoOlfLicxDKeBGB4PrMhmwEUg4VUNYGlIkLxnH
    8Vz49Kgo4ToQVoSAwCeEtDa3/OHzdnSDqWKev24jjGCmj5kHJaMOz9p5kq1uJzUfimZzDj
    ctFoZtMPMLl03YRBfuxxVu6nPXCwDvd5MZ7lgUYxfFIoqbJvDommu29T6zUJ0gRL7R01wX
    hVM5p5fOjqHaQ+xgr+tqvmWjcWIkq4/M5uivhsXs6QdfVAn+ffoPhIr1SLFEBgaVyEHHWz
    2WV5q9qo8U1ZbeC54ZNOsnc+KoRn483PJQSc7MLTiHmN31PIuA0pyGLxIjpsP6nq0H3qBf
    9jcNB72CboYgXKJrzVkZiGmA5MWn/g6nNdPcUbMgmglleuSeO2580eBQe5ZdGkNPDdoYS3
    A3Jpfy2BW74LqX43PFDqjJdoKNLzUS5wyIRkOeLlZ1wxdRa9ALSzGpGANuCQRdHFJDr96q
    Tn2V0V7psSpp1SHBnWluweFq9PNy4hCzkadi9XzaLWVJjr0aT0X2p6MyNSFLLil3YAbyBT
    99SfQaM4WzyjY4LcgmCagvxDqROLsc6S64OPD4n1euHf0Y9SXeQ/wzbF1K9A
X-ME-Proxy: <xmx:49VKao101rOhvJU8ugcWR_F3ZUzJr5yYnuhI3ox7EKLgmG5tjbbmsw>
    <xmx:49VKatt9gngqvqnflaLxKp52ArbPz-yPgLSoCD7_q1lYnXsmfDj2tg>
    <xmx:49VKam4OKI6xaqeoMJTUwb0lJpst-P0ErLI22i7sca50rnnmCwqbdg>
    <xmx:49VKahf1c_6XmWeirx5UgqKfwgxZV-ciP7wgHH_4VSRn1TT35Q28lg>
    <xmx:49VKarzrkeCG0IWfLCavrwikwzZKRWRCBie_mVcfljjeoiNLEiqMP_Am>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:08:35 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH 10/15] PCI/TSM: Add device interface security LOCKED support
Date: Sun,  5 Jul 2026 15:08:14 -0700
Message-ID: <20260705220819.2472765-11-djbw@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705220819.2472765-1-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
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
be followed with an operation to transition the interface to RUN.

 - lock(): Transition the device to the TDISP LOCKED state. In this state
   measurements can validated to ensure that the VM trusts the device's
   security manager (DSM).

 - unlock(): Transition the device to the TDISP UNLOCKED state.

The device shall not be attached to a driver during these transitions.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-pci   |  34 +++-
 Documentation/ABI/testing/sysfs-class-tsm |  19 ++
 Documentation/driver-api/pci/tsm.rst      |  47 +++++
 include/linux/pci-tsm.h                   |  21 ++-
 drivers/pci/tsm/core.c                    | 213 +++++++++++++++++++++-
 drivers/virt/coco/tsm-core.c              |  43 ++++-
 6 files changed, 366 insertions(+), 11 deletions(-)

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
index 2949468deaf7..44e8a0bf4dae 100644
--- a/Documentation/ABI/testing/sysfs-class-tsm
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -7,3 +7,22 @@ Description:
 		signals when the PCI layer is able to support establishment of
 		link encryption and other device-security features coordinated
 		through a platform tsm.
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
index 232b92bec93f..19df202107fa 100644
--- a/Documentation/driver-api/pci/tsm.rst
+++ b/Documentation/driver-api/pci/tsm.rst
@@ -5,6 +5,53 @@
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
+locked. Accepting the locked configuration moves the device to the RUN
+state where it will accept private (T=1) traffic to its MMIO interface.
+
+Note that the RUN state is necessary, but not sufficient for the device
+to access private host memory (send T=1 DMA). That is only enabled after
+the device's trust level has been elevated to indicate it can operate
+within the TCB.
+
+A device in the RUN state is trusted to cease TCB interactions (send T=1
+DMA / accept T=1 MMIO TLPs) when it is next unlocked or encounters a
+security relevant error. The TSM is responsible for enforcing that the
+device is not unlocked within the interval between evidence collection
+and acceptance, by correlating the evidence from LOCK to the subsequent
+RUN request.
+
 Subsystem Interfaces
 ====================
 
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 8bc16029d31e..326471f1e01a 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -72,7 +72,8 @@ struct pci_tsm_ops {
 	 * @unlock: destroy TSM context and return device to UNLOCKED state
 	 *
 	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
-	 * sync with TSM unregistration and each other
+	 * sync with TSM unregistration and each other. All operations run under
+	 * the device lock for mutual exclusion with driver attach and detach.
 	 */
 	struct_group_tagged(pci_tsm_devsec_ops, devsec_ops,
 		struct pci_tsm *(*lock)(struct tsm_dev *tsm_dev,
@@ -115,6 +116,13 @@ struct pci_tdi {
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
@@ -136,6 +144,14 @@ struct pci_tsm_pf0 {
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
@@ -216,6 +232,8 @@ int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
 			     struct tsm_dev *tsm_dev);
 int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
 			    struct tsm_dev *tsm_dev);
+int pci_tsm_devsec_constructor(struct pci_dev *pdev, struct pci_tsm_devsec *tsm,
+			       struct tsm_dev *tsm_dev);
 void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
 int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
 			 size_t req_sz, void *resp, size_t resp_sz);
@@ -230,6 +248,7 @@ static inline const struct pci_tsm_ops *to_pci_tsm_ops(struct pci_tsm *tsm)
 {
 	return tsm->tsm_dev->pci_ops;
 }
+struct pci_tsm_devsec *to_pci_tsm_devsec(struct pci_tsm *tsm);
 #else
 static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
index 220842df42bc..590e19f6c2b8 100644
--- a/drivers/pci/tsm/core.c
+++ b/drivers/pci/tsm/core.c
@@ -9,6 +9,7 @@
 #define dev_fmt(fmt) "PCI/TSM: " fmt
 
 #include <linux/bitfield.h>
+#include <linux/ioport.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/pci-tsm.h>
@@ -58,6 +59,26 @@ static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *tsm)
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
@@ -531,6 +552,125 @@ static ssize_t dsm_show(struct device *dev, struct device_attribute *attr,
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
@@ -556,6 +696,13 @@ static bool pci_tsm_link_group_visible(struct kobject *kobj)
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
@@ -587,12 +734,19 @@ static umode_t pci_tsm_attr_visible(struct kobject *kobj,
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
 
@@ -601,6 +755,8 @@ static struct attribute *pci_tsm_attrs[] = {
 	&dev_attr_disconnect.attr,
 	&dev_attr_bound.attr,
 	&dev_attr_dsm.attr,
+	&dev_attr_lock.attr,
+	&dev_attr_unlock.attr,
 	NULL
 };
 
@@ -729,6 +885,29 @@ int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
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
@@ -756,6 +935,13 @@ void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *pf0_tsm)
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
@@ -777,8 +963,10 @@ int pci_tsm_register(struct tsm_dev *tsm_dev)
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
@@ -813,6 +1001,9 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
 	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev) && !pci_tsm_link_count)
 		link_sysfs_disable(pdev);
 
+	if (is_devsec_tsm(tsm_dev) && !pci_tsm_devsec_count)
+		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
+
 	/* Nothing else to do if this device never attached to the departing TSM */
 	if (!tsm)
 		return;
@@ -823,10 +1014,18 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
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
index e784993353d8..8e298bda10fc 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -9,10 +9,50 @@
 #include <linux/cleanup.h>
 #include <linux/pci-tsm.h>
 
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
 static void tsm_release(struct device *);
 static const struct class tsm_class = {
 	.name		= "tsm",
-	.dev_release	= tsm_release
+	.dev_release	= tsm_release,
+	.dev_groups	= tsm_pci_groups,
 };
 static DEFINE_IDA(tsm_ida);
 
@@ -72,6 +112,7 @@ static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
 		device_unregister(&tsm_dev->dev);
 		return ERR_PTR(rc);
 	}
+	sysfs_update_group(&tsm_dev->dev.kobj, &tsm_pci_group);
 
 	/* Notify TSM userspace that PCI/TSM operations are now possible */
 	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
-- 
2.54.0

