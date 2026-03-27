Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6312A3FEB1C;
	Fri, 27 Mar 2026 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628636; cv=none; b=bftN4OLwWUj5r4FUb0vVcVsFTFxJyRDIRoiY6sRqvCFZUkcKnWi3hg10Pmyn9oI6s4g2qVOz1M01nWeIPjIOz1McyJizjv4H1Z+0g24zJzf3KjLK+u3KwNI26+ZjQIWRZPCGQLc2J/Yuz7mrE/JzhBAeD81J/4ip5Kz2NsyjfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628636; c=relaxed/simple;
	bh=4N4OssQklL/B7HyKRZJOSblHOdQoFgXqUseYPZid0EE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tjNUI8TptrAcBUAjYcl1ZPP1p1FjoWZ6AbflRkl9kpj9c3AYoHZIyRa8h+jAXmUHsW+q+dF6RqWQmsWa4ulfZseJxF9aJE4s0YLOZqfTfhyqiKIvFnZGtTTwfpSGshOUW4CUl/6jvL+q+eiqxRphE3SdR0OStHL989jkPVcaHMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhEqOiPA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhEqOiPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628635; x=1806164635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4N4OssQklL/B7HyKRZJOSblHOdQoFgXqUseYPZid0EE=;
  b=EhEqOiPAz2WV/AGZJDDK/TXNOA1DuJbqh0LJPfF9yrhwzezTHj090dac
   9xSppzvLuYob4zC3hIvPZPG+BatmATngAwhmoyGydmrOaEu4HzXhRU9Ec
   w/tdEfbu0/KwAZyJjMh5+ahQ5O2dRig6H2iZabr+xi7355xZHgug2VvN9
   xUE0LC91G5Z7Cq8C2PwKwDM0sjBdO9l2k010ADLl5rIe5xjAJN8GcQw8P
   sBE73nPXxKfsQ1e27SGKnOis6+WbIDERa5Li122vgl7oA9omXDVXGTxfc
   vYcFzfa4VZHeMHoiZClvRRfDyPwEyBFz+2Vg2SV5te+Tdi6eL0AgQTBxk
   g==;
X-CSE-ConnectionGUID: ZQQ3XzckRuWCbBKvA8d5yg==
X-CSE-MsgGUID: MgCKW7QzSBe3oUMUu3uvRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565651"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565651"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:23:54 -0700
X-CSE-ConnectionGUID: dt1l+oQwR5iY4ZOfYTtnEg==
X-CSE-MsgGUID: QZ4FgOGYQSOqVGVIpnJ43g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516341"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:23:51 -0700
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
Subject: [PATCH v2 22/31] iommu/vt-d: Export a helper to do function for each dmar_drhd_unit
Date: Sat, 28 Mar 2026 00:01:23 +0800
Message-Id: <20260327160132.2946114-23-yilun.xu@linux.intel.com>
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

Enable the tdx-host module to get VTBAR address for every IOMMU device.
The VTBAR address is for TDX Module to identify the IOMMU device and
setup its trusted configuraion.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 include/linux/dmar.h       |  2 ++
 drivers/iommu/intel/dmar.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 692b2b445761..cd8d9f440975 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -86,6 +86,8 @@ extern struct list_head dmar_drhd_units;
 				dmar_rcu_check())			\
 		if (i=drhd->iommu, 0) {} else 
 
+int do_for_each_drhd_unit(int (*fn)(struct dmar_drhd_unit *));
+
 static inline bool dmar_rcu_check(void)
 {
 	return rwsem_is_locked(&dmar_global_lock) ||
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 4f9571eee1d4..eea9ba691f99 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2452,3 +2452,19 @@ bool dmar_platform_optin(void)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dmar_platform_optin);
+
+int do_for_each_drhd_unit(int (*fn)(struct dmar_drhd_unit *))
+{
+	struct dmar_drhd_unit *drhd;
+	int ret;
+
+	guard(rwsem_read)(&dmar_global_lock);
+
+	for_each_drhd_unit(drhd) {
+		ret = fn(drhd);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(do_for_each_drhd_unit);
-- 
2.25.1

