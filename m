Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B23FFABA;
	Fri, 27 Mar 2026 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628640; cv=none; b=hjkS+gaulU156LWZWyeDaN11dITwFlk+ZXUjmENhhHRk4XCbcIz3fiN01zvkPvzCAjd17PkrZVot+lY8+BSjl4n9K61BHuoLT3u2pc3BqHknYqayndfwpWk/Oy1wpCVvcqbt7B/Cy5ZYL8D8wHFNC5RX7s/9lKkODX6jF61TBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628640; c=relaxed/simple;
	bh=YzOkHMivVD/+gHSn2pojaLxbNd1uQTgUv+wqAcBP+bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rjF+wMD4yNnfS4UUNzOPKjFkBqcCjqh+WuGPYICqswH98SO80W7QNpgp0bXIWfFRix+EsSvaJSVHXEX2hkVKJ/0GzxzbMKnoP9ibwNLjgZlmhTHEzteSyoZ82zi/Y+LAnxb3pbk29k2TusfXxEE170aQ+aHsTwRrg+EFzIhWOZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZrdqVmU4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZrdqVmU4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628638; x=1806164638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YzOkHMivVD/+gHSn2pojaLxbNd1uQTgUv+wqAcBP+bs=;
  b=ZrdqVmU4XhDKzKT6Pd+S34YHPinjMNO4DICd9Dt7w4PHaDS2IuIP9X8Z
   o+lrMWL1Hw5LPo+qRUiZzqmn/1aNs737uHzhtY7qBGrKiHaGeRQa97CXU
   o9CQVO4BhCM/7a2S9KDW7K71kV7ltJyANOWOVaG+NbRCWL26N8lND0Z5Z
   leKf9ppsojJS5kK05Z/FGSR9t3tdBe36cGWFHxmznjnihtt4+Mk92+pxO
   VWd7wp0kLmkCVetUSwPr2Gt+rVB9+JAdWlvrZgdtLjDZNyeDv3/B/BKOQ
   55f7ecy8rgMLZHH24UFxh4bADUJ7hCWIqQNHKHSyryyDdqaSR5DRaqQLn
   Q==;
X-CSE-ConnectionGUID: bjySKThtSoSOQ4KGPIAckg==
X-CSE-MsgGUID: 3U6Bg8BEROqwIi07aK775w==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565654"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565654"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:23:58 -0700
X-CSE-ConnectionGUID: YWnWYM/cS2icefPw8WDqWQ==
X-CSE-MsgGUID: 41WgSvkdQ7uo8CXRqhfzxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516345"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:23:55 -0700
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
Subject: [PATCH v2 23/31] coco/tdx-host: Setup all trusted IOMMUs on TDX Connect init
Date: Sat, 28 Mar 2026 00:01:24 +0800
Message-Id: <20260327160132.2946114-24-yilun.xu@linux.intel.com>
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

Setup all trusted IOMMUs on TDX Connect initialization and clear all on
TDX Connect removal.

Trusted IOMMU setup is the pre-condition for all following TDX Connect
operations such as SPDM/IDE setup. It is more of a platform
configuration than a standalone IOMMU configuration, so put the
implementation in tdx-host driver.

There is no dedicated way to enumerate which IOMMU devices support
trusted operations. The host has to call TDH.IOMMU.SETUP on all IOMMU
devices and tell their trusted capability by the return value.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/virt/coco/tdx-host/Kconfig    |  1 +
 drivers/virt/coco/tdx-host/tdx-host.c | 85 +++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
index 32add81b7d56..24e872f8953e 100644
--- a/drivers/virt/coco/tdx-host/Kconfig
+++ b/drivers/virt/coco/tdx-host/Kconfig
@@ -13,3 +13,4 @@ config TDX_CONNECT
 	def_bool y
 	depends on TDX_HOST_SERVICES
 	depends on PCI_TSM
+	depends on INTEL_IOMMU
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 5ea35a514865..98ed93ac0153 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/device/faux.h>
+#include <linux/dmar.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/pci.h>
@@ -119,6 +120,82 @@ static void unregister_link_tsm(void *link)
 	tsm_unregister(link);
 }
 
+static DEFINE_XARRAY(tlink_iommu_xa);
+
+static void tdx_iommu_clear(u64 iommu_id, struct tdx_page_array *iommu_mt)
+{
+	u64 r;
+
+	r = tdh_iommu_clear(iommu_id, iommu_mt);
+	if (r) {
+		pr_err("fail to clear tdx iommu 0x%llx\n", r);
+		goto leak;
+	}
+
+	if (tdx_page_array_ctrl_release(iommu_mt, iommu_mt->nr_pages,
+					virt_to_phys(iommu_mt->root))) {
+		pr_err("fail to release iommu_mt pages\n");
+		goto leak;
+	}
+
+	return;
+
+leak:
+	tdx_page_array_ctrl_leak(iommu_mt);
+}
+
+static int tdx_iommu_enable_one(struct dmar_drhd_unit *drhd)
+{
+	unsigned int nr_pages = tdx_sysinfo->connect.iommu_mt_page_count;
+	u64 r, iommu_id;
+	int ret;
+
+	struct tdx_page_array *iommu_mt __free(tdx_page_array_free) =
+		tdx_page_array_create_iommu_mt(1, nr_pages);
+	if (!iommu_mt)
+		return -ENOMEM;
+
+	r = tdh_iommu_setup(drhd->reg_base_addr, iommu_mt, &iommu_id);
+	/* This drhd doesn't support tdx mode, skip. */
+	if ((r & TDX_SEAMCALL_STATUS_MASK)  == TDX_OPERAND_INVALID)
+		return 0;
+
+	if (r) {
+		pr_err("fail to enable tdx mode for DRHD[0x%llx]\n",
+		       drhd->reg_base_addr);
+		return -EFAULT;
+	}
+
+	ret = xa_insert(&tlink_iommu_xa, (unsigned long)iommu_id,
+			no_free_ptr(iommu_mt), GFP_KERNEL);
+	if (ret) {
+		tdx_iommu_clear(iommu_id, iommu_mt);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void tdx_iommu_disable_all(void *data)
+{
+	struct tdx_page_array *iommu_mt;
+	unsigned long iommu_id;
+
+	xa_for_each(&tlink_iommu_xa, iommu_id, iommu_mt)
+		tdx_iommu_clear(iommu_id, iommu_mt);
+}
+
+static int tdx_iommu_enable_all(void)
+{
+	int ret;
+
+	ret = do_for_each_drhd_unit(tdx_iommu_enable_one);
+	if (ret)
+		tdx_iommu_disable_all(NULL);
+
+	return ret;
+}
+
 static int __maybe_unused tdx_connect_init(struct device *dev)
 {
 	struct tsm_dev *link;
@@ -130,6 +207,14 @@ static int __maybe_unused tdx_connect_init(struct device *dev)
 	if (!(tdx_sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT))
 		return 0;
 
+	ret = tdx_iommu_enable_all();
+	if (ret)
+		return dev_err_probe(dev, ret, "Enable tdx iommu failed\n");
+
+	ret = devm_add_action_or_reset(dev, tdx_iommu_disable_all, NULL);
+	if (ret)
+		return ret;
+
 	link = tsm_register(dev, &tdx_tsm_link_ops);
 	if (IS_ERR(link))
 		return dev_err_probe(dev, PTR_ERR(link),
-- 
2.25.1

