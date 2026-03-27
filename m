Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972334A789;
	Fri, 27 Mar 2026 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628562; cv=none; b=sgUwKS4HCqrnQEbw5EQxrAKD4z1cu0hKxRkpIzDy9RneoFms4V8SJ6iP61m2Wd5IZY6Jgkf7qWGvLnZmsN+hoDm/eD47kgd9mGszGM/Hn+R8L4eW6rCSBG0pBqAOgrTH5OWSSgRmoDjxHm5DDibjFqr/UlSAVy1YT94Mvvf70og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628562; c=relaxed/simple;
	bh=kpGbvHoaXkXL7UPtDLh0r6IDkgZKESQJe+SKEMtuWqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLYfMULFXX6uwlMGzmZaYMEcl4w3ZdiBlM5xK7tS5nB2emhCcJ7ZBEeLafFIjDpmLXS6OTUJKrfR4PYWOTV6XxRKfhp5fl7TAN1Cbyb6sj5ryMMni5QrQAGhB9IWtlnsZn3dLtABjNWR7rWGplWtEZjoof6nVqD08tOLooDyXeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gD3cKNzD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gD3cKNzD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628561; x=1806164561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kpGbvHoaXkXL7UPtDLh0r6IDkgZKESQJe+SKEMtuWqs=;
  b=gD3cKNzDF+RbYhh5t44mdyIJnpKnXKwd37xqy1EGMEAlMSctd24C7/lJ
   X9NHY8OXilEnYCBdFuQ28OfiAxIcXgp39ty1AeVw70fY64fh+epo/yTId
   GQ+yR9WnBNm0p7x9bC+r6LAm2RlLfqN5hXEPRgeghY88p7aVxfwmxt3DF
   7fmRXPtQ/w94TzIB+NOa6z/zwqPRpoKqhgwExPUMD4KFVs7PCtvZoT73N
   YuAo5F1lyRO3ub2axTJnL6Z9ByT2oLXkEWWY3J8qXMisfUs3jYcVpcHpp
   Jv4h+8sxMblaVclqQmpW7uchfrRAZWEBLKB1ysgXmwIZkUHKrcKTEvP0n
   Q==;
X-CSE-ConnectionGUID: maLePqYFSEetb3+6qQ+p4Q==
X-CSE-MsgGUID: zdBW4plWRyOaIz/+J0zXxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565497"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565497"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:22:40 -0700
X-CSE-ConnectionGUID: 8cAe9lgUQYOSEy9qJyUBwQ==
X-CSE-MsgGUID: eh2NIIVNT4uURSnlVSCYtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516125"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:22:37 -0700
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
Subject: [PATCH v2 02/31] x86/virt/tdx: Move bit definitions of TDX_FEATURES0 to public header
Date: Sat, 28 Mar 2026 00:01:03 +0800
Message-Id: <20260327160132.2946114-3-yilun.xu@linux.intel.com>
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

Move bit definitions of TDX_FEATURES0 to TDX core public header.

Kernel users get TDX_FEATURES0 bitmap via tdx_get_sysinfo(). It is
reasonable to also public the definitions of each bit. TDX Connect (a
new TDX feature to enable Trusted I/O virtualization) will add new bits
and check them in separate kernel modules.

Take the opportunity to change its type to BIT_ULL since TDX_FEATURES0
is explicitly defined as 64-bit in both TDX Module Specification and
TDX core code.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h  | 4 ++++
 arch/x86/virt/vmx/tdx/tdx.h | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index e040e0467ae4..65c4da396450 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -127,6 +127,10 @@ static __always_inline u64 sc_retry(sc_func_t func, u64 fn,
 int tdx_cpu_enable(void);
 int tdx_enable(void);
 const char *tdx_dump_mce_info(struct mce *m);
+
+/* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
+
 const struct tdx_sys_info *tdx_get_sysinfo(void);
 
 int tdx_guest_keyid_alloc(void);
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 82bb82be8567..c641b4632826 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -84,9 +84,6 @@ struct tdmr_info {
 	DECLARE_FLEX_ARRAY(struct tdmr_reserved_area, reserved_areas);
 } __packed __aligned(TDMR_INFO_ALIGNMENT);
 
-/* Bit definitions of TDX_FEATURES0 metadata field */
-#define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
-
 /*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!
-- 
2.25.1

