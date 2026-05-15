Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F50373BF2;
	Fri, 15 May 2026 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885107; cv=none; b=VQ5L3IbKOZtIEJifp5zg3KdTYkuXb/V+nvZRzjBx+NY0hbWPmqbUqgNnlVS9fSH66COfeiEI6YXni7swYWE9Uv9Khq+wFbOo3ZJ9yHJ+Qkvp8pcXtTmvV7lnbsxHA+bzgRaMu7uuI/5rGhPrSaMleuV7w97NfUCA0TEeLu+1tkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885107; c=relaxed/simple;
	bh=bXeEbllSUhc62/nolE52XEdol2e7UKXNWrejec72ScU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNZJxobcYxPs+etre+/2ug0KSQd5McClSKB1R6/fAD3yaWd9lH6HKZT1AYSVQQHYAoIFhOST95pMjOg4fTaRgz6N04WOBzpTm9WllM3HsS/NzL3ZiC/oWIzzmusi51mR2QnZ8d5YT4JwQTeGBCoWPKWOkvEi8u9Ju/9jsF5P1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqDzQdep; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqDzQdep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778885106; x=1810421106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bXeEbllSUhc62/nolE52XEdol2e7UKXNWrejec72ScU=;
  b=ZqDzQdep+45i54r4+5s24UuQFT9DDwUvIZHvXzd7BK0KtnbcbZnr05Zk
   VgtICYd3hLz95Yvn4isNGrsyP6mpl3QFmbZEE1uxcu8bXpPTTpeaY66NT
   SdJqpE7qtsbiMo+VSn/I8cicDrRDV3ebph+dOm3Z1sTkWmrYnLhNhqvKc
   JOBOy+/XyfPeD5crhjRXSJdipJQ7RtdBOnkMhZ01P3UL0RIg3LVpXoTGd
   CSiPTdGHcKqph8rejc2NCMFkXPk/jCgPwMxOtNvb2jK+lClduqESS7pku
   ag8tEebsXUxPuM3qdCfuREP2BMq7OGZftotruihelFr8TGXQYxAAi4N0u
   g==;
X-CSE-ConnectionGUID: StfmldcbTbK94nearRAgdQ==
X-CSE-MsgGUID: fHgkYFVIS6+2OLi0fnOxWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="90949167"
X-IronPort-AV: E=Sophos;i="6.23,237,1770624000"; 
   d="scan'208";a="90949167"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 15:45:04 -0700
X-CSE-ConnectionGUID: kyDGS7tPSVe144ay6Le0jA==
X-CSE-MsgGUID: G57napPZSfqYcJVlBUizmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,237,1770624000"; 
   d="scan'208";a="243146633"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 15 May 2026 15:45:04 -0700
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
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	linux-doc@vger.kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Bharath R <bharath.r@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v3 02/14] libie: add PCI device initialization helpers to libie
Date: Fri, 15 May 2026 15:44:26 -0700
Message-ID: <20260515224443.2772147-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phani R Burra <phani.r.burra@intel.com>

Add support functions for drivers to configure PCI functionality and access
MMIO space.

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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libie/Kconfig  |   6 +
 drivers/net/ethernet/intel/libie/Makefile |   4 +
 drivers/net/ethernet/intel/libie/pci.c    | 208 ++++++++++++++++++++++
 include/linux/intel/libie/pci.h           |  56 ++++++
 4 files changed, 274 insertions(+)
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
index 000000000000..7276a3533b54
--- /dev/null
+++ b/drivers/net/ethernet/intel/libie/pci.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include <linux/intel/libie/pci.h>
+
+/**
+ * libie_find_mmio_region - find MMIO region containing a range
+ * @mmio_list: list that contains MMIO region info
+ * @offset: range start offset
+ * @size: range size
+ * @bar_idx: BAR index containing the range to search
+ *
+ * Return: pointer to a MMIO region overlapping with the range in any way or
+ *	   NULL if no such region is mapped.
+ */
+static struct libie_pci_mmio_region *
+libie_find_mmio_region(const struct list_head *mmio_list,
+		       resource_size_t offset, resource_size_t size,
+		       int bar_idx)
+{
+	resource_size_t end_offset = offset + size;
+	struct libie_pci_mmio_region *mr;
+
+	list_for_each_entry(mr, mmio_list, list) {
+		resource_size_t mr_end = mr->offset + mr->size;
+		resource_size_t mr_start = mr->offset;
+
+		if (mr->bar_idx != bar_idx)
+			continue;
+		if (offset < mr_end && end_offset > mr_start)
+			return mr;
+	}
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
+	if (offset + size > pci_resource_len(pdev, bar_idx))
+		return false;
+
+	mr = libie_find_mmio_region(&mmio_info->mmio_list, offset, size,
+				    bar_idx);
+	if (mr) {
+		pci_warn(pdev,
+			 "Mapping of BAR%u (offset=%llu, size=%llu) intersecting region (offset=%llu, size=%llu) already exists\n",
+			 bar_idx, (unsigned long long)mr->offset,
+			 (unsigned long long)mr->size,
+			 (unsigned long long)offset, (unsigned long long)size);
+		return mr->offset <= offset &&
+		       mr->offset + mr->size >= offset + size;
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
+		kvfree(mr);
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
+		kvfree(mr);
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

