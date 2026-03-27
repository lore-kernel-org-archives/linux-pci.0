Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD38407119;
	Fri, 27 Mar 2026 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628661; cv=none; b=WUP85A4T86XMcOpcqPQXGY1WKsdpj/tF+s97+0DUbk8z5tQ+XjVCtc+PfgrFOJfgCiJM9bEk5Ze3Vzbt/h/dWZobyuEbMexWw0a72cfrWn4JyJ68YkHjnD5OtqqlpBbLIQg6z27t9HF29fD9UJmpBG/mMX1ERfKgpuZ8rLpRBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628661; c=relaxed/simple;
	bh=nSxKB/mCLDrbbeTMk6Of7USqSp6UAUKOXUxNYtSimUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pFiIsFFy9XujFqePIS6S3KRIGzxj9MQtOTfzc0YXmgYkaDKOpooWHOF42H7aeAC1RBObfGhvYV95oHiO4Uq5hwto+HxXpJM9LhVVEv3sFXlnqcYpJd/UFLC06SxqEHyB2mhaxFQW8uN2qKqjUthwFLaG7Vk9BTJBOtbe1ZaC5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hX20DsvX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hX20DsvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628660; x=1806164660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nSxKB/mCLDrbbeTMk6Of7USqSp6UAUKOXUxNYtSimUQ=;
  b=hX20DsvXtg2K6hBpLW1DXk70+tsRyVtYqQ9iiXY3YiJpGuAfyoWDSbiW
   I1FLXp0S3kBX/p1BnxwQBXufMb0ZKw3aTNQqhKEAFPXO6Vm977+jDeiak
   KLAgC2cwxaxVPJqweC7rgyHXiCNBhetUc9Sqwf9PGwjMRa6eDLhGaF8cp
   yVGaV88wgsatkUhxMrUK8g+e3SnqwV8otVy1aZCNpivfHxGlEU+bnjmcD
   0mVarUilpLycDWWn+Z++9Zi8toMah9jlinQwwVgM5tNmh9NfxUkqOPdPt
   YZINLC2S9sIhu1mWrNRioPr8LmQhfOiT+vNIPAyJWhyBL+YB8GZZViyYI
   w==;
X-CSE-ConnectionGUID: v9rN96s/QpSSZ28j8HXjqA==
X-CSE-MsgGUID: 7ZwL2awETuWGPJVtDOge0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565694"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565694"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:24:20 -0700
X-CSE-ConnectionGUID: OhsKLpSLSxWe+zwCDUuyEw==
X-CSE-MsgGUID: NioMDJNJR9Gj9xcXUa9o/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516389"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:24:17 -0700
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
Subject: [PATCH v2 29/31] x86/virt/tdx: Add SEAMCALL wrappers for IDE stream management
Date: Sat, 28 Mar 2026 00:01:30 +0800
Message-Id: <20260327160132.2946114-30-yilun.xu@linux.intel.com>
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

Add several SEAMCALL wrappers for IDE stream management.

- TDH.IDE.STREAM.CREATE creates IDE stream metadata buffers for TDX
  Module, and does root port side IDE configuration.
- TDH.IDE.STREAM.BLOCK clears the root port side IDE configuration.
- TDH.IDE.STREAM.DELETE releases the IDE stream metadata buffers.
- TDH.IDE.STREAM.KM deals with the IDE Key Management protocol (IDE-KM)

More information see Intel TDX Connect ABI Specification [1]
Section 3.2 TDX Connect Host-Side (SEAMCALL) Interface Functions.

[1]: https://cdrdv2.intel.com/v1/dl/getContent/858625

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h  | 14 ++++++
 arch/x86/virt/vmx/tdx/tdx.h |  4 ++
 arch/x86/virt/vmx/tdx/tdx.c | 86 +++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 8abdad084972..7bdd66acda5b 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -260,6 +260,20 @@ u64 tdh_exec_spdm_mng(u64 spdm_id, u64 spdm_op, struct page *spdm_param,
 		      struct page *spdm_rsp, struct page *spdm_req,
 		      struct tdx_page_array *spdm_out,
 		      u64 *spdm_req_or_out_len);
+u64 tdh_ide_stream_create(u64 stream_info, u64 spdm_id,
+			  struct tdx_page_array *stream_mt, u64 stream_ctrl,
+			  u64 rid_assoc1, u64 rid_assoc2,
+			  u64 addr_assoc1, u64 addr_assoc2,
+			  u64 addr_assoc3,
+			  u64 *stream_id,
+			  u64 *rp_ide_id);
+u64 tdh_ide_stream_block(u64 spdm_id, u64 stream_id);
+u64 tdh_ide_stream_delete(u64 spdm_id, u64 stream_id,
+			  struct tdx_page_array *stream_mt,
+			  unsigned int *nr_released, u64 *released_hpa);
+u64 tdh_ide_stream_km(u64 spdm_id, u64 stream_id, u64 operation,
+		      struct page *spdm_rsp, struct page *spdm_req,
+		      u64 *spdm_req_len);
 #else
 static inline void tdx_init(void) { }
 static inline int tdx_cpu_enable(void) { return -ENODEV; }
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 4784db2d1d92..d0a9694432de 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -66,6 +66,10 @@
 #define TDH_IOMMU_CLEAR			129
 #define TDH_SPDM_CREATE			130
 #define TDH_SPDM_DELETE			131
+#define TDH_IDE_STREAM_CREATE		132
+#define TDH_IDE_STREAM_BLOCK		133
+#define TDH_IDE_STREAM_DELETE		134
+#define TDH_IDE_STREAM_KM		135
 #define TDH_SPDM_CONNECT		142
 #define TDH_SPDM_DISCONNECT		143
 #define TDH_SPDM_MNG			144
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 02882c2ad177..72d836b25bd6 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2616,3 +2616,89 @@ u64 tdh_exec_spdm_mng(u64 spdm_id, u64 spdm_op, struct page *spdm_param,
 	return r;
 }
 EXPORT_SYMBOL_FOR_MODULES(tdh_exec_spdm_mng, "tdx-host");
+
+u64 tdh_ide_stream_create(u64 stream_info, u64 spdm_id,
+			  struct tdx_page_array *stream_mt, u64 stream_ctrl,
+			  u64 rid_assoc1, u64 rid_assoc2,
+			  u64 addr_assoc1, u64 addr_assoc2,
+			  u64 addr_assoc3,
+			  u64 *stream_id,
+			  u64 *rp_ide_id)
+{
+	struct tdx_module_args args = {
+		.rcx = stream_info,
+		.rdx = spdm_id,
+		.r8 = hpa_array_t_assign_raw(stream_mt),
+		.r9 = stream_ctrl,
+		.r10 = rid_assoc1,
+		.r11 = rid_assoc2,
+		.r12 = addr_assoc1,
+		.r13 = addr_assoc2,
+		.r14 = addr_assoc3,
+	};
+	u64 r;
+
+	tdx_clflush_page_array(stream_mt);
+
+	r = seamcall_saved_ret(TDH_IDE_STREAM_CREATE, &args);
+
+	*stream_id = args.rcx;
+	*rp_ide_id = args.rdx;
+
+	return r;
+}
+EXPORT_SYMBOL_FOR_MODULES(tdh_ide_stream_create, "tdx-host");
+
+u64 tdh_ide_stream_block(u64 spdm_id, u64 stream_id)
+{
+	struct tdx_module_args args = {
+		.rcx = spdm_id,
+		.rdx = stream_id,
+	};
+
+	return seamcall(TDH_IDE_STREAM_BLOCK, &args);
+}
+EXPORT_SYMBOL_FOR_MODULES(tdh_ide_stream_block, "tdx-host");
+
+u64 tdh_ide_stream_delete(u64 spdm_id, u64 stream_id,
+			  struct tdx_page_array *stream_mt,
+			  unsigned int *nr_released, u64 *released_hpa)
+{
+	struct tdx_module_args args = {
+		.rcx = spdm_id,
+		.rdx = stream_id,
+		.r8 = hpa_array_t_release_raw(stream_mt),
+	};
+	u64 r;
+
+	r = seamcall_ret(TDH_IDE_STREAM_DELETE, &args);
+	if (r != TDX_SUCCESS)
+		return r;
+
+	*nr_released = FIELD_GET(HPA_ARRAY_T_SIZE, args.rcx) + 1;
+	*released_hpa = FIELD_GET(HPA_ARRAY_T_PFN, args.rcx) << PAGE_SHIFT;
+
+	return r;
+}
+EXPORT_SYMBOL_FOR_MODULES(tdh_ide_stream_delete, "tdx-host");
+
+u64 tdh_ide_stream_km(u64 spdm_id, u64 stream_id, u64 operation,
+		      struct page *spdm_rsp, struct page *spdm_req,
+		      u64 *spdm_req_len)
+{
+	struct tdx_module_args args = {
+		.rcx = spdm_id,
+		.rdx = stream_id,
+		.r8 = operation,
+		.r9 = page_to_phys(spdm_rsp),
+		.r10 = page_to_phys(spdm_req),
+	};
+	u64 r;
+
+	r = seamcall_ret_ir_resched(TDH_IDE_STREAM_KM, &args);
+
+	*spdm_req_len = args.rcx;
+
+	return r;
+}
+EXPORT_SYMBOL_FOR_MODULES(tdh_ide_stream_km, "tdx-host");
-- 
2.25.1

