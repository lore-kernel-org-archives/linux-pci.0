Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC59E25B0A1;
	Thu, 18 Jun 2026 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772649; cv=none; b=M8LdRPANcC3bESJlg7Of2xGq1Ox4MNKHKYel38evii6DZnTyilD12YuSO8E21dPk03AChF1GUnC0ebSLoJnc7glY5aDm5rNZ+851umFl4s6hP7hZZ+lmgVKFonIt+39nXUsUmOrK39k8p0xABmc+/Kt77Cn1kbRWLauGBDwVyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772649; c=relaxed/simple;
	bh=UdNHVLNJhllPqDOhWnuEtKRqjFTmfTx1guRRdvrtmP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LV766Zjg4IwGNOwktfgfnpbFjW133AvTWb0BDyXAxMYtCGeLmq2C4MzxDxQ6GDMTtkil2XTDm1kV0rbTrfVyRq/E/x9GPaBP9aAlbvWLSvm9Y99qCD3jnOEFUE3aklsPIhNQ/FHUHfR+7iGbG40ku5xc6vMXawm3UMLDoUI8syg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9bYYopu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9bYYopu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781772648; x=1813308648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UdNHVLNJhllPqDOhWnuEtKRqjFTmfTx1guRRdvrtmP8=;
  b=R9bYYopuCfrrisutYT01fjQ7ZhOVtRLMaTdX/PYFVnt0Og0N7iGjaBgv
   lQVGwpU7EQXENpWd233Hm4JdtlhKnz8Ofz8SfGhoScA0j9pvBGpb1h58p
   lIFeJebqSuX+iP4sWUkAk7N8AwIankvIlErfZSi+QuWMHn9J12q3uj1dx
   Udbr1sPdaM7l9Opz19IVQC/N80qy9u+qbnpeOl9fKmaUTgtUL4MptRzUN
   OCP75afWPcSPJHOvNW7MlZ5H7JayI78IJpSvBknHhGfkFXQxjIFZehtoX
   6vjjKe4uk2NejTMAAj68kEAMPaSKzHzFg6yUNwNMP4Bade/SxP8NOqjI8
   Q==;
X-CSE-ConnectionGUID: NW//jDTPRSec7BTdSspJ7w==
X-CSE-MsgGUID: YfDyRyasQy+NEu4mbXGSJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="93974390"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="93974390"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:50:48 -0700
X-CSE-ConnectionGUID: Lkkzqsf/T2qztE+O8NBMxg==
X-CSE-MsgGUID: WkkiWFUtTmirzfmj7IvobA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="278491185"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by orviesa002.jf.intel.com with ESMTP; 18 Jun 2026 01:50:45 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v2 2/2] Bluetooth: btintel_pcie: Fix TOCTOU race in reset path
Date: Thu, 18 Jun 2026 14:20:16 +0530
Message-ID: <20260618085016.9173-2-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618085016.9173-1-chandrashekar.devegowda@intel.com>
References: <20260618085016.9173-1-chandrashekar.devegowda@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS) check
before the SETUP_DONE check to fix a Time-Of-Check to Time-Of-Use
race. Previously, multiple callers could pass the SETUP_DONE check
concurrently and then race on the RECOVERY_IN_PROGRESS flag,
potentially scheduling conflicting removal work.

By reordering the existing atomic guard to execute first, concurrent
reset requests are atomically rejected before any state is inspected.
The RECOVERY_IN_PROGRESS flag is cleared on the early-exit path
(setup not done) to allow future reset attempts.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
v2:
  - No changes
v1:
  - Initial version
---
 drivers/bluetooth/btintel_pcie.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index d3a03cf96421..f4f400421833 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2686,11 +2686,15 @@ static void btintel_pcie_reset(struct hci_dev *hdev, u8 reset_type)
 
 	data = hci_get_drvdata(hdev);
 
-	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags))
+	if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags)) {
+		bt_dev_warn(hdev, "Reset rejected: recovery already in progress");
 		return;
+	}
 
-	if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags))
+	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags)) {
+		clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);
 		return;
+	}
 
 	data->reset_type = (reset_type == 1) ?
 			    BTINTEL_PCIE_IOSF_PRR_PLDR : BTINTEL_PCIE_IOSF_PRR_FLR;
-- 
2.43.0

