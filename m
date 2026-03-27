Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C1435E940;
	Fri, 27 Mar 2026 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628573; cv=none; b=LyhKRFyxnrJcA5vqFSVBSva+VchwhN6XWeZBbhRwPYahM8DRSbTV/b2UG1WtLbbLbNwCmfiMob/q7TzSG93Or1BWCf0i7WjEw9JIlB1LlTtiYoS4QpSzvpIMOF9Wa0LD3fwvR0ZN0CXskiGnzMtpf3A2WBa9reqlDTQS/TuBixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628573; c=relaxed/simple;
	bh=USq+0qILH9pbLBmpZHYQbhDjl5P3jkvMI4zsV0/QepU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UL4IuvdxLszOhEMxqRmsR3msFtuJgd0ajkpj4XEtTtay6wUKfj5hmoXdYbWhTfyz2sJjzuKDt+CyCeW5rbvZnPXgrJCMPSpdgZyvPGz9EUuFp5QBwiL2xOUNu07ew3/SJOK+438lTh/S5wb2PRxcgjsApYP9RnglwobOUs7Q0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R61jeR5W; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R61jeR5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628571; x=1806164571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=USq+0qILH9pbLBmpZHYQbhDjl5P3jkvMI4zsV0/QepU=;
  b=R61jeR5WWbKH9l9NspS+exTDn/bIfmTPxj2mTTUgeqTxXc2hj0L0e7wn
   iYSkZAUq++4EBUi/1oIULveNiC60HTkJUVezyvztZhEIIb3180pXdJTsK
   J7Awr2INkVf6HPV/mMnofP4nWnbpdkC2cypFZCBpQBS1nGgvYhcqVDMCC
   /NVrHTbM9OPkvHziD5bU1Xalt0eIANHbHEXZq1avCQOINFAWVJj7NC1b5
   EWER8i3/niO9Be5djk8ioV9wYvH6Pkm4EbGHo7AVrNs10/9qsgODXhkoU
   U2xwZgUCC59wzfqvLxugWUZFGhEIYgr+ml8ybuHQixKlCTcqMCdan+ft5
   Q==;
X-CSE-ConnectionGUID: 348s2YDGRQaxVjm1ObHKRA==
X-CSE-MsgGUID: vD+ERaUaTAugRGpiWpqeLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565514"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565514"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:22:51 -0700
X-CSE-ConnectionGUID: COEQRPy/QgSyM6AlpsKiag==
X-CSE-MsgGUID: lKGOSQ2KQ26sBhpgS9rn9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516146"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:22:48 -0700
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
Subject: [PATCH v2 05/31] x86/virt/tdx: Extend tdx_page_array to support IOMMU_MT
Date: Sat, 28 Mar 2026 00:01:06 +0800
Message-Id: <20260327160132.2946114-6-yilun.xu@linux.intel.com>
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

IOMMU_MT is another TDX Module defined structure similar to HPA_ARRAY_T
and HPA_LIST_INFO. The difference is it requires multi-order contiguous
pages for some entries. It adds an additional NUM_PAGES field for every
multi-order page entry.

Add a dedicated allocation helper for IOMMU_MT. Fortunately put_page()
works well for both single pages and multi-order folios, simplifying the
cleanup logic for all allocation methods.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h  |  2 +
 arch/x86/virt/vmx/tdx/tdx.c | 90 +++++++++++++++++++++++++++++++++++--
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 9173a432b312..d5f1d7b7d1e7 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -175,6 +175,8 @@ void tdx_page_array_ctrl_leak(struct tdx_page_array *array);
 int tdx_page_array_ctrl_release(struct tdx_page_array *array,
 				unsigned int nr_released,
 				u64 released_hpa);
+struct tdx_page_array *
+tdx_page_array_create_iommu_mt(unsigned int iq_order, unsigned int nr_mt_pages);
 
 struct tdx_td {
 	/* TD root structure: */
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 6c4ed80e8e5a..2b17e0f73dac 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -275,8 +275,15 @@ static int tdx_page_array_populate(struct tdx_page_array *array,
 			    TDX_PAGE_ARRAY_MAX_NENTS);
 
 	entries = array->root;
-	for (i = 0; i < array->nents; i++)
-		entries[i] = page_to_phys(array->pages[offset + i]);
+	for (i = 0; i < array->nents; i++) {
+		struct page *page = array->pages[offset + i];
+
+		entries[i] = page_to_phys(page);
+
+		/* Now only for iommu_mt */
+		if (compound_nr(page) > 1)
+			entries[i] |= compound_nr(page);
+	}
 
 	return array->nents;
 }
@@ -286,7 +293,7 @@ static void tdx_free_pages_bulk(unsigned int nr_pages, struct page **pages)
 	int i;
 
 	for (i = 0; i < nr_pages; i++)
-		__free_page(pages[i]);
+		put_page(pages[i]);
 }
 
 static int tdx_alloc_pages_bulk(unsigned int nr_pages, struct page **pages,
@@ -463,6 +470,10 @@ static bool tdx_page_array_validate_release(struct tdx_page_array *array,
 			struct page *page = array->pages[offset + i];
 			u64 val = page_to_phys(page);
 
+			/* Now only for iommu_mt */
+			if (compound_nr(page) > 1)
+				val |= compound_nr(page);
+
 			if (val != entries[i]) {
 				pr_err("%s entry[%d] [0x%llx] doesn't match page hpa [0x%llx]\n",
 				       __func__, i, entries[i], val);
@@ -555,6 +566,79 @@ tdx_page_array_alloc_contig(unsigned int nr_pages)
 	return tdx_page_array_alloc(nr_pages, tdx_alloc_pages_contig, NULL);
 }
 
+static int tdx_alloc_pages_iommu_mt(unsigned int nr_pages, struct page **pages,
+				    void *data)
+{
+	unsigned int iq_order = (unsigned int)(long)data;
+	struct folio *t_iq, *t_ctxiq;
+	int ret;
+
+	/* TODO: folio_alloc_node() is preferred, but need numa info */
+	t_iq = folio_alloc(GFP_KERNEL | __GFP_ZERO, iq_order);
+	if (!t_iq)
+		return -ENOMEM;
+
+	t_ctxiq = folio_alloc(GFP_KERNEL | __GFP_ZERO, iq_order);
+	if (!t_ctxiq) {
+		ret = -ENOMEM;
+		goto out_t_iq;
+	}
+
+	ret = tdx_alloc_pages_bulk(nr_pages - 2, pages + 2, NULL);
+	if (ret)
+		goto out_t_ctxiq;
+
+	pages[0] = folio_page(t_iq, 0);
+	pages[1] = folio_page(t_ctxiq, 0);
+
+	return 0;
+
+out_t_ctxiq:
+	folio_put(t_ctxiq);
+out_t_iq:
+	folio_put(t_iq);
+
+	return ret;
+}
+
+/**
+ * tdx_page_array_create_iommu_mt() - Create a page array for IOMMU Memory Tables
+ * @iq_order: The allocation order for the IOMMU Invalidation Queue.
+ * @nr_mt_pages: Number of additional order-0 pages for the MT.
+ *
+ * Allocate and populate a specialized tdx_page_array for IOMMU_MT structures.
+ * The resulting array consists of two multi-order folios (at index 0 and 1)
+ * followed by the requested number of order-0 pages.
+ *
+ * Return: Fully populated tdx_page_array or NULL on failure.
+ */
+struct tdx_page_array *
+tdx_page_array_create_iommu_mt(unsigned int iq_order, unsigned int nr_mt_pages)
+{
+	unsigned int nr_pages = nr_mt_pages + 2;
+	struct tdx_page_array *array;
+	int populated;
+
+	if (nr_pages > TDX_PAGE_ARRAY_MAX_NENTS)
+		return NULL;
+
+	array = tdx_page_array_alloc(nr_pages, tdx_alloc_pages_iommu_mt,
+				     (void *)(long)iq_order);
+	if (!array)
+		return NULL;
+
+	populated = tdx_page_array_populate(array, 0);
+	if (populated != nr_pages)
+		goto out_free;
+
+	return array;
+
+out_free:
+	tdx_page_array_free(array);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(tdx_page_array_create_iommu_mt);
+
 #define HPA_LIST_INFO_FIRST_ENTRY	GENMASK_U64(11, 3)
 #define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
 #define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
-- 
2.25.1

