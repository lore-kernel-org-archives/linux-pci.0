Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6746402B8E;
	Fri, 27 Mar 2026 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628650; cv=none; b=XxuMztE977utoXO8SMVYGETfkzDkEsIb48HXUjV1xjbpcSkrmGDtyk3bV7cdR9X22IxqKKkBOCnIRmRcDsJr+aJ4vsOnOAPOx9goGD0hL7x7mqpiVQzo4542L+o8d+nzPvuwxoR7mYpRAhLfW2L9l768HpR1b9nNJ+83K7HhWIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628650; c=relaxed/simple;
	bh=8E2PLd8Xi1KBtL2Kxec5V5ZmUSQnGJ77ky0/+RmRlqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l3R4vTjeayZdS5bDsmBRQho45Ngok61Qk4/V/5TgD9NDd/ST8WijRb3JFPYqofCEVUfyrK0EsqxHtzioStMp5r3dzqdPrZqS1Yf1l5xy40zQZZWSBqIdHAcMRU+xHOD8WgrfnJY/FFtwTbfNFzH/gaG+UyN8vQPnbq+xLAV2jbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PmDk0dLx; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PmDk0dLx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628649; x=1806164649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8E2PLd8Xi1KBtL2Kxec5V5ZmUSQnGJ77ky0/+RmRlqo=;
  b=PmDk0dLxtx3OtJzIU9LzR+iZlfFFogJAJ3rZcV6OU4HToL8AVxJDS9Ye
   F4ONWE+oYKE0r2UMvIzBUo4Owkoj+fN0BLI8WHhI3F4vk9+yJSss6Nbuz
   WJ4vYs1/5MaZpQm/rQaWnzmSVUZ3cyf/jRQTrkYKpFCOs4LXoizIXjaGT
   4Ii9d/mKhO/NO8DlUfyBIwtQAyepIh/he+qBu7oF0izGzKP+DfzDM6SQJ
   asgCb3vv9uLnKg8f3qCBYKbo3WPvEBZvOL0DKE1KwvfE16yMZnUVOhxfU
   jHJ4Fqtw+plxtL7EDarJUQxNLgN6IWUlYA0niuDwXEMKEqZpkCtb6tQTA
   Q==;
X-CSE-ConnectionGUID: cGuIfJfzSsKoq0zlWdSO1Q==
X-CSE-MsgGUID: y2EJi8zETKaJUyYhyXlK/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565672"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565672"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:24:09 -0700
X-CSE-ConnectionGUID: INInqSmmT5GX8l6IsBXsZw==
X-CSE-MsgGUID: MDEUJzpURl2LxhyA9Xh66w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516363"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:24:06 -0700
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
Subject: [PATCH v2 26/31] mm: Add __free() support for __free_page()
Date: Sat, 28 Mar 2026 00:01:27 +0800
Message-Id: <20260327160132.2946114-27-yilun.xu@linux.intel.com>
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

Allow for the declaration of struct page * variables that trigger
__free_page() when they go out of scope.

A example usage would be in the following patch:

  static struct pci_tsm *tdx_tsm_link_pf0_probe(...)
  {
	...

	struct page *in_msg_page __free(__free_page) =
		alloc_page(GFP_KERNEL | __GFP_ZERO);
	if (!in_msg_page)
		return NULL;

	struct page *out_msg_page __free(__free_page) =
		alloc_page(GFP_KERNEL | __GFP_ZERO);
	if (!out_msg_page)
		return NULL;

	...

	tlink->in_msg = no_free_ptr(in_msg_page);
	tlink->out_msg = no_free_ptr(out_msg_page);

	...
  }

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 include/linux/gfp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 51ef13ed756e..d37e5564234e 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -391,6 +391,7 @@ extern void free_pages_nolock(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
 
 #define __free_page(page) __free_pages((page), 0)
+DEFINE_FREE(__free_page, struct page *, if (_T) __free_page(_T))
 #define free_page(addr) free_pages((addr), 0)
 
 void page_alloc_init_cpuhp(void);
-- 
2.25.1

