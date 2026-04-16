Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D331BD9C9;
	Thu, 16 Apr 2026 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776319476; cv=none; b=o549Dff91UdP/wlLpjxPbh/Abn/geS5hUXzqtDWUV+d+e2BDBmCLvdvpabphG6zA8sWMITFvRM/LlV7CWDM5Gj0Sblw37Zp9HKwgz87TPpAdgxdPRBQ3JKjQX3bVwpn0xSlPa+8CF1ugNAjA+ZgNct4gCI226QDgmAWUaI4b7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776319476; c=relaxed/simple;
	bh=yFapuNipVikkE2B6owuuk3dLGajTUEesaj3UiOKWjf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+cTTXp+85zu++YtFGTQq4CoSCU1l8ppp0WbRk2d0FaI3WUXgMGrx0gYAUu9Om1kVUJR6DuezKdbbyocvm+2Hl6wAp5SMjIJO+gCcEM1h2smWDnn+6VeMsCYKPuHf4lYZAeVOPScyQ6fbZqOWCPHzJ0vn11ENNRRNHu/to3slsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ReHTs9dS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ReHTs9dS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776319473; x=1807855473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yFapuNipVikkE2B6owuuk3dLGajTUEesaj3UiOKWjf8=;
  b=ReHTs9dSrKRk0oLAMpd9O9Dfi9S3gLHC79ZP70XhB33C/pXabyIxam3h
   iFEcvQwV4Ixz4KlM8/0jSQHE0+wWdGPiUUx+iEM5UKFKxbBGJu3QDrDgP
   QopPGYoiCpM6/IJtiwbe+2VpGQIQBQdKPHgQZnmyxc9ChxvgAmPMWJHku
   FoUcnTIjnUgvYyN3udd4fxXY9WtGDgworrZLfrL+STtc090UGf1Lr3PgK
   gmJj9cyGbhze518687WWWKk2KJjF1KAcgdFTV8K/ueeKeNV7Sgig57a0w
   Wodn+ChtIG9lQJQOxuQhsuGdkuCKWYunqFySf4fNTQ5i3grBDH6IxRiHB
   w==;
X-CSE-ConnectionGUID: REaZzMu5TFqCFP2fghQz4A==
X-CSE-MsgGUID: 2MTpWcY1RiKKuVHfhnBS+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="99958245"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="99958245"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 23:04:32 -0700
X-CSE-ConnectionGUID: 1R076qMiQ7a5aQer4qBSpA==
X-CSE-MsgGUID: UWfQmIhRQFCkp/jTk43U2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="268621981"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by orviesa001.jf.intel.com with ESMTP; 15 Apr 2026 23:04:31 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Fix build error when CONFIG_ACPI is disabled
Date: Thu, 16 Apr 2026 11:33:51 +0530
Message-ID: <20260416060352.1392139-1-chandrashekar.devegowda@intel.com>
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
like ppc64le that lack ACPI support.

Guard btintel_pcie_acpi_reset_method() with IS_ENABLED(CONFIG_ACPI)
and provide a stub returning -ENODEV when ACPI is not enabled.

Fixes: 912a499a7955 ("Bluetooth: btintel_pcie: Support Product level reset")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 076beb45c410..4d136ff342b8 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2280,6 +2280,7 @@ static void btintel_pcie_inc_recovery_count(struct pci_dev *pdev,
 static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data);
 static void btintel_pcie_reset(struct hci_dev *hdev);
 
+#if IS_ENABLED(CONFIG_ACPI)
 static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
 {
 	union acpi_object *obj, argv4;
@@ -2333,6 +2334,12 @@ static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
 	pci_dev_unlock(data->pdev);
 	return ret;
 }
+#else
+static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
+{
+	return -ENODEV;
+}
+#endif
 
 static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 {
-- 
2.43.0

