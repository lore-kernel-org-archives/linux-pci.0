Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA1F428841
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782752455; cv=none; b=tSk83iVpOLj8rs7YNoOgBfN4Dizbc9wXSxQ6rRnPDVjyIhsVCk8pSdp6TyVnyFO7EX2DHGl85y+BcG5pU90stnjiCDAlQJEFmCzlmgOrWAhc36zoYj6l/ZxFiKZAAZo/j8mCq52ttmL4Io/fzK8+8v507rXGHov9+vGeDbyIlYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782752455; c=relaxed/simple;
	bh=2J5Fqs2ahHlvFcZVaxewM+t4fw0WhPY53YtHRg77aNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DF9v1pwvVXZGHhBOhZ2jKoIZyK86NYlAs3xf0s3hN1uAuYVPQEKuLc0cZO+p/irBKz6Gje/D0k9DIY+rr0mqn4rnfPj95RqtCx0L5tXXaWVS/aKfmaUxNMRzZHJQ86RwWZ6/it8n7Rbm4Lnc1vYhuDnQ55qM+scSzkYBQsEwOks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5HLVaiO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5HLVaiO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782752455; x=1814288455;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2J5Fqs2ahHlvFcZVaxewM+t4fw0WhPY53YtHRg77aNg=;
  b=g5HLVaiOcxWZbMWXmoddmlxz5FuoM3ej+ihkLafAT9L1Vd4Olk/3XxvM
   pDFK9d6cKGuAIGPSqIgEXBx3Bg+KdPn30GpPJnuQQSrx+bEBA5I2Onx8Y
   JRDW43iKngF8f92mhE2+OZd5VJm+V25WZ/tVvMGnQYr888qcQbehleSnT
   diQBiTA2h2lkHIYMVog30as3HsTTThclEIRgHqDvwDRC21wZS8pYgRQTa
   trb74H4Sh73mAl1ZccF/dWTqTno8wBQ5ROyPdbwWEsGMhWuBjkb/tnaiD
   VYPH50BLjFiUah6ZhVPsAtwNHsJe1EknzGy3aciNlX9s7qRuKxmwMVtPg
   g==;
X-CSE-ConnectionGUID: 1H2yoW9QRxmu5jdCw2icrg==
X-CSE-MsgGUID: 7salbgDlQOibIRYNWeVECw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="93804203"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="93804203"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:00:54 -0700
X-CSE-ConnectionGUID: rVcCgpBlQF6a5zdpr+PMwg==
X-CSE-MsgGUID: sa8ptrffQ1GcOXDaBMDshQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="249384855"
Received: from zp3110c002s0704.zpn.intel.com ([10.219.117.38])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:00:51 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: nirmal.patel@intel.com,
	<linux-pci@vger.kernel.org>
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	lpieralisi@kernel.org,
	linux-pc,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH] PCI: vmd: Only assign _OSC features in bare metal OS.
Date: Mon, 29 Jun 2026 17:01:17 +0000
Message-ID: <20260629170117.269703-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nirmal Patel <nirmal.patel@intel.com>

Copy valid _OSC flags from root bridge only when OS can provide correct
values. In virtual machine, all of the control features are disabled as
hypervisor will not passthrough root bridge information to VM.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by:  Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/pci/controller/vmd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d4ae250d4bc6..f9e38f2f926a 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -910,8 +910,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		return -ENODEV;
 	}
 
-	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
-				   to_pci_host_bridge(vmd->bus->bridge));
+	/* Don't copy _OSC control flags in VM, it disables features.*/
+	if (!offset[0] || !offset[1])
+		vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
+					 to_pci_host_bridge(vmd->bus->bridge));
 
 	vmd_attach_resources(vmd);
 	if (vmd->irq_domain)
-- 
2.43.0

