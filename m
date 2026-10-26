Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039350;
	b=ksjv7smH9osyo4XpGt7n9jeazvHmRN1giwW+P/OtrJSDP9fyvwfbhdoDyVIr68YH9MDg
	 RAKsPWbMtub/7z2rNi8LedPiqTD+cJb7mFnDNUN9XB+b9hGpH4Komy9Rl/C2VIYhbIG6a
	 MYkVHWMprGv/RkmlAU+/z89wXLaprGnqGTWNCoMxc/ycQfa5i+qYiK0bzb9yYl6woZG4t
	 fVBOlx+UjFnpQbcB2+1nk2UJWE1pZgFW1YG9zUnRPeSfXTx53n5uK3zq/WzWfCUIZJ2T3
	 mx8ssMKf+lKe5REFxVZPFVf8dgiT6a3Le5tUFhe09idETCISpgw2sTgB/obDlS3ZRmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039350;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T5eyJuPYBB5dJvizm4B+jyIC7d0qJizGLlsOlHeOB6A=;
	b=H9i+ER+CiO3ct6NOK7WPsQH3D3LdyrCDBfuMeWWZYYsRFNFn2RUJCa2eYvBTLtmrUr12
	 dEUctHCJ+Ec8+LC+1YpjG1TuOeknDXqAn7vjYutNTSV93z1QjYUzhY4UbM2VC49tgqGkD
	 fD0mH9pVgD6THHLssg4xtL+7s+TcxZ5IQ46v319InWxmu1ZKVpSrDXEuefA5NThS10Ghw
	 1RygeZ7F+ghe+6lAASgiemm+jgA6LwKssY3Um6Cev0k945j5wnjbC4uQ00DSAJBjdCgYb
	 NZFWoq41GjgfZetGRkfA1EDhsiP52Co9gJbQtYYk90atGVj4jxaBaPUga7bNHS/93vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NZoaDG9e;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D0A606A332;
	Mon, 26 Oct 2026 18:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76D0A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NZoaDG9e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039350; x=1824575350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DOuXCw5dCps78nu9B9Qpc8vBfwq58tJ6JyIJ3pVMFXc=;
  b=NZoaDG9ebApIJz+P568mCznCKF7ETv5MRBUrT5uSkZjOXjNwHHR4mXAI
   IXU/KuzEvxLZ+yczsl4K5iYES3MGYwecg8NK5BYWu1Qznd6sJ5yRJt/pD
   6AlZcgJZSOLX7vC/S68bAasCHjO59H+cOcfHUCH+lNAq6J1hEHL+hcMh8
   2jGc8IhPZ+xQdLzaTJ8EZdkyFZWvkhqliQCDRMTDi702bNNLP/LAEqEXZ
   jX39Q5RNR4V5ZwQ7S8RyWAXfigPaE9eyW4e80R2bWTNaG22PE1OH1rsdi
   jia0ePRli/W4mwPvvvvJ5p8JgMTh6QWV1eEBkNhiXDHaP/CbIkjkBkD7q
   Q==;
X-CSE-ConnectionGUID: pQriogK5QE2j4eigVe3fgw==
X-CSE-MsgGUID: S2Fxy8Z+SdGYBpAEuQTOow==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1601005"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1601005"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:29:10 -0700
X-CSE-ConnectionGUID: bzEHCSreTOaive/tL+vpzQ==
X-CSE-MsgGUID: VmCmFiQ0R+m3Yf7sIGYzrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4720088"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:29:07 -0700
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
Subject: [PATCH v9 2/7] PCI: vmd: Add vmd_configure_cfgbar() helper function
Date: Mon, 26 Oct 2026 20:54:55 +0000
Message-ID: <20261026205502.3502574-3-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026205502.3502574-1-szymon.durawa@linux.intel.com>
References: <20261026205502.3502574-1-szymon.durawa@linux.intel.com>
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
index 57d5e917dc45..2a8c10604c82 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -905,6 +905,22 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
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
@@ -962,7 +978,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
-	resource_size_t busn_end;
 	bool vmd_in_guest;
 	int ret;
 
@@ -971,16 +986,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
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

