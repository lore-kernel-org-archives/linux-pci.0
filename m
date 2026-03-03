Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C80318E025
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496062; cv=none; b=UepcmFdPcpt9+8D28ch3/8aj+0c1iDO/a/V7mQtCllWcNm2VeUmOmOjYqLBmZ7Yigrrmnpsp1rIE02YY8tXwBqaLvJySK7zIa2j6lAh0l70jI9ZDYGeHI3+nvHhFvhIgzb/MTZ6dLL/LVS5OP9DczJw8QWVulY7K+IqofHGnwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496062; c=relaxed/simple;
	bh=DaAZtQbbrtkEUuEADfJ9RFEp4ZxjDMbq0PfdFo++k9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bqcl4fD1xxJqnyFXuyHWqf1+dQTy0mrf54LdH3Pp2uVUGtN6m/oRcmh8DxOrURBIbEDtTl7zNPlk87xS9YM/bzuXmqYm9tKk6dhjoORuNOhRyzfC+fsaRBvCfdOH4mBB/LKuyQDHB+96gTP1y3iCGEBHmmEtLIDyxft4qzTWxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c49+X58j; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c49+X58j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496061; x=1804032061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DaAZtQbbrtkEUuEADfJ9RFEp4ZxjDMbq0PfdFo++k9s=;
  b=c49+X58jMz77b0GwTzpC+JJirVHz4qAr+AZxjh5+DMWimA8xM8YS/Hmj
   yVLU6WssMWJGELbExRB6iE4WXwtekIOA9d+uA3O1YVi9cNkXsAxJlB8J9
   hIHcoqjeQ56e/6MFFxBCxI+cdZNYHKyGqZPwXk4+1eVHAzLr/8LS4QoRj
   yFaYewgf8Ak32fwQcZW46ZleBYKe0dctdkG5hrduCnoCQJjYCzFwQFBdg
   3XiVkqeEmNvJUg+Ymm9O8AgZF8W5QjPErIQf45ZL5FCl8tjgTDBTH8Vyh
   lF0O6JzvklxOwxz2tzcjS3V319VFnRvVZZqwIGt6TeDMpOI/C4dqjFrcq
   w==;
X-CSE-ConnectionGUID: eX0DrgHjQSi4zrE3mv6WDg==
X-CSE-MsgGUID: qnFR2jE1QFGQDnWnHN4VUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73482906"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73482906"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:00:56 -0800
X-CSE-ConnectionGUID: 0DQ7/9P7QCuoJH2oSracoA==
X-CSE-MsgGUID: mmvdxzkfR1ytQ/beTG5vkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="214967095"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2026 16:00:56 -0800
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
Subject: [PATCH v2 07/19] PCI/TSM: Add Device Security (TVM Guest) ACCEPT operation support
Date: Mon,  2 Mar 2026 16:01:55 -0800
Message-ID: <20260303000207.1836586-8-dan.j.williams@intel.com>
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

The final operation of the PCIe Trusted Execution Environment (TEE) Device
Interface Security Protocol (TDISP) is asking the TEE Security Manager
(TEE) to enable private DMA and MMIO.

The story so far in the security lifecycle of the device is that the VMM
setup an SPDM session and link encryption with the device's physical
function0. The VMM then assigned either that physical function or other
virtual function of that device to a VM. The VM asked the TSM to transition
the device from TDISP UNLOCKED->LOCKED. With the device LOCKED the VM
validated signed fresh device evidence and expected MMIO mappings.

The VM now accepts the device to transition it from LOCKED to RUN and tell
the TSM to unblock DMA to VM private memory.

Implement a sysfs trigger to flip the device to private operation and plumb
that to a 'struct pci_tsm_ops::accept()' operation.

Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/Kconfig                     |  2 +
 Documentation/ABI/testing/sysfs-bus-pci | 13 +++++
 include/linux/pci-tsm.h                 |  7 ++-
 drivers/pci/tsm.c                       | 69 ++++++++++++++++++++++++-
 4 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index e3f848ffb52a..c45c6b978e1d 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -127,6 +127,8 @@ config PCI_IDE
 
 config PCI_TSM
 	bool "PCI TSM: Device security protocol support"
+	depends on ARCH_HAS_CC_PLATFORM
+	select CONFIDENTIAL_DEVICES
 	select PCI_IDE
 	select PCI_DOE
 	select TSM
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
index 2a896b83bff9..176d214cd0da 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -66,15 +66,18 @@ struct pci_tsm_ops {
 	 *	  pci_tsm') for follow-on security state transitions from the
 	 *	  LOCKED state
 	 * @unlock: destroy TSM context and return device to UNLOCKED state
+	 * @accept: accept a locked TDI for use, move it to RUN state
 	 *
 	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
-	 * sync with TSM unregistration and each other. All operations run under
-	 * the device lock for mutual exclusion with driver attach and detach.
+	 * sync with TSM unregistration and each other. @accept runs under
+	 * pci_tsm_rwsem held for read. All operations run under the device lock
+	 * for mutual exclusion with driver attach and detach.
 	 */
 	struct_group_tagged(pci_tsm_devsec_ops, devsec_ops,
 		struct pci_tsm *(*lock)(struct tsm_dev *tsm_dev,
 					struct pci_dev *pdev);
 		void (*unlock)(struct pci_tsm *tsm);
+		int (*accept)(struct pci_dev *pdev);
 	);
 };
 
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 259e75092618..aa93a59d2720 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -557,6 +557,71 @@ static ssize_t dsm_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(dsm);
 
+/**
+ * pci_tsm_accept() - accept a device for private MMIO+DMA operation
+ * @pdev: PCI device to accept
+ *
+ * "Accept" transitions a device to the run state, it is only suitable to make
+ * that transition from a known DMA-idle (no active mappings) state. The "driver
+ * detached" state is a coarse way to assert that requirement.
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
+	rc = to_pci_tsm_ops(pdev->tsm)->accept(pdev);
+	if (rc)
+		return rc;
+
+	return device_cc_accept(&pdev->dev);
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
+	return sysfs_emit(buf, "%d\n", device_cc_accepted(dev));
+}
+static DEVICE_ATTR_RW(accept);
+
 /**
  * pci_tsm_unlock() - Transition TDI from LOCKED/RUN to UNLOCKED
  * @pdev: TDI device to unlock
@@ -740,7 +805,8 @@ static umode_t pci_tsm_attr_visible(struct kobject *kobj,
 	}
 
 	if (pci_tsm_devsec_group_visible(kobj)) {
-		if (attr == &dev_attr_lock.attr ||
+		if (attr == &dev_attr_accept.attr ||
+		    attr == &dev_attr_lock.attr ||
 		    attr == &dev_attr_unlock.attr)
 			return attr->mode;
 	}
@@ -760,6 +826,7 @@ static struct attribute *pci_tsm_attrs[] = {
 	&dev_attr_disconnect.attr,
 	&dev_attr_bound.attr,
 	&dev_attr_dsm.attr,
+	&dev_attr_accept.attr,
 	&dev_attr_lock.attr,
 	&dev_attr_unlock.attr,
 	NULL
-- 
2.52.0

