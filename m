Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981770;
	b=M4vlgfXzxXCXja1Qaulx3wzzfemwiLpOUAIW3lLSob+MJvN2U+Xwjo385OGWzUkb+WLv
	 g9Ow4mY1P/U8lwqLYqQOzelxuHBukYdhHesK66uV07gX0W/j/bzdZy3GIR1KdHrwQMwLX
	 066gYJps4KUzfbkLnd/JfgxR0KhHJn0tBVuOY8FRtcIJQApr4WM4OCPasW3F+iBN+P1UA
	 g7TQElG41+944ZcmGkXVxr088QHyvsXnF1ZRRqvyDkdeGWvWfooNd3Al6BoXbzOhxBgZZ
	 3lSBniVlU/S7XKMe/5727516U6K1iklJFZvvT8z4KHzKrbCtxt0dxsHIMtY6AfeP9pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981770;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=euUjs7g5m1kBgqRnzu/IvV2JEZwIjebPlXv93uatAJg=;
	b=Ux11wQaKMeg8SvguEGt4rIXLHFALSV4xz03tuzWndPYfYPV9AEGSJprtm0kAFTVAi/h8
	 YtO+4UMv+FR8G2xJ6b5BI4lSj9yi/XcxF455iKTDAy+0FhjlPpYwpBSdd53cmek9jp+kl
	 sVGrxJ4nDetPcX1tB3QH29Ovl+xGFDBQEMGdesEITtk2q5+uO12ex96oTwGPNJHkS2UUp
	 WzRdONrl9uPOnOrC4+B0JPP+XPDQg7bC5FwG/05Gzq80SLW55R7f+OMijuN4gWEnMbmLN
	 DcQQOs3yv7TZfRqhnrSi1LH2vkf3Fw1jXCHMWL0ZyQu0NxBCui3SwQsUQJNIulK7bUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L3hiQZ05;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C00606A32E;
	Fri,  6 Nov 2026 16:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35C00606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L3hiQZ05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793981770; x=1825517770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J/JRYTAvKXFUHp2RZmX+Fogs7RGWrYI67ncXWIwYPxs=;
  b=L3hiQZ0592b5JgCSwHT5vWqCgY4ObRzmd9PowYkNy+3C1kCJD2kSp0K7
   BDLpnPa9VAGQAiv3sLuNnbxw3zoit+qJ4dMpVkFtGZXbW531EtqR0pr5c
   w0XQ09XbQQtzFUE9BNMfxlXRgXFuaEhN2Ab7bYbFQYhv8ysE/K79AkmpA
   Z6Bwp0GryBlboJTIGCa+hdYRhY5opCAyLYjP9szkNCmrsRN7CMdyLIXVh
   s6lLi9Anuad9SjE3t33efRMYwqv/EhY3Ak/R7A3OC2KyzjtzX5G4YWGj9
   y5Tn1NNd7lX687wjBG8IRPd39QDKGEEKHELIw6lTSmtprTLMTt89Uq521
   g==;
X-CSE-ConnectionGUID: nHdsK9J8SZG8hMr4TLlObw==
X-CSE-MsgGUID: a36cZwnwRxOuVaNBzqNIdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2889297"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2889297"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:16:05 -0800
X-CSE-ConnectionGUID: uqBO6s9/TE6+rvyqXWJepA==
X-CSE-MsgGUID: xkkP3+96Rp2KIPrzcML3/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7341886"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:16:02 -0800
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: nirmal.patel@linux.intel.com,
	bhelgaas@google.com,
	robh@kernel.org,
	mani@kernel.org,
	kwilczynski@kernel.org,
	lpieralisi@kernel.org,
	asutosh.pathak@linux.intel.com,
	szymon.durawa@linux.intel.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/7] PCI: vmd: Add vmd_configure_cfgbar() helper function
Date: Fri,  6 Nov 2026 18:42:50 +0000
Message-ID: <20261106184256.4130-3-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
References: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the VMD CFGBAR initialization code to a new helper
vmd_configure_cfgbar(). No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Asutosh Pathak <asutosh.pathak@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e4ac04936320..4992682a69b1 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -954,6 +954,22 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	return 0;
 }
 
+static void vmd_configure_cfgbar(struct vmd_dev *vmd)
+{
+	struct resource *res = &vmd->dev->resource[VMD_CFGBAR];
+	resource_size_t busn_end;
+
+	/* Do not let resource[0] end go out of bound.*/
+	busn_end = vmd->busn_start + (resource_size(res) >> 20) - 1;
+	busn_end = min_t(resource_size_t, busn_end, 0xff);
+	vmd->resources[0] = (struct resource) {
+		.name  = "VMD CFGBAR",
+		.start = vmd->busn_start,
+		.end   = busn_end,
+		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
+	};
+}
+
 static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 {
 	struct pci_bus *child;
@@ -1011,7 +1027,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
-	resource_size_t busn_end;
 	bool vmd_in_guest;
 	int ret;
 
@@ -1020,16 +1035,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	if (ret)
 		return ret;
 
-	/* Do not let resource[0] end go out of bounds */
-	res = &vmd->dev->resource[VMD_CFGBAR];
-	busn_end = vmd->busn_start + (resource_size(res) >> 20) - 1;
-	busn_end = min_t(resource_size_t, busn_end, 0xff);
-	vmd->resources[0] = (struct resource) {
-		.name  = "VMD CFGBAR",
-		.start = vmd->busn_start,
-		.end   = busn_end,
-		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
-	};
+	vmd_configure_cfgbar(vmd);
 
 	/*
 	 * If the window is below 4GB, clear IORESOURCE_MEM_64 so we can
-- 
2.43.0

