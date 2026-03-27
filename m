Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E706B3624A9;
	Fri, 27 Mar 2026 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628577; cv=none; b=ToPv/fnqYjYRXB7UzDIP8RqX8px82/qgD2SsD6JbcLTIod2l7u3JMs526eO0Nr7PPMrKDVNg4Kf2D0wKTWlomC6egtg4c8LmsOC7UQm7NrBr/T8aB68IoHu6ln84bheIYUXpGcXZpnnsqoUP0BtSDZn9KMEz4I3O7oK9+wUVB1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628577; c=relaxed/simple;
	bh=xPHgxfDyMSOxBqXoGww2xpS50SPwXH+y3hJLxy7+2vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IacB7Gvd9MiZrgzpKZmBr3Y7mzzwkK/RDAS90Z9v2uERRA7V6jwzUAoDkjekomX8jywXIWDAfSY2pESMlaA/k1gr2W4wPwMZ/DJZkHQF21zigu6XMuRLWHB85w9fCfDF+dftJkYoznIImsgQIGISnTXLM/2veCpqxYU6OwCqoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZcSikWu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZcSikWu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628575; x=1806164575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xPHgxfDyMSOxBqXoGww2xpS50SPwXH+y3hJLxy7+2vg=;
  b=XZcSikWu/2mHxzT0/NPoma0AfG2+A6c7QTboa5tdvJZUxIyS4Fte0l9g
   c84V7Q6vat4hebxR8yxJQfAxff4huXn8ZW6AqS4CRVWlxyMGcuHBu5Qg4
   h/RhZ74x2sPiOrtTyTbZj2kci6rm712EplJkCUDdRQOwUfRVKZdnfmHSc
   eGgTckMnYYcXIY1c49sGJr8zZcwBHU4wxrBGMpiOC2r+1xCzw9LMeDxX+
   el+6bs5DYIPUph1MZQM10bG6dMd7z1LB50YHUSI/YJKBJl2mLJ5kX2RNA
   jen8cYtbHL5MuSckyABYdxhX7sPtd4GCMMYYqxGNj0+Cx5n4cu5UkGR3A
   A==;
X-CSE-ConnectionGUID: UZEFPanBTOyQ4EbvIT4Q6g==
X-CSE-MsgGUID: T13VESzaRj2fJAsqrkb2vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565524"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565524"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:22:55 -0700
X-CSE-ConnectionGUID: dzGbcFO8RruOGMCFpo70sQ==
X-CSE-MsgGUID: 6TkXo9ENSwqs1Qx4+FpUgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516153"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:22:52 -0700
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
Subject: [PATCH v2 06/31] x86/virt/tdx: Read global metadata for TDX Module Extensions/Connect
Date: Sat, 28 Mar 2026 00:01:07 +0800
Message-Id: <20260327160132.2946114-7-yilun.xu@linux.intel.com>
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

Add reading of the global metadata for TDX Module Extensions & TDX
Connect. Add them in a batch as TDX Connect is currently the only user
of TDX Module Extensions and no way to initialize TDX Module Extensions
without firstly enabling TDX Connect.

TDX Module Extensions & TDX Connect are optional features enumerated by
TDX_FEATURES0. Check the TDX_FEATURES0 before reading these metadata to
avoid failing the whole TDX initialization.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h                  |  2 ++
 arch/x86/include/asm/tdx_global_metadata.h  | 14 ++++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 36 +++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index d5f1d7b7d1e7..d7605235aa9b 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -129,7 +129,9 @@ int tdx_enable(void);
 const char *tdx_dump_mce_info(struct mce *m);
 
 /* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_TDXCONNECT	BIT_ULL(6)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
+#define TDX_FEATURES0_EXT		BIT_ULL(39)
 
 const struct tdx_sys_info *tdx_get_sysinfo(void);
 
diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index 060a2ad744bf..e7948bca671a 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -34,11 +34,25 @@ struct tdx_sys_info_td_conf {
 	u64 cpuid_config_values[128][2];
 };
 
+struct tdx_sys_info_ext {
+	u16 memory_pool_required_pages;
+	u8 ext_required;
+};
+
+struct tdx_sys_info_connect {
+	u16 ide_mt_page_count;
+	u16 spdm_mt_page_count;
+	u16 iommu_mt_page_count;
+	u16 spdm_max_dev_info_pages;
+};
+
 struct tdx_sys_info {
 	struct tdx_sys_info_features features;
 	struct tdx_sys_info_tdmr tdmr;
 	struct tdx_sys_info_td_ctrl td_ctrl;
 	struct tdx_sys_info_td_conf td_conf;
+	struct tdx_sys_info_ext ext;
+	struct tdx_sys_info_connect connect;
 };
 
 #endif
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 13ad2663488b..a07f1e7b18e8 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -85,6 +85,36 @@ static int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *sysinfo_td_conf
 	return ret;
 }
 
+static int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
+{
+	int ret = 0;
+	u64 val;
+
+	if (!ret && !(ret = read_sys_metadata_field(0x3100000100000000, &val)))
+		sysinfo_ext->memory_pool_required_pages = val;
+	if (!ret && !(ret = read_sys_metadata_field(0x3100000100000001, &val)))
+		sysinfo_ext->ext_required = val;
+
+	return ret;
+}
+
+static int get_tdx_sys_info_connect(struct tdx_sys_info_connect *sysinfo_connect)
+{
+	int ret = 0;
+	u64 val;
+
+	if (!ret && !(ret = read_sys_metadata_field(0x3000000100000001, &val)))
+		sysinfo_connect->ide_mt_page_count = val;
+	if (!ret && !(ret = read_sys_metadata_field(0x3000000100000002, &val)))
+		sysinfo_connect->spdm_mt_page_count = val;
+	if (!ret && !(ret = read_sys_metadata_field(0x3000000100000003, &val)))
+		sysinfo_connect->iommu_mt_page_count = val;
+	if (!ret && !(ret = read_sys_metadata_field(0x3000000100000007, &val)))
+		sysinfo_connect->spdm_max_dev_info_pages = val;
+
+	return ret;
+}
+
 static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 {
 	int ret = 0;
@@ -94,5 +124,11 @@ static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
 	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
 
+	if (sysinfo->features.tdx_features0 & TDX_FEATURES0_EXT)
+		ret = ret ?: get_tdx_sys_info_ext(&sysinfo->ext);
+
+	if (sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT)
+		ret = ret ?: get_tdx_sys_info_connect(&sysinfo->connect);
+
 	return ret;
 }
-- 
2.25.1

