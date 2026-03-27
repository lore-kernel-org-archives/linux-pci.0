Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44001401A30;
	Fri, 27 Mar 2026 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628647; cv=none; b=ssk2EtSQA3Hd7MfRqJlPFDLMhtKocDcIgX4IGfbIpNSU2L95TlW0diuZ+g9OWW57bhUik8lkG/m+AQP+gdTVOS6Jr8C7zWAR6vG6GkXUVD4hjIBYMLU7AVQFdQulm6EUGdpyA3RNnNBijQQuqlrXo3yhSqj7tgNYynvz4JuxAnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628647; c=relaxed/simple;
	bh=d5v7kombDkpimMLhqFIFaDnGOds7NdDu5NS7qDGKkQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GJb9flL6xva3WJtF1vHe5xRr/NtQ3oCNM0rutGYHS9EIufu6zKgQlkpzOmlRfbAjmnIWolcay4u73xzUCKSSXQGu2fv2nvMs5F2T/2ntcBWVtWMotg6eCAVgh/wg674svs5H/FwcVlrjIFlZJ5/qjhE0izDSzHBfJmkbkT2dprI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cItCTTno; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cItCTTno"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628646; x=1806164646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d5v7kombDkpimMLhqFIFaDnGOds7NdDu5NS7qDGKkQQ=;
  b=cItCTTno3cWJQBKSSyco1N9pQ12QOIO6n7k4ZTTZNp8QEvzzXFBv8vbN
   J4kbhUTBld5M9MWkQr8hD8xWs6k21bxE61YTJGG0k7jKwWntjubXjCcJN
   If1PT6y18djYE6cb2nFXkxKvc33DM/lLPuVkwO5b7+nfWbLBI9ar0HcEF
   /cQmSGXeRRjBzv5fybldDQHafntyIfKEmU/n8DeGGWkFsMiQ/rzTzW+W8
   9MYxaqeA7F6+BL9MRJKY9FWjAt0eqLYw4yhE/L61YPypKrwk9DndjGV13
   lI6yyQD5uULGi0X1bcoay6OV0t7pnCD+QY7aKB9VH1nT5yqLrWyb/kMUG
   g==;
X-CSE-ConnectionGUID: E5CfgM7CQH23y/CaAlNTSA==
X-CSE-MsgGUID: loGfHvF6TUyUKha8c4Fk5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565666"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565666"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:24:05 -0700
X-CSE-ConnectionGUID: uPp5MI4jQcKo/WTcMstNsw==
X-CSE-MsgGUID: fmhf5p5NSIGthkwPzkRFIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516357"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:24:02 -0700
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
Subject: [PATCH v2 25/31] x86/virt/tdx: Add SEAMCALL wrappers for SPDM management
Date: Sat, 28 Mar 2026 00:01:26 +0800
Message-Id: <20260327160132.2946114-26-yilun.xu@linux.intel.com>
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Add several SEAMCALL wrappers for SPDM management. TDX Module requires
HPA_ARRAY_T structure as input/output parameters for these SEAMCALLs.
So use tdx_page_array for these wrappers.

- TDH.SPDM.CREATE creates SPDM session metadata buffers for TDX Module.
- TDH.SPDM.DELETE destroys SPDM session metadata and returns these
  buffers to host, after checking no reference attached to the metadata.
- TDH.SPDM.CONNECT establishes a new SPDM session with the device.
- TDH.SPDM.DISCONNECT tears down the SPDM session with the device.
- TDH.SPDM.MNG supports three SPDM runtime operations: HEARTBEAT,
  KEY_UPDATE and DEV_INFO_RECOLLECTION.

Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 arch/x86/include/asm/tdx.h  |  13 ++++
 arch/x86/virt/vmx/tdx/tdx.h |   5 ++
 arch/x86/virt/vmx/tdx/tdx.c | 114 +++++++++++++++++++++++++++++++++++-
 3 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index a59e0e43e465..8abdad084972 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -247,6 +247,19 @@ u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td);
 u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page);
 u64 tdh_iommu_setup(u64 vtbar, struct tdx_page_array *iommu_mt, u64 *iommu_id);
 u64 tdh_iommu_clear(u64 iommu_id, struct tdx_page_array *iommu_mt);
+u64 tdh_spdm_create(u64 func_id, struct tdx_page_array *spdm_mt, u64 *spdm_id);
+u64 tdh_spdm_delete(u64 spdm_id, struct tdx_page_array *spdm_mt,
+		    unsigned int *nr_released, u64 *released_hpa);
+u64 tdh_exec_spdm_connect(u64 spdm_id, struct page *spdm_conf,
+			  struct page *spdm_rsp, struct page *spdm_req,
+			  struct tdx_page_array *spdm_out,
+			  u64 *spdm_req_or_out_len);
+u64 tdh_exec_spdm_disconnect(u64 spdm_id, struct page *spdm_rsp,
+			     struct page *spdm_req, u64 *spdm_req_len);
+u64 tdh_exec_spdm_mng(u64 spdm_id, u64 spdm_op, struct page *spdm_param,
+		      struct page *spdm_rsp, struct page *spdm_req,
+		      struct tdx_page_array *spdm_out,
+		      u64 *spdm_req_or_out_len);
 #else
 static inline void tdx_init(void) { }
 static inline int tdx_cpu_enable(void) { return -ENODEV; }
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index b25c418f6e61..4784db2d1d92 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -64,6 +64,11 @@
 #define TDH_EXT_MEM_ADD			61
 #define TDH_IOMMU_SETUP			128
 #define TDH_IOMMU_CLEAR			129
+#define TDH_SPDM_CREATE			130
+#define TDH_SPDM_DELETE			131
+#define TDH_SPDM_CONNECT		142
+#define TDH_SPDM_DISCONNECT		143
+#define TDH_SPDM_MNG			144
 
 /* TDX page types */
 #define	PT_NDA		0x0
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 790713881f1f..02882c2ad177 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -654,7 +654,7 @@ static u64 hpa_list_info_assign_raw(struct tdx_page_array *array)
 #define HPA_ARRAY_T_PFN		GENMASK_U64(51, 12)
 #define HPA_ARRAY_T_SIZE	GENMASK_U64(63, 55)
 
-static u64 __maybe_unused hpa_array_t_assign_raw(struct tdx_page_array *array)
+static u64 hpa_array_t_assign_raw(struct tdx_page_array *array)
 {
 	unsigned long pfn;
 
@@ -667,7 +667,7 @@ static u64 __maybe_unused hpa_array_t_assign_raw(struct tdx_page_array *array)
 	       FIELD_PREP(HPA_ARRAY_T_SIZE, array->nents - 1);
 }
 
-static u64 __maybe_unused hpa_array_t_release_raw(struct tdx_page_array *array)
+static u64 hpa_array_t_release_raw(struct tdx_page_array *array)
 {
 	if (array->nents == 1)
 		return 0;
@@ -2107,6 +2107,15 @@ static u64 __seamcall_ir_resched(sc_func_t sc_func, u64 fn,
 #define seamcall_ret_ir_resched(fn, args)	\
 	__seamcall_ir_resched(__seamcall_ret, fn, args)
 
+/*
+ * seamcall_ret_ir_exec() aliases seamcall_ret_ir_resched() for
+ * documentation purposes. It documents the TDX Module extension
+ * seamcalls that are long running / hard-irq preemptible flows that
+ * generate events. The calls using seamcall_ret_ir_resched() are long
+ * running flows, that periodically yield.
+ */
+#define seamcall_ret_ir_exec seamcall_ret_ir_resched
+
 noinstr u64 tdh_vp_enter(struct tdx_vp *td, struct tdx_module_args *args)
 {
 	args->rcx = td->tdvpr_pa;
@@ -2506,3 +2515,104 @@ u64 tdh_iommu_clear(u64 iommu_id, struct tdx_page_array *iommu_mt)
 	return seamcall_ret_ir_resched(TDH_IOMMU_CLEAR, &args);
 }
 EXPORT_SYMBOL_FOR_MODULES(tdh_iommu_clear, "tdx-host");
+
+u64 tdh_spdm_create(u64 func_id, struct tdx_page_array *spdm_mt, u64 *spdm_id)
+{
+	struct tdx_module_args args = {
+		.rcx = func_id,
+		.rdx = hpa_array_t_assign_raw(spdm_mt)
+	};
+	u64 r;
+
+	tdx_clflush_page_array(spdm_mt);
+
+	r = seamcall_ret(TDH_SPDM_CREATE, &args);
+
+	*spdm_id = args.rcx;
+
+	return r;
+}
+EXPORT_SYMBOL_FOR_MODULES(tdh_spdm_create, "tdx-host");
+
+u64 tdh_spdm_delete(u64 spdm_id, struct tdx_page_array *spdm_mt,
+		    unsigned int *nr_released, u64 *released_hpa)
+{
+	struct tdx_module_args args = {
+		.rcx = spdm_id,
+		.rdx = hpa_array_t_release_raw(spdm_mt),
+	};
+	u64 r;
+
+	r = seamcall_ret(TDH_SPDM_DELETE, &args);
+	if (r != TDX_SUCCESS)
+		return r;
+
+	*nr_released = FIELD_GET(HPA_ARRAY_T_SIZE, args.rcx) + 1;
+	*released_hpa = FIELD_GET(HPA_ARRAY_T_PFN, args.rcx) << PAGE_SHIFT;
+
+	return r;
+}
+EXPORT_SYMBOL_FOR_MODULES(tdh_spdm_delete, "tdx-host");
+
+u64 tdh_exec_spdm_connect(u64 spdm_id, struct page *spdm_conf,
+			  struct page *spdm_rsp, struct page *spdm_req,
+			  struct tdx_page_array *spdm_out,
+			  u64 *spdm_req_or_out_len)
+{
+	struct tdx_module_args args = {
+		.rcx = spdm_id,
+		.rdx = page_to_phys(spdm_conf),
+		.r8 = page_to_phys(spdm_rsp),
+		.r9 = page_to_phys(spdm_req),
+		.r10 = hpa_array_t_assign_raw(spdm_out),
+	};
+	u64 r;
+
+	r = seamcall_ret_ir_exec(TDH_SPDM_CONNECT, &args);
+
+	*spdm_req_or_out_len = args.rcx;
+
+	return r;
+}
+EXPORT_SYMBOL_FOR_MODULES(tdh_exec_spdm_connect, "tdx-host");
+
+u64 tdh_exec_spdm_disconnect(u64 spdm_id, struct page *spdm_rsp,
+			     struct page *spdm_req, u64 *spdm_req_len)
+{
+	struct tdx_module_args args = {
+		.rcx = spdm_id,
+		.rdx = page_to_phys(spdm_rsp),
+		.r8 = page_to_phys(spdm_req),
+	};
+	u64 r;
+
+	r = seamcall_ret_ir_exec(TDH_SPDM_DISCONNECT, &args);
+
+	*spdm_req_len = args.rcx;
+
+	return r;
+}
+EXPORT_SYMBOL_FOR_MODULES(tdh_exec_spdm_disconnect, "tdx-host");
+
+u64 tdh_exec_spdm_mng(u64 spdm_id, u64 spdm_op, struct page *spdm_param,
+		      struct page *spdm_rsp, struct page *spdm_req,
+		      struct tdx_page_array *spdm_out,
+		      u64 *spdm_req_or_out_len)
+{
+	struct tdx_module_args args = {
+		.rcx = spdm_id,
+		.rdx = spdm_op,
+		.r8 = spdm_param ? page_to_phys(spdm_param) : -1,
+		.r9 = page_to_phys(spdm_rsp),
+		.r10 = page_to_phys(spdm_req),
+		.r11 = spdm_out ? hpa_array_t_assign_raw(spdm_out) : -1,
+	};
+	u64 r;
+
+	r = seamcall_ret_ir_exec(TDH_SPDM_MNG, &args);
+
+	*spdm_req_or_out_len = args.rcx;
+
+	return r;
+}
+EXPORT_SYMBOL_FOR_MODULES(tdh_exec_spdm_mng, "tdx-host");
-- 
2.25.1

