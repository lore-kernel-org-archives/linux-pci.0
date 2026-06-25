Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42BB383318
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 06:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367677; cv=none; b=D5az96q+a5Ba/dR8fK9RFrBj+GsU/VtXrWyiuM8DYfjGbbl8RjmHiRM0Fu2L+wFAXXup66HoacqGNSOB8JxTPNFTpGaZJlKK7W572PC9j4XRmXFhk9w5zaJDOOr1T3u/H8ZWJ70NtWDRfHokcghZN8VuziGCltEHvX83BwP4xr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367677; c=relaxed/simple;
	bh=B0PjpAPHO5usfACySzuXSKmwOSCxgNobSQ3i5sCXQDo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCBsJWRxVRB8FuWHCL+EVuYHOcahJC+E8kFjE6R7covG9aBqsYzkb8NelKKthPELE04wJTv+EXoiIDjL8SAlDn/ELR6mBpwrt95bPatkJ/bENHlxIYC+dR/Pvs8E6n6jtY7lfNLSArl/+5GHeoGkR10FBgElPKxvl+bjUwnh42U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsisTXiH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsisTXiH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782367675; x=1813903675;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=B0PjpAPHO5usfACySzuXSKmwOSCxgNobSQ3i5sCXQDo=;
  b=TsisTXiHsyL9mkQL6c2Vsy5xyyaPqXhMWGySZxVRQCoky7b5dMp3VV6p
   Du+jthQVl5796Tnz9jOmqLrDCfVvuVQwsaZoIx+UNMWw1ulfwUzgh5WHh
   IWxnmlsA9mIaao6cGmnvQXw7YgQFLb4lQgbm7aqNjzhkp6EpJeXzzUfRd
   iVDklg4PDgU9Zr06NgxMW+aLckcCvhTILhBGlukOUqr5aW/JK790wszxH
   IyB9algB9hSye1hccsSoDxJMrlBjN4phWeFZ0eo7syKHqA9FqNL+73QoN
   VAX2JjUxeCWC269+WeXty3o8bCJUCcwaGnm2WqTcq3p0i3+Do64d6WajC
   g==;
X-CSE-ConnectionGUID: hgUNAVbpSVmZAxQff/zXhQ==
X-CSE-MsgGUID: AtSSGTN4QPO4OFjE2tsnwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83021823"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="83021823"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:07:55 -0700
X-CSE-ConnectionGUID: 6P3F2FIKREyzsb7TuMo1aQ==
X-CSE-MsgGUID: cjRG3HZ4R5GOHa76xDFfvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="250725414"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:07:53 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v5 2/8] PCI: vmd: Add vmd_configure_cfgbar() helper function
Date: Thu, 25 Jun 2026 08:29:31 +0000
Message-ID: <20260625082940.1290740-3-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
References: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the VMD CFGBAR initialization code to a new helper
vmd_configure_cfgbar(). No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 070b247b3fbb..2c824660cabd 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -771,6 +771,18 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	return 0;
 }
 
+static void vmd_configure_cfgbar(struct vmd_dev *vmd)
+{
+	struct resource *res = &vmd->dev->resource[VMD_CFGBAR];
+
+	vmd->resources[0] = (struct resource){
+		.name = "VMD CFGBAR",
+		.start = vmd->busn_start,
+		.end = vmd->busn_start + (resource_size(res) >> 20) - 1,
+		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
+	};
+}
+
 static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 {
 	struct pci_bus *child;
@@ -857,13 +869,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 			return ret;
 	}
 
-	res = &vmd->dev->resource[VMD_CFGBAR];
-	vmd->resources[0] = (struct resource) {
-		.name  = "VMD CFGBAR",
-		.start = vmd->busn_start,
-		.end   = vmd->busn_start + (resource_size(res) >> 20) - 1,
-		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
-	};
+	vmd_configure_cfgbar(vmd);
 
 	/*
 	 * If the window is below 4GB, clear IORESOURCE_MEM_64 so we can
-- 
2.43.0

