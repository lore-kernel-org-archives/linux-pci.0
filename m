Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8035BDC9
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496060; cv=none; b=sn74nTQybz0kndueSTpzJdoi8zlEysb5+dWGzDGUf/N8SiQG3FD61ercsclDBhENtCFIahnyv0vj6hCoBxkzSZZbCO+BcBncqks18Zw8xbaMioLJKFiMwMa5rzpnvbJMd4c+GijwxLNmxcNVn3KjJYeqrVeFHzKOoDpQm8ZFPCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496060; c=relaxed/simple;
	bh=ifx2EivxwUhEGldst3SF4CM2HJ8L7fTvgnozA0DKSYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcRSnM8Cqgg7UgUSjnSMdGFS77wHtRH79Pg66HgW83goUgoaIEqz9/AvEHP2yCcDLRIFjnc2nIedOMCjR/bFPnJb9PnJCqIMdGE9Rn915LWqe4DwsbTfWyBR+uL55DupR9kR9FYdT51rWkd7sg3xcQalAgQwNuPm2BVHH6gvM7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbMpkiq9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbMpkiq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496057; x=1804032057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ifx2EivxwUhEGldst3SF4CM2HJ8L7fTvgnozA0DKSYI=;
  b=SbMpkiq97E2ZDbI4jmnRPatcqCNjoF4Dpt0BUsmiBLmNXIG9E6/5nYbS
   KQLrqSxtmbL6kp0dtU/zM6mepFGbyw4iQq6J4uiiidkzWstTBAfaGNkS1
   b0TXg70HqkyAXtogLsX2x7o7hAhC74miXXu5Mxt3Qbv5iC6LtPeerIgjH
   M3A7iHeIwCCxtd6j9Bfk0NtbubpYzIe6E2xOgeFgeJjfNrZACE/6UjPcw
   GK1eagQAajOLWMdtZQDOYg2KUiKAFEKlXkRnVc9b6tRArr2rxCGQKAKxA
   eo4zEy2V2fL3RLGJuExCrYYy9DiRaVzlRKad4WW3uOx1DJM6k6pjuT8PD
   g==;
X-CSE-ConnectionGUID: f7P9QOffStCsb+dtVwIXGA==
X-CSE-MsgGUID: UcQe9CzqRNKDB7fbVqbK6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73482852"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73482852"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:00:55 -0800
X-CSE-ConnectionGUID: KjOjtmIpTeic39zk/dMJsg==
X-CSE-MsgGUID: w+O4MCgdSa6VQCCbafn/YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="214967079"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2026 16:00:54 -0800
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
	jgg@nvidia.com,
	Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 03/19] device core: Introduce confidential device acceptance
Date: Mon,  2 Mar 2026 16:01:51 -0800
Message-ID: <20260303000207.1836586-4-dan.j.williams@intel.com>
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

An "accepted" device is one that is allowed to access private memory within
a Trusted Computing Boundary (TCB). The concept of "acceptance" is distinct
from other device properties like usb_device::authorized, or
tb_switch::authorized. The entry to the accepted state is a violent
operation in which the device will reject MMIO requests that are not
encrypted, and the device enters a new IOMMU protection domain to allow it
to access addresses that were previously off-limits.

Subsystems like the DMA mapping layer, that need to modify their behavior
based on the accept state, may only have access to the base 'struct
device'. It is also likely that the concept of TCB acceptance grows beyond
PCI devices over time. For these reasons, introduce the concept of
acceptance in 'struct device_private' which is device common, but only
suitable for buses and built-in infrastructure to consume.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Roman Kisel <romank@linux.microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/Kconfig   |  4 +++
 drivers/base/Makefile  |  1 +
 drivers/base/base.h    |  9 +++++++
 include/linux/device.h | 22 ++++++++++++++++
 drivers/base/coco.c    | 58 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 94 insertions(+)
 create mode 100644 drivers/base/coco.c

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 1786d87b29e2..d4743bf978ec 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -249,4 +249,8 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
 	  command line option on every system/board your kernel is expected to
 	  work on.
 
+config CONFIDENTIAL_DEVICES
+	depends on ARCH_HAS_CC_PLATFORM
+	bool
+
 endmenu
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 8074a10183dc..e11052cd5253 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_GENERIC_MSI_IRQ) += platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
 obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
 obj-$(CONFIG_ACPI) += physical_location.o
+obj-$(CONFIG_CONFIDENTIAL_DEVICES) += coco.o
 
 obj-y			+= test/
 
diff --git a/drivers/base/base.h b/drivers/base/base.h
index b68355f5d6e3..1ae9a1679504 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -119,8 +119,13 @@ struct driver_type {
  * @dead: This device is currently either in the process of or has been
  *	  removed from the system. Any asynchronous events scheduled for this
  *	  device should exit without taking any action.
+ * @cc_accepted: track the TEE acceptance state of the device for deferred
+ *		 probing, MMIO mapping type, and SWIOTLB bypass for private memory DMA.
  *
  * Nothing outside of the driver core should ever touch these fields.
+ *
+ * All bitfield flags are manipulated under device_lock() to avoid
+ * read-modify-write collisions.
  */
 struct device_private {
 	struct klist klist_children;
@@ -136,6 +141,10 @@ struct device_private {
 	struct driver_type driver_type;
 #endif
 	u8 dead:1;
+#ifdef CONFIG_CONFIDENTIAL_DEVICES
+	u8 cc_accepted:1;
+#endif
+
 };
 #define to_device_private_parent(obj)	\
 	container_of(obj, struct device_private, knode_parent)
diff --git a/include/linux/device.h b/include/linux/device.h
index 0be95294b6e6..4470365d772b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1191,6 +1191,28 @@ static inline bool device_link_test(const struct device_link *link, u32 flags)
 	return !!(link->flags & flags);
 }
 
+/* Confidential Device state helpers */
+#ifdef CONFIG_CONFIDENTIAL_DEVICES
+int device_cc_accept(struct device *dev);
+int device_cc_reject(struct device *dev);
+bool device_cc_accepted(struct device *dev);
+#else
+static inline int device_cc_accept(struct device *dev)
+{
+	lockdep_assert_held(&dev->mutex);
+	return 0;
+}
+static inline int device_cc_reject(struct device *dev)
+{
+	lockdep_assert_held(&dev->mutex);
+	return 0;
+}
+static inline bool device_cc_accepted(struct device *dev)
+{
+	return false;
+}
+#endif /* CONFIG_CONFIDENTIAL_DEVICES */
+
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
diff --git a/drivers/base/coco.c b/drivers/base/coco.c
new file mode 100644
index 000000000000..2589745530e3
--- /dev/null
+++ b/drivers/base/coco.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Intel Corporation */
+#include <linux/device.h>
+#include <linux/lockdep.h>
+#include "base.h"
+
+/*
+ * Confidential devices implement encrypted + integrity protected MMIO and have
+ * the ability to issue DMA to encrypted + integrity protected System RAM
+ * (private memory). The device_cc_*() helpers aid buses in setting the
+ * acceptance state and the DMA mapping subsystem augmenting behavior in the
+ * presence of accepted devices.
+ */
+
+/**
+ * device_cc_accept(): Mark a device as able to access private memory
+ * @dev: device to accept
+ *
+ * Confidential bus drivers use this helper to accept devices. For example, PCI
+ * has a sysfs ABI to accept devices after relying party attestation.
+ *
+ * Given that moving a device into confidential / private operation implicates
+ * changes to MMIO mapping attributes and DMA mappings, the transition must be
+ * done while the device is idle (driver detached).
+ */
+int device_cc_accept(struct device *dev)
+{
+	lockdep_assert_held(&dev->mutex);
+
+	if (dev->driver)
+		return -EBUSY;
+	dev->p->cc_accepted = 1;
+
+	return 0;
+}
+
+int device_cc_reject(struct device *dev)
+{
+	lockdep_assert_held(&dev->mutex);
+
+	if (dev->driver)
+		return -EBUSY;
+	dev->p->cc_accepted = 0;
+
+	return 0;
+}
+
+/**
+ * device_cc_accepted(): Fetch the device's ability to access private memory
+ * @dev: device to check
+ *
+ * Mechanisms like swiotlb and dma_alloc() need to augment their behavior in the
+ * presence of accepted devices.
+ */
+bool device_cc_accepted(struct device *dev)
+{
+	return dev->p->cc_accepted;
+}
-- 
2.52.0

