Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D2C369974;
	Fri, 27 Mar 2026 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628592; cv=none; b=OC4FWVrqMJVBTXPk6uTHfnIE7cpySkvlGg7JowH89OHtR9sokq5SPw3aGPeDwl5yT4zsztPyrKMgbS07HdJsaIgp3kyN2IezeBv2GYJAsLRqNStuwZelK0IE4kNHt6ITvyCvTSS3c5Hn4ZMY30xzXi3CRYNQP9TQtuSVrONowMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628592; c=relaxed/simple;
	bh=DFu7IpMW3OWHV01lKFnhvTeC+NplEcS0CgOhg0CuuzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DrnVCMEylG0TIxCvc5Hhz20Gx21yuydnEQQW5UHO60heDLImA1RG/SNnMOMLb/3tLGcNC92CjWhUMGYcnNFIim0zcmGiIDvIqjjN56vhRDik10HLPefK3kxLzEmrhHljQcCIqHyHRqDrizyDaPFY3nyRwK7Z4zgFVlyqcZbkrh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3gNA4jx; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3gNA4jx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628590; x=1806164590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DFu7IpMW3OWHV01lKFnhvTeC+NplEcS0CgOhg0CuuzQ=;
  b=H3gNA4jx5DJsKg9jftEccdV1IrDwqB8UuKXSG+NGBqEEvsII7AFTLXJB
   qqTCWUu8OfXdKyinmcBPgLnB/ZgbUh2QCbkVvLpSE0/PJqY8+dYVtqISf
   bq940jT9ftnUynUl30mfjFs8+17IJmgirCj+q0K7jJZmxrdXbKT8rn9g6
   NSxh9MU2mhXLAQ894Db314m1Z9Ny0E/5fLn+jHXf45+JV8sCIiZTA6h4H
   sHSJZqZ84Kg6pJCRP5o9qDsGLjww175vhuLDfo1yE24j0+TH74sDTvY+O
   gaAtSmNU8bWT3f1u6dwCxfUZwjRMUz5jqvOHNOVdLU6DrPyl9kzKlX8dR
   g==;
X-CSE-ConnectionGUID: OxwI/7/QQbOem4CVfEvbPg==
X-CSE-MsgGUID: MDZPgzB8QVaMunKyawzXrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565545"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565545"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:23:10 -0700
X-CSE-ConnectionGUID: 78QD7ClFQlOkfsj+yeSW4g==
X-CSE-MsgGUID: 8/iKa9MpQxOohP7dpzqWIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516181"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:23:06 -0700
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
Subject: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module for Extensions
Date: Sat, 28 Mar 2026 00:01:11 +0800
Message-Id: <20260327160132.2946114-11-yilun.xu@linux.intel.com>
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

Adding more memory to TDX Module is the first step to enable Extensions.

Currently, TDX Module memory use is relatively static. But, some new
features (called "TDX Module Extensions") need to use memory more
dynamically. While 'static' here means the kernel provides necessary
amount of memory to TDX Module for its basic functionalities, 'dynamic'
means extra memory is needed only if new optional features are to be
enabled. So add a new memory feeding process backed by a new SEAMCALL
TDH.EXT.MEM.ADD.

The process is mostly the same as adding PAMT. The kernel queries TDX
Module how much memory needed, allocates it, hands it over, and never
gets it back.

TDH.EXT.MEM.ADD uses tdx_page_array to provide control (private) pages
to TDX Module. Introduce a tdx_clflush_page_array() helper to flush
shared cache before SEAMCALL, to avoid shared cache write back damages
these private pages.

For now, TDX Module Extensions consume relatively large amount of
memory (~50MB). Use contiguous page allocation to avoid permanently
fragment too much memory. Print this readout value on TDX Module
Extensions initialization for visibility.

Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.h |  1 +
 arch/x86/virt/vmx/tdx/tdx.c | 92 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 870bb75da3ba..31ccdfcf518c 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -60,6 +60,7 @@
 #define TDH_VP_WR			43
 #define TDH_SYS_CONFIG_V0		45
 #define TDH_SYS_CONFIG			SEAMCALL_LEAF_VER(TDH_SYS_CONFIG_V0, 1)
+#define TDH_EXT_MEM_ADD			61
 
 /* TDX page types */
 #define	PT_NDA		0x0
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4fb56bb442f0..5fae17c13191 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -560,7 +560,7 @@ static int tdx_alloc_pages_contig(unsigned int nr_pages, struct page **pages,
  * Similar to tdx_page_array_alloc(), after allocating with this
  * function, call tdx_page_array_populate() to populate the tdx_page_array.
  */
-static __maybe_unused struct tdx_page_array *
+static struct tdx_page_array *
 tdx_page_array_alloc_contig(unsigned int nr_pages)
 {
 	return tdx_page_array_alloc(nr_pages, tdx_alloc_pages_contig, NULL);
@@ -643,7 +643,7 @@ EXPORT_SYMBOL_GPL(tdx_page_array_create_iommu_mt);
 #define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
 #define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
 
-static u64 __maybe_unused hpa_list_info_assign_raw(struct tdx_page_array *array)
+static u64 hpa_list_info_assign_raw(struct tdx_page_array *array)
 {
 	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
 	       FIELD_PREP(HPA_LIST_INFO_PFN,
@@ -1513,6 +1513,94 @@ static void tdx_clflush_page(struct page *page)
 	clflush_cache_range(page_to_virt(page), PAGE_SIZE);
 }
 
+static void tdx_clflush_page_array(struct tdx_page_array *array)
+{
+	for (int i = 0; i < array->nents; i++)
+		tdx_clflush_page(array->pages[array->offset + i]);
+}
+
+static int tdx_ext_mem_add(struct tdx_page_array *ext_mem)
+{
+	struct tdx_module_args args = {
+		.rcx = hpa_list_info_assign_raw(ext_mem),
+	};
+	u64 r;
+
+	tdx_clflush_page_array(ext_mem);
+
+	do {
+		r = seamcall_ret(TDH_EXT_MEM_ADD, &args);
+		cond_resched();
+	} while (r == TDX_INTERRUPTED_RESUMABLE);
+
+	if (r != TDX_SUCCESS)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int tdx_ext_mem_setup(struct tdx_page_array *ext_mem)
+{
+	unsigned int populated, offset = 0;
+	int ret;
+
+	/*
+	 * tdx_page_array's root page can hold 512 HPAs at most. We have ~50MB
+	 * memory to add, re-populate the array and add pages bulk by bulk.
+	 */
+	while (1) {
+		populated = tdx_page_array_populate(ext_mem, offset);
+		if (!populated)
+			break;
+
+		ret = tdx_ext_mem_add(ext_mem);
+		if (ret)
+			return ret;
+
+		offset += populated;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused init_tdx_ext(void)
+{
+	struct tdx_page_array *ext_mem = NULL;
+	unsigned int nr_pages;
+	int ret;
+
+	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
+		return 0;
+
+	nr_pages = tdx_sysinfo.ext.memory_pool_required_pages;
+	/*
+	 * memory_pool_required_pages == 0 means no need to add more pages,
+	 * skip the memory setup.
+	 */
+	if (nr_pages) {
+		ext_mem = tdx_page_array_alloc_contig(nr_pages);
+		if (!ext_mem)
+			return -ENOMEM;
+
+		ret = tdx_ext_mem_setup(ext_mem);
+		if (ret)
+			goto out_ext_mem;
+	}
+
+	/* Extension memory is never reclaimed once assigned */
+	tdx_page_array_ctrl_leak(ext_mem);
+
+	pr_info("%lu KB allocated for TDX Module Extensions\n",
+		nr_pages * PAGE_SIZE / 1024);
+
+	return 0;
+
+out_ext_mem:
+	tdx_page_array_free(ext_mem);
+
+	return ret;
+}
+
 static int init_tdx_module(void)
 {
 	int ret;
-- 
2.25.1

