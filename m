Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D76360EC0
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289319; cv=none; b=qL4KikF6S+Oa4HefgyPxKF1k+B4S9ryxhaHrn/WLRoZyrkh31pPjjhw6LuyjWkrL0TiyCWUMpy/oAUT941P+cCzxRC1S7xqif4O3AdmyQAGRPp09of6eVQn5WlBmWvL6fUUiW1MCg5ulmkiwwlQniHCG197MmUxTAXGCZoMbxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289319; c=relaxed/simple;
	bh=MJeGUpoKxH6gurr8J3uanuKpvHICha9PE0rA6V3whqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C52hSG56cbopthJ+2RzL1nxH5MlW2pNJGE8T8QrVTot7asTvWmyLYBv83P6ZoV3/vNR049ysVPYNzzEAF3cxqkMVTwOt6wUFkdvDfdEJkRWO9VfhfRQZRmHW14Kb7fWu8A8vFwVileT/T0LerdphdyvvwJeD4r/09AU0kzYT+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrSR3tv9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrSR3tv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10F41F00AC4;
	Sun,  5 Jul 2026 22:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289318;
	bh=IAzd7BRV2s9fz6KrhGvKz7eiqQ1HLo7ctwozuw58OCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PrSR3tv9/lW2ndiLtVaMmisa5Lynsc1+Qbmr+bJJ8yEv2CI6lFgir1FvMJzlxvPL9
	 bXeRfzGfX7PoXzvh1b4K+Ydz9fYVybuNqiYtH9qUEvyH68Vm2kMrdEi6nANUmgY96y
	 syPAT4fEC7iIy0yNYh0VmG2lLiPONZV2I4Bvtqe+TDSrbKulhRhzm2pHOWb5PgqxWO
	 +U74PUaU9uEHwx8949bN3Lh9T4IJzBi8oA9XjwnqHVKXOwW6xwRyZFvOrEAt91vGRW
	 9HyJXpmqC6yRSo7KWDijl5+A3vhQF3jNm3II9Eo+wZtJ0D0oTFJnOBmtw7Wbg8AWdP
	 C66aL/odp1Elg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 39E16F40068;
	Sun,  5 Jul 2026 18:08:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 05 Jul 2026 18:08:37 -0400
X-ME-Sender: <xms:5dVKauRaPV4_OJPfSQrhGCerZZZ7ZcwXM1Q4HhBCpXzHxtQprbSfZg>
    <xme:5dVKamVrrPSNu_-LAINP1QJkZP6KAA3pzCtsA-YPvWy9PhDtsfpz-RPelpciL9WZ4
    pKowgQuiZm3XLRQL6XHWrKGx4-YdMKlKltU6HSPdwzROoe8kTN5Zqs>
X-ME-Received: <xmr:5dVKavdMIDRS7paHy-Qb1aYhGJr6Cg1TWr8g9-QpA5o82yj_hSzMt4n_MmTWJC4-fSuitm79k_TmN0Sp7LmoJQfM1ILr13IsHoA>
X-ME-Proxy-Cause: dmFkZTG0CP0dZmdNcV8rsEn3S06MMs4XQ44MiZG4ZCs2XrFV7lXiuhlneABQQTaICxUcMc
    P+1ODA6MGYz0784hsjgTsV05YmgkywfdQoOlfLicxDKeBGB4PrMhmwEUg4VUNYGlIkLxnH
    8Vz49Kgo4ToQVoSAwCeEtDa3/OHzdnSDqWKev24jjGCmj5kHJaMOz9p5kq1uJzUfimZzDj
    ctFoZtMPMLl03YRBfuxxVu6nPXCwDvd5MZ7lgUYxfFIoqbJvDommu29T6zUJ0gRL7R01wX
    hVM5p5fOjqHaQ+xgr+tqvmWjcWIkq4/M5uivhsXs6QdfVAn+ffoPhIr1SLFEBgaVyEHHOf
    Ri1rU8OD2b7GhO5W6H8NEQqgGhWefy8VD2k4Y+t0AkiotjIYKmswGoENdUHOq2TXGtU+x+
    uIldhpQzIwRWsjScat6bt2uZVT4Q2wzRu/hid/qkFzBHNHcMG+0C4bOMju6Ks0OO1YY3OZ
    ShjidSWpysDxPWLKmjp692sn9GCI69WNDS/pZkO9Z5Zw1OWEUFpwnAlt1Q+gF0X3GdgkWB
    bpgTGkkFK94M72tajeHBVaaoHBoTbbYCjM8nI860ufC5WkP2bgITqV+NVo2goAuDqMf44X
    x4YXZxuxs/s/SNdFnbSnEy4InLI4gXis7xhziECalupCOh31LYuyxGrEV0qA
X-ME-Proxy: <xmx:5dVKaqJkJ2qNGAC0UoLshbCu4xyvrVHDEwOZiNi32U-CHEvnwSqtZw>
    <xmx:5dVKasyUB1qGyBh_JCJtVlSl65CFeLVSySzsBtIVMtG97Rbn908WQw>
    <xmx:5dVKagtZm0pNWZm5Ta5JIWK3ZFKbi02NPk_HF6XcZ1gcLpxrk74Uqg>
    <xmx:5dVKavDHT7-wjVMWChyo_9BuGIokDLsCs0C_ylhEVpv0awcqS-k3sA>
    <xmx:5dVKaiGopQuOgqvNtjJqift10HdXxxFeTuodSv_bUAQCaTpBA3MGd5BB>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:08:36 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH 11/15] PCI/TSM: Add device interface security RUN support
Date: Sun,  5 Jul 2026 15:08:15 -0700
Message-ID: <20260705220819.2472765-12-djbw@kernel.org>
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

The final device-side operation of the PCIe Trusted Execution Environment
(TEE) Device Interface Security Protocol (TDISP) state machine is to ask
the TSM to flip the device from LOCKED to RUN.

The story so far in the security lifecycle of the device is that the VMM
setup an SPDM session and link encryption with the device's physical
function0. The VMM then assigned either that physical function or other
virtual function of that device to a VM. The VM asked the TSM to transition
the device from TDISP UNLOCKED->LOCKED. With the device LOCKED the VM is
enabled to validate signed fresh evidence of the device's configuration and
expected MMIO mappings.

The VM now accepts the device to transition it from LOCKED to RUN.

Implement a sysfs trigger to flip the device to private operation and plumb
that to a 'struct pci_tsm_ops::run()' operation.

Note that the RUN state only allows the device to be accessed via private
MMIO. DMA enable is a separate step triggered at pci_dma_configure() time.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-pci | 13 ++++
 include/linux/pci-tsm.h                 | 12 +++-
 drivers/pci/tsm/core.c                  | 89 ++++++++++++++++++++++++-
 3 files changed, 110 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 1ed77b9402a6..c2a5c4fe9373 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -732,3 +732,16 @@ Description:
 		'lock' to teardown the connection. Writes fail with EBUSY if
 		this device is bound to a driver. This is a "devsec" TSM
 		attribute, see Documentation/ABI/testing/sysfs-class-tsm.
+
+What:		/sys/bus/pci/devices/.../tsm/accept
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RW) Write "1" (or any boolean "true" string) to this file to
+		request that TSM transition the device from the TDISP LOCKED
+		state to the RUN state and arrange the for the secure IOMMU to
+		accept requests with T=1 in the PCIe packet header (TLP)
+		targeting private memory. Per TDISP the only exits from the RUN
+		state are via an explicit unlock request or an event that
+		transitions the device to the ERROR state. Writes fail with
+		EBUSY if this device is bound to a driver. This is a "devsec"
+		TSM attribute, see Documentation/ABI/testing/sysfs-class-tsm.
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 326471f1e01a..371a7e300a64 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -70,15 +70,18 @@ struct pci_tsm_ops {
 	 *	  pci_tsm') for follow-on security state transitions from the
 	 *	  LOCKED state
 	 * @unlock: destroy TSM context and return device to UNLOCKED state
+	 * @run: Move a device to the RUN state / prepare to enable DMA
 	 *
 	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
-	 * sync with TSM unregistration and each other. All operations run under
-	 * the device lock for mutual exclusion with driver attach and detach.
+	 * sync with TSM unregistration and each other. @run runs under
+	 * pci_tsm_rwsem held for read. All operations run under the device lock
+	 * for mutual exclusion with driver attach and detach.
 	 */
 	struct_group_tagged(pci_tsm_devsec_ops, devsec_ops,
 		struct pci_tsm *(*lock)(struct tsm_dev *tsm_dev,
 					struct pci_dev *pdev);
 		void (*unlock)(struct pci_tsm *tsm);
+		int (*run)(struct pci_dev *pdev);
 	);
 
 	int (*refresh_evidence)(struct pci_tsm *tsm, const void *nonce,
@@ -97,6 +100,9 @@ struct pci_tdi {
 	u32 tdi_id;
 };
 
+/* Private operation acknowledged, future ioremap will use private alias */
+#define PCI_TSM_F_ACCEPT (1UL << 0)
+
 /**
  * struct pci_tsm - Core TSM context for a given PCIe endpoint
  * @pdev: Back ref to device function, distinguishes type of pci_tsm context
@@ -104,6 +110,7 @@ struct pci_tdi {
  * @tsm_dev: PCI TEE Security Manager device for Link Confidentiality or Device
  *	     Function Security operations
  * @tdi: TDI context established by the @bind link operation
+ * @flags: Convey TDISP availabilty and / or state
  * @evidence: cached evidence from SPDM session establishment (connect), or
  *	      TDISP bind (lock)
  *
@@ -130,6 +137,7 @@ struct pci_tsm {
 	struct tsm_dev *tsm_dev;
 	struct pci_tdi *tdi;
 	struct device_evidence *evidence;
+	unsigned long flags;
 };
 
 /**
diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
index 590e19f6c2b8..1f09ab4e8d4c 100644
--- a/drivers/pci/tsm/core.c
+++ b/drivers/pci/tsm/core.c
@@ -552,6 +552,89 @@ static ssize_t dsm_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(dsm);
 
+/**
+ * pci_tsm_accept() - accept a device for private MMIO operation
+ * @pdev: PCI device to accept
+ *
+ * "Accept" transitions the device interface to the RUN state, it is
+ * only suitable to make that transition from a known idle (no active
+ * DMA / MMIO mappings) state. The "driver detached" state is a coarse
+ * way to assert that requirement.
+ */
+static int pci_tsm_accept(struct pci_dev *pdev)
+{
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
+		return rc;
+
+	if (!pdev->tsm)
+		return -EINVAL;
+
+	ACQUIRE(device_intr, dev_lock)(&pdev->dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &dev_lock)))
+		return rc;
+
+	if (pdev->dev.driver)
+		return -EBUSY;
+
+	if (test_bit(PCI_TSM_F_ACCEPT, &pdev->tsm->flags))
+		return 0;
+
+	rc = to_pci_tsm_ops(pdev->tsm)->run(pdev);
+	if (rc)
+		return rc;
+
+	set_bit(PCI_TSM_F_ACCEPT, &pdev->tsm->flags);
+
+	return 0;
+}
+
+static ssize_t accept_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	bool accept;
+	int rc;
+
+	rc = kstrtobool(buf, &accept);
+	if (rc)
+		return rc;
+
+	/*
+	 * TDISP can only go from RUN to UNLOCKED/ERROR, so there is no
+	 * 'unaccept' verb.
+	 */
+	if (!accept)
+		return -EINVAL;
+
+	rc = pci_tsm_accept(pdev);
+	if (rc)
+		return rc;
+
+	return len;
+}
+
+static ssize_t accept_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	bool accept = false;
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
+		return rc;
+
+	/* Unlocked == Unaccepted */
+	if (pdev->tsm)
+		accept = test_bit(PCI_TSM_F_ACCEPT, &pdev->tsm->flags);
+
+	return sysfs_emit(buf, "%d\n", accept);
+}
+static DEVICE_ATTR_RW(accept);
+
 /**
  * pci_tsm_unlock() - Transition TDI from LOCKED/RUN to UNLOCKED
  * @pdev: TDI device to unlock
@@ -568,9 +651,9 @@ static void pci_tsm_unlock(struct pci_dev *pdev)
 			  "unlock attempted on driver attached device\n"))
 		return;
 
-	device_cc_reject(&pdev->dev);
 	to_pci_tsm_ops(pdev->tsm)->unlock(pdev->tsm);
 	pdev->tsm = NULL;
+	/* implicit clear of PCI_TSM_F_ACCEPT */
 }
 
 static int pci_tsm_lock(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
@@ -735,7 +818,8 @@ static umode_t pci_tsm_attr_visible(struct kobject *kobj,
 	}
 
 	if (pci_tsm_devsec_group_visible(kobj)) {
-		if (attr == &dev_attr_lock.attr ||
+		if (attr == &dev_attr_accept.attr ||
+		    attr == &dev_attr_lock.attr ||
 		    attr == &dev_attr_unlock.attr)
 			return attr->mode;
 	}
@@ -755,6 +839,7 @@ static struct attribute *pci_tsm_attrs[] = {
 	&dev_attr_disconnect.attr,
 	&dev_attr_bound.attr,
 	&dev_attr_dsm.attr,
+	&dev_attr_accept.attr,
 	&dev_attr_lock.attr,
 	&dev_attr_unlock.attr,
 	NULL
-- 
2.54.0

