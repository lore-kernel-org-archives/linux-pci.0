Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790394D09ED;
	Wed,  7 Oct 2026 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791392333; cv=none; b=gL15MJ6GumbTynlrpEek47yxUS39bGc03+6z3k+x/HLvg9AhCKr3NpF9Nax0acT1COJf9Pk8JW7XzEGbOtW2Ooem107cNm6XjvFnTt7SBB9qqQEoLzbSsNr9OL4ckqEykxbOkYUuFYsqRW7EnffAW2cniq7MtSLXa1kkirInMlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791392333; c=relaxed/simple;
	bh=Q2lJuy5EfFC52cG8aaSSjYDq9rR1GKGNdMtvGWpn8Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZfwnw46wJx508wTD8sWRK2JIfrS5LhFufKnNJgNvtOvceesCw7nJhQfm5mkk3/8yjR7YxZOb/mDvd4DDKmBIHD1lkFnlXtKs/ScBsRMI9f3MUMxKdlKBobeMJOzzmFq5K9AjNWl9AqJ7lUJxEGCR/FbiO2TriIkZJuGF2b32yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhMzW08J; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhMzW08J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791392332; x=1822928332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q2lJuy5EfFC52cG8aaSSjYDq9rR1GKGNdMtvGWpn8Go=;
  b=AhMzW08J+YOPAl59gUfXrzT6GZ4dXnM1Oh2G0uWSpWw0Jmpl6eM+G16S
   farUMbO7E5yAlFfxh2fER/2pS5lanM7E7gV7jGxq4uDyRAmX5KFYF2DxJ
   N9qZRdj54/a4MhSsnQi9fCyOPu6kwjiIR3/iwiatzXCRTdfFrzlu3f7zS
   MdYcWq7pUIRlKnMhzh3JeWF3xoMZVibdhJO52WWYTqZWdrRKn3f7TllL2
   CUhSFgsa14a6d7DNZZHL0GIiIahs7NDZEGIbL8BuHbTVStFcOLmGV2ecr
   cgdIBsvTU7V9XNex71Xui/d2TyTFxhv3MA2LyfYkkrKD6FAqX3vcPToy0
   Q==;
X-CSE-ConnectionGUID: j3migDjjQQCipT7/60z5cQ==
X-CSE-MsgGUID: Lc4wP8JzTCWl9fNI7wZHEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="263229"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="263229"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 09:58:47 -0700
X-CSE-ConnectionGUID: HZ1Ohk8WQe6n9avX5R56cA==
X-CSE-MsgGUID: KoCIwHxNREimEvMKwsGFCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="306958467"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 09:58:47 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] PCI/ACPI: Request DPC control only together with AER control
Date: Wed,  7 Oct 2026 09:58:39 -0700
Message-ID: <20261007165840.1604136-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007165840.1604136-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261007165840.1604136-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI Firmware r3.3, sec 4.5.2.4, requires the OS to request AER control
when it requests DPC control.  calculate_control() requests DPC control
whenever CONFIG_PCIE_DPC is enabled, even if it does not request AER
control, e.g., with "pci=noaer" or when MSI is disabled.

Request DPC control only if AER control is also requested.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/pci_root.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index b0e0b33e3254..5c674d5b6bb8 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -516,8 +516,12 @@ static u32 calculate_control(void)
 	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
 	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
 	 * and EDR.  EDR is always built with DPC on ACPI systems.
+	 *
+	 * PCI Firmware r3.3, sec 4.5.2.4, requires the OS to request AER
+	 * control while requesting DPC control.
 	 */
-	if (IS_ENABLED(CONFIG_PCIE_DPC))
+	if (IS_ENABLED(CONFIG_PCIE_DPC) &&
+	    (control & OSC_PCI_EXPRESS_AER_CONTROL))
 		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
 
 	return control;
-- 
2.43.0

