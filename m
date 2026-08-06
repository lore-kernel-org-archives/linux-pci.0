Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3252305699
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045820; cv=none; b=U70UM3MTIwBt87PN1v6I1GyUoA6Rb/e5NFZQGdrf2yxaOHE9gKZkFv/M+13qUsAmZPXBnt/iEUUAsQJO0WbMAH3U6ZY65XZ7yihbnzbRKOQltE7KnHmlGuQZxAfuFSNTd1LvAAgxRLmpjFDQ8eBFTEN5Cb2jf+Om8QWQsI+qyx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045820; c=relaxed/simple;
	bh=B0PjpAPHO5usfACySzuXSKmwOSCxgNobSQ3i5sCXQDo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7YlsicNo2Hv1e/JB76V7U6CVqD+Nd+TYkWgPtguO6y0wZTX6X1peY+ndfwtTEK5vayu7RkbsXHOgpodRnj59r+hFGDlczGkGZjl6biNPX76ygxbiIzUSzy+e0iHTMwcJm7sZmb6zGtDLo0w+3l8xZ+LjVffztGaS3KAVK/FcbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQIfAMIG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQIfAMIG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786045812; x=1817581812;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=B0PjpAPHO5usfACySzuXSKmwOSCxgNobSQ3i5sCXQDo=;
  b=DQIfAMIG7X1aZ+GOGuF11+52+FLvVy9iK9DImkEKeDoNSjJ4hJUMCYRi
   Rd21UfpwM0V5WNJ2p4ZKSOiSMSnQ5I9lA/jj8HlY1KyPsIZXsqRORV9tb
   H3LE+WMHVAVIUzSKl0fuQo2bumboid+Lk5ckwjGMBWgq/J5nRnbSP2TdS
   gNq1m5cj1bShwbqWxyk3ko8k/ZD0D03jcyV7kHOYjprpVJXH8jlSSPObA
   yyn/HrAfxJG61yP0pctnTIuWdRujaqCgKH5Rx8g2O9snc+afQBabZqQte
   3vcTvYG9pqQXY7RM2khUq6dUEarYnpCyCJvK5f6Hy7vniOYTv81QN0Xyl
   w==;
X-CSE-ConnectionGUID: Q+948ef0TwCP/X4nq8NhSA==
X-CSE-MsgGUID: Zc6UP5oiRP+8FzK3vLCuuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85622526"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="85622526"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:50:06 -0700
X-CSE-ConnectionGUID: IfHJe0ZwQrmerbnEsefG1g==
X-CSE-MsgGUID: MVhzJ67jThWa2ofw1JoaFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="260923394"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:50:04 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v6 2/8] PCI: vmd: Add vmd_configure_cfgbar() helper function
Date: Thu,  6 Aug 2026 22:13:41 +0000
Message-ID: <20260806221351.38592-3-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
References: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
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

