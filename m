Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF002E2DDD;
	Thu, 16 Apr 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353765; cv=none; b=egl7L6tdEFH6D4sCqF98yJCye/mJnP8fCqVNNoBwPynvmDtmdmcqpddlwx8whFwNEvfWcAWCZqmj0IUqhkbuar9htfUyBSzp2EhnmEPHSXAPodwC/45/ayHSv1lhlbw7FML5CTTUj2IS5+6hy6DFW2PJZ0NbZSaFGPE64cWAa+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353765; c=relaxed/simple;
	bh=b5J/XNpLxlUh/lvWwGpUhJktPbhokRVEjpHgais1vZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3e9c1J7LB00YGGS1/IeOL6MwmvKV0bqR5glultUJ7d3Xpa719xJ0G9wh2nQhFukGACi2Rtbg6Gt/5TX9Yms9Q3ac6YHuYMdo18uLhPYoIJI9WG7Hgxee25ZCTfQUUPQn9FqvcSI9HSdThjlnwcRFWgsyM6AinbJmJUCSfW+3oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+Q/7e2s; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+Q/7e2s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776353765; x=1807889765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b5J/XNpLxlUh/lvWwGpUhJktPbhokRVEjpHgais1vZw=;
  b=H+Q/7e2sGMDxquxNq1jwjGusn532AXAiukPp8ulz0P+a14ovUtm1jSRE
   9G9EBiTJn6sPUrJWqZXmo5SnubT7+PN0Z13tFqgE+zGjgHvqAbIokIR3K
   LTQhi9r9+Ao8C3zN1ImKtYDF/By4hX++H8gRgI+YIeDq8cTUjqQRyCLlw
   Y6W8nUq40OTJqAirQdTUcwzv8zDO8nv0tEHE0V70O8rA+VmTWyP4DbPYP
   GNPeKPW/tm34QhOlEwl84X9zHbaDorskqPahQu71bGe+hN5AedSWDM3PF
   sJHZu3MQNU3JqNRvRsOAuD7L0u2TEJmYteheDZ9Ec1KrVpnX0qWrOTPWa
   A==;
X-CSE-ConnectionGUID: iT2mneZuT5eixUhvjGNhNQ==
X-CSE-MsgGUID: 7DibotmiTTW6PO75vKjllw==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77056428"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77056428"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 08:36:04 -0700
X-CSE-ConnectionGUID: QAhyX3eGSTGP38wrX73gRA==
X-CSE-MsgGUID: Eg9BzuShROWOPSKSeRvdnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="231006022"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by orviesa007.jf.intel.com with ESMTP; 16 Apr 2026 08:36:02 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Fix build error when CONFIG_ACPI is disabled
Date: Thu, 16 Apr 2026 21:05:23 +0530
Message-ID: <20260416153524.1405955-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btintel_pcie_acpi_reset_method() uses ACPI APIs such as
acpi_evaluate_object() and acpi_has_method() which are not available
when CONFIG_ACPI is disabled, causing build errors on architectures
that lack ACPI support.

Guard btintel_pcie_acpi_reset_method() and btintel_pcie_perform_pldr()
with IS_ENABLED(CONFIG_ACPI). Since PLDR relies entirely on ACPI reset
methods, skip the entire PLDR flow when ACPI is not enabled instead of
unnecessarily unbinding and reprobing WiFi with no actual reset.

Fixes: 912a499a7955 ("Bluetooth: btintel_pcie: Support Product level reset")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
v1 -> v2:
  - Guard btintel_pcie_perform_pldr() along with
    btintel_pcie_acpi_reset_method() under IS_ENABLED(CONFIG_ACPI)
    instead of providing a separate stub for the ACPI method, since
    PLDR is meaningless without ACPI support (Paul).
  - Tested with CONFIG_ACPI=y, CONFIG_ACPI disabled, and 0day CI
    alpha config.

 drivers/bluetooth/btintel_pcie.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 076beb45c410..07223965388a 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2280,6 +2280,7 @@ static void btintel_pcie_inc_recovery_count(struct pci_dev *pdev,
 static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data);
 static void btintel_pcie_reset(struct hci_dev *hdev);
 
+#if IS_ENABLED(CONFIG_ACPI)
 static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
 {
 	union acpi_object *obj, argv4;
@@ -2389,6 +2390,12 @@ static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 			BT_ERR("BT reprobe failed for BDF:%s", pci_name(pdev));
 	}
 }
+#else
+static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
+{
+	bt_dev_warn(data->hdev, "PLDR not supported, ACPI is disabled");
+}
+#endif
 
 static void btintel_pcie_reset_work(struct work_struct *wk)
 {
-- 
2.43.0

