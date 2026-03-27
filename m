Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0228371CFD;
	Fri, 27 Mar 2026 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628600; cv=none; b=fEcpbB60p1xY+MwF3DwwrzqoVfqG4kA0oved2i+HAp9ZtSoN3ox/IB8et9Pb9UCThbW5YAQC3Mtt3JalsaFzsDtjJiIL+Fmo02/N7cNKDBRNWqgQGJowStVFRXul4DW1Gmmjx/8YuKjtMJA+FRxWLaQUbCnAa7l4RcA4/PkL5Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628600; c=relaxed/simple;
	bh=RtbDb463am0ETHo/8RtK51kAaPZf1IlC30Of1RwsQQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABQQoQZMZsw+XAyIsY2owoRbpiUe5Cq+RX86WXeYJ39lszpdYnTsa/up7IBnrmt0iVg7Pc5fU4En9qhHU8NcCVIhoA/E2ZWWdla16dPj31ul48FQObpo7ZgTuJwbtw4tUxbjVUioLTvuuT0G8TpTGVq6nna379TDc03zazIQ7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHpz8zr0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHpz8zr0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628597; x=1806164597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RtbDb463am0ETHo/8RtK51kAaPZf1IlC30Of1RwsQQ0=;
  b=nHpz8zr0bWUolDn8goqbTE4CBVTfwNp3K3hwFp7OB1HJat/t6cIs3C38
   EIAUUCC8J4k9gjNxD00z/g7Jb32ltjJ/kCd66J/ZKSKIv68gCYwwQX/rm
   uU4bIxIODQBJ3kF46U1UKfF9Owe7ExGS1uQrT2+F8gyGC46ZsGF9hTMwX
   x+77W9OmhrvAHTZ+9OlueBBDf6gXEaqbVHOg61CViNrgQEZ149OZEdpYN
   jqdbNMkW6lUpTCgExF/XQISu++jiNpKd0bpKbvyxrLZOPreR00VOaZwwu
   y3QvqwYNkXgpYHeB+171/rZhu1jYVsGmAgzh8PqVHNwKhcylzrhf1BsHp
   A==;
X-CSE-ConnectionGUID: RoKFU9JATo6mbahaFY405w==
X-CSE-MsgGUID: 57qmkzDrR7i8I9tuyxjgRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565557"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565557"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:23:17 -0700
X-CSE-ConnectionGUID: Bb7IBTbCSyyXuI5HkgFb0g==
X-CSE-MsgGUID: z3taUSlXSEmCvY8q9njN9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516211"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:23:14 -0700
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
Subject: [PATCH v2 12/31] x86/virt/tdx: Enable the Extensions after basic TDX Module init
Date: Sat, 28 Mar 2026 00:01:13 +0800
Message-Id: <20260327160132.2946114-13-yilun.xu@linux.intel.com>
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

The detailed initialization flow for TDX Module Extensions has been
fully implemented. Enable the flow after basic TDX Module
initialization.

Theoretically, the Extensions can be initialized later when the first
usage of the Extension-SEAMCALL comes. That would save or postpone the
usage of ~50M memory. But it isn't worth the complexity, the needs for
Extensions are vast but the savings are little for a typical TDX capable
system (about 0.001% of memory). So just enable it along with the basic
TDX.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4134f92425da..0e1ad793e648 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1580,7 +1580,7 @@ static int tdx_ext_mem_setup(struct tdx_page_array *ext_mem)
 	return 0;
 }
 
-static int __maybe_unused init_tdx_ext(void)
+static int init_tdx_ext(void)
 {
 	struct tdx_page_array *ext_mem = NULL;
 	unsigned int nr_pages;
@@ -1705,6 +1705,10 @@ static int init_tdx_module(void)
 	if (ret)
 		goto err_reset_pamts;
 
+	ret = init_tdx_ext();
+	if (ret)
+		goto err_reset_pamts;
+
 	pr_info("%lu KB allocated for PAMT\n", tdmrs_count_pamt_kb(&tdx_tdmr_list));
 
 out_put_tdxmem:
-- 
2.25.1

