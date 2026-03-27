Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BFE35B646;
	Fri, 27 Mar 2026 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628569; cv=none; b=O8lJIW4Xn4rXKAYeuTqzkx2wG6tXNZVUynrK6KsQzB8npGsvR6WklcOmqKlJRl6MUZPxC2Rr7tLxnQG2T+pZrewIou2I++Z3S1/D9tNY9aGfc1R8ONUuKGeOxhqcX19TWOaIEMVbB4mhR+GqWO5a+B4XTEJEhNh4xBIkMyLbK44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628569; c=relaxed/simple;
	bh=tqGp7zAocPvqaSnOyu6xaRIKdzXyFBuBaIxg8X/6vco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uerQCRteG8meKf7JBlJf1VznszA438uwJLwsi880nD0Dizlk5m45+xxPgXytvTqwAbw+k2OGHWdRyWA63lbbdTbFOW4XJhyRj1J/Bd20VHPvdwfkiBySBrPFlZ4rfprp+AvwL9VHD0ud+hKiSv1MPHjpmw4Hi2VmfTTZh1mrUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bL3xD+n+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bL3xD+n+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628568; x=1806164568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tqGp7zAocPvqaSnOyu6xaRIKdzXyFBuBaIxg8X/6vco=;
  b=bL3xD+n+lS5XqCGF3ivpAzmFGU6HYvIljXhZkNCDZxYB7FqVPbo6q6ZC
   ACwIkbUoqEJZzDB6cu+UIKM7zpLvZh7xBc4zxHxH9Pk70jF0JE7TNUdAV
   i8VrLLzoEdqqcDNyBc+uSkWIjp78aEXbks8A9blSGuMcAx532N+ZBur16
   BEMts5bGMETpfZ45AHkKM+3FH6gtn7EDCyjOzqj7MYxQUBl92Sz6IYatR
   VsYQvfW2jIQqEoMPWCws3ilWknay7N//GksU+I/yKeyTkCeaIOovRPzIW
   C5m7ucmA4iJRaTamFOrx9MrTQbt/EgnYlGgqux6S8kFcokP1ydDZKpHfc
   g==;
X-CSE-ConnectionGUID: UYbuIjShQSiADJk1BOLAKA==
X-CSE-MsgGUID: G9ojT8vIRt2v6zoiu08SVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565508"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565508"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:22:48 -0700
X-CSE-ConnectionGUID: gKXXZ7+RQuKLIE0qtKVoWw==
X-CSE-MsgGUID: XeYds5OAQ9+YkPiEWPamWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516143"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:22:45 -0700
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
Subject: [PATCH v2 04/31] x86/virt/tdx: Support allocating contiguous pages for tdx_page_array
Date: Sat, 28 Mar 2026 00:01:05 +0800
Message-Id: <20260327160132.2946114-5-yilun.xu@linux.intel.com>
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

The current tdx_page_array implementation allocates scattered order-0
pages. However, some TDX Module operations benefit from contiguous
physical memory. E.g. Enabling TDX Module Extensions (an optional TDX
feature) requires ~50MB memory and never returns. Such allocation
would at worst cause ~25GB permanently fragmented memory if each
allocated page is from a different 2M region.

Support allocating contiguous pages for tdx_page_array by making the
allocation method configurable. Change the tdx_page_array_alloc() to
accept a custom allocation function pointer and a context parameter.
Wrap the specific allocation into a tdx_page_array_alloc_contig()
helper.

The foreseeable caller will allocate ~50MB memory with this helper,
exceeding the maximum HPAs (512) a root page can hold, the typical usage
will be:

 - struct tdx_page_array *array = tdx_page_array_alloc_contig(nr_pages);
 - for each 512-page bulk
   - tdx_page_array_populate(array, offset);
   - seamcall(TDH_XXX_ADD, array, ...);

The configurable allocation method would also benefit more
tdx_page_array usages. TDX Module may require more specific memory
layouts encoded in the root page. Will introduce them in following
patches.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 42 +++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index a3021e7e2490..6c4ed80e8e5a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -289,7 +289,8 @@ static void tdx_free_pages_bulk(unsigned int nr_pages, struct page **pages)
 		__free_page(pages[i]);
 }
 
-static int tdx_alloc_pages_bulk(unsigned int nr_pages, struct page **pages)
+static int tdx_alloc_pages_bulk(unsigned int nr_pages, struct page **pages,
+				void *data)
 {
 	unsigned int filled, done = 0;
 
@@ -326,7 +327,10 @@ void tdx_page_array_free(struct tdx_page_array *array)
 EXPORT_SYMBOL_GPL(tdx_page_array_free);
 
 static struct tdx_page_array *
-tdx_page_array_alloc(unsigned int nr_pages)
+tdx_page_array_alloc(unsigned int nr_pages,
+		     int (*alloc_fn)(unsigned int nr_pages,
+				     struct page **pages, void *data),
+		     void *data)
 {
 	struct tdx_page_array *array = NULL;
 	struct page **pages = NULL;
@@ -348,7 +352,7 @@ tdx_page_array_alloc(unsigned int nr_pages)
 	if (!pages)
 		goto out_free;
 
-	ret = tdx_alloc_pages_bulk(nr_pages, pages);
+	ret = alloc_fn(nr_pages, pages, data);
 	if (ret)
 		goto out_free;
 
@@ -388,7 +392,7 @@ struct tdx_page_array *tdx_page_array_create(unsigned int nr_pages)
 	if (nr_pages > TDX_PAGE_ARRAY_MAX_NENTS)
 		return NULL;
 
-	array = tdx_page_array_alloc(nr_pages);
+	array = tdx_page_array_alloc(nr_pages, tdx_alloc_pages_bulk, NULL);
 	if (!array)
 		return NULL;
 
@@ -521,6 +525,36 @@ int tdx_page_array_ctrl_release(struct tdx_page_array *array,
 }
 EXPORT_SYMBOL_GPL(tdx_page_array_ctrl_release);
 
+static int tdx_alloc_pages_contig(unsigned int nr_pages, struct page **pages,
+				  void *data)
+{
+	struct page *page;
+	int i;
+
+	page = alloc_contig_pages(nr_pages, GFP_KERNEL, numa_mem_id(),
+				  &node_online_map);
+	if (!page)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_pages; i++)
+		pages[i] = page + i;
+
+	return 0;
+}
+
+/*
+ * For holding large number of contiguous pages, usually larger than
+ * TDX_PAGE_ARRAY_MAX_NENTS (512).
+ *
+ * Similar to tdx_page_array_alloc(), after allocating with this
+ * function, call tdx_page_array_populate() to populate the tdx_page_array.
+ */
+static __maybe_unused struct tdx_page_array *
+tdx_page_array_alloc_contig(unsigned int nr_pages)
+{
+	return tdx_page_array_alloc(nr_pages, tdx_alloc_pages_contig, NULL);
+}
+
 #define HPA_LIST_INFO_FIRST_ENTRY	GENMASK_U64(11, 3)
 #define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
 #define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
-- 
2.25.1

