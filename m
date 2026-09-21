Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0AB46F4BB
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000294; cv=none; b=dRdB0jFYsZSsh5xzPTQIGYrX5fLDhOUWZzpgizp5pC0P6QU28h9fHrfj/iV9Rg31LsEoP446vOW/z8X7mIF7LLylo0tWpZZpP/qz68oDaWITOrGvkHyXF+ZvIn/yT6FCN0w2Hya6Tu93+l9+kjmaf8tJ1SX0GRMFP5QNk7gBE5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000294; c=relaxed/simple;
	bh=J+9zZgiXiuFgPZlhyfhf+6tNtyJtSGdM5M2qGqJo7Ag=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhSAAxMC4banFrE7ZeqysXvv2jc9ZY91sywvh3WnfttkHCKmVhJWiFAQK14ZhSTptihc/vA1FG4U/NDr9aC89SXJf21W9Hvq2i+GWEzUDFzWohmURXA2RneNKxPQ3oKYZ1GhHBjqge5mgigRyHfbhBYz4nw7F7pF7wSfPGbFHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrRIFKbm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrRIFKbm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790000290; x=1821536290;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=J+9zZgiXiuFgPZlhyfhf+6tNtyJtSGdM5M2qGqJo7Ag=;
  b=OrRIFKbmg1/tadUz62tteWBOMXp7rEzF6tnXxY7rjBZ+gMgVtpKGrvvG
   yR8rsq9uLDvWnYrSF8IZCCLgxDq7feHgE6Q238ekebims79pIKIqVIllU
   xlWqMYC8buxt+HcX5RGFDRBVbKQ6l0L4riPNf+7j+LIzJ/ubJ/isYKQ5C
   pMh7Yf3fA/MRs4z9rmq8xLVH4Go+q+OUHGBAaF1QEkmpqpHunU8o6zdln
   MrV7otqquMhYz/QAeMQvRoRQqSgV0q1QodYqvdNGQyR5YpSy6ZADKT48e
   oB1NqDthGjxQtACG3UcgX9Jh8i5TfAnqsov2bbCfHlc7tk9V1beNDsYJD
   A==;
X-CSE-ConnectionGUID: kITRzdRESAe83YxNtYWJGw==
X-CSE-MsgGUID: aPgKEWGaSAWQ1VQHRHO6kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101108348"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="101108348"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:18:10 -0700
X-CSE-ConnectionGUID: 08LiMjFoSoGWN8uBQ+V12g==
X-CSE-MsgGUID: y1smScZOQ6GEoBmUi0BjJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3654373"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:18:09 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v8 2/8] PCI: vmd: Add vmd_configure_cfgbar() helper function
Date: Mon, 21 Sep 2026 16:43:08 +0000
Message-ID: <20260921164316.3860312-3-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
References: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
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

