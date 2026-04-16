Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3864248F64;
	Thu, 16 Apr 2026 05:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776317353; cv=none; b=gVHYREiF+rEl3y0mkEqT5ZYJLphGLUXgw/Ntk+P4neY9Kb2mrD7O9hPX1ZVGNJi4gt9KFgR2WDkmM2yvf+VO+4DWcJkM2cJRKcvMzvscMcWOz/HEyaKP+BU5mHWUMuG4gcb+q0yCfujVh//6Je6+B/2WFhcTLrxKWiWTYLPZipU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776317353; c=relaxed/simple;
	bh=S7mZ50UewIwmlyGHpi8dzh+qDTo7ko+JCZWvBEtCreE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eD4rxnry19Wbkws33cvC4HrOWKbhs4kLubxXMzu7187cXueVvftT4p18pxTyETSU9FratYLON9fAaxBv19zb2LN2apHXBxwl1bCZkBEfPI3SqQSqrY9CgC+Bt5+le0bjhW2/1Rmv6fdOfxbtOMMAaYyzOFxtjeEhtauE6ajP8lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDYI2RR7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDYI2RR7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776317350; x=1807853350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S7mZ50UewIwmlyGHpi8dzh+qDTo7ko+JCZWvBEtCreE=;
  b=SDYI2RR7OcVpmTEUm+OWa54m58H9EpZB7wtNGGNzWk1u1S4LsdKMsZnY
   smfc2JeOlXgQ9PUfyS4REYFPOeV7+15KnXUt9PBH2gG3BcVjfSrHBp5UF
   jDBjr/oKWgJXvDyAjBmBYJWXhrTG+peO86P/4qBUAYiacudwkBrwgKd41
   0DgUQJ/8Vu2KKwmNW/GQYrtXux9Job1bhD71aqefyu/4v2t54APHS/BD4
   L1vRxC/UPnTrceyHNI0Iypi5wZk8s6TESSpxcWOFK+BM5lGasRxDO6VP9
   +vMefuRHVfieZyIPtQ6B6lGO17D/NWzU/r2LPpJ3MUnBZiCI1wVzrS4Cf
   A==;
X-CSE-ConnectionGUID: mmLRnTsfT/yULIC6pWH1yA==
X-CSE-MsgGUID: z71NMsqDRgKC24ry8u2pAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="76473805"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="76473805"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 22:29:09 -0700
X-CSE-ConnectionGUID: YduiFPqZQwyAKPAY0P8OvQ==
X-CSE-MsgGUID: kspW7npLTiK2WgAcKVBEyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="235585135"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 15 Apr 2026 22:29:05 -0700
Date: Thu, 16 Apr 2026 13:07:10 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 05/31] x86/virt/tdx: Extend tdx_page_array to support
 IOMMU_MT
Message-ID: <aeBufjwO3t7XzVle@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-6-yilun.xu@linux.intel.com>
 <828f174d49a1ecaec65ba1179e08c6b22e249297.camel@intel.com>
 <acvX1x5nDdGtZWyI@yilunxu-OptiPlex-7050>
 <f38d0a080aee052937cb6721683d55155c657717.camel@intel.com>
 <ad4Pj0cqlprvNUSj@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4Pj0cqlprvNUSj@yilunxu-OptiPlex-7050>

On Tue, Apr 14, 2026 at 05:57:35PM +0800, Xu Yilun wrote:
> On Wed, Apr 01, 2026 at 12:17:45AM +0000, Edgecombe, Rick P wrote:
> > On Tue, 2026-03-31 at 22:19 +0800, Xu Yilun wrote:
> > > > Consider the amount of tricks that are needed to coax the tdx_page_array to
> > > > populate the handoff page as needed. It adds 2 pages here, then subtracts
> > > > them
> > > > later in the callback. Then tweaks the pa in tdx_page_array_populate() to
> > > > add
> > > > the length...
> > > 
> > > mm.. The tricky part is the specific memory requirement/allocation, the
> > > common part is the pa list contained in a root page. Maybe we only model
> > > the later, let the specific user does the memory allocation. Is that
> > > closer to your "break concepts apart" idea?
> > 
> > I haven't wrapped my head around this enough to suggest anything is definitely
> > the right approach.
> > 
> > But yes, the idea would be that the allocation of the list of pages to give to
> > the TDX module would be a separate allocation and set of management functions.
> > And the the allocation of the pages that are used to communicate the list of
> > pages (and in this case other args) with the module would be another set. So
> > each type of TDX module arg page format (IOMMU_MT, etc) would be separable, but
> > share the page list allocation part only. It looks like Nikolay was probing
> > along the same path. Not sure if he had the same solution in mind.
> > 
> > So for this:
> > 1. Allocate a list or array of pages using a generic method.
> > 2. Allocate these two IOMMU special pages.
> > 3. Allocate memory needed for the seamcall (root pages)
> > 
> > Hand all three to the wrapper and have it shove them all through in the special
> > way it prefers.
> 
> I'm drafting some changes and make the tdx_page_array look like:
> 
>   struct tdx_page_array {
> 	/* public: */
> 	unsigned int nr_pages;
> 	struct page **pages;
> 
> 	/* private: */
> 	u64 *root;
> 	bool flush_on_free;
>   };
> 
>   - I removed the page allocations for tdx_page_array kAPIs. Now the
>     caller needs to allocate the struct page **pages and the page list,
>     then create the tdx_page_array by providing these pages.
> 
>     struct tdx_page_array *tdx_page_array_create(struct page **pages,
> 						 unsigned int nr_pages)
> 
>     This also means tdx_page_array doesn't have to hold more than 512
>     pages anymore, it now an exact descriptor for the TDX Module's
>     definitions rather than a manager. It's a chunk of the required
>     memory when we need more than 512 pages. This eliminates the need
>     for 'offset' field and the slide window operations so make the
>     helpers simpler.
> 
>   - I still keep the generic struct tdx_page_array to represent all
>     kinds of object types (HPA_ARRAY_T, HPA_LIST_INFO, IOMMU_MT), and
>     provide the tdx_page_array to SEAMCALL helpers as parameters. I
>     think this structure is generally good enough to represent a list of
>     pages, keeps type safety compared to a list of HPAs.
> 
>   - I still record both the page list (struct page **pages) and the HPA
>     list (in u64 *root). struct page **pages works with kernel memory
>     management (e.g. vmap) well while the populated root works with
>     SEAMCALLs.
> 
>   - I'm not introducing more structures each for an object type, like 
>     struct hpa_array, struct hpa_list_info, struct iommu_metadata. They
>     are conceptually the same thing. The iommu_mt supports multi-order
>     pages, hpa_array_t & hpa_list_info don't support. But their bit
>     definitions don't conflict. I can use the same piece of code to
>     populate their root page content.
> 
>   - Add a flush_on_free field to mark if a cache write back is needed on
>     tdx_page_array_free(), then we don't need 2 free APIs.
> 
> I want to clean up my code, then post an incremental patch for preview.

Hi, I end up made the following changes on top of this series:

-------8<--------

 arch/x86/include/asm/tdx.h            |  32 +-
 arch/x86/virt/vmx/tdx/tdx.c           | 561 ++++++++------------------
 drivers/virt/coco/tdx-host/tdx-host.c | 179 ++++++--
 3 files changed, 316 insertions(+), 456 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 7bdd66acda5b..31d1101a4f45 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -143,15 +143,12 @@ void tdx_quirk_reset_page(struct page *page);
 
 /**
  * struct tdx_page_array - Represents a list of pages for TDX Module access
- * @nr_pages: Total number of data pages in the collection
- * @pages: Array of data page pointers containing all the data
+ * @nr_pages: Number of data pages in the collection (up to 512)
+ * @pages: Array of data page pointers
  *
- * @offset: Internal: The starting index in @pages, positions the currently
- *	    populated page window in @root.
- * @nents: Internal: Number of valid HPAs for the page window in @root
- * @root: Internal: A single 4KB page holding the 8-byte HPAs of the page
- *	  window. The page window max size is constrained by the root page,
- *	  which is 512 HPAs.
+ * @root: Internal: A single 4KB page holding the 8-byte HPAs of the @pages
+ * @flush_on_free: Internal: whether to flush cache when @pages are to be
+ *		   freed.
  *
  * This structure abstracts several TDX Module defined object types, e.g.,
  * HPA_ARRAY_T and HPA_LIST_INFO. Typically they all use a "root page" as the
@@ -165,20 +162,13 @@ struct tdx_page_array {
 	struct page **pages;
 
 	/* private: */
-	unsigned int offset;
-	unsigned int nents;
 	u64 *root;
+	bool flush_on_free;
 };
 
 void tdx_page_array_free(struct tdx_page_array *array);
-DEFINE_FREE(tdx_page_array_free, struct tdx_page_array *, if (_T) tdx_page_array_free(_T))
-struct tdx_page_array *tdx_page_array_create(unsigned int nr_pages);
-void tdx_page_array_ctrl_leak(struct tdx_page_array *array);
-int tdx_page_array_ctrl_release(struct tdx_page_array *array,
-				unsigned int nr_released,
-				u64 released_hpa);
-struct tdx_page_array *
-tdx_page_array_create_iommu_mt(unsigned int iq_order, unsigned int nr_mt_pages);
+struct tdx_page_array *tdx_page_array_create(struct page **pages,
+					     unsigned int nr_pages);
 
 struct tdx_td {
 	/* TD root structure: */
@@ -248,8 +238,7 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page);
 u64 tdh_iommu_setup(u64 vtbar, struct tdx_page_array *iommu_mt, u64 *iommu_id);
 u64 tdh_iommu_clear(u64 iommu_id, struct tdx_page_array *iommu_mt);
 u64 tdh_spdm_create(u64 func_id, struct tdx_page_array *spdm_mt, u64 *spdm_id);
-u64 tdh_spdm_delete(u64 spdm_id, struct tdx_page_array *spdm_mt,
-		    unsigned int *nr_released, u64 *released_hpa);
+u64 tdh_spdm_delete(u64 spdm_id, struct tdx_page_array *spdm_mt);
 u64 tdh_exec_spdm_connect(u64 spdm_id, struct page *spdm_conf,
 			  struct page *spdm_rsp, struct page *spdm_req,
 			  struct tdx_page_array *spdm_out,
@@ -269,8 +258,7 @@ u64 tdh_ide_stream_create(u64 stream_info, u64 spdm_id,
 			  u64 *rp_ide_id);
 u64 tdh_ide_stream_block(u64 spdm_id, u64 stream_id);
 u64 tdh_ide_stream_delete(u64 spdm_id, u64 stream_id,
-			  struct tdx_page_array *stream_mt,
-			  unsigned int *nr_released, u64 *released_hpa);
+			  struct tdx_page_array *stream_mt);
 u64 tdh_ide_stream_km(u64 spdm_id, u64 stream_id, u64 operation,
 		      struct page *spdm_rsp, struct page *spdm_req,
 		      u64 *spdm_req_len);
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 72d836b25bd6..04f47c5eb2a5 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -262,21 +262,27 @@ static int build_tdx_memlist(struct list_head *tmb_list)
 #define TDX_PAGE_ARRAY_MAX_NENTS	(PAGE_SIZE / sizeof(u64))
 
 static int tdx_page_array_populate(struct tdx_page_array *array,
-				   unsigned int offset)
+				   struct page **pages, unsigned int nr_pages)
 {
-	u64 *entries;
+	u64 *entries = array->root;
 	int i;
 
-	if (offset >= array->nr_pages)
-		return 0;
+	if (!pages || !nr_pages || nr_pages > TDX_PAGE_ARRAY_MAX_NENTS)
+		return -EINVAL;
+
+	/*
+	 * When re-populating, the old pages are no longer tracked.
+	 * Theoretically they require cache flushing similar to
+	 * tdx_page_array_free(). Since there is no use case for this yet,
+	 * just warn to prompt future improvement.
+	 */
+	WARN_ON_ONCE(array->pages && array->flush_on_free);
 
-	array->offset = offset;
-	array->nents = umin(array->nr_pages - offset,
-			    TDX_PAGE_ARRAY_MAX_NENTS);
+	for (i = 0; i < nr_pages; i++) {
+		struct page *page = pages[i];
 
-	entries = array->root;
-	for (i = 0; i < array->nents; i++) {
-		struct page *page = array->pages[offset + i];
+		if (!page)
+			return -EINVAL;
 
 		entries[i] = page_to_phys(page);
 
@@ -285,359 +291,96 @@ static int tdx_page_array_populate(struct tdx_page_array *array,
 			entries[i] |= compound_nr(page);
 	}
 
-	return array->nents;
-}
-
-static void tdx_free_pages_bulk(unsigned int nr_pages, struct page **pages)
-{
-	int i;
-
-	for (i = 0; i < nr_pages; i++)
-		put_page(pages[i]);
-}
-
-static int tdx_alloc_pages_bulk(unsigned int nr_pages, struct page **pages,
-				void *data)
-{
-	unsigned int filled, done = 0;
-
-	do {
-		filled = alloc_pages_bulk(GFP_KERNEL, nr_pages - done,
-					  pages + done);
-		if (!filled) {
-			tdx_free_pages_bulk(done, pages);
-			return -ENOMEM;
-		}
-
-		done += filled;
-	} while (done != nr_pages);
+	array->pages = pages;
+	array->nr_pages = nr_pages;
 
 	return 0;
 }
 
 /**
- * tdx_page_array_free() - Free all memory for a tdx_page_array
+ * tdx_page_array_free() - Free the tdx_page_array
  * @array: The tdx_page_array to be freed.
  *
- * Free all associated pages and the container itself.
+ * Free this page array decriptor. Note the associated pages are not
+ * freed, their lifecycles are not controlled by tdx_page_array.
+ *
+ * TDX Module may consume page array for private accessing, flush cache before
+ * this tracking decriptor is freed, to avoid private cache write back
+ * damages these pages which may further be returned to kernel and reused.
+ * Specific SEAMCALL helpers should indicate the flushing by setting this flag.
  */
 void tdx_page_array_free(struct tdx_page_array *array)
 {
 	if (!array)
 		return;
 
-	tdx_free_pages_bulk(array->nr_pages, array->pages);
-	kfree(array->pages);
-	kfree(array->root);
-	kfree(array);
-}
-EXPORT_SYMBOL_GPL(tdx_page_array_free);
-
-static struct tdx_page_array *
-tdx_page_array_alloc(unsigned int nr_pages,
-		     int (*alloc_fn)(unsigned int nr_pages,
-				     struct page **pages, void *data),
-		     void *data)
-{
-	struct tdx_page_array *array = NULL;
-	struct page **pages = NULL;
-	u64 *root = NULL;
-	int ret;
-
-	if (!nr_pages)
-		return NULL;
-
-	array = kzalloc_obj(*array);
-	if (!array)
-		goto out_free;
-
-	root = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!root)
-		goto out_free;
-
-	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
-	if (!pages)
-		goto out_free;
-
-	ret = alloc_fn(nr_pages, pages, data);
-	if (ret)
-		goto out_free;
+	if (array->flush_on_free) {
+		int i;
 
-	array->nr_pages = nr_pages;
-	array->pages = pages;
-	array->root = root;
+		for (i = 0; i < array->nr_pages; i++) {
+			u64 r;
 
-	return array;
+			r = tdh_phymem_page_wbinvd_hkid(tdx_global_keyid,
+							array->pages[i]);
+			WARN_ON_ONCE(r);
+		}
+	}
 
-out_free:
-	kfree(pages);
-	kfree(root);
+	kfree(array->root);
 	kfree(array);
-
-	return NULL;
 }
+EXPORT_SYMBOL_GPL(tdx_page_array_free);
 
-/**
- * tdx_page_array_create() - Create a small tdx_page_array (up to 512 pages)
- * @nr_pages: Number of pages to allocate (must be <= 512).
- *
- * Allocate and populate a tdx_page_array in a single step. This is intended
- * for small collections that fit within a single root page. The allocated
- * pages are all order-0 pages. This is the most common use case for a list of
- * TDX control pages.
- *
- * If more pages are required, use tdx_page_array_alloc() and
- * tdx_page_array_populate() to build tdx_page_array chunk by chunk.
- *
- * Return: Fully populated tdx_page_array or NULL on failure.
- */
-struct tdx_page_array *tdx_page_array_create(unsigned int nr_pages)
+static struct tdx_page_array *tdx_page_array_alloc(void)
 {
 	struct tdx_page_array *array;
-	int populated;
 
-	if (nr_pages > TDX_PAGE_ARRAY_MAX_NENTS)
-		return NULL;
-
-	array = tdx_page_array_alloc(nr_pages, tdx_alloc_pages_bulk, NULL);
+	array = kzalloc_obj(*array);
 	if (!array)
 		return NULL;
 
-	populated = tdx_page_array_populate(array, 0);
-	if (populated != nr_pages)
-		goto out_free;
-
-	return array;
-
-out_free:
-	tdx_page_array_free(array);
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(tdx_page_array_create);
-
-/**
- * tdx_page_array_ctrl_leak() - Leak data pages and free the container
- * @array: The tdx_page_array to be leaked.
- *
- * Call this function when failed to reclaim the control pages. Free the root
- * page and the holding structures, but orphan the data pages, to prevent the
- * host from re-allocating and accessing memory that the hardware may still
- * consider private.
- */
-void tdx_page_array_ctrl_leak(struct tdx_page_array *array)
-{
-	if (!array)
-		return;
-
-	kfree(array->pages);
-	kfree(array->root);
-	kfree(array);
-}
-EXPORT_SYMBOL_GPL(tdx_page_array_ctrl_leak);
-
-static bool tdx_page_array_validate_release(struct tdx_page_array *array,
-					    unsigned int offset,
-					    unsigned int nr_released,
-					    u64 released_hpa)
-{
-	unsigned int nents;
-
-	if (offset >= array->nr_pages)
-		return false;
-
-	nents = umin(array->nr_pages - offset, TDX_PAGE_ARRAY_MAX_NENTS);
-
-	if (nents != nr_released) {
-		pr_err("%s nr_released [%d] doesn't match page array nents [%d]\n",
-		       __func__, nr_released, nents);
-		return false;
-	}
-
-	/*
-	 * Unfortunately TDX has multiple page allocation protocols, check the
-	 * "singleton" case required for HPA_ARRAY_T.
-	 */
-	if (page_to_phys(array->pages[0]) == released_hpa &&
-	    array->nr_pages == 1)
-		return true;
-
-	/* Then check the "non-singleton" case */
-	if (virt_to_phys(array->root) == released_hpa) {
-		u64 *entries = array->root;
-		int i;
-
-		for (i = 0; i < nents; i++) {
-			struct page *page = array->pages[offset + i];
-			u64 val = page_to_phys(page);
-
-			/* Now only for iommu_mt */
-			if (compound_nr(page) > 1)
-				val |= compound_nr(page);
-
-			if (val != entries[i]) {
-				pr_err("%s entry[%d] [0x%llx] doesn't match page hpa [0x%llx]\n",
-				       __func__, i, entries[i], val);
-				return false;
-			}
-		}
-
-		return true;
+	array->root = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!array->root) {
+		kfree(array);
+		return NULL;
 	}
 
-	pr_err("%s failed to validate, released_hpa [0x%llx], root page hpa [0x%llx], page0 hpa [%#llx], number pages %u\n",
-	       __func__, released_hpa, virt_to_phys(array->root),
-	       page_to_phys(array->pages[0]), array->nr_pages);
-
-	return false;
+	return array;
 }
 
 /**
- * tdx_page_array_ctrl_release() - Verify and release TDX control pages
- * @array: The tdx_page_array used to originally create control pages.
- * @nr_released: Number of HPAs the TDX Module reported as released.
- * @released_hpa: The HPA list the TDX Module reported as released.
+ * tdx_page_array_create() - Create a populated tdx_page_array (up to 512 pages)
+ * @pages: Pointer to struct page array for tdx_page_array populating
+ * @nr_pages: Size of @pages array.
  *
- * TDX Module can at most release 512 control pages, so this function only
- * accepts small tdx_page_array (up to 512 pages), usually created by
- * tdx_page_array_create().
+ * Create a populated tdx_page_array in a single step. This is intended for
+ * small collections that fit within a single root page. This is the most
+ * common use case for a list of TDX control pages.
  *
- * Return: 0 on success, -errno on page release protocol error.
- */
-int tdx_page_array_ctrl_release(struct tdx_page_array *array,
-				unsigned int nr_released,
-				u64 released_hpa)
-{
-	int i;
-
-	/*
-	 * The only case where ->nr_pages is allowed to be >
-	 * TDX_PAGE_ARRAY_MAX_NENTS is a case where those pages are never
-	 * expected to be released by this function.
-	 */
-	if (WARN_ON(array->nr_pages > TDX_PAGE_ARRAY_MAX_NENTS))
-		return -EINVAL;
-
-	if (WARN_ONCE(!tdx_page_array_validate_release(array, 0, nr_released,
-						       released_hpa),
-		      "page release protocol error, consider reboot and replace TDX Module.\n"))
-		return -EFAULT;
-
-	for (i = 0; i < array->nr_pages; i++) {
-		u64 r;
-
-		r = tdh_phymem_page_wbinvd_hkid(tdx_global_keyid,
-						array->pages[i]);
-		if (WARN_ON(r))
-			return -EFAULT;
-	}
-
-	tdx_page_array_free(array);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(tdx_page_array_ctrl_release);
-
-static int tdx_alloc_pages_contig(unsigned int nr_pages, struct page **pages,
-				  void *data)
-{
-	struct page *page;
-	int i;
-
-	page = alloc_contig_pages(nr_pages, GFP_KERNEL, numa_mem_id(),
-				  &node_online_map);
-	if (!page)
-		return -ENOMEM;
-
-	for (i = 0; i < nr_pages; i++)
-		pages[i] = page + i;
-
-	return 0;
-}
-
-/*
- * For holding large number of contiguous pages, usually larger than
- * TDX_PAGE_ARRAY_MAX_NENTS (512).
- *
- * Similar to tdx_page_array_alloc(), after allocating with this
- * function, call tdx_page_array_populate() to populate the tdx_page_array.
- */
-static struct tdx_page_array *
-tdx_page_array_alloc_contig(unsigned int nr_pages)
-{
-	return tdx_page_array_alloc(nr_pages, tdx_alloc_pages_contig, NULL);
-}
-
-static int tdx_alloc_pages_iommu_mt(unsigned int nr_pages, struct page **pages,
-				    void *data)
-{
-	unsigned int iq_order = (unsigned int)(long)data;
-	struct folio *t_iq, *t_ctxiq;
-	int ret;
-
-	/* TODO: folio_alloc_node() is preferred, but need numa info */
-	t_iq = folio_alloc(GFP_KERNEL | __GFP_ZERO, iq_order);
-	if (!t_iq)
-		return -ENOMEM;
-
-	t_ctxiq = folio_alloc(GFP_KERNEL | __GFP_ZERO, iq_order);
-	if (!t_ctxiq) {
-		ret = -ENOMEM;
-		goto out_t_iq;
-	}
-
-	ret = tdx_alloc_pages_bulk(nr_pages - 2, pages + 2, NULL);
-	if (ret)
-		goto out_t_ctxiq;
-
-	pages[0] = folio_page(t_iq, 0);
-	pages[1] = folio_page(t_ctxiq, 0);
-
-	return 0;
-
-out_t_ctxiq:
-	folio_put(t_ctxiq);
-out_t_iq:
-	folio_put(t_iq);
-
-	return ret;
-}
-
-/**
- * tdx_page_array_create_iommu_mt() - Create a page array for IOMMU Memory Tables
- * @iq_order: The allocation order for the IOMMU Invalidation Queue.
- * @nr_mt_pages: Number of additional order-0 pages for the MT.
- *
- * Allocate and populate a specialized tdx_page_array for IOMMU_MT structures.
- * The resulting array consists of two multi-order folios (at index 0 and 1)
- * followed by the requested number of order-0 pages.
+ * If more pages are required, use tdx_page_array_alloc() and
+ * tdx_page_array_populate() to build tdx_page_array chunk by chunk.
  *
- * Return: Fully populated tdx_page_array or NULL on failure.
+ * Return: Populated tdx_page_array or NULL on failure.
  */
 struct tdx_page_array *
-tdx_page_array_create_iommu_mt(unsigned int iq_order, unsigned int nr_mt_pages)
+tdx_page_array_create(struct page **pages, unsigned int nr_pages)
 {
-	unsigned int nr_pages = nr_mt_pages + 2;
 	struct tdx_page_array *array;
-	int populated;
-
-	if (nr_pages > TDX_PAGE_ARRAY_MAX_NENTS)
-		return NULL;
+	int ret;
 
-	array = tdx_page_array_alloc(nr_pages, tdx_alloc_pages_iommu_mt,
-				     (void *)(long)iq_order);
+	array = tdx_page_array_alloc();
 	if (!array)
 		return NULL;
 
-	populated = tdx_page_array_populate(array, 0);
-	if (populated != nr_pages)
-		goto out_free;
+	ret = tdx_page_array_populate(array, pages, nr_pages);
+	if (ret) {
+		tdx_page_array_free(array);
+		return NULL;
+	}
 
 	return array;
-
-out_free:
-	tdx_page_array_free(array);
-	return NULL;
 }
-EXPORT_SYMBOL_GPL(tdx_page_array_create_iommu_mt);
+EXPORT_SYMBOL_GPL(tdx_page_array_create);
 
 #define HPA_LIST_INFO_FIRST_ENTRY	GENMASK_U64(11, 3)
 #define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
@@ -648,7 +391,7 @@ static u64 hpa_list_info_assign_raw(struct tdx_page_array *array)
 	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
 	       FIELD_PREP(HPA_LIST_INFO_PFN,
 			  PFN_DOWN(virt_to_phys(array->root))) |
-	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, array->nents - 1);
+	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, array->nr_pages - 1);
 }
 
 #define HPA_ARRAY_T_PFN		GENMASK_U64(51, 12)
@@ -658,18 +401,18 @@ static u64 hpa_array_t_assign_raw(struct tdx_page_array *array)
 {
 	unsigned long pfn;
 
-	if (array->nents == 1)
-		pfn = page_to_pfn(array->pages[array->offset]);
+	if (array->nr_pages == 1)
+		pfn = page_to_pfn(array->pages[0]);
 	else
 		pfn = PFN_DOWN(virt_to_phys(array->root));
 
 	return FIELD_PREP(HPA_ARRAY_T_PFN, pfn) |
-	       FIELD_PREP(HPA_ARRAY_T_SIZE, array->nents - 1);
+	       FIELD_PREP(HPA_ARRAY_T_SIZE, array->nr_pages - 1);
 }
 
 static u64 hpa_array_t_release_raw(struct tdx_page_array *array)
 {
-	if (array->nents == 1)
+	if (array->nr_pages == 1)
 		return 0;
 
 	return virt_to_phys(array->root);
@@ -1515,8 +1258,8 @@ static void tdx_clflush_page(struct page *page)
 
 static void tdx_clflush_page_array(struct tdx_page_array *array)
 {
-	for (int i = 0; i < array->nents; i++)
-		tdx_clflush_page(array->pages[array->offset + i]);
+	for (int i = 0; i < array->nr_pages; i++)
+		tdx_clflush_page(array->pages[i]);
 }
 
 /* Initialize the TDX Module Extensions then Extension-SEAMCALLs can be used */
@@ -1536,14 +1279,14 @@ static int tdx_ext_init(void)
 	return 0;
 }
 
-static int tdx_ext_mem_add(struct tdx_page_array *ext_mem)
+static int tdx_ext_mem_add(struct tdx_page_array *mem)
 {
 	struct tdx_module_args args = {
-		.rcx = hpa_list_info_assign_raw(ext_mem),
+		.rcx = hpa_list_info_assign_raw(mem),
 	};
 	u64 r;
 
-	tdx_clflush_page_array(ext_mem);
+	tdx_clflush_page_array(mem);
 
 	do {
 		r = seamcall_ret(TDH_EXT_MEM_ADD, &args);
@@ -1556,33 +1299,86 @@ static int tdx_ext_mem_add(struct tdx_page_array *ext_mem)
 	return 0;
 }
 
-static int tdx_ext_mem_setup(struct tdx_page_array *ext_mem)
+struct tdx_ext_mem {
+	struct page **pages;
+	unsigned int nr_pages;
+	struct tdx_page_array *chunk;
+};
+
+static void tdx_ext_mem_remove(struct tdx_ext_mem *ext_mem)
 {
-	unsigned int populated, offset = 0;
-	int ret;
+	int i;
 
-	/*
-	 * tdx_page_array's root page can hold 512 HPAs at most. We have ~50MB
-	 * memory to add, re-populate the array and add pages bulk by bulk.
-	 */
-	while (1) {
-		populated = tdx_page_array_populate(ext_mem, offset);
-		if (!populated)
-			break;
+	tdx_page_array_free(ext_mem->chunk);
+
+	for (i = 0; i < ext_mem->nr_pages; i++)
+		__free_page(ext_mem->pages[i]);
+
+	kfree(ext_mem->pages);
+}
+
+static int tdx_ext_mem_setup(unsigned int nr_pages,
+			     struct tdx_ext_mem *ext_mem)
+{
+	struct tdx_page_array *chunk;
+	struct page **pages;
+	struct page *page;
+	int i, ret;
 
-		ret = tdx_ext_mem_add(ext_mem);
+	pages = kmalloc_objs(*pages, nr_pages);
+	if (!pages)
+		return -ENOMEM;
+
+	page = alloc_contig_pages(nr_pages, GFP_KERNEL, numa_mem_id(),
+				  &node_online_map);
+	if (!page) {
+		ret = -ENOMEM;
+		goto out_free_pages;
+	}
+
+	for (i = 0; i < nr_pages; i++)
+		pages[i] = page + i;
+
+	chunk = tdx_page_array_alloc();
+	if (!chunk) {
+		ret = -ENOMEM;
+		goto out_free_contig;
+	}
+
+	for (i = 0; i < nr_pages;) {
+		int nents = min(nr_pages - i, TDX_PAGE_ARRAY_MAX_NENTS);
+
+		ret = tdx_page_array_populate(chunk, pages + i, nents);
 		if (ret)
-			return ret;
+			goto out_free_chunk;
+
+		ret = tdx_ext_mem_add(chunk);
+		if (ret)
+			goto out_free_chunk;
 
-		offset += populated;
+		i += nents;
 	}
 
+	ext_mem->nr_pages = nr_pages;
+	ext_mem->pages = pages;
+	ext_mem->chunk = chunk;
+
 	return 0;
+
+out_free_chunk:
+	tdx_page_array_free(chunk);
+out_free_contig:
+	for (i = 0; i < nr_pages; i++)
+		__free_page(pages[i]);
+out_free_pages:
+	kfree(pages);
+
+	return ret;
 }
 
 static int init_tdx_ext(void)
 {
-	struct tdx_page_array *ext_mem = NULL;
+	struct tdx_ext_mem ext_mem;
 	unsigned int nr_pages;
 	int ret;
 
@@ -1600,48 +1396,48 @@ static int init_tdx_ext(void)
 	if (boot_cpu_has_bug(X86_BUG_TDX_PW_MCE))
 		return -ENXIO;
 
+	/* No feature requires TDX Module Extensions. */
+	if (!tdx_sysinfo.ext.ext_required)
+		return 0;
+
 	nr_pages = tdx_sysinfo.ext.memory_pool_required_pages;
 	/*
 	 * memory_pool_required_pages == 0 means no need to add more pages,
 	 * skip the memory setup.
 	 */
 	if (nr_pages) {
-		ext_mem = tdx_page_array_alloc_contig(nr_pages);
-		if (!ext_mem)
-			return -ENOMEM;
-
-		ret = tdx_ext_mem_setup(ext_mem);
+		ret = tdx_ext_mem_setup(nr_pages, &ext_mem);
 		if (ret)
-			goto out_ext_mem;
+			return ret;
 	}
 
+	ret = tdx_ext_init();
+	if (ret)
+		goto out_remove_ext_mem;
+
 	/*
-	 * ext_required == 0 means no need to call TDH.EXT.INIT, the Extensions
-	 * are already working.
+	 * Extensions memory is never reclaimed once assigned, stop tracking it
+	 * and free the tracking structures.
 	 */
-	if (tdx_sysinfo.ext.ext_required) {
-		ret = tdx_ext_init();
-		/*
-		 * Some pages may have been touched by the TDX module.
-		 * Flush cache before returning these pages to kernel.
-		 */
-		if (ret)
-			goto out_flush;
-	}
-
-	/* Extension memory is never reclaimed once assigned */
-	tdx_page_array_ctrl_leak(ext_mem);
+	tdx_page_array_free(ext_mem.chunk);
+	kfree(ext_mem.pages);
 
 	pr_info("%lu KB allocated for TDX Module Extensions\n",
 		nr_pages * PAGE_SIZE / 1024);
 
 	return 0;
 
-out_flush:
-	if (ext_mem)
+out_remove_ext_mem:
+	if (nr_pages) {
+		/*
+		 * TDH.EXT.MEM.ADD only collects required memory. TDX.EXT.INIT
+		 * does the actual initialization so if it fails some pages may
+		 * have been touched by the TDX module, flush cache before
+		 * returning these pages to kernel.
+		 */
 		wbinvd_on_all_cpus();
-out_ext_mem:
-	tdx_page_array_free(ext_mem);
+		tdx_ext_mem_remove(&ext_mem);
+	}
 
 	return ret;
 }
@@ -2497,6 +2293,7 @@ u64 tdh_iommu_setup(u64 vtbar, struct tdx_page_array *iommu_mt, u64 *iommu_id)
 	u64 r;
 
 	tdx_clflush_page_array(iommu_mt);
+	iommu_mt->flush_on_free = true;
 
 	r = seamcall_ret_ir_resched(TDH_IOMMU_SETUP, &args);
 
@@ -2525,6 +2322,7 @@ u64 tdh_spdm_create(u64 func_id, struct tdx_page_array *spdm_mt, u64 *spdm_id)
 	u64 r;
 
 	tdx_clflush_page_array(spdm_mt);
+	spdm_mt->flush_on_free = true;
 
 	r = seamcall_ret(TDH_SPDM_CREATE, &args);
 
@@ -2534,23 +2332,14 @@ u64 tdh_spdm_create(u64 func_id, struct tdx_page_array *spdm_mt, u64 *spdm_id)
 }
 EXPORT_SYMBOL_FOR_MODULES(tdh_spdm_create, "tdx-host");
 
-u64 tdh_spdm_delete(u64 spdm_id, struct tdx_page_array *spdm_mt,
-		    unsigned int *nr_released, u64 *released_hpa)
+u64 tdh_spdm_delete(u64 spdm_id, struct tdx_page_array *spdm_mt)
 {
 	struct tdx_module_args args = {
 		.rcx = spdm_id,
 		.rdx = hpa_array_t_release_raw(spdm_mt),
 	};
-	u64 r;
-
-	r = seamcall_ret(TDH_SPDM_DELETE, &args);
-	if (r != TDX_SUCCESS)
-		return r;
 
-	*nr_released = FIELD_GET(HPA_ARRAY_T_SIZE, args.rcx) + 1;
-	*released_hpa = FIELD_GET(HPA_ARRAY_T_PFN, args.rcx) << PAGE_SHIFT;
-
-	return r;
+	return seamcall_ret(TDH_SPDM_DELETE, &args);
 }
 EXPORT_SYMBOL_FOR_MODULES(tdh_spdm_delete, "tdx-host");
 
@@ -2639,6 +2428,7 @@ u64 tdh_ide_stream_create(u64 stream_info, u64 spdm_id,
 	u64 r;
 
 	tdx_clflush_page_array(stream_mt);
+	stream_mt->flush_on_free = true;
 
 	r = seamcall_saved_ret(TDH_IDE_STREAM_CREATE, &args);
 
@@ -2661,24 +2451,15 @@ u64 tdh_ide_stream_block(u64 spdm_id, u64 stream_id)
 EXPORT_SYMBOL_FOR_MODULES(tdh_ide_stream_block, "tdx-host");
 
 u64 tdh_ide_stream_delete(u64 spdm_id, u64 stream_id,
-			  struct tdx_page_array *stream_mt,
-			  unsigned int *nr_released, u64 *released_hpa)
+			  struct tdx_page_array *stream_mt)
 {
 	struct tdx_module_args args = {
 		.rcx = spdm_id,
 		.rdx = stream_id,
 		.r8 = hpa_array_t_release_raw(stream_mt),
 	};
-	u64 r;
 
-	r = seamcall_ret(TDH_IDE_STREAM_DELETE, &args);
-	if (r != TDX_SUCCESS)
-		return r;
-
-	*nr_released = FIELD_GET(HPA_ARRAY_T_SIZE, args.rcx) + 1;
-	*released_hpa = FIELD_GET(HPA_ARRAY_T_PFN, args.rcx) << PAGE_SHIFT;
-
-	return r;
+	return seamcall_ret(TDH_IDE_STREAM_DELETE, &args);
 }
 EXPORT_SYMBOL_FOR_MODULES(tdh_ide_stream_delete, "tdx-host");
 
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 7800afb0893d..3a37e78dbc89 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -83,6 +83,119 @@ static struct tdx_tsm_link *to_tdx_tsm_link(struct pci_tsm *tsm)
 	return container_of(tsm, struct tdx_tsm_link, pci.base_tsm);
 }
 
+static void tdx_free_pages_bulk(unsigned int nr_pages, struct page **pages)
+{
+	int i;
+
+	for (i = 0; i < nr_pages; i++)
+		put_page(pages[i]);
+}
+
+static int tdx_alloc_pages_bulk(unsigned int nr_pages, struct page **pages)
+{
+	unsigned int filled, done = 0;
+
+	do {
+		filled = alloc_pages_bulk(GFP_KERNEL, nr_pages - done,
+					  pages + done);
+		if (!filled) {
+			tdx_free_pages_bulk(done, pages);
+			return -ENOMEM;
+		}
+
+		done += filled;
+	} while (done != nr_pages);
+
+	return 0;
+}
+
+static void tdx_page_array_mt_free(struct tdx_page_array *array_mt)
+{
+	struct page **pages = array_mt->pages;
+	unsigned int nr_pages = array_mt->nr_pages;
+
+	tdx_page_array_free(array_mt);
+	tdx_free_pages_bulk(nr_pages, pages);
+	kfree(pages);
+}
+
+DEFINE_FREE(tdx_page_array_mt_free, struct tdx_page_array *, if (_T) tdx_page_array_mt_free(_T))
+
+static struct tdx_page_array *tdx_page_array_mt_create(unsigned int nr_pages)
+{
+	struct tdx_page_array *array;
+	struct page **pages;
+	int ret;
+
+	pages = kzalloc_objs(*pages, nr_pages);
+	if (!pages)
+		return NULL;
+
+	ret = tdx_alloc_pages_bulk(nr_pages, pages);
+	if (ret)
+		goto out_free_pages;
+
+	array = tdx_page_array_create(pages, nr_pages);
+	if (!array)
+		goto out_free_bulk;
+
+	return array;
+
+out_free_bulk:
+	tdx_free_pages_bulk(nr_pages, pages);
+out_free_pages:
+	kfree(pages);
+
+	return NULL;
+}
+
+static struct tdx_page_array *
+tdx_page_array_iommu_mt_create(unsigned int iq_order, unsigned int nr_mt_pages)
+{
+	unsigned int nr_pages = nr_mt_pages + 2;
+	struct tdx_page_array *array;
+	struct folio *t_iq, *t_ctxiq;
+	struct page **pages;
+	int ret;
+
+	pages = kzalloc_objs(*pages, nr_pages);
+	if (!pages)
+		return NULL;
+
+	/* TODO: folio_alloc_node() is preferred, but need numa info */
+	t_iq = folio_alloc(GFP_KERNEL | __GFP_ZERO, iq_order);
+	if (!t_iq)
+		goto out_free_pages;
+
+	t_ctxiq = folio_alloc(GFP_KERNEL | __GFP_ZERO, iq_order);
+	if (!t_ctxiq)
+		goto out_free_t_iq;
+
+	pages[0] = folio_page(t_iq, 0);
+	pages[1] = folio_page(t_ctxiq, 0);
+
+	ret = tdx_alloc_pages_bulk(nr_mt_pages, pages + 2);
+	if (ret)
+		goto out_free_t_ctxiq;
+
+	array = tdx_page_array_create(pages, nr_pages);
+	if (!array)
+		goto out_free_bulk;
+
+	return array;
+
+out_free_bulk:
+	tdx_free_pages_bulk(nr_mt_pages, pages + 2);
+out_free_t_ctxiq:
+	folio_put(t_ctxiq);
+out_free_t_iq:
+	folio_put(t_iq);
+out_free_pages:
+	kfree(pages);
+
+	return NULL;
+}
+
 #define PCI_DOE_DATA_OBJECT_HEADER_1_OFFSET	0
 #define PCI_DOE_DATA_OBJECT_HEADER_2_OFFSET	4
 #define PCI_DOE_DATA_OBJECT_HEADER_SIZE		8
@@ -275,8 +388,8 @@ static struct tdx_tsm_link *tdx_spdm_create(struct tdx_tsm_link *tlink)
 	unsigned int nr_pages = tdx_sysinfo->connect.spdm_mt_page_count;
 	u64 spdm_id, r;
 
-	struct tdx_page_array *spdm_mt __free(tdx_page_array_free) =
-		tdx_page_array_create(nr_pages);
+	struct tdx_page_array *spdm_mt __free(tdx_page_array_mt_free) =
+		tdx_page_array_mt_create(nr_pages);
 	if (!spdm_mt)
 		return ERR_PTR(-ENOMEM);
 
@@ -292,24 +405,18 @@ static struct tdx_tsm_link *tdx_spdm_create(struct tdx_tsm_link *tlink)
 static void tdx_spdm_delete(struct tdx_tsm_link *tlink)
 {
 	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
-	unsigned int nr_released;
-	u64 released_hpa, r;
+	u64 r;
 
-	r = tdh_spdm_delete(tlink->spdm_id, tlink->spdm_mt, &nr_released, &released_hpa);
+	r = tdh_spdm_delete(tlink->spdm_id, tlink->spdm_mt);
 	if (r) {
+		/* leak the metadata pages */
 		pci_err(pdev, "fail to delete spdm 0x%llx\n", r);
-		goto leak;
+		return;
 	}
 
-	if (tdx_page_array_ctrl_release(tlink->spdm_mt, nr_released, released_hpa)) {
-		pci_err(pdev, "fail to release spdm_mt pages\n");
-		goto leak;
-	}
+	tdx_page_array_mt_free(tlink->spdm_mt);
 
 	return;
-
-leak:
-	tdx_page_array_ctrl_leak(tlink->spdm_mt);
 }
 
 DEFINE_FREE(tdx_spdm_delete, struct tdx_tsm_link *, if (!IS_ERR_OR_NULL(_T)) tdx_spdm_delete(_T))
@@ -323,8 +430,8 @@ static struct tdx_tsm_link *tdx_spdm_session_setup(struct tdx_tsm_link *tlink)
 	if (IS_ERR(tlink_create))
 		return tlink_create;
 
-	struct tdx_page_array *dev_info __free(tdx_page_array_free) =
-		tdx_page_array_create(nr_pages);
+	struct tdx_page_array *dev_info __free(tdx_page_array_mt_free) =
+		tdx_page_array_mt_create(nr_pages);
 	if (!dev_info)
 		return ERR_PTR(-ENOMEM);
 
@@ -424,8 +531,8 @@ static struct tdx_tsm_link *tdx_ide_stream_create(struct tdx_tsm_link *tlink,
 	struct pci_ide_regs regs;
 	u64 r;
 
-	struct tdx_page_array *stream_mt __free(tdx_page_array_free) =
-		tdx_page_array_create(nr_pages);
+	struct tdx_page_array *stream_mt __free(tdx_page_array_mt_free) =
+		tdx_page_array_mt_create(nr_pages);
 	if (!stream_mt)
 		return ERR_PTR(-ENOMEM);
 
@@ -472,33 +579,23 @@ static struct tdx_tsm_link *tdx_ide_stream_create(struct tdx_tsm_link *tlink,
 static void tdx_ide_stream_delete(struct tdx_tsm_link *tlink)
 {
 	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
-	unsigned int nr_released;
-	u64 released_hpa, r;
+	u64 r;
 
 	r = tdh_ide_stream_block(tlink->spdm_id, tlink->stream_id);
 	if (r) {
+		/* leak the metadata pages */
 		pci_err(pdev, "ide stream block fail 0x%llx\n", r);
-		goto leak;
+		return;
 	}
 
 	r = tdh_ide_stream_delete(tlink->spdm_id, tlink->stream_id,
-				  tlink->stream_mt, &nr_released,
-				  &released_hpa);
+				  tlink->stream_mt);
 	if (r) {
 		pci_err(pdev, "ide stream delete fail 0x%llx\n", r);
-		goto leak;
-	}
-
-	if (tdx_page_array_ctrl_release(tlink->stream_mt, nr_released,
-					released_hpa)) {
-		pci_err(pdev, "fail to release IDE stream_mt pages\n");
-		goto leak;
+		return;
 	}
 
-	return;
-
-leak:
-	tdx_page_array_ctrl_leak(tlink->stream_mt);
+	tdx_page_array_mt_free(tlink->stream_mt);
 }
 
 DEFINE_FREE(tdx_ide_stream_delete, struct tdx_tsm_link *,
@@ -815,20 +912,14 @@ static void tdx_iommu_clear(u64 iommu_id, struct tdx_page_array *iommu_mt)
 
 	r = tdh_iommu_clear(iommu_id, iommu_mt);
 	if (r) {
+		/* leak the metadata pages */
 		pr_err("fail to clear tdx iommu 0x%llx\n", r);
-		goto leak;
+		return;
 	}
 
-	if (tdx_page_array_ctrl_release(iommu_mt, iommu_mt->nr_pages,
-					virt_to_phys(iommu_mt->root))) {
-		pr_err("fail to release iommu_mt pages\n");
-		goto leak;
-	}
+	tdx_page_array_mt_free(iommu_mt);
 
 	return;
-
-leak:
-	tdx_page_array_ctrl_leak(iommu_mt);
 }
 
 static int tdx_iommu_enable_one(struct dmar_drhd_unit *drhd)
@@ -837,8 +928,8 @@ static int tdx_iommu_enable_one(struct dmar_drhd_unit *drhd)
 	u64 r, iommu_id;
 	int ret;
 
-	struct tdx_page_array *iommu_mt __free(tdx_page_array_free) =
-		tdx_page_array_create_iommu_mt(1, nr_pages);
+	struct tdx_page_array *iommu_mt __free(tdx_page_array_mt_free) =
+		tdx_page_array_iommu_mt_create(1, nr_pages);
 	if (!iommu_mt)
 		return -ENOMEM;

