Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107B13FBEA3;
	Fri, 27 Mar 2026 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628630; cv=none; b=IN+l4+deKLcfm2zZagLeW5GA1ZSgAEU3r6BK2RUvjusX3gAA3AQ2hc03ItwlOnfr02BC1ZOpJxrOT++7DQStkEiEx70Ne6R4yCn3Qh9cbaQl/jKZ/57NIA0vLzHOZ2m2IdZptGOWTYCFprqZQAegBaf8SrcMX7ffTGi/jCTPGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628630; c=relaxed/simple;
	bh=JpFljdI5U/a/gNIVQmuIsHGSGIbydMYmkZ3Ia68L6tY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H9cnWGF6nKOV27DV8mP5BVllG/coB1myXcZdcUV5ll9fFDb0o9X6Zgm7zELaa0g+i+D/E9ciczlM7IzTaQVpzPld6SFhafpAi9RYapRwzOecsn2OalCUArfuHWoultG1PRI3nqoACe/U8BE0rCRFxYg4+HOeV0SnKUT1RRq6ghE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCsZM/kr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCsZM/kr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628627; x=1806164627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JpFljdI5U/a/gNIVQmuIsHGSGIbydMYmkZ3Ia68L6tY=;
  b=lCsZM/kr62MegnwBbFhk9vZ+WBHCtPdFk/iI/kfVGYTAcTNCMSdMxhOv
   pz29OLPo5m86fesM9CwT7Syxqacmg04/GIeFE/Qy/gAAIl7hiQz2DTbgY
   eGDBhPwrnr0z4mHkjdc/Hqxj8KPZmZmBv81FzID8eSaqGWrQokw1nEEYc
   HAMI8I1JK0w6DWijsRZq/JooaS8IgZARvNETX7Z+vhOq3Q+zI2YoY7B98
   RnLhr/BJQSeoy8N8ai6xsaMAzAcE2vRL0qy8fehZY2U5pIqgM3WoLyinF
   aNBme6E/3+7AlbMKFy/FdaBNd4B+pSlqgeiKQE9m2eUxzniERFa3ZJGZn
   g==;
X-CSE-ConnectionGUID: p9lcJTVjRpe9Ha0HhAo4FQ==
X-CSE-MsgGUID: tmy7QabXT5iNCTRkvm3L6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565638"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565638"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:23:47 -0700
X-CSE-ConnectionGUID: kDe/7qQWQEuII0+9rgCC4w==
X-CSE-MsgGUID: d6DN10EoR3GvEZ5n+2TJQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516321"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:23:44 -0700
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
Subject: [PATCH v2 20/31] x86/virt/tdx: Add a helper to loop on TDX_INTERRUPTED_RESUMABLE
Date: Sat, 28 Mar 2026 00:01:21 +0800
Message-Id: <20260327160132.2946114-21-yilun.xu@linux.intel.com>
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

Add a helper to handle SEAMCALL return code TDX_INTERRUPTED_RESUMABLE.

SEAMCALL returns TDX_INTERRUPTED_RESUMABLE to avoid stalling host for
long time. After host has handled the interrupt, it calls the
interrupted SEAMCALL again and TDX Module continues to execute. TDX
Module made progress in this case and would eventually finish. An
infinite loop in host should be safe.

The helper is for SEAMCALL wrappers which output information by using
seamcall_ret() or seamcall_saved_ret(). The 2 functions overwrite input
arguments by outputs but much SEAMCALLs expect the same inputs to
resume.

The helper is not for special cases where the SEAMCALL expects modified
inputs to resume. The helper is also not for SEAMCALLs with no output,
do {...} while (r == TDX_INTERRUPTED_RESUMABLE) just works.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index cd0948794b6c..294f36048c03 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2084,6 +2084,29 @@ static inline u64 tdx_tdr_pa(struct tdx_td *td)
 	return page_to_phys(td->tdr_page);
 }
 
+static u64 __maybe_unused __seamcall_ir_resched(sc_func_t sc_func, u64 fn,
+						struct tdx_module_args *args)
+{
+	struct tdx_module_args _args;
+	u64 r;
+
+	while (1) {
+		_args = *(args);
+		r = sc_retry(sc_func, fn, &_args);
+		if (r != TDX_INTERRUPTED_RESUMABLE)
+			break;
+
+		cond_resched();
+	}
+
+	*args = _args;
+
+	return r;
+}
+
+#define seamcall_ret_ir_resched(fn, args)	\
+	__seamcall_ir_resched(__seamcall_ret, fn, args)
+
 noinstr u64 tdh_vp_enter(struct tdx_vp *td, struct tdx_module_args *args)
 {
 	args->rcx = td->tdvpr_pa;
-- 
2.25.1

