Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF38365A1E;
	Fri, 27 Mar 2026 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628584; cv=none; b=bBpoRAoryFvQFaiqqUr1QFltHHL9Dl44PRxQSO54BPfB3i1HVQ3h+5sp+An/YqIEYnsITmVdcXvXHQVDHi7mHWgmq97Efr+4LWhk6pzsoTlBwIPCNIUbTfsCCAF66pJT0qNyASVL2SPwD6+nrK99v86CPk2HCB9wrZH79HDT23g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628584; c=relaxed/simple;
	bh=+upVX1QhrFrQr7GIQbke+fYKEB7JHU6Rc+v4ck+/2sY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e7awGkxi2Bkhn+CZeH+e66EWyKuOsV6V8eQTh08X/F5UFbnF1YnrfmcnPf8YWdbJsL2Szgv9fCsx7XTqTw77jFyMN4vHbFEzDtdmHgfLryRkUuYytyDxNk5lDfLAMlwmWMpKqP7r2A6mg0TAX4fJ7YXZxxSSDbbwHeugGrDYXe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSqrof3q; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CSqrof3q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628582; x=1806164582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+upVX1QhrFrQr7GIQbke+fYKEB7JHU6Rc+v4ck+/2sY=;
  b=CSqrof3qt4U36Q4bMYlQieKvGiWw+WSG1K3GWfzKck0PLWLEy83bxjZi
   4mXLEZ0NGLxDzIHqEKnqp4BHVZwc0JnL2Zc8SkOzSX1FYurIl3axX4jcx
   pw1SmpeFTMZzOh1YC61Ut9AMza/K/h7QmcpyveyF4u8RIAHmIpBKhRImi
   vy4SqDoID3DX3h3KOVJ7V/CFCys0lCsXlfSf2sAhFh5IcQcIPlspvQ3nQ
   QiirgGZdl7PdjNEvNJZ8HgSgc8B3+xBZYD+uCvaDgSejIv/JZlT66mWdJ
   qeF26rJxllJGbChLyf6je5jSzFGJfOXooMUhuB1SGmHiyyepPHOEQWno3
   g==;
X-CSE-ConnectionGUID: VUYPf1NURwCI8XuqBA1RyA==
X-CSE-MsgGUID: FvcqTJ9wRt++0LXqIWcnSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565535"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565535"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:23:02 -0700
X-CSE-ConnectionGUID: cpJeYFmcQWeJ6DZdIYULlQ==
X-CSE-MsgGUID: na2u/tGSRk2g87aLLo8LJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516164"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:22:59 -0700
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
Subject: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with optional TDX Connect feature
Date: Sat, 28 Mar 2026 00:01:09 +0800
Message-Id: <20260327160132.2946114-9-yilun.xu@linux.intel.com>
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

TDX Module supports optional TDX features (e.g. TDX Connect & TDX Module
Extensions) that won't be enabled by default. It extends TDH.SYS.CONFIG
for host to choose to enable them on bootup.

Call TDH.SYS.CONFIG with a new bitmap input parameter to specify which
features to enable. The bitmap uses the same definitions as
TDX_FEATURES0. But note not all bits in TDX_FEATURES0 are valid for
configuration, e.g. TDX Module Extensions is a service that supports TDX
Connect, it is implicitly enabled when TDX Connect is enabled. Setting
TDX_FEATURES0_EXT in the bitmap has no effect.

TDX Module advances the version of TDH.SYS.CONFIG for the change, so
use the latest version (v1) for optional feature enabling. But
supporting existing Modules which only support v0 is still necessary
until they are deprecated, enumerate via TDX_FEATURES0 to decide which
version to use.

TDX Module updates global metadata when optional features are enabled.
Host should update the cached tdx_sysinfo to reflect these changes.

Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.h |  3 ++-
 arch/x86/virt/vmx/tdx/tdx.c | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index e5a9331df451..870bb75da3ba 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -58,7 +58,8 @@
 #define TDH_PHYMEM_CACHE_WB		40
 #define TDH_PHYMEM_PAGE_WBINVD		41
 #define TDH_VP_WR			43
-#define TDH_SYS_CONFIG			45
+#define TDH_SYS_CONFIG_V0		45
+#define TDH_SYS_CONFIG			SEAMCALL_LEAF_VER(TDH_SYS_CONFIG_V0, 1)
 
 /* TDX page types */
 #define	PT_NDA		0x0
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 130214933c2f..0c5d6bdd810f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1353,6 +1353,7 @@ static int construct_tdmrs(struct list_head *tmb_list,
 static int config_tdx_module(struct tdmr_info_list *tdmr_list, u64 global_keyid)
 {
 	struct tdx_module_args args = {};
+	u64 seamcall_fn = TDH_SYS_CONFIG_V0;
 	u64 *tdmr_pa_array;
 	size_t array_sz;
 	int i, ret;
@@ -1377,7 +1378,15 @@ static int config_tdx_module(struct tdmr_info_list *tdmr_list, u64 global_keyid)
 	args.rcx = __pa(tdmr_pa_array);
 	args.rdx = tdmr_list->nr_consumed_tdmrs;
 	args.r8 = global_keyid;
-	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
+
+	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_TDXCONNECT) {
+		args.r9 |= TDX_FEATURES0_TDXCONNECT;
+		args.r11 = ktime_get_real_seconds();
+		/* These parameters requires version >= 1 */
+		seamcall_fn = TDH_SYS_CONFIG;
+	}
+
+	ret = seamcall_prerr(seamcall_fn, &args);
 
 	/* Free the array as it is not required anymore. */
 	kfree(tdmr_pa_array);
@@ -1537,6 +1546,11 @@ static int init_tdx_module(void)
 	if (ret)
 		goto err_free_pamts;
 
+	/* configuration to tdx module may change tdx_sysinfo, update it */
+	ret = get_tdx_sys_info(&tdx_sysinfo);
+	if (ret)
+		goto err_reset_pamts;
+
 	/* Config the key of global KeyID on all packages */
 	ret = config_global_keyid();
 	if (ret)
-- 
2.25.1

