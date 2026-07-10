Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2990389118
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783713935; cv=none; b=mk5pJcQiADWIhU159arFhxFxMVV300HCQp/cUx/WHkAkxeH+Qe35NLdcFGSjYNXBFapVSKA00fRjC7lOnzW963NUrup+3nq5l3AnvDZipix6eGQHJjsxUHkQkryhZnUyO558Z2PuOgnn+2apBgPXey3jhf1Vow66Qvqp7yGt45k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783713935; c=relaxed/simple;
	bh=FoWwWXVDZETpKxVmh18Jn9ti0urJNvpnqzKv2SXecDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ew9x0FUVORKXC0b/dTrUJBDi1Gj7NFx0LzUI9UizBeGKkNWgrGDREPp8LaJN8N6Mto6hIp0mMFyC3QyuoOZJmNFeMv2aAuswrkHgGjEZkn4gvfs+5q+Y+58N6Mi8wP98o1B7vjskinGC/uW8lH+wlWwxlRJtloH1QXmbPAKsW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izxbcjIv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izxbcjIv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783713932; x=1815249932;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FoWwWXVDZETpKxVmh18Jn9ti0urJNvpnqzKv2SXecDQ=;
  b=izxbcjIv/zeZmbAN5TL8S2rj6d/sCsSwEPMBhTCco7SVXLhShWslbT9A
   HZ+/U210R+AcbzZaS5i+8cdfq00ZkNiCO0OvMVxeUc+qUXT3OZsJNwyZy
   rr84tFW3iAa62+u2L2h199eAC30We7RGbyej06rxJjYEgSOOPEj3PcL6n
   LAg2upszx8J7JswAg2ZzPwLXB0dg0LjWsQzP5/etVphZwSp3vxZ+buw3q
   vdu+k/xMZ2pHt2XpO68BeeTYmWDy2DPtx5vteAjxs4dYoF/6p0cnOjSjb
   2F7Eq/X1SszykAufQr0ge7VjVLH6rPwm/TDepyZbA8+tvc5gd5DCpA0W5
   Q==;
X-CSE-ConnectionGUID: 1GfqROVrS2SNbMH5TcjbSQ==
X-CSE-MsgGUID: m4FGnvlOQmStC9+EOPgmHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95064345"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95064345"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 13:05:31 -0700
X-CSE-ConnectionGUID: J6HAIumRRkW74gJfcMeKvA==
X-CSE-MsgGUID: liwwotYSQs2IAx/5Ob0RRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="278219610"
Received: from zp3110c002s0704.zpn.intel.com ([10.219.117.38])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 13:05:30 -0700
From: Nirmal Patel <nirmal.patel@intel.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	lpieralisi@kernel.org,
	Nirmal Patel <nirmal.patel@intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2] PCI: vmd: Only assign OSC features in bare metal OS.
Date: Fri, 10 Jul 2026 20:05:58 +0000
Message-ID: <20260710200558.499434-1-nirmal.patel@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy valid OSC flags from root bridge only when OS can provide correct
values. In virtual machine, all of the control features are disabled as
hypervisor will not passthrough root bridge information to VM.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
v2 : Added descriptive boolean and removed period from commit message.
---
 drivers/pci/controller/vmd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d4ae250d4bc6..760dfb4d9480 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -782,6 +782,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	resource_size_t membar2_offset = 0x2000;
 	struct pci_bus *child;
 	struct pci_dev *dev;
+	bool vmd_in_guest;
 	int ret;

 	/*
@@ -862,14 +863,15 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		.parent = res,
 	};

+	/* Non-zero offset means guest/direct assign view. */
+	vmd_in_guest = offset[0] || offset[1];
 	/*
 	 * Currently MSI remapping must be enabled in guest passthrough mode
 	 * due to some missing interrupt remapping plumbing. This is probably
 	 * acceptable because the guest is usually CPU-limited and MSI
 	 * remapping doesn't become a performance bottleneck.
 	 */
-	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
-	    offset[0] || offset[1]) {
+	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) || vmd_in_guest) {
 		ret = vmd_alloc_irqs(vmd);
 		if (ret)
 			return ret;
@@ -910,8 +912,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		return -ENODEV;
 	}

-	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
-				   to_pci_host_bridge(vmd->bus->bridge));
+	/* Don't copy OSC control flags in VM, it disables features.*/
+	if (!vmd_in_guest)
+		vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
+					 to_pci_host_bridge(vmd->bus->bridge));

 	vmd_attach_resources(vmd);
 	if (vmd->irq_domain)
--
2.43.0

