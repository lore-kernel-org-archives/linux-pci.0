Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D25A36BCFD;
	Fri, 27 Mar 2026 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628595; cv=none; b=uim0lkKR+bUUZ9mZPNd0ZIIo0TGCCXCFwciCenH5uxH1c6GzspHeCbWfiokFgs0VqSVCThdDx5OEZSfCmo8BZY0hvP2HQWYeAMHiKhcclJomtCNObkh5CAtJ1xCUC+mBgDq4XOKZ6Bg3JpziGAnKNifseQc0vsGD8IGApk3yy/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628595; c=relaxed/simple;
	bh=z5CL/0DGGrz7pQMCfp9DD/99lRybVld0TfABDp+3gMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W71jCwErjXUa+ItNWyY3cSR+YyLGy1HDzf92lqR8w2R02ofR+PKGDTGtsBeQE95XyjydODoxRmEG4O4OtARSZESko5kTeG5Eps7GcWtyZZr3tWw9zILqWHv1fR1ZlvdlsBm3kxNy6IQ45AAoYdQCqka+PBf+g92hLGTYizsOQJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GfViFb8a; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GfViFb8a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628593; x=1806164593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z5CL/0DGGrz7pQMCfp9DD/99lRybVld0TfABDp+3gMk=;
  b=GfViFb8aUHoyYwhxZNtaocQ3sjQdWtAbnRUJc1snC8VsmaY/nd1B5IiL
   ZOvMMY5FidSdBECKU6geySpyHzNBGsRkNZEzBM6wI9HaQkckvxT7/XGTa
   vgMWsBGs7Sq3iAh/ST8AlcBMBzHO2XjaqD4lqkREaQEYrtTLLAlI1cvnQ
   /NSM7tKurWbKHWv+mHiD/lFhVSkjO0OuKQnfgtrcETyOhcddDWRBXBa99
   OG9uu767Klc/4nbCl+SJHejpDgRfZS/1UISKQzmMkkB2ToLVATPmX3WUz
   USIWAGo/EkFktijL+hI7x+wE3GT3rDlg0+/I2InkZMG59Iw3ps00CmpIe
   Q==;
X-CSE-ConnectionGUID: OoKRgvbcQBW1pOLX8eLdLA==
X-CSE-MsgGUID: 7hxR6OkMSaiOszx05MH3lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565554"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565554"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:23:13 -0700
X-CSE-ConnectionGUID: BK74wRU+T86K0QGGrRTlww==
X-CSE-MsgGUID: V54k45S2Ro+2cOJ3jO7Q6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516201"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:23:10 -0700
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
Subject: [PATCH v2 11/31] x86/virt/tdx: Make TDX Module initialize Extensions
Date: Sat, 28 Mar 2026 00:01:12 +0800
Message-Id: <20260327160132.2946114-12-yilun.xu@linux.intel.com>
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

After providing all required memory to TDX Module, initialize the
Extensions via TDH.EXT.INIT, and then Extension-SEAMCALLs can be used.

The initialization of Extensions touches the required memory (previously
provided by TDH.EXT.MEM.ADD) in private manner. If failed, flush cache
before freeing these memory, to avoid private cache write back damages
the shared pages.

TDX should use movdir64b to clear private pages when reclaiming them on
older platforms with the X86_BUG_TDX_PW_MCE erratum. For simplicity,
don't expect this errata on any TDX Extensions supported platform. So
TDX Extensions & all features that require TDX Extensions (e.g. TDX
Connect) will not call the clearing helpers.

Note the "ext_required" global metadata specifies if TDH.EXT.INIT call
is needed. If 0, the Extensions are already working, so skip the SEAMCALL.

Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.h |  1 +
 arch/x86/virt/vmx/tdx/tdx.c | 45 +++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 31ccdfcf518c..a26fe94c07ff 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -60,6 +60,7 @@
 #define TDH_VP_WR			43
 #define TDH_SYS_CONFIG_V0		45
 #define TDH_SYS_CONFIG			SEAMCALL_LEAF_VER(TDH_SYS_CONFIG_V0, 1)
+#define TDH_EXT_INIT			60
 #define TDH_EXT_MEM_ADD			61
 
 /* TDX page types */
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 5fae17c13191..4134f92425da 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1519,6 +1519,23 @@ static void tdx_clflush_page_array(struct tdx_page_array *array)
 		tdx_clflush_page(array->pages[array->offset + i]);
 }
 
+/* Initialize the TDX Module Extensions then Extension-SEAMCALLs can be used */
+static int tdx_ext_init(void)
+{
+	struct tdx_module_args args = {};
+	u64 r;
+
+	do {
+		r = seamcall(TDH_EXT_INIT, &args);
+		cond_resched();
+	} while (r == TDX_INTERRUPTED_RESUMABLE);
+
+	if (r != TDX_SUCCESS)
+		return -EFAULT;
+
+	return 0;
+}
+
 static int tdx_ext_mem_add(struct tdx_page_array *ext_mem)
 {
 	struct tdx_module_args args = {
@@ -1572,6 +1589,17 @@ static int __maybe_unused init_tdx_ext(void)
 	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
 		return 0;
 
+	/*
+	 * With this errata, TDX should use movdir64b to clear private pages
+	 * when reclaiming them. See tdx_quirk_reset_paddr().
+	 *
+	 * Don't expect this errata on any TDX Extensions supported platform.
+	 * All features require TDX Extensions (including TDX Extensions
+	 * itself) will never call tdx_quirk_reset_paddr().
+	 */
+	if (boot_cpu_has_bug(X86_BUG_TDX_PW_MCE))
+		return -ENXIO;
+
 	nr_pages = tdx_sysinfo.ext.memory_pool_required_pages;
 	/*
 	 * memory_pool_required_pages == 0 means no need to add more pages,
@@ -1587,6 +1615,20 @@ static int __maybe_unused init_tdx_ext(void)
 			goto out_ext_mem;
 	}
 
+	/*
+	 * ext_required == 0 means no need to call TDH.EXT.INIT, the Extensions
+	 * are already working.
+	 */
+	if (tdx_sysinfo.ext.ext_required) {
+		ret = tdx_ext_init();
+		/*
+		 * Some pages may have been touched by the TDX module.
+		 * Flush cache before returning these pages to kernel.
+		 */
+		if (ret)
+			goto out_flush;
+	}
+
 	/* Extension memory is never reclaimed once assigned */
 	tdx_page_array_ctrl_leak(ext_mem);
 
@@ -1595,6 +1637,9 @@ static int __maybe_unused init_tdx_ext(void)
 
 	return 0;
 
+out_flush:
+	if (ext_mem)
+		wbinvd_on_all_cpus();
 out_ext_mem:
 	tdx_page_array_free(ext_mem);
 
-- 
2.25.1

