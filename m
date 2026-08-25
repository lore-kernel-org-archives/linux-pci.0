Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7E3A7F4C;
	Tue, 25 Aug 2026 05:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787636637; cv=none; b=QYmPGGXstKBGIEFkY+jn0G7Lfpbr9ci+JdxaXvvgsWCAjy9LdE99BkLQlU/9G2V1LKA2HW9Nfu3kMGc1fb8KlcMJSjhZkJdwv02s7iQhSS08JqMvJJUZ3RNoKu+zyE6MBtrYOE6neMr2dadYyA7hoUzGkx3+oMCwhpiZuhSWUwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787636637; c=relaxed/simple;
	bh=NckCnP6OWUrT+a8Ar5FSx/z1JUqU1muMHZoGOJ3whYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmSiKdMD3C/m1aZypowfMQuzqpmSX0gkOBuXvrfh5+9GweWVhdBPNUySV0lF8esaN8CCWv6O1K4CBbYnBJEPlrcKgXNm5CKK5WVkGB9dnYL7vrFFVmPnRLYJ91yd1Ypf59uBh1+2cGJpHFsZMW64kIT3CK1r1nKsBybSLpjgdP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cm9F4lMR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cm9F4lMR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787636635; x=1819172635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NckCnP6OWUrT+a8Ar5FSx/z1JUqU1muMHZoGOJ3whYU=;
  b=Cm9F4lMRD5qqIrK193gVfvpTni5yNUcnxVqqgWSskVXiJXAMwv6tVkAm
   seSaqeqLAZg+iY2kkaqCZKIAVSS+JR+Sk4jOwovwgfLUd4fNIatBd2dJH
   STIXbxcfkYA6jaNwUqPA+sHwy0zzswYFuKWpodELvh3fMtWTf/+bmgz8J
   Jb+eiIG/ivlVXPhhRVcA0uOJLhVmID2uTsU8BLzPsjgHUSy9QBtGgl2vo
   ldwXJqFNc1hICo8+X24BuP0MkVTUVwUKimN0Px+M39+a3tWUkI5d76tTe
   jg9DvaKOQp8s7NmCxcHFvOcw+gCHwcln2E7p6iO3aOv19nctqZRyIJy6M
   g==;
X-CSE-ConnectionGUID: xeYNzSERTOasEQ/LozITqQ==
X-CSE-MsgGUID: Qy07r0C0RWuKUZK+hMo7Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88152524"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="88152524"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 22:43:54 -0700
X-CSE-ConnectionGUID: uVLU52bNQX+noE1BJyA8yw==
X-CSE-MsgGUID: /bmHWHGpQPGdSX2Zhu/uNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="272418233"
Received: from unknown (HELO jraag-Z790M-ITX-WiFi.iind.intel.com) ([10.190.239.23])
  by fmviesa005.fm.intel.com with ESMTP; 24 Aug 2026 22:43:50 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	iweiny@kernel.org,
	ming.li@zohomail.com,
	bhelgaas@google.com,
	rodrigo.vivi@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	lukas@wunner.de,
	riana.tauro@intel.com,
	michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 2/2] drm/xe/ras: Enable SGUnit PCIe error reporting
Date: Tue, 25 Aug 2026 11:12:51 +0530
Message-ID: <20260825054312.1319951-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825054312.1319951-1-raag.jadav@intel.com>
References: <20260825054312.1319951-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SGUnit as a PCI endpoint is not AER capable and requires explicit
programming of error reporting bits in DevCtl register of it's config
space for upstream error propagation. Hack it.

While at it, add native AER sanity check for upstream port before
programming SGUnit register.

This is as per pci_enable_pcie_error_reporting() logic implemented
in PCIe AER driver.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/gpu/drm/xe/xe_ras.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index de4cb9ef7355..c4b5c0b5eb0d 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -3,6 +3,8 @@
  * Copyright © 2026 Intel Corporation
  */
 
+#include <linux/aer.h>
+
 #include "xe_debugfs.h"
 #include "xe_device.h"
 #include "xe_drm_ras.h"
@@ -234,6 +236,9 @@ static struct pci_dev *find_usp_dev(struct pci_dev *pdev)
 	return pci_upstream_bridge(vsp);
 }
 
+#define PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
+				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
+
 static void ras_usp_aer_init(struct xe_device *xe)
 {
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
@@ -251,6 +256,14 @@ static void ras_usp_aer_init(struct xe_device *xe)
 		return;
 	}
 
+	if (!pcie_aer_is_native(usp)) {
+		dev_warn(&usp->dev, "No native AER support\n");
+		return;
+	}
+
+	pcie_capability_set_word(pdev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
+	pci_save_state(pdev);
+
 	/*
 	 * Clear any stale Uncorrectable Internal Error Status event in Uncorrectable Error
 	 * Status Register.
@@ -279,6 +292,7 @@ static void ras_usp_aer_init(struct xe_device *xe)
 	pci_save_state(usp);
 	dev_dbg(&usp->dev, "Uncorrectable Internal Errors downgraded and unmasked\n");
 }
+MODULE_IMPORT_NS("AER");
 
 static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
 {
-- 
2.43.0

