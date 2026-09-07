Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C9448391;
	Mon,  7 Sep 2026 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788771788; cv=none; b=EZtwsB5HU8Ke9NwuCai5Z6mFjncvTWfPNEehIWk97pHMMjmGbg9cai7Rofn8QVqii2qXPB1ecpX1FDzIv/YO2gqiPSAMic0FWx74B+kehagSwAG2SkG1Ci0w+FOLvIfOVT1j/r617pCnPxT97+Jy5ieNru1ZeKEDnr/fIn11qMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788771788; c=relaxed/simple;
	bh=98wbZBa0cueKeX7rxI7zVGJ1KZaQ56QTJZuCcR8ZZK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uppL4vg6luw33Iy8gQLjvEtKjsio0ErzBUFkHY1w2NuGyYK47UzOOXlHgTOmcb+z8E2YDxrsA++kRAoKlDRzlpAOcwMixHpEV9yxO/4GngokIaYErssmoAwPEW75N4znkTqbTGFqF6azWFltoJt/FDVwNCtq+vDHNGWYlytE2F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cpRh0mK8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cpRh0mK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788771786; x=1820307786;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=98wbZBa0cueKeX7rxI7zVGJ1KZaQ56QTJZuCcR8ZZK0=;
  b=cpRh0mK8nMyWAaKhqzZCPMAhqqkIsmsavaMTb+f02inATkbNCWC3hLXh
   qJeop1veKgXsgxiBj1agt8NDcBFNlff3eU7Kj6t3JAgBe8miKXwqMNuVZ
   dYT5gKFGo+Kp71QPFgX3iNYleIqZcq1YSJkiIHiT5kF6f1DD+zKSNEFRK
   Z62aGMnQ73mYcwStT86JmFLLbt5J62lQkDK7Ay4TucLnvBybrNTwjqLb6
   qxgvdGDK7yJV5UnkQjem6+BRGdP1h9eMwG6+LVEy1ssXizsZp2Iow/50g
   f+f0Xv0kavMD0Ee/rxyHh3GPNsnsJ78UA+IqzxZyZfwmKnw3Mich1Jvb7
   Q==;
X-CSE-ConnectionGUID: tRbtK+7sRJ+qrySJqxkzqg==
X-CSE-MsgGUID: XtCI4r2UTYeL8fLtHFzZ7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="92872962"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="92872962"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 02:03:05 -0700
X-CSE-ConnectionGUID: TVe2MCW+QtG99Mcl8b8VKA==
X-CSE-MsgGUID: XkAqN48+Q/a/TJ/wvaUqHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="272588583"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.66])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 02:03:01 -0700
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
Subject: [PATCH v2] PCI: Disable not supported reset methods on DG1 0x4905
Date: Mon,  7 Sep 2026 10:59:18 +0200
Message-ID: <20260907090249.1348552-2-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DRM CI consistently reports failing device reset attempts on Intel DG1
discrete graphics adapters.  Manual reproduction attempts allowed to
narrow down the scope of that problem to a specific revision of that
hardware, SKU 8086:4905.  It has been confirmed that both reset methods
claimed by the device, i.e., flr and bus, suffer from that issue.

Since consecutively failing device resets may lead to system hangs,
disable both useless reset methods.  A respective CI test will then be
skipped instead of aborting whole CI jobs.

Suggested-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/11814
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
v2: Fix commit description wording (Andi)
  - add Suggested-by: tag missing from v1,
  - add collected Reviewed-by: tags.

 drivers/pci/quirks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21fd..e55475374c6fd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3811,6 +3811,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0xb005, quirk_no_bus_reset);
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1164, quirk_no_bus_reset);
 
+/* Intel DG1 0x4905 may not recover from bus reset */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4905, quirk_no_bus_reset);
+
 static void quirk_no_pm_reset(struct pci_dev *dev)
 {
 	/*
@@ -5597,6 +5600,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
  * AMD Neural Processing Unit 0x1502 0x17f0
  * Intel 82579LM Gigabit Ethernet Controller 0x1502
  * Intel 82579V Gigabit Ethernet Controller 0x1503
+ * Intel DG1 Discrete Graphics Adapter 0x4905
  * Mediatek MT7922 802.11ax PCI Express Wireless Network Adapter
  * Mediatek MT7925 802.11be PCI Express Wireless Network Adapter
  */
@@ -5612,6 +5616,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1502, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x17f0, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x4905, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x7925, quirk_no_flr);
 
-- 
2.54.0

