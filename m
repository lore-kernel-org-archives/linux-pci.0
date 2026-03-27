Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66F1373C02;
	Fri, 27 Mar 2026 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628602; cv=none; b=kMyAyMtmRfIS1z+Suv06Ypx5dAIm7+gAZjFUxX4Kfe/3fYhbTX3ZGNRXpiwmgJuVlyHuwHD7xFBLxzSunk+N9OoUsGBDzzHGh/8dbyIybx6EgHn+tlsgjr6yMNIZlOm/O7AXZPIPy34R9wgWaxE88ok5OE0fKvnQuM8JwOYSpTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628602; c=relaxed/simple;
	bh=WGFPbx7sgPfDQCJrPwMdxh2FwqrprHEWOswcgWAGZe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6Z/Eh37+S84AnYuJBDmPUN9nAui1YhKulQx74ZYMxKeHrNM+n0Bv+gXFYnXVydMW1tjHITM/R/aGf6lew3OPXaoenjbplWQqkNfVxW/f5i+n0JdsCtgCTn2Xpd/4Bg3R0KGFGhMdobQ3hLq8IeSr7Fn64hU0EBK13eeBEzTs98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GV8be0Ij; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GV8be0Ij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628601; x=1806164601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WGFPbx7sgPfDQCJrPwMdxh2FwqrprHEWOswcgWAGZe0=;
  b=GV8be0IjvNWMi5nCPKo9F9Ke9VfCO2nN//gkipA/uHQlCUgNGjH6M4wd
   vhlNRGnLcGRG7aKxXgS25ltEwEjinntWpu9mE2QfQLs66w2rPmdOBOUOJ
   FyQxiF8CTTbqWPF8eSLJIdo/Y0MriFpq1aOtyncTGSZALVbM37Bargbwn
   WlrV3ipwPxCPgTpfO4d9Uex+JUGTrlwDq53UdJsWidrYpWHl/Yxvu97X3
   3m7iirmSsFm1S7Lr7NHB4EVh+zX/U+lWsnmI8agdd/6FaDZ1VzuGvWon4
   LIjRMUXpnzG5GDd/60kFNHT/4mnLRpQGjG8RCx3adovKTmFMY/j1N/IqG
   g==;
X-CSE-ConnectionGUID: EMa/TsdSQpmLCxcYfqtmqg==
X-CSE-MsgGUID: t3PD/HiWT2KLe0pMUT2ktQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565575"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565575"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:23:21 -0700
X-CSE-ConnectionGUID: J1a8EKhESLywQV8Ib29x2g==
X-CSE-MsgGUID: pVo962/CTmOwIowi7PFdnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516225"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:23:18 -0700
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
Subject: [PATCH v2 13/31] x86/virt/tdx: Extend tdx_clflush_page() to handle compound pages
Date: Sat, 28 Mar 2026 00:01:14 +0800
Message-Id: <20260327160132.2946114-14-yilun.xu@linux.intel.com>
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

Use page_size() to correctly flush the range that a compound page
covers.

Recall that TDX Module requires VMM to provide IOMMU metadata known as
IOMMU_MT, which contains some multi-order pages. Like all other
metadata, TDX Module will convert these multi-order pages to private so
VMM should flush the shared cache beforehand. Extend tdx_clflush_page()
to handle this case.

The usage of tdx_clflush_page() for IOMMU_MT will be introduced later,
but the change stands as a valid improvement on its own.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 0e1ad793e648..e7d47fbe7057 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1510,7 +1510,7 @@ static int init_tdmrs(struct tdmr_info_list *tdmr_list)
  */
 static void tdx_clflush_page(struct page *page)
 {
-	clflush_cache_range(page_to_virt(page), PAGE_SIZE);
+	clflush_cache_range(page_to_virt(page), page_size(page));
 }
 
 static void tdx_clflush_page_array(struct tdx_page_array *array)
-- 
2.25.1

