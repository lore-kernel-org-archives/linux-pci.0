Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDFD224D6
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782752573; cv=none; b=RsgfRTmhktAxeJtj63hHnJajoZbwCSmNYRxhX9ou3xT5r1CgiN/LFc2mhZiPGKJqiYSbLjaY6BOT0By1IeotU4jDiYb82BoiZ3FNXtw7VkBwShO5J4QEQSfssyKdQHqxgOjeEioUZTFoNQ4EgjInz/fYu0xe9UPgypNlQijNkgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782752573; c=relaxed/simple;
	bh=2J5Fqs2ahHlvFcZVaxewM+t4fw0WhPY53YtHRg77aNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gR1SaanizpU8i/atLLzk1NHWWY9hU6C/daBN5NZDN0HXVpBz2naRPHfZimMd5aQ8BkEoCeL2GGb4JgsuysAkZOPXNoBZ2odoCyJfoAJcnTCveb68lc9oTmsVr4wMBopZcKVbFI2WMk+l0lHXI3ZZZIhzZvbjw5SAeHDs0ePdDak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WeVnh9PO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WeVnh9PO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782752572; x=1814288572;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2J5Fqs2ahHlvFcZVaxewM+t4fw0WhPY53YtHRg77aNg=;
  b=WeVnh9POBt7ZfsceIUXCgqSncYkHB7drsP03pCWkSp935kMK/Jvea+kT
   ZUQ8ayICGNtvRAu1JAu18vt3O6DMQNlbK4p+GYh2n5DM2cCxAC0WB3X+r
   ghDorqWtH/GICyTlH6UMxqjVkuhiiVsn7qSRzMQrTumeA8od1FsW5d3/6
   23ZDiyXs4iqvVKV87T1nePd5hEWHXN4OEziblhpW3Prs+EqZ00FbcArlu
   scsQTvAHppjIWKu0L/L5v/xyi+YiqSjze7xgRTUy45pln2xm8b9JBQ+Pi
   dOYcuRDsPrkb7bOicTK8RkeyQk4TGsfOuMDr1l02IDlVI6QWeEDU4Z2bs
   A==;
X-CSE-ConnectionGUID: 6TUGAaRITW6OFV9rArcoIg==
X-CSE-MsgGUID: wxCkYNZZTJ+sduq81nLBKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="108999369"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="108999369"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:02:19 -0700
X-CSE-ConnectionGUID: zaGEPMctS/Km8U0ujulgLg==
X-CSE-MsgGUID: pMVC16kdQn6p97xvOQF8Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="250952477"
Received: from zp3110c002s0704.zpn.intel.com ([10.219.117.38])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:02:18 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: nirmal.patel@intel.com,
	<linux-pci@vger.kernel.org>
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	lpieralisi@kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH] PCI: vmd: Only assign _OSC features in bare metal OS.
Date: Mon, 29 Jun 2026 17:02:43 +0000
Message-ID: <20260629170243.269830-1-nirmal.patel@linux.intel.com>
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

