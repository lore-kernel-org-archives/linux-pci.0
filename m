Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A0335B65F;
	Fri, 27 Mar 2026 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628568; cv=none; b=YZQH9XN8uROumQ0n6ihw99WZC7Tkl3/m84JoWCPEUqjG37Z691XUZKFf5r4MPYF1TqhJTCB6VOUmvDsB2IM5/x/8XC+Qh3U5OHn1K2Kupion0HhzefKAKuWfjNh1bZQDIHCfzP78rqMv+j62vldDWhN5BUfisZZQdGSUwdLgJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628568; c=relaxed/simple;
	bh=AG4iml9WAszT+rigBrGpH8H5M7c1d9jK3pet9HvraTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AgFMO0gBWFuhdPbYeFN9v2Pt6PzIHDmElA28nes7Jm7bbml5a+QbXROEOK47kCixBpo9NUMc6g+9jzCZLj8MJubG8A6B9CmAGd1GAzyZVwEzs/KbYvlU42Kll+HSDIScyNO1NiJD9qy2FkqcWBMLJahAglwQ0SXajQHdseV4Tbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l08lMvyJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l08lMvyJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628564; x=1806164564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AG4iml9WAszT+rigBrGpH8H5M7c1d9jK3pet9HvraTI=;
  b=l08lMvyJAgqCdtAAbmwyB2qIqHQw5+4hetBEN5m1oK/R9h24gv2OK/HI
   pOXBRce/PaiubjEbPgKbLg5JWKl9DnuBuKNEbfoDyEqblIadPkGJEma8j
   MMPOJgE2AvrmoNefdHAAIvPqW9cwfDlGuBzockWacmD2AIvwCeaiVpOE3
   GBTx9zmOgZRCiB8qSwYud/TB7zY4YnPtk3ukq5fOMCNjLSyFI7Q2Q61Nu
   OKfRaUMsdiTFJ6eARTMoJte/sDYsSzRDj85EA2fW8ITfKp1stmKb3AWUV
   +esc4UgnDY+amTARYx3o5WWn9kyhvMrvP6CDQSU7+PsiNtD/YBr67ZDrp
   w==;
X-CSE-ConnectionGUID: yz5aT9laR5GrvwOa4Bj9Dg==
X-CSE-MsgGUID: DLmGIb0BRPm/oJOtmlPDkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565504"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565504"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:22:44 -0700
X-CSE-ConnectionGUID: u9OExjqsRtGhT2BbGg6cfg==
X-CSE-MsgGUID: DJi5nfsTRC+prmNX404Lmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516132"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:22:41 -0700
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
Subject: [PATCH v2 03/31] x86/virt/tdx: Add tdx_page_array helpers for new TDX Module objects
Date: Sat, 28 Mar 2026 00:01:04 +0800
Message-Id: <20260327160132.2946114-4-yilun.xu@linux.intel.com>
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

Add struct tdx_page_array definition for new TDX Module object
types - HPA_ARRAY_T and HPA_LIST_INFO. They are used as input/output
parameters in newly defined SEAMCALLs. Also define some helpers to
allocate, setup and free tdx_page_array.

HPA_ARRAY_T and HPA_LIST_INFO are similar in most aspects. They both
represent a list of pages for TDX Module accessing. There are several
use cases for these 2 structures:

 - As SEAMCALL inputs. They are claimed by TDX Module as control pages.
   Control pages are private pages for TDX Module to hold its internal
   control structures or private data. TDR, TDCS, TDVPR... are existing
   control pages, just not added via tdx_page_array.
 - As SEAMCALL outputs. They were TDX Module control pages and now are
   released.
 - As SEAMCALL inputs. They are just temporary buffers for exchanging
   data blobs in one SEAMCALL. TDX Module will not hold them for long
   time.

The 2 structures both need a 'root page' which contains a list of HPAs.
They collapse the HPA of the root page and the number of valid HPAs
into a 64 bit raw value for SEAMCALL parameters. The root page is
always a medium for passing data pages, TDX Module never keeps the
root page.

A main difference is HPA_ARRAY_T requires singleton mode when
containing just 1 functional page (page0). In this mode the root page is
not needed and the HPA field of the raw value directly points to the
page0. But in this patch, root page is always allocated for user
friendly kAPIs.

Another small difference is HPA_LIST_INFO contains a 'first entry' field
which could be filled by TDX Module. This simplifies host by providing
the same structure when re-invoke the interrupted SEAMCALL. No need for
host to touch this field.

Typical usages of the tdx_page_array:

1. Add control pages:
 - struct tdx_page_array *array = tdx_page_array_create(nr_pages);
 - seamcall(TDH_XXX_CREATE, array, ...);

2. Release control pages:
 - seamcall(TDX_XXX_DELETE, array, &nr_released, &released_hpa);
 - tdx_page_array_ctrl_release(array, nr_released, released_hpa);

3. Exchange data blobs:
 - struct tdx_page_array *array = tdx_page_array_create(nr_pages);
 - seamcall(TDX_XXX, array, ...);
 - Read data from array.
 - tdx_page_array_free(array);

4. Note the root page contains 512 HPAs at most, if more pages are
   required, re-populate the tdx_page_array is needed.

 - struct tdx_page_array *array = tdx_page_array_alloc(nr_pages);
 - for each 512-page bulk
   - tdx_page_array_populate(array, offset);
   - seamcall(TDH_XXX_ADD, array, ...);

In case 2, SEAMCALLs output the released page array in the form of
HPA_ARRAY_T or PAGE_LIST_INFO. Use tdx_page_array_ctrl_release() to
check if the output pages match the original input pages. If failed,
TDX Module is buggy. In this case the safer way is to leak the
control pages, call tdx_page_array_ctrl_leak().

The usage of tdx_page_array will be in following patches.

Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h  |  37 +++++
 arch/x86/virt/vmx/tdx/tdx.c | 299 ++++++++++++++++++++++++++++++++++++
 2 files changed, 336 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 65c4da396450..9173a432b312 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -139,6 +139,43 @@ void tdx_guest_keyid_free(unsigned int keyid);
 
 void tdx_quirk_reset_page(struct page *page);
 
+/**
+ * struct tdx_page_array - Represents a list of pages for TDX Module access
+ * @nr_pages: Total number of data pages in the collection
+ * @pages: Array of data page pointers containing all the data
+ *
+ * @offset: Internal: The starting index in @pages, positions the currently
+ *	    populated page window in @root.
+ * @nents: Internal: Number of valid HPAs for the page window in @root
+ * @root: Internal: A single 4KB page holding the 8-byte HPAs of the page
+ *	  window. The page window max size is constrained by the root page,
+ *	  which is 512 HPAs.
+ *
+ * This structure abstracts several TDX Module defined object types, e.g.,
+ * HPA_ARRAY_T and HPA_LIST_INFO. Typically they all use a "root page" as the
+ * medium to exchange a list of data pages between host and TDX Module. This
+ * structure serves as a unified parameter type for SEAMCALL wrappers, where
+ * these hardware object types are needed.
+ */
+struct tdx_page_array {
+	/* public: */
+	unsigned int nr_pages;
+	struct page **pages;
+
+	/* private: */
+	unsigned int offset;
+	unsigned int nents;
+	u64 *root;
+};
+
+void tdx_page_array_free(struct tdx_page_array *array);
+DEFINE_FREE(tdx_page_array_free, struct tdx_page_array *, if (_T) tdx_page_array_free(_T))
+struct tdx_page_array *tdx_page_array_create(unsigned int nr_pages);
+void tdx_page_array_ctrl_leak(struct tdx_page_array *array);
+int tdx_page_array_ctrl_release(struct tdx_page_array *array,
+				unsigned int nr_released,
+				u64 released_hpa);
+
 struct tdx_td {
 	/* TD root structure: */
 	struct page *tdr_page;
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 8b8e165a2001..a3021e7e2490 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -30,6 +30,7 @@
 #include <linux/suspend.h>
 #include <linux/idr.h>
 #include <linux/kvm_types.h>
+#include <linux/bitfield.h>
 #include <asm/page.h>
 #include <asm/special_insns.h>
 #include <asm/msr-index.h>
@@ -258,6 +259,304 @@ static int build_tdx_memlist(struct list_head *tmb_list)
 	return ret;
 }
 
+#define TDX_PAGE_ARRAY_MAX_NENTS	(PAGE_SIZE / sizeof(u64))
+
+static int tdx_page_array_populate(struct tdx_page_array *array,
+				   unsigned int offset)
+{
+	u64 *entries;
+	int i;
+
+	if (offset >= array->nr_pages)
+		return 0;
+
+	array->offset = offset;
+	array->nents = umin(array->nr_pages - offset,
+			    TDX_PAGE_ARRAY_MAX_NENTS);
+
+	entries = array->root;
+	for (i = 0; i < array->nents; i++)
+		entries[i] = page_to_phys(array->pages[offset + i]);
+
+	return array->nents;
+}
+
+static void tdx_free_pages_bulk(unsigned int nr_pages, struct page **pages)
+{
+	int i;
+
+	for (i = 0; i < nr_pages; i++)
+		__free_page(pages[i]);
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
+/**
+ * tdx_page_array_free() - Free all memory for a tdx_page_array
+ * @array: The tdx_page_array to be freed.
+ *
+ * Free all associated pages and the container itself.
+ */
+void tdx_page_array_free(struct tdx_page_array *array)
+{
+	if (!array)
+		return;
+
+	tdx_free_pages_bulk(array->nr_pages, array->pages);
+	kfree(array->pages);
+	kfree(array->root);
+	kfree(array);
+}
+EXPORT_SYMBOL_GPL(tdx_page_array_free);
+
+static struct tdx_page_array *
+tdx_page_array_alloc(unsigned int nr_pages)
+{
+	struct tdx_page_array *array = NULL;
+	struct page **pages = NULL;
+	u64 *root = NULL;
+	int ret;
+
+	if (!nr_pages)
+		return NULL;
+
+	array = kzalloc_obj(*array);
+	if (!array)
+		goto out_free;
+
+	root = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!root)
+		goto out_free;
+
+	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		goto out_free;
+
+	ret = tdx_alloc_pages_bulk(nr_pages, pages);
+	if (ret)
+		goto out_free;
+
+	array->nr_pages = nr_pages;
+	array->pages = pages;
+	array->root = root;
+
+	return array;
+
+out_free:
+	kfree(pages);
+	kfree(root);
+	kfree(array);
+
+	return NULL;
+}
+
+/**
+ * tdx_page_array_create() - Create a small tdx_page_array (up to 512 pages)
+ * @nr_pages: Number of pages to allocate (must be <= 512).
+ *
+ * Allocate and populate a tdx_page_array in a single step. This is intended
+ * for small collections that fit within a single root page. The allocated
+ * pages are all order-0 pages. This is the most common use case for a list of
+ * TDX control pages.
+ *
+ * If more pages are required, use tdx_page_array_alloc() and
+ * tdx_page_array_populate() to build tdx_page_array chunk by chunk.
+ *
+ * Return: Fully populated tdx_page_array or NULL on failure.
+ */
+struct tdx_page_array *tdx_page_array_create(unsigned int nr_pages)
+{
+	struct tdx_page_array *array;
+	int populated;
+
+	if (nr_pages > TDX_PAGE_ARRAY_MAX_NENTS)
+		return NULL;
+
+	array = tdx_page_array_alloc(nr_pages);
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
+EXPORT_SYMBOL_GPL(tdx_page_array_create);
+
+/**
+ * tdx_page_array_ctrl_leak() - Leak data pages and free the container
+ * @array: The tdx_page_array to be leaked.
+ *
+ * Call this function when failed to reclaim the control pages. Free the root
+ * page and the holding structures, but orphan the data pages, to prevent the
+ * host from re-allocating and accessing memory that the hardware may still
+ * consider private.
+ */
+void tdx_page_array_ctrl_leak(struct tdx_page_array *array)
+{
+	if (!array)
+		return;
+
+	kfree(array->pages);
+	kfree(array->root);
+	kfree(array);
+}
+EXPORT_SYMBOL_GPL(tdx_page_array_ctrl_leak);
+
+static bool tdx_page_array_validate_release(struct tdx_page_array *array,
+					    unsigned int offset,
+					    unsigned int nr_released,
+					    u64 released_hpa)
+{
+	unsigned int nents;
+
+	if (offset >= array->nr_pages)
+		return false;
+
+	nents = umin(array->nr_pages - offset, TDX_PAGE_ARRAY_MAX_NENTS);
+
+	if (nents != nr_released) {
+		pr_err("%s nr_released [%d] doesn't match page array nents [%d]\n",
+		       __func__, nr_released, nents);
+		return false;
+	}
+
+	/*
+	 * Unfortunately TDX has multiple page allocation protocols, check the
+	 * "singleton" case required for HPA_ARRAY_T.
+	 */
+	if (page_to_phys(array->pages[0]) == released_hpa &&
+	    array->nr_pages == 1)
+		return true;
+
+	/* Then check the "non-singleton" case */
+	if (virt_to_phys(array->root) == released_hpa) {
+		u64 *entries = array->root;
+		int i;
+
+		for (i = 0; i < nents; i++) {
+			struct page *page = array->pages[offset + i];
+			u64 val = page_to_phys(page);
+
+			if (val != entries[i]) {
+				pr_err("%s entry[%d] [0x%llx] doesn't match page hpa [0x%llx]\n",
+				       __func__, i, entries[i], val);
+				return false;
+			}
+		}
+
+		return true;
+	}
+
+	pr_err("%s failed to validate, released_hpa [0x%llx], root page hpa [0x%llx], page0 hpa [%#llx], number pages %u\n",
+	       __func__, released_hpa, virt_to_phys(array->root),
+	       page_to_phys(array->pages[0]), array->nr_pages);
+
+	return false;
+}
+
+/**
+ * tdx_page_array_ctrl_release() - Verify and release TDX control pages
+ * @array: The tdx_page_array used to originally create control pages.
+ * @nr_released: Number of HPAs the TDX Module reported as released.
+ * @released_hpa: The HPA list the TDX Module reported as released.
+ *
+ * TDX Module can at most release 512 control pages, so this function only
+ * accepts small tdx_page_array (up to 512 pages), usually created by
+ * tdx_page_array_create().
+ *
+ * Return: 0 on success, -errno on page release protocol error.
+ */
+int tdx_page_array_ctrl_release(struct tdx_page_array *array,
+				unsigned int nr_released,
+				u64 released_hpa)
+{
+	int i;
+
+	/*
+	 * The only case where ->nr_pages is allowed to be >
+	 * TDX_PAGE_ARRAY_MAX_NENTS is a case where those pages are never
+	 * expected to be released by this function.
+	 */
+	if (WARN_ON(array->nr_pages > TDX_PAGE_ARRAY_MAX_NENTS))
+		return -EINVAL;
+
+	if (WARN_ONCE(!tdx_page_array_validate_release(array, 0, nr_released,
+						       released_hpa),
+		      "page release protocol error, consider reboot and replace TDX Module.\n"))
+		return -EFAULT;
+
+	for (i = 0; i < array->nr_pages; i++) {
+		u64 r;
+
+		r = tdh_phymem_page_wbinvd_hkid(tdx_global_keyid,
+						array->pages[i]);
+		if (WARN_ON(r))
+			return -EFAULT;
+	}
+
+	tdx_page_array_free(array);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_page_array_ctrl_release);
+
+#define HPA_LIST_INFO_FIRST_ENTRY	GENMASK_U64(11, 3)
+#define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
+#define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
+
+static u64 __maybe_unused hpa_list_info_assign_raw(struct tdx_page_array *array)
+{
+	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
+	       FIELD_PREP(HPA_LIST_INFO_PFN,
+			  PFN_DOWN(virt_to_phys(array->root))) |
+	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, array->nents - 1);
+}
+
+#define HPA_ARRAY_T_PFN		GENMASK_U64(51, 12)
+#define HPA_ARRAY_T_SIZE	GENMASK_U64(63, 55)
+
+static u64 __maybe_unused hpa_array_t_assign_raw(struct tdx_page_array *array)
+{
+	unsigned long pfn;
+
+	if (array->nents == 1)
+		pfn = page_to_pfn(array->pages[array->offset]);
+	else
+		pfn = PFN_DOWN(virt_to_phys(array->root));
+
+	return FIELD_PREP(HPA_ARRAY_T_PFN, pfn) |
+	       FIELD_PREP(HPA_ARRAY_T_SIZE, array->nents - 1);
+}
+
+static u64 __maybe_unused hpa_array_t_release_raw(struct tdx_page_array *array)
+{
+	if (array->nents == 1)
+		return 0;
+
+	return virt_to_phys(array->root);
+}
+
 static int read_sys_metadata_field(u64 field_id, u64 *data)
 {
 	struct tdx_module_args args = {};
-- 
2.25.1

