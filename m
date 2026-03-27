Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D9C405ACD;
	Fri, 27 Mar 2026 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628658; cv=none; b=aUs1fv+VvAHi1gq/y1Y1ITfyppRMdJShGE1xfDctYFHlcaHGfvIzLPZ5M9qBOPh7t0IGtN5HnejQtJlk40MCb4bj0TBTN0jppa/pU55DhiIpZfkc+vgW4je2Yb/JwqR2YtK2ogSXE0fTH2SIHjcnbtlToV72I2QOKLIoefIh1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628658; c=relaxed/simple;
	bh=qUyRwAaoP/Pd1LzP3/qJcfABY/rt+g58V38MuLi8Pu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YCo+ezs9wPNERTNvYRZb2CRBPrYtcZ87oUXcI3NokQopUmTcjfDjdnwh1MzcTDDmueDYKRMdHQanCy0UyYge6hAV5DYtrhq+EI/SDgXacpZ3z93F8i2XhnXIJ/6XO6FUX+DuMmCPtjsY4MkzJvFzIpK4+BNQiWfqeR5jQ5efWVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmjYwiPm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmjYwiPm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628656; x=1806164656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qUyRwAaoP/Pd1LzP3/qJcfABY/rt+g58V38MuLi8Pu0=;
  b=QmjYwiPmNqOpsK9SuY9qoz0h+iUfbrRy8OdY+os4QYIO8G1vUSKTTfvy
   dBjc1ctxJITgZGM1Pnb894c0qFtF9MWbDU3/J9j6tRbjC4cqQ/V1B9R3Z
   KO9dFAtUGKZ/uJs6YbfWpkO6xWxtucOfTCQFXyF4AFxc/S9fIn7GUS5aW
   ZxpxbyTcNJeGrNOr1PPItRrSJ/5jpTYawMMpfrpDc5tRZytHDSGUbZPU5
   3jY4RVsZCNf+GrjYS7h5tmhDRElgpRGJavMMHwVpU4nWlwq76za9RdosL
   iKwMsaH0o6CmbhkNBsbdNl837+CEz87OkXar7Cgf1VdQxwfS58/MiClOe
   w==;
X-CSE-ConnectionGUID: nnoW+v+qTiGShy/FICJgiQ==
X-CSE-MsgGUID: FqEbF/gzTEuefFJnQXHq9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565686"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565686"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:24:16 -0700
X-CSE-ConnectionGUID: z4SQgsAsS+SrUSoIgdBDMg==
X-CSE-MsgGUID: MoAPMc/wRW+/IysahX6pRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516380"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:24:13 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dan.j.williams@intel.com,
	x86@kernel.org
Cc: chao.gao@intel.com,
	dave.jiang@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
	zhenzhong.duan@intel.com,
	kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	dave.hansen@linux.intel.com,
	kas@kernel.org,
	xiaoyao.li@intel.com,
	vishal.l.verma@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/31] coco/tdx-host: Parse ACPI KEYP table to init IDE for PCI host bridges
Date: Sat, 28 Mar 2026 00:01:29 +0800
Message-Id: <20260327160132.2946114-29-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse the KEYP Key Configuration Units (KCU), to decide the max IDE
streams supported for each host bridge.

The KEYP table points to a number of KCU structures that each associates
with a list of root ports (RP) via segment, bus, and devfn. Sanity check
the KEYP table, ensure all RPs listed for each KCU are included in one
host bridge. Then extact the max IDE streams supported to
pci_host_bridge via pci_ide_set_nr_streams().

Co-developed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/virt/coco/tdx-host/tdx-host.c | 111 ++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 4d127b7c2591..d5072a68b81a 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2025 Intel Corporation
  */
 
+#include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/device/faux.h>
 #include <linux/dmar.h>
@@ -12,6 +13,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <linux/pci-ide.h>
 #include <linux/pci-tsm.h>
 #include <linux/tsm.h>
 #include <linux/vmalloc.h>
@@ -474,6 +476,111 @@ static void unregister_link_tsm(void *link)
 	tsm_unregister(link);
 }
 
+#define KCU_STR_CAP_NUM_STREAMS		GENMASK(8, 0)
+
+/* The bus_end is inclusive */
+struct keyp_hb_info {
+	/* input */
+	u16 segment;
+	u8 bus_start;
+	u8 bus_end;
+	/* output */
+	u8 nr_ide_streams;
+};
+
+static bool keyp_info_match(struct acpi_keyp_rp_info *rp,
+			    struct keyp_hb_info *hb)
+{
+	return rp->segment == hb->segment && rp->bus >= hb->bus_start &&
+	       rp->bus <= hb->bus_end;
+}
+
+static int keyp_config_unit_handler(union acpi_subtable_headers *header,
+				    void *arg, const unsigned long end)
+{
+	struct acpi_keyp_config_unit *acpi_cu =
+		(struct acpi_keyp_config_unit *)&header->keyp;
+	struct keyp_hb_info *hb_info = arg;
+	int rp_size, rp_count, i;
+	void __iomem *addr;
+	bool match = false;
+	u32 cap;
+
+	rp_size = acpi_cu->header.length - sizeof(*acpi_cu);
+	if (rp_size % sizeof(struct acpi_keyp_rp_info))
+		return -EINVAL;
+
+	rp_count = rp_size / sizeof(struct acpi_keyp_rp_info);
+	if (!rp_count || rp_count != acpi_cu->root_port_count)
+		return -EINVAL;
+
+	for (i = 0; i < rp_count; i++) {
+		struct acpi_keyp_rp_info *rp_info = &acpi_cu->rp_info[i];
+
+		if (i == 0) {
+			match = keyp_info_match(rp_info, hb_info);
+			/* The host bridge already matches another KCU */
+			if (match && hb_info->nr_ide_streams)
+				return -EINVAL;
+
+			continue;
+		}
+
+		if (match ^ keyp_info_match(rp_info, hb_info))
+			return -EINVAL;
+	}
+
+	if (!match)
+		return 0;
+
+	addr = ioremap(acpi_cu->register_base_address, sizeof(cap));
+	if (!addr)
+		return -ENOMEM;
+	cap = ioread32(addr);
+	iounmap(addr);
+
+	hb_info->nr_ide_streams = FIELD_GET(KCU_STR_CAP_NUM_STREAMS, cap) + 1;
+
+	return 0;
+}
+
+static u8 keyp_find_nr_ide_stream(u16 segment, u8 bus_start, u8 bus_end)
+{
+	struct keyp_hb_info hb_info = {
+		.segment = segment,
+		.bus_start = bus_start,
+		.bus_end = bus_end,
+	};
+	int rc;
+
+	rc = acpi_table_parse_keyp(ACPI_KEYP_TYPE_CONFIG_UNIT,
+				   keyp_config_unit_handler, &hb_info);
+	if (rc < 0)
+		return 0;
+
+	return hb_info.nr_ide_streams;
+}
+
+static void keyp_setup_nr_ide_stream(struct pci_bus *bus)
+{
+	struct pci_host_bridge *hb = pci_find_host_bridge(bus);
+	u8 nr_ide_streams;
+
+	nr_ide_streams = keyp_find_nr_ide_stream(pci_domain_nr(bus),
+						 bus->busn_res.start,
+						 bus->busn_res.end);
+
+	pci_ide_set_nr_streams(hb, nr_ide_streams);
+}
+
+static void tdx_setup_nr_ide_stream(void)
+{
+	struct pci_bus *bus = NULL;
+
+	while ((bus = pci_find_next_bus(bus)))
+		keyp_setup_nr_ide_stream(bus);
+}
+
 static DEFINE_XARRAY(tlink_iommu_xa);
 
 static void tdx_iommu_clear(u64 iommu_id, struct tdx_page_array *iommu_mt)
@@ -569,6 +676,8 @@ static int __maybe_unused tdx_connect_init(struct device *dev)
 	if (ret)
 		return ret;
 
+	tdx_setup_nr_ide_stream();
+
 	link = tsm_register(dev, &tdx_tsm_link_ops);
 	if (IS_ERR(link))
 		return dev_err_probe(dev, PTR_ERR(link),
@@ -612,5 +721,7 @@ static void __exit tdx_host_exit(void)
 }
 module_exit(tdx_host_exit);
 
+MODULE_IMPORT_NS("ACPI");
+MODULE_IMPORT_NS("PCI_IDE");
 MODULE_DESCRIPTION("TDX Host Services");
 MODULE_LICENSE("GPL");
-- 
2.25.1

