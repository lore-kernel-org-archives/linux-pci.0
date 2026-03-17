Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FFA3F788F;
	Tue, 17 Mar 2026 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788965; cv=none; b=k3SzC4oPsgqPNSvvtHq/8cWEgG8MvIfN+5KfjA/cmB/PJYlpCW5LBc0OFH1nIQTD8dF7oZT3jfxLC8M+U+9gCV7DlKhM4dpvwxuTsSy4o1O7TkIlX+XdVOGrHxp16JfOqQpjllgXwZohkoez6KwAFJKatb1guyL55Ip/jvLo0qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788965; c=relaxed/simple;
	bh=6zqtt7nPxZCdqRlVG9jKtF9aaYGKpqPjqA2V84t2WmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNAJvPP2tFlMb9wYoEHdyBnLJnYjzfP3gN5qqlN60USp/FhM4MRS8ojmSIo16HWNxREhp2xxYPPJgAKwt9q0V0d8PZ1E4xI+pG4hnDD96kskHcggWWwrHYwiN3InOacKMLnJ+A91j2R4KrvQzRyPb+hoKN0PFL6E7tBziqNt1FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c26ELl6e; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c26ELl6e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773788963; x=1805324963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6zqtt7nPxZCdqRlVG9jKtF9aaYGKpqPjqA2V84t2WmU=;
  b=c26ELl6errukagZbDGV53A/wvxQ+z7L+x3RbuBi2WQIzlUiDyrlpKtxP
   wH7BSLYyYRQFQ5kdIaB53pEAR2bm7qefWPDnGOjWsS07SdsJ04X7Nl1dg
   QasZGlAioVUo6PEkMS4md0eIXlD/nRpvUvHQ4NOqi/FyOfNyYcb00ipAY
   WVOXivUa9kEjN5eH17s3Q3RwEsFuwqVY0gEns4ITuxynixpw6fGXMWOow
   Fez2Rb7YrcoZKNVK3xLulSqHtOshy3QXbZ6Kll5ht6qmfQiEtUnRFFlSe
   8pnr/3Ik5u5NUznD4y4UK57A5rlqC0wzWakGJyiCCVMw3X8p/J1E9GKf9
   w==;
X-CSE-ConnectionGUID: NS6XbcCZQJeWB1tbi3q95w==
X-CSE-MsgGUID: fY2EAkmhQ2mUqmEwfkGTPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74811591"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74811591"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 16:09:21 -0700
X-CSE-ConnectionGUID: K0hNjz6GSPmr0IuyyMDp1Q==
X-CSE-MsgGUID: Vcz7tzfkRuKpO5MtcAl+Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="226566380"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 17 Mar 2026 16:09:20 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Phani R Burra <phani.r.burra@intel.com>,
	anthony.l.nguyen@intel.com,
	larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	anjali.singhai@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	natalia.wochtman@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	linux-doc@vger.kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Bharath R <bharath.r@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 03/15] libie: add PCI device initialization helpers to libie
Date: Tue, 17 Mar 2026 16:08:51 -0700
Message-ID: <20260317230905.847744-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260317230905.847744-1-anthony.l.nguyen@intel.com>
References: <20260317230905.847744-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phani R Burra <phani.r.burra@intel.com>

Add memory related support functions for drivers to access MMIO space and
allocate/free dma buffers.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
Co-developed-by: Victor Raj <victor.raj@intel.com>
Signed-off-by: Victor Raj <victor.raj@intel.com>
Co-developed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Bharath R <bharath.r@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libie/Kconfig  |   6 +
 drivers/net/ethernet/intel/libie/Makefile |   4 +
 drivers/net/ethernet/intel/libie/pci.c    | 190 ++++++++++++++++++++++
 include/linux/intel/libie/pci.h           |  56 +++++++
 4 files changed, 256 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/libie/pci.c
 create mode 100644 include/linux/intel/libie/pci.h

diff --git a/drivers/net/ethernet/intel/libie/Kconfig b/drivers/net/ethernet/intel/libie/Kconfig
index 70831c7e336e..500a95c944a8 100644
--- a/drivers/net/ethernet/intel/libie/Kconfig
+++ b/drivers/net/ethernet/intel/libie/Kconfig
@@ -23,3 +23,9 @@ config LIBIE_FWLOG
 	  for it. Firmware logging is using admin queue interface to communicate
 	  with the device. Debugfs is a user interface used to config logging
 	  and dump all collected logs.
+
+config LIBIE_PCI
+	tristate
+	help
+	  Helper functions for management of PCI resources belonging
+	  to networking devices.
diff --git a/drivers/net/ethernet/intel/libie/Makefile b/drivers/net/ethernet/intel/libie/Makefile
index db57fc6780ea..a28509cb9086 100644
--- a/drivers/net/ethernet/intel/libie/Makefile
+++ b/drivers/net/ethernet/intel/libie/Makefile
@@ -12,3 +12,7 @@ libie_adminq-y			:= adminq.o
 obj-$(CONFIG_LIBIE_FWLOG) 	+= libie_fwlog.o
 
 libie_fwlog-y			:= fwlog.o
+
+obj-$(CONFIG_LIBIE_PCI)		+= libie_pci.o
+
+libie_pci-y			:= pci.o
diff --git a/drivers/net/ethernet/intel/libie/pci.c b/drivers/net/ethernet/intel/libie/pci.c
new file mode 100644
index 000000000000..834e1f25e99e
--- /dev/null
+++ b/drivers/net/ethernet/intel/libie/pci.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include <linux/intel/libie/pci.h>
+
+/**
+ * libie_find_mmio_region - find if MMIO region is present in the list
+ * @mmio_list: list that contains MMIO region info
+ * @offset: MMIO region start offset
+ * @bar_idx: BAR index where the offset to search
+ *
+ * Return: MMIO region pointer or NULL if the region info is not present.
+ */
+static struct libie_pci_mmio_region *
+libie_find_mmio_region(const struct list_head *mmio_list,
+		       resource_size_t offset, int bar_idx)
+{
+	struct libie_pci_mmio_region *mr;
+
+	list_for_each_entry(mr, mmio_list, list)
+		if (mr->bar_idx == bar_idx && mr->offset == offset)
+			return mr;
+
+	return NULL;
+}
+
+/**
+ * __libie_pci_get_mmio_addr - get the MMIO virtual address
+ * @mmio_info: contains list of MMIO regions
+ * @offset: register offset to find
+ * @num_args: number of additional arguments present
+ *
+ * This function finds the virtual address of a register offset by iterating
+ * through the non-linear MMIO regions that are mapped by the driver.
+ *
+ * Return: valid MMIO virtual address or NULL.
+ */
+void __iomem *__libie_pci_get_mmio_addr(struct libie_mmio_info *mmio_info,
+					resource_size_t offset,
+					int num_args, ...)
+{
+	struct libie_pci_mmio_region *mr;
+	int bar_idx = 0;
+	va_list args;
+
+	if (num_args) {
+		va_start(args, num_args);
+		bar_idx = va_arg(args, int);
+		va_end(args);
+	}
+
+	list_for_each_entry(mr, &mmio_info->mmio_list, list)
+		if (bar_idx == mr->bar_idx && offset >= mr->offset &&
+		    offset < mr->offset + mr->size) {
+			offset -= mr->offset;
+
+			return mr->addr + offset;
+		}
+
+	return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(__libie_pci_get_mmio_addr, "LIBIE_PCI");
+
+/**
+ * __libie_pci_map_mmio_region - map PCI device MMIO region
+ * @mmio_info: struct to store the mapped MMIO region
+ * @offset: MMIO region start offset
+ * @size: MMIO region size
+ * @num_args: number of additional arguments present
+ *
+ * Return: true on success, false on memory map failure.
+ */
+bool __libie_pci_map_mmio_region(struct libie_mmio_info *mmio_info,
+				 resource_size_t offset,
+				 resource_size_t size, int num_args, ...)
+{
+	struct pci_dev *pdev = mmio_info->pdev;
+	struct libie_pci_mmio_region *mr;
+	resource_size_t pa;
+	void __iomem *va;
+	int bar_idx = 0;
+	va_list args;
+
+	if (num_args) {
+		va_start(args, num_args);
+		bar_idx = va_arg(args, int);
+		va_end(args);
+	}
+
+	mr = libie_find_mmio_region(&mmio_info->mmio_list, offset, bar_idx);
+	if (mr) {
+		pci_warn(pdev, "Mapping of BAR%u with offset %llu already exists\n",
+			 bar_idx, (unsigned long long)offset);
+		return true;
+	}
+
+	pa = pci_resource_start(pdev, bar_idx) + offset;
+	va = ioremap(pa, size);
+	if (!va) {
+		pci_err(pdev, "Failed to map BAR%u region\n", bar_idx);
+		return false;
+	}
+
+	mr = kvzalloc_obj(*mr);
+	if (!mr) {
+		iounmap(va);
+		return false;
+	}
+
+	mr->addr = va;
+	mr->offset = offset;
+	mr->size = size;
+	mr->bar_idx = bar_idx;
+
+	list_add_tail(&mr->list, &mmio_info->mmio_list);
+
+	return true;
+}
+EXPORT_SYMBOL_NS_GPL(__libie_pci_map_mmio_region, "LIBIE_PCI");
+
+/**
+ * libie_pci_unmap_fltr_regs - unmap selected PCI device MMIO regions
+ * @mmio_info: contains list of MMIO regions to unmap
+ * @fltr: returns true, if region is to be unmapped
+ */
+void libie_pci_unmap_fltr_regs(struct libie_mmio_info *mmio_info,
+			       bool (*fltr)(struct libie_mmio_info *mmio_info,
+					    struct libie_pci_mmio_region *reg))
+{
+	struct libie_pci_mmio_region *mr, *tmp;
+
+	list_for_each_entry_safe(mr, tmp, &mmio_info->mmio_list, list) {
+		if (!fltr(mmio_info, mr))
+			continue;
+		iounmap(mr->addr);
+		list_del(&mr->list);
+		kfree(mr);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(libie_pci_unmap_fltr_regs, "LIBIE_PCI");
+
+/**
+ * libie_pci_unmap_all_mmio_regions - unmap all PCI device MMIO regions
+ * @mmio_info: contains list of MMIO regions to unmap
+ */
+void libie_pci_unmap_all_mmio_regions(struct libie_mmio_info *mmio_info)
+{
+	struct libie_pci_mmio_region *mr, *tmp;
+
+	list_for_each_entry_safe(mr, tmp, &mmio_info->mmio_list, list) {
+		iounmap(mr->addr);
+		list_del(&mr->list);
+		kfree(mr);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(libie_pci_unmap_all_mmio_regions, "LIBIE_PCI");
+
+/**
+ * libie_pci_init_dev - enable and reserve PCI regions of the device
+ * @pdev: PCI device information
+ *
+ * Return: %0 on success, -%errno on failure.
+ */
+int libie_pci_init_dev(struct pci_dev *pdev)
+{
+	int err;
+
+	err = pcim_enable_device(pdev);
+	if (err)
+		return err;
+
+	for (int bar = 0; bar < PCI_STD_NUM_BARS; bar++)
+		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
+			err = pcim_request_region(pdev, bar, pci_name(pdev));
+			if (err)
+				return err;
+		}
+
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (err)
+		return err;
+
+	pci_set_master(pdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(libie_pci_init_dev, "LIBIE_PCI");
+
+MODULE_DESCRIPTION("Common Ethernet PCI library");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/intel/libie/pci.h b/include/linux/intel/libie/pci.h
new file mode 100644
index 000000000000..effd072c55c8
--- /dev/null
+++ b/include/linux/intel/libie/pci.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef __LIBIE_PCI_H
+#define __LIBIE_PCI_H
+
+#include <linux/pci.h>
+
+/**
+ * struct libie_pci_mmio_region - structure for MMIO region info
+ * @list: used to add a MMIO region to the list of MMIO regions in
+ *	  libie_mmio_info
+ * @addr: virtual address of MMIO region start
+ * @offset: start offset of the MMIO region
+ * @size: size of the MMIO region
+ * @bar_idx: BAR index to which the MMIO region belongs to
+ */
+struct libie_pci_mmio_region {
+	struct list_head	list;
+	void __iomem		*addr;
+	resource_size_t		offset;
+	resource_size_t		size;
+	u16			bar_idx;
+};
+
+/**
+ * struct libie_mmio_info - contains list of MMIO regions
+ * @pdev: PCI device pointer
+ * @mmio_list: list of MMIO regions
+ */
+struct libie_mmio_info {
+	struct pci_dev		*pdev;
+	struct list_head	mmio_list;
+};
+
+#define libie_pci_map_mmio_region(mmio_info, offset, size, ...)	\
+	__libie_pci_map_mmio_region(mmio_info, offset, size,		\
+				     COUNT_ARGS(__VA_ARGS__), ##__VA_ARGS__)
+
+#define libie_pci_get_mmio_addr(mmio_info, offset, ...)		\
+	__libie_pci_get_mmio_addr(mmio_info, offset,			\
+				   COUNT_ARGS(__VA_ARGS__), ##__VA_ARGS__)
+
+bool __libie_pci_map_mmio_region(struct libie_mmio_info *mmio_info,
+				 resource_size_t offset, resource_size_t size,
+				 int num_args, ...);
+void __iomem *__libie_pci_get_mmio_addr(struct libie_mmio_info *mmio_info,
+					resource_size_t offset,
+					int num_args, ...);
+void libie_pci_unmap_all_mmio_regions(struct libie_mmio_info *mmio_info);
+void libie_pci_unmap_fltr_regs(struct libie_mmio_info *mmio_info,
+			       bool (*fltr)(struct libie_mmio_info *mmio_info,
+					    struct libie_pci_mmio_region *reg));
+int libie_pci_init_dev(struct pci_dev *pdev);
+
+#endif /* __LIBIE_PCI_H */
-- 
2.47.1

