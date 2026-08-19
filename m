Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2585428463;
	Wed, 19 Aug 2026 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135136; cv=none; b=gi2TTlOxvd7H290VpbrRZrTPRUItHlpm9V9q6HFPPspP+wK6L3FVx8yIrCrBz9fR/4pipdyfoY78wT1HAhwszDDrPRbonyweylHz4j0Rt91aiGT4pg6JlFW1mzBcQUxhZMi2fbB6cR3siUsiOgC05xgx+u4Jz+gfbnMdQE28ql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135136; c=relaxed/simple;
	bh=3f9oCDaVVLcAqYqHQpXm8qWQti8vW8R5PhoT4gZ6Ht0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4rOB7Nrp85kmA7I9lajkypjg0/1OdJH/Mp8fdaaWQ93olvtwu8gJuQjgNqpSAU7t1BO7Du+u5vSnFDmBGvwJwtKEAwAIVY/UAuTxysy9j0ahNZ4PAfvH0M6OSIxh+qxJKRfAFXWwkftsdobBi2s2oO+bIPSVGtQAZu8Y1BGXXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ht2udHil; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ht2udHil"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787135134; x=1818671134;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3f9oCDaVVLcAqYqHQpXm8qWQti8vW8R5PhoT4gZ6Ht0=;
  b=Ht2udHil5oHM3iqwpq2iULGhgnZlszVunEPn6s4e3zLOeNUSV6dzueaY
   LfsfOiiQn8OUYrVayK7X2KG+KAh5e6f5dpUXC7HhqQX1MhmvWQnGos7B8
   uLQLA+wbsZeCA47tiFlRQQm/Jjz1Xts++UEz1nCnGdQtXGrgbqMHi87/o
   qwORoqWHZxXG0qTcn54WsHwN56rpo6PltTlL3v1/Xp/N84NGFq8xtLIk0
   a4o3mURjcf0hrrs2ABnLlb8Wo4HGt8ocNe73FT+8MvQk+XBdgRAX2RG4d
   p/b0Lome62MnEN+oFm4PUb19DieXUh/rIxLPx/wxaeegl5Mgj+64cOWWv
   A==;
X-CSE-ConnectionGUID: sKSsQCiUTS2B7A+E2YZCNw==
X-CSE-MsgGUID: g72x6E+PQsidwVaQv3bAiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87406484"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87406484"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 03:25:33 -0700
X-CSE-ConnectionGUID: zIj3ZprmTMiqI4x4NKjO3A==
X-CSE-MsgGUID: +nO2PVB1S+6nIL3w0Xqy/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="269008437"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.91])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 03:25:31 -0700
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Krzysztof Karas <krzysztof.karas@intel.com>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
	linux-kernel@vger.kernel.org,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH] PCI: Disable not supported reset methods on DG1 0x4905
Date: Wed, 19 Aug 2026 12:24:53 +0200
Message-ID: <20260819102509.1662504-2-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DRM CI consequently reports failing device reset attempts on Intel DG1
discrete graphics adapters.  Manual reproduction attempts allowed to
narrow down the scope of that problem to a specific revision of that
hardware, SKU 8086:4905.  It has been confirmed that both reset methods
claimed by the device, i.e., flr and bus, suffer from that issue.

Since consecutively failing device resets may lead to system hangs,
disable both useless reset methods.  A respective CI test will then be
skipped instead of aborting whole CI jobs.

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/11814
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/pci/quirks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846fc..63298fba9ddeb 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3808,6 +3808,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0xb005, quirk_no_bus_reset);
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1164, quirk_no_bus_reset);
 
+/* Intel DG1 0x4905 may not recover from bus reset */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4905, quirk_no_bus_reset);
+
 static void quirk_no_pm_reset(struct pci_dev *dev)
 {
 	/*
@@ -5594,6 +5597,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
  * AMD Neural Processing Unit 0x1502 0x17f0
  * Intel 82579LM Gigabit Ethernet Controller 0x1502
  * Intel 82579V Gigabit Ethernet Controller 0x1503
+ * Intel DG1 Discrete Graphics Adapter 0x4905
  * Mediatek MT7922 802.11ax PCI Express Wireless Network Adapter
  * Mediatek MT7925 802.11be PCI Express Wireless Network Adapter
  */
@@ -5609,6 +5613,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1502, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x17f0, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x4905, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x7925, quirk_no_flr);
 
-- 
2.54.0

