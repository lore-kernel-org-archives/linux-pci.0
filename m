Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD852367F28;
	Fri, 27 Mar 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628587; cv=none; b=l8tZVybTtom/6cti/zdq5265VsSlJKM5/XYyjam4iwRVo05/gICMZBmtqU7iM6gSym4OlV+qvCFidTq2A15fUGF6mkRc2vVaPX9vNi8xJoG0hhkbsXT1AJi506cRqIi4Fy50W72hrg/13/IVpwcRe/5s34XeJFL9u57hH/4R+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628587; c=relaxed/simple;
	bh=NRFQsWbcpqDGf5zixGV9qrACvFa8LqbAu2Kx6hhchmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aW/dtmitmdSMq4xX3i6+g9aoUbTFG0WYnKaxD7jEs87ofkeNo1EoTHV4t65oIvrlMqPGTIrFZ6+qG/AY2Leit8UTOCPI7z1BT0OwKJBNAgWAlAOipAYILZEcU6kQ2NacJNnGySY+nDn+OiVqpj1/aKELStpgcD/H82hyrdDglMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jdLqOKfr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdLqOKfr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628586; x=1806164586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NRFQsWbcpqDGf5zixGV9qrACvFa8LqbAu2Kx6hhchmk=;
  b=jdLqOKfrLH5BvsTdi1FafVLOp5Ul829yFXXtTDZKwYaaF3fiQuAl9Wm3
   qolDGX1flfRBCt8gPdCPJcFi8zmjIffZAIYOSXSbW+6mjH9+4dLTDiLPB
   IaTG6jPkRJQ0YxaWnViCPIaG5nyKMWLCBFYYNjgnnFaBEPO7bqemVjcS9
   z2t1gK9HCEqQV/oHEK0vZbKMpJJgjroK9rwq9vYPsoF0ef4/XxL2oCT2a
   wh66gKWZLSpVpbKjd0OazfyOlvBnX57f2LRa7Q49Z17N813D5CeYj1PLh
   6Ymwh4+NTQzzfp0cJENk/3omMp0sG2yd7TP+eDVTjfnDmF9/+mXh15Yof
   Q==;
X-CSE-ConnectionGUID: N5CHLIiwTU+kTESlG3PceQ==
X-CSE-MsgGUID: 14u/s5FzSG6KBFyrqLHZbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565540"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565540"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:23:06 -0700
X-CSE-ConnectionGUID: Je9XVUSpSNCJAKe+QF6ErQ==
X-CSE-MsgGUID: 5Sf7lSvYT3SPjffYmyVSJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516170"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:23:03 -0700
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
Subject: [PATCH v2 09/31] x86/virt/tdx: Move tdx_clflush_page() up in the file
Date: Sat, 28 Mar 2026 00:01:10 +0800
Message-Id: <20260327160132.2946114-10-yilun.xu@linux.intel.com>
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

Prepare to add more callers earlier in this file, so move this
function up in advance.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 0c5d6bdd810f..4fb56bb442f0 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1502,6 +1502,17 @@ static int init_tdmrs(struct tdmr_info_list *tdmr_list)
 	return 0;
 }
 
+/*
+ * The TDX module exposes a CLFLUSH_BEFORE_ALLOC bit to specify whether
+ * a CLFLUSH of pages is required before handing them to the TDX module.
+ * Be conservative and make the code simpler by doing the CLFLUSH
+ * unconditionally.
+ */
+static void tdx_clflush_page(struct page *page)
+{
+	clflush_cache_range(page_to_virt(page), PAGE_SIZE);
+}
+
 static int init_tdx_module(void)
 {
 	int ret;
@@ -1936,17 +1947,6 @@ static inline u64 tdx_tdr_pa(struct tdx_td *td)
 	return page_to_phys(td->tdr_page);
 }
 
-/*
- * The TDX module exposes a CLFLUSH_BEFORE_ALLOC bit to specify whether
- * a CLFLUSH of pages is required before handing them to the TDX module.
- * Be conservative and make the code simpler by doing the CLFLUSH
- * unconditionally.
- */
-static void tdx_clflush_page(struct page *page)
-{
-	clflush_cache_range(page_to_virt(page), PAGE_SIZE);
-}
-
 noinstr u64 tdh_vp_enter(struct tdx_vp *td, struct tdx_module_args *args)
 {
 	args->rcx = td->tdvpr_pa;
-- 
2.25.1

