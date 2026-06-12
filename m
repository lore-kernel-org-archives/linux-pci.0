Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8535BDCE;
	Fri, 12 Jun 2026 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227772; cv=none; b=RobBkNHF6QCQ7SS0YeKpgvSxbUth//MhHRF8ybuFTdrHvA7ouPR8R+RGmVc8lt+Ch/AzKr9ZSsMe+RgkwYOcJZguV742Tt3oYlz+VjU6jAA67Q26XIbqbXMhIlS8TfIxY8Y1Yq2jdwR55mGw71a/eVtop+Y6poOKKMcBirvWrFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227772; c=relaxed/simple;
	bh=k2X1fVVJ3tZ6G9pe5pZaGVzoEQH61OPQtKYFk2HUFtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVQr0GXsVZMedW1jLIxfmCkLfN3V3/sfF5qqlYdfSi/VeOKIBy6pTzpJDOU6TFfFUyrcXmwrD4c3+TVJb8IfjyluBga5owekrCI5Zheaizdb4q0wOPU4xfKK3C0BjyXCG2Nrz2Qt47z9H50Hl8h5N91nCkzLWGG34Rs8LD/NxlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TM2hijsb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TM2hijsb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781227771; x=1812763771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k2X1fVVJ3tZ6G9pe5pZaGVzoEQH61OPQtKYFk2HUFtM=;
  b=TM2hijsb6ve0j8jZ4eGbIvkVR5f7JAbVyliur74zomObfA7GK9kw61J9
   Qw4vhuNXKRUe1vlI7zML9UZgE2A5rjLBv5MrS6h7ouD2BSPQ7OQTrQVys
   jByf3CRScllZv7Zm3+9xjyt0tdBEIJ158iOIS7SXcYccnwmm+l4+KVJo/
   1+oO2CrMRiBJmcvJ4iGJsPHipA9WbDXhQ6gF92gSMK07CLnb6H/hTiro1
   lo6/Y7NjjnaFiECVRBtrMHqQQj7rkLjmig18K6QVmWUnsPgF+W7pOKSqB
   G/fmtKrCFhmw5dhI0sM64G0hJCABl5Mp18vq4dbX5xtqHweygJHT7W3fm
   g==;
X-CSE-ConnectionGUID: b98B3lvkT5mo//r8kuTCFA==
X-CSE-MsgGUID: MrWd5psJRLiUxJd35GEXmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93165725"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="93165725"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:29:31 -0700
X-CSE-ConnectionGUID: leUeh1ekR1m6EdY0P5yoaw==
X-CSE-MsgGUID: VK4s5UIVTOSydDPf4iEB3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="251767131"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa005.fm.intel.com with ESMTP; 11 Jun 2026 18:29:29 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v1 2/2] Bluetooth: btintel_pcie: Fix TOCTOU race in reset path
Date: Fri, 12 Jun 2026 06:58:30 +0530
Message-ID: <20260612012832.2395034-2-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
References: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
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

