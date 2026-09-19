Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240B7380FF5;
	Sat, 19 Sep 2026 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789835226; cv=none; b=fSp1wdeUZqfS0EEP0O1PUjV5M3LtVDUglmYVoikewOxfIQCBoCl5vDW8akVhKxWfpLFJYsqF2ajsSvNdSU2r1aBHi7FautYIZPMKcf2gVKgiLB/H5pAD3cwnuI05+NvIQCKUZM6mZJ287o/4U5PRBsaFsUK91454HDEX2ZxLHEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789835226; c=relaxed/simple;
	bh=KBEyovsTBQZ4FyHhLxPlufc+TwZjADtubpxUAsCsdGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2fT8TrVTfOmW6zdYUrZD61IqXjy8Bb5X9+1rJR8Zojdo7DWHxsbwABrwxJSkPmwiADh0o1eSAM+fZv5Cf7J/TF5kajOajftz4ek3by21+8dagk2Ry1Su7LMxHroCqRyAst6KUqWG2d9AFg/eH6V8ZZ8IKvva0MNONNLJKYPnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5P+k+Sv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5P+k+Sv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789835225; x=1821371225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KBEyovsTBQZ4FyHhLxPlufc+TwZjADtubpxUAsCsdGg=;
  b=P5P+k+Sv6SF+t9uLKFph5aZztlLFTpwaPjs5xcvIvLkrjRFXW84SARrB
   moVklbLBChTktLObGobPWb5QEgvU82aE/oT7516KRjDwZm2DPLA05KR/X
   brbqfrH1nDNIDRRHyt6y+2hnVA4RLoDOsCkh5TIda5CLLtrlvxsLg4KQ6
   mWXpUnJTFFlvTu1OOdqRONgchsxBcfJW8zhRPwnEpLpMxC9esCLngbKCK
   nZEFlRgwJri4P0aWW3S79/eKROH5ag6xEGm3SEgfij/dG6G5ybfnqUv20
   k/GY+UY2s8PH2ssrt3OaBZ/efXNQfbXv1axC/bdArz3IV4CtRoTra321p
   w==;
X-CSE-ConnectionGUID: jlP3375HRfyHtYBLi+Lcng==
X-CSE-MsgGUID: eVdk/Ow+RouXvc7FCSjR8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="94187233"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="94187233"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 09:27:02 -0700
X-CSE-ConnectionGUID: MEE+hRoRSEif6lde+bj8XA==
X-CSE-MsgGUID: 3d87gAWKTmCWAVQp+K1uQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="272186118"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 09:27:02 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rafael J Wysocki <rafael@kernel.org>,
	Guixin Liu <kanie@linux.alibaba.com>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH v13 2/5] PCI: Assume control of portdrv-related features only when portdrv enabled
Date: Sat, 19 Sep 2026 09:26:52 -0700
Message-ID: <20260919162655.3499010-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
Changes since v12

 * Rebased to v7.3-rc3.  No code change.
 * Commit log reworded.  v12 said we can always take control of LTR and
   SHPC hotplug unless a platform interface tells us otherwise, which is
   not true on ACPI systems.

v12 posting
https://lore.kernel.org/all/20201126011816.711106-1-helgaas@kernel.org/

 drivers/pci/probe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..5f7eb6bc438b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -668,12 +668,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	 * may implement its own AER handling and use _OSC to prevent the
 	 * OS from interfering.
 	 */
+#ifdef CONFIG_PCIEPORTBUS
 	bridge->native_aer = 1;
 	bridge->native_pcie_hotplug = 1;
-	bridge->native_shpc_hotplug = 1;
 	bridge->native_pme = 1;
-	bridge->native_ltr = 1;
 	bridge->native_dpc = 1;
+#endif
+	bridge->native_ltr = 1;
+	bridge->native_shpc_hotplug = 1;
 	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
 	bridge->native_cxl_error = 1;
 	bridge->dev.type = &pci_host_bridge_type;
-- 
2.43.0

