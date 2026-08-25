Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC031E830;
	Tue, 25 Aug 2026 02:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787624855; cv=none; b=HSa0o+iN6B0lUJOjq5eIABVmQkBIxb+3K5ZUJ3SDbTMq2pHoOEsmrFE2fayYH2snjDpXjbMOC5rPOU3svNZ9On/7KcwH2X66UrwHm5oAVnw2D5OgNMHCuqbj4TzZo+ae9Zp6kJ8y/Xbe3zIg1nAOp0ymUaO+YwOFs3k6isi290U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787624855; c=relaxed/simple;
	bh=pWL2Fx2f1XZ+ch7E4+5dIo1Wx0My4gYiTT+UYgnRcCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmjsF+u6pQVYavFC1jsTlLShFNBPnO3WaDOEh87zs1iKXJFyl1GHWJvWlfnhkKaaLXZdNZ2UfEO20OsHaiNHvH1pRltTUDPf0dMfXyYLHBIqaBaf9zo2BsCVbyfsWhRXxwsFXs5hUWeNCwBO9wBAo3eFNlq5j/pNazA27UhoMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FzZfqJ/l; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FzZfqJ/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624853; x=1819160853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pWL2Fx2f1XZ+ch7E4+5dIo1Wx0My4gYiTT+UYgnRcCg=;
  b=FzZfqJ/lufbQ0R9/dZfUe7X/Jm2MVMJCkr+i2qjzn119Ed/rYqtF5OUH
   ZGAq0GWCVOqph7tJEYAOy5Nt3MTiYL+u3C9ZN0yBcM5DCvGiTQhT4TJcS
   pR4KBjL4mnjmN0DQP3IFt7NMU+/TtIdxm3Y5/+KhRP56orTRa2PO2pZY4
   AxTCctUJ0wLHmDHnHzeFlmkg4DiZV0+WQsdAOZGG4PfcWk0mWKvG4/B0t
   2RHskHQtNoE0+NVmuYd2WmIDHe7pbseTL8+aBdymJVxFWSU4V9vr0S5fd
   eH6R/dj0WMLLXvmIq7JHDk695PDr4mkJNkdSgAOxG3UNgLHulrIX3N/fp
   Q==;
X-CSE-ConnectionGUID: SSdCsTtlROaWNXWvExVYEg==
X-CSE-MsgGUID: fEHs2xyaTsaBk3+TDlLAUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98761118"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98761118"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:32 -0700
X-CSE-ConnectionGUID: 7NtM2xUoQvWwCT7qK5iedg==
X-CSE-MsgGUID: cG6ZbR99R2KFBRJD6RIbrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390100"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:25 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v2 07/13] cxl/core: Add region disable and enable for a DPort SBR
Date: Tue, 25 Aug 2026 04:26:22 +0200
Message-ID: <20260825022628.3651434-8-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A Secondary Bus Reset of a CXL Downstream Port removes the downstream
component from the bus, so a CXL region reached through that Port has to
be disabled while the reset runs.

Add cxl_region_disable() to offline memory, invalidate the CPU caches
for its range and release its driver, and cxl_region_enable() to
re-attach the driver afterwards.

Neither function has a caller yet. Both are driven by the reset once the
set of regions routed through the Port is known.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/core.h      |  3 ++
 drivers/cxl/core/dport_sbr.c | 79 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c    |  3 +-
 3 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index a8b9d7990d32..ac55f9e8160e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -56,6 +56,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 int devm_cxl_add_dax_region(struct cxl_region *cxlr);
 int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
 void kill_regions(struct cxl_root_decoder *cxlrd);
+int cxl_region_invalidate_memregion(struct cxl_region *cxlr);
+int cxl_region_disable(struct cxl_region *cxlr);
+void cxl_region_enable(struct cxl_region *cxlr);
 struct pci_dev;
 void cxl_sbr_recommit_decoders(struct pci_dev *dport_pci,
 			       struct xarray *hdm_state);
diff --git a/drivers/cxl/core/dport_sbr.c b/drivers/cxl/core/dport_sbr.c
index 55c35386d0cb..0f398ab0d3a4 100644
--- a/drivers/cxl/core/dport_sbr.c
+++ b/drivers/cxl/core/dport_sbr.c
@@ -1,11 +1,90 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2026 Intel Corporation. */
 
+#include <linux/memregion.h>
+#include <linux/memory_hotplug.h>
+#include <linux/memory.h>
 #include <linux/device.h>
 #include <linux/pci.h>
 #include <cxl.h>
 #include "core.h"
 
+/*
+ * cxl_region_disable - make a region inactive ahead of a Secondary Bus Reset
+ * @cxlr: region routed through the CXL Downstream Port being reset
+ *
+ * Offline the memory blocks the region owns and unbind its driver. An SBR
+ * zeroes the downstream bus number, so a region left live as System RAM would
+ * be accessed while the device is in reset. On offline failure return the error
+ * so the caller aborts the reset; the memory is never force-removed.
+ *
+ * Context: process context. Offlining and driver unbind sleep and take the
+ * memory hotplug lock, so this cannot run in atomic context.
+ */
+int cxl_region_disable(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	unsigned long block_size;
+	u64 start, end;
+	int rc;
+
+	/*
+	 * Per CXL r4.0 sec 9.13.1 an Interleave Set has a Base HPA and a Size
+	 * that are multiples of 256 MB, while a memory block spans up to 2 GB.
+	 * A block overlapping either end of the range therefore also covers
+	 * memory outside this region, so round the range inward to block
+	 * granularity as dax_kmem did when it onlined the range. Offlining a
+	 * straddling block would migrate pages that the reset does not affect.
+	 */
+	block_size = memory_block_size_bytes();
+	start = ALIGN(p->res->start, block_size);
+	end = ALIGN_DOWN(p->res->end + 1, block_size);
+	if (start >= end) {
+		dev_dbg(&cxlr->dev, "%s: HPA %pr spans no whole memory block, no System RAM to offline\n",
+			__func__, p->res);
+	} else {
+		rc = cxl_offline_memory(start, end - start);
+		if (rc) {
+			dev_warn(&cxlr->dev, "offline System RAM failed before reset: %d\n",
+				 rc);
+			return rc;
+		}
+	}
+
+	rc = cxl_region_invalidate_memregion(cxlr);
+	if (rc) {
+		dev_warn(&cxlr->dev, "CPU cache invalidate failed before reset: %d\n",
+			 rc);
+		return rc;
+	}
+
+	device_release_driver(&cxlr->dev);
+	dev_dbg(&cxlr->dev, "%s: System RAM offline, region disabled before reset, HPA %pr\n",
+		__func__, p->res);
+
+	return 0;
+}
+
+/*
+ * cxl_region_enable - restore a region after a Secondary Bus Reset
+ * @cxlr: region disabled by cxl_region_disable() before the reset
+ *
+ * Rebind the region driver. The System RAM is left offline; bringing it back
+ * online is a separate administrative step.
+ */
+void cxl_region_enable(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+
+	if (device_attach(&cxlr->dev) < 0) {
+		dev_dbg(&cxlr->dev, "driver re-attach failed after reset\n");
+		return;
+	}
+
+	dev_dbg(&cxlr->dev, "%s: region re-enabled after reset, HPA %pr, IW %d, IG %d\n",
+		__func__, p->res, p->interleave_ways, p->interleave_granularity);
+}
+
 /*
  * The reset cleared the HDM Decoder registers of every CXL component below
  * @dport_pci, so restore them from the settings the driver holds and from
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..fc0bec991a69 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -222,7 +222,7 @@ static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
 	return xa_load(&port->regions, (unsigned long)cxlr);
 }
 
-static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
+int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 {
 	if (!cpu_cache_has_invalidate_memregion()) {
 		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
@@ -4273,4 +4273,5 @@ void cxl_region_exit(void)
 
 MODULE_IMPORT_NS("CXL");
 MODULE_IMPORT_NS("DEVMEM");
+MODULE_IMPORT_NS("CXL_MHP");
 MODULE_ALIAS_CXL(CXL_DEVICE_REGION);
-- 
2.55.0

