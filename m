Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594EF3264F7
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363254; cv=none; b=nh6xnwYsajHbDyt2zBFqp8xOOCeWplQ9BKvXMzCCaKj3jMQpb/vsIJmuXKAChqh0URCy98zXeyUx4Viwl7b4W3J67kwXCaHTV/CAg3Omnpf2j7PbGo2ba88ugkMiAGXLrDKgVSvYs1j2cKtYavUHOi6moXEQK8mXRQgIOfmuMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363254; c=relaxed/simple;
	bh=qgJb7sEef0nizcIBEc+OTblU4SOxIF+XL4QKiKj8vKk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgmOoWiJsoiBD1IOuch51AMk/CTl39aBs+1UUcd4k++dCvc3uW8OAt/gpOYoAm68khASWu9gPLG1LiusEwudj/B9wQgS9cejoB2G+1sXzPfe1gtZ26+cjM0d5/mECCljf1aMrtjpXaJBG2t5AoRW6yL9o++7wUevDy6EXxsFYP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Te5rOvGO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Te5rOvGO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788363252; x=1819899252;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=qgJb7sEef0nizcIBEc+OTblU4SOxIF+XL4QKiKj8vKk=;
  b=Te5rOvGOcRLfnBzwVMUVlWJrZtM23CId8Hw5HtVSlb7b2Pz9UhgMtVxt
   lEHuOPe6KMOvoVAD00D96/xI5B0BFBnoUT/EGjeC3ZbOrKND+UOczvMgj
   gjQcj/8J5BGZYNwstFlGDH7TCuOfwEXo08itjg+cLnCqDaudYAg0HFyKf
   g7AKz38G+f5R1x+zkhxac9049HN+Ds5cIuf33ZYkB2RWgkdEhmemJ5Sd9
   Jyb8NcYsCPypUyO/F1VDI418Be4hDor+9NrmMPObvEANB6eqQhI7RACFt
   4Iuncb0BEOh0FhMBpyHq51dC/5pOBaTHbVlEh8X/QjjFv+0rnFhEweCkL
   A==;
X-CSE-ConnectionGUID: yL+Zzix+T/2rbFsg6vGypQ==
X-CSE-MsgGUID: qyvt8949SLeXlil1mUy2mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92646663"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92646663"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:34:12 -0700
X-CSE-ConnectionGUID: lMQm3S5sS2eUPOKubDAhfw==
X-CSE-MsgGUID: JYGNhQv8RrazXICaz653Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="271406758"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:34:11 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v7 2/8] PCI: vmd: Add vmd_configure_cfgbar() helper function
Date: Wed,  2 Sep 2026 17:58:38 +0000
Message-ID: <20260902175846.3497854-3-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902175846.3497854-1-szymon.durawa@linux.intel.com>
References: <20260902175846.3497854-1-szymon.durawa@linux.intel.com>
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
index c7d705fe2530..08636e2ba010 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -902,6 +902,22 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
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
@@ -959,7 +975,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
-	resource_size_t busn_end;
 	int ret;
 
 	ret = vmd_prepare_offsets_and_bus(vmd, features, &membar2_offset,
@@ -967,16 +982,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	if (ret)
 		return ret;
 
-	/* Do not let resource[0] end go out of bound.*/
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

