Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A63644D7;
	Fri, 27 Mar 2026 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628580; cv=none; b=bRVD9Euj+TsI2XIrNwfLIYnBK81zfiziz0jzaokHPdG5wvAFfjpHtPfp5El1i9DNyVyWHZhazs+0YaBindhrjLoIbQmn829hxGI0tHubAPlr5L5c8lN+zO/Gy2zjg8Y6g45vZPGNH+juI2B8yBNO2z9ht1SNwCChiGOqJY2SOWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628580; c=relaxed/simple;
	bh=Bt+AXgtn75w+rtXbNgQtMbF5XGKAtT1/wyjaqcGdGfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mtgqIp2ccU9yrHW75bvhEf9tQZ6gVYfFj+ps9c/FFtbATrDOFAhOjQOOHSbMtD6WXlXmvYVZUD3caxe4wo5LOzZF6RYDuFUgCwxol3Xs7tcFdnieJ5dt9rQwiVaVaUFrJ4i9rd99zCfOSEIjGDkB2hkSMc1XJx8EOUemutfb6OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdvQIbGI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdvQIbGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628579; x=1806164579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bt+AXgtn75w+rtXbNgQtMbF5XGKAtT1/wyjaqcGdGfU=;
  b=kdvQIbGIn7Mdt8FrOPmoHAq+5P/fLBy0z2dv2Ojtl6Kv5Rrw5MAg4WjP
   bAX29Bmra7o0GKUrSljXF7PJ5dMV7Zhzcg3cebGpMZUFgrQvuGqlUp7LJ
   tdMc9s8XDcPcO50o3mXKFGtXkyKv8kLfffW+SNUZq4QsuBtk9uEWyjAVv
   xODzEmkDXeBHsa6iY59ajyvB71bPo3Ie1ZjdPTvu8Q1MG2aOBbEkAkP75
   XrCsh5FEosKer9XMGXJ6vth6s9ZuUK64H3SlpiYljZ8nJM479Ps/dNFli
   GCZhjS6n7mF/yPgsHPSaHzTEZemkvPvV28jQ/zKY2cpra5cAvrJuoJaVw
   A==;
X-CSE-ConnectionGUID: QuowUohcQL2C1sE1KCgWng==
X-CSE-MsgGUID: sTQu5qcbROamvUvU+EBVxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565530"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565530"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:22:59 -0700
X-CSE-ConnectionGUID: YdQUWutwQw+iZMy1w4tZGQ==
X-CSE-MsgGUID: GtvkTFD1RIGQEdOsfwxIdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516160"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:22:55 -0700
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
Subject: [PATCH v2 07/31] x86/virt/tdx: Embed version info in SEAMCALL leaf function definitions
Date: Sat, 28 Mar 2026 00:01:08 +0800
Message-Id: <20260327160132.2946114-8-yilun.xu@linux.intel.com>
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

Embed version information in SEAMCALL leaf function definitions rather
than let the caller open code them. For now, only TDH.VP.INIT is
involved.

Don't bother the caller to choose the SEAMCALL version if unnecessary.
New version SEAMCALLs are guaranteed to be backward compatible, so
ideally kernel doesn't need to keep version history and only uses the
latest version SEAMCALLs.

The concern is some old TDX Modules don't recognize new version
SEAMCALLs. Multiple SEAMCALL versions co-exist when kernel should
support these old Modules. As time goes by, the old Modules deprecate
and old version SEAMCALL definitions should disappear.

The old TDX Modules that only support TDH.VP.INIT v0 are all deprecated,
so only provide the latest (v1) definition.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.h | 23 ++++++++++++++---------
 arch/x86/virt/vmx/tdx/tdx.c |  4 ++--
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index c641b4632826..e5a9331df451 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -2,6 +2,7 @@
 #ifndef _X86_VIRT_TDX_H
 #define _X86_VIRT_TDX_H
 
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 
 /*
@@ -11,6 +12,18 @@
  * architectural definitions come first.
  */
 
+/*
+ * SEAMCALL leaf:
+ *
+ * Bit 15:0	Leaf number
+ * Bit 23:16	Version number
+ */
+#define SEAMCALL_LEAF			GENMASK(15, 0)
+#define SEAMCALL_VER			GENMASK(23, 16)
+
+#define SEAMCALL_LEAF_VER(l, v)		(FIELD_PREP(SEAMCALL_LEAF, l) | \
+					 FIELD_PREP(SEAMCALL_VER, v))
+
 /*
  * TDX module SEAMCALL leaf functions
  */
@@ -31,7 +44,7 @@
 #define TDH_VP_CREATE			10
 #define TDH_MNG_KEY_FREEID		20
 #define TDH_MNG_INIT			21
-#define TDH_VP_INIT			22
+#define TDH_VP_INIT			SEAMCALL_LEAF_VER(22, 1)
 #define TDH_PHYMEM_PAGE_RDMD		24
 #define TDH_VP_RD			26
 #define TDH_PHYMEM_PAGE_RECLAIM		28
@@ -47,14 +60,6 @@
 #define TDH_VP_WR			43
 #define TDH_SYS_CONFIG			45
 
-/*
- * SEAMCALL leaf:
- *
- * Bit 15:0	Leaf number
- * Bit 23:16	Version number
- */
-#define TDX_VERSION_SHIFT		16
-
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 2b17e0f73dac..130214933c2f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2202,8 +2202,8 @@ u64 tdh_vp_init(struct tdx_vp *vp, u64 initial_rcx, u32 x2apicid)
 		.r8 = x2apicid,
 	};
 
-	/* apicid requires version == 1. */
-	return seamcall(TDH_VP_INIT | (1ULL << TDX_VERSION_SHIFT), &args);
+	/* apicid requires version == 1. See TDH_VP_INIT definition.*/
+	return seamcall(TDH_VP_INIT, &args);
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_vp_init);
 
-- 
2.25.1

