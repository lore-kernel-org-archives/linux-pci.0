Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3144A400;
	Fri,  2 Oct 2026 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975929; cv=none; b=cJpgBlKfp3Wp9j2jNZ9OWSHxEv1lM1E/DRyuoHuFBSxWowyF0CtxJfPHJuLfsAmbD57MGKxTQ3v1OvRqpGJdchDK0lME6DSmVlxxR/ff6JZvOpkS3g79RK9Ank3n2ZXXOA/dBNJRslx6E6/RO6hSDAhfTB+JaulDZd4UvZax1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975929; c=relaxed/simple;
	bh=UA82couGMHhZLvH3o2HBoLaG92GelpugjChcu0rPUnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hx9KhMJ22PYL1JI2gFu7pDHTGXH3L5C/NV8yNH8l/hifT+rnahg3wB+DFjz7sMEZ8jAI3Zl3dVNQM9dkaXkrAXDGYqVixRfzEc16SrS2g84yvuGa0OmdUjmD94YKuAQvBOJobFUgy++zi+iCbrbPhrUeR7JRTDcVahmRS8W5F8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhKkei3c; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhKkei3c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790975927; x=1822511927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UA82couGMHhZLvH3o2HBoLaG92GelpugjChcu0rPUnc=;
  b=GhKkei3cMK/M/R+1zWOQQDTGdV/u4XZbqizvGos11Pr0FK02axhsrzpS
   qa25wVRGwla6iswRwd5OvE8vHca6x5iY/nMNzYDl9QEjbQPMxlxwAU80W
   AwiujINkvUbkcq9AqGanB7bH2xbDptZ0pBNLvyWM4N1hxC9fgiGKIdOVt
   1600gLzrMXJ+E47oPjGyPdnMg3Z6cVg5843LbS0J3yQbKObqNjZ+kHeUJ
   gY73q/T39iWCvUY0kXnoe1nMUjb2XTMxfqvpU28UwMVTKl36iSvGR4RMe
   ut2Mc3sNA6kynrVvlaXC5rdh7ft3UV6/jnoQtzHHh12uo3X+c2DJc6laK
   w==;
X-CSE-ConnectionGUID: hlRgZrgaSnil6tGUckzC/w==
X-CSE-MsgGUID: Z/mXDXFVQnq9w+ksCvKKkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="101077484"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="101077484"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 14:18:44 -0700
X-CSE-ConnectionGUID: KQO/tcn8TP+UXlPXdePF9Q==
X-CSE-MsgGUID: JhEqg0AuTm2owz6KTif0JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="274987381"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 14:18:43 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	lukas@wunner.de,
	terry.bowman@amd.com,
	kanie@linux.alibaba.com,
	olof@lixom.net
Subject: [PATCH v15 1/4] PCI: Assume control of portdrv-related features only when portdrv enabled
Date: Fri,  2 Oct 2026 14:18:25 -0700
Message-ID: <20261002211828.1293177-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Native control of PME, AER, DPC, and PCIe hotplug depends on the portdrv,
so default to native handling of them only when CONFIG_PCIEPORTBUS is
enabled.

Native control of LTR and SHPC hotplug does not depend on portdrv, so keep
defaulting those to native regardless.

[bhelgaas: commit log]
Link: https://lore.kernel.org/r/fcbe8a624166a1101a755edfef44a185d32ff493.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
Changes since v14

 * No change.

v14 posting
https://lore.kernel.org/r/20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com

Changes since v13

 * Use a local IS_ENABLED(CONFIG_PCIEPORTBUS) variable instead of
   #ifdef (Lukas Wunner)

v13 posting
https://lore.kernel.org/r/20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com

 drivers/pci/probe.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..1e487a213eb0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -658,6 +658,8 @@ static const struct device_type pci_host_bridge_type = {
 
 static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 {
+	bool port_services = IS_ENABLED(CONFIG_PCIEPORTBUS);
+
 	INIT_LIST_HEAD(&bridge->windows);
 	INIT_LIST_HEAD(&bridge->dma_ranges);
 	INIT_LIST_HEAD(&bridge->ports);
@@ -668,12 +670,12 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	 * may implement its own AER handling and use _OSC to prevent the
 	 * OS from interfering.
 	 */
-	bridge->native_aer = 1;
-	bridge->native_pcie_hotplug = 1;
+	bridge->native_aer = port_services;
+	bridge->native_pcie_hotplug = port_services;
 	bridge->native_shpc_hotplug = 1;
-	bridge->native_pme = 1;
+	bridge->native_pme = port_services;
 	bridge->native_ltr = 1;
-	bridge->native_dpc = 1;
+	bridge->native_dpc = port_services;
 	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
 	bridge->native_cxl_error = 1;
 	bridge->dev.type = &pci_host_bridge_type;
-- 
2.43.0

