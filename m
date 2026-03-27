Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E460740F8C1;
	Fri, 27 Mar 2026 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628669; cv=none; b=R14YfbR3KWHXxGpqQQhBy2gDzN841fUVjPvBPCByl5I0/paod0XnJBLXpdbBCwGEqu4CXgtDFnTSVUQRm2hFy3nBcxPY8seeJSF/ivct95lEKhqucRA5KtHS40ZHKEEW1uDvUPZSCKOu0MY/vl/h2wzvCFgVfvs8OuYRLNnITCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628669; c=relaxed/simple;
	bh=e3F8B2xO+pmyAcCvVmFZ6e91fRtjUozwO9dyL7DqLVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CNj4hqYR2aO6L1O4wm9gBHQI0DigiFYnawLYNryn0da8iig3QQOHJn1pglQK2YpbbIGFqd3tVHpbfy6DXKskD3u0UWq47M4McsBGsxnzkRCqNkAmR3qgX+ehcK3g49psBSA5O/G1oFEYsLBRtTRr2nEocMUFz4BRmlgCHXGJ0aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lv+Qd+VV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lv+Qd+VV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628667; x=1806164667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e3F8B2xO+pmyAcCvVmFZ6e91fRtjUozwO9dyL7DqLVo=;
  b=Lv+Qd+VVAu3CACoOokdFASpm7L3B+FcNOQT6JCXyNoWVOxIzr3DOqmsP
   vf5A6dIRi5dJJoeUeiunQukfGcR5U5lDz/1vubvaJ8t6+kEMBpi1+PVAA
   6ERXbVzIA89VEcuAsr4EVIeK+V0XpAl9oV9o0Zi0/x6n6DGnCAnVZntuJ
   0g7CyMbVjQfM77/1nLMLCR6SXzFK6cgOqffWA8Fp4DxYZmwXFObfI5CNW
   PJ3CfJujuRCdPz8yeQYPTc4MiD1NRXO71aDHRdww6NEPKYA623A60mLS5
   PzgrqZbITiYy97F8JP1xwbEVOWQknFMaRU+6lgSBxZhpCYtGToeIruGNq
   A==;
X-CSE-ConnectionGUID: 9cFhp+/pQNKnNRsWp19vJQ==
X-CSE-MsgGUID: plzuFNNHT9+Q6MN90Ju/GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565712"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565712"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:24:27 -0700
X-CSE-ConnectionGUID: D42qXb8nS2GqNB9VSReytw==
X-CSE-MsgGUID: frmzYPmVQ62s1CJ9Wz5V5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516409"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:24:24 -0700
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
Subject: [PATCH v2 31/31] coco/tdx-host: Finally enable SPDM session and IDE Establishment
Date: Sat, 28 Mar 2026 00:01:32 +0800
Message-Id: <20260327160132.2946114-32-yilun.xu@linux.intel.com>
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

The basic SPDM session and IDE functionalities are all implemented,
enable them.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/virt/coco/tdx-host/tdx-host.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 0f6056945788..7800afb0893d 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -883,7 +883,7 @@ static int tdx_iommu_enable_all(void)
 	return ret;
 }
 
-static int __maybe_unused tdx_connect_init(struct device *dev)
+static int tdx_connect_init(struct device *dev)
 {
 	struct tsm_dev *link;
 	int ret;
@@ -914,8 +914,7 @@ static int __maybe_unused tdx_connect_init(struct device *dev)
 
 static int tdx_host_probe(struct faux_device *fdev)
 {
-	/* TODO: do tdx_connect_init() when it is fully implemented. */
-	return 0;
+	return tdx_connect_init(&fdev->dev);
 }
 
 static struct faux_device_ops tdx_host_ops = {
-- 
2.25.1

