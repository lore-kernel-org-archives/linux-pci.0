Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A34D8D83;
	Mon, 11 May 2026 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533791; cv=none; b=B53+MOkmnzP5A8UTFtL13E+iZEPgpiDyQGSS5M13Cvz1rBE/NEXNpabb0rBAQUk59kL3Jf9sqZbN7J0Fa/KQ1jTYqIQ2nDrZI9NUzGTcqzT3bDYgF30m7ebnV/NLRD2uFb00mBuFxh7z+XZisHOMGzHE+hC9ymV2s3DTpNjkXkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533791; c=relaxed/simple;
	bh=7D4fT+zPuVHr8Q5e3aJoqT1YsGA8vp4dbvyoG9Ho010=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeWSwmzgGpLN4rBCxZl3lwO3r0RSrIf4aUtsuDwcbtPoa13k3LXUXJU16r+nY0chOIYvvdW5Eq3+qM/F4kF/J7VjnH5kz27NTNwr7oWiV0/JGyLO59/omBQG8rijQ5xDeWZidKb/uksTiiB5yn9Aj5sJUGbpIj8+c2+yBtL4Fww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0WIbHX6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0WIbHX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778533789; x=1810069789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7D4fT+zPuVHr8Q5e3aJoqT1YsGA8vp4dbvyoG9Ho010=;
  b=S0WIbHX679c7u8bx16Ow9EFpghEO+EZuLmcUQl0hdGxLoZ3MnHkCZH4J
   qHQWs3Ep1G9NCXZOGoCMh3jgxNPIvjNFfhOLq4wK/Wl33NjL+6GSINESk
   v+NNa1/X4NeLXw3ObLt6J4lTOZ7f/w5kzLqTBnbKUx4zJ16872LnMxnbi
   +SGf8cIds3bLk+WH6cvpL6OgTJQg0vJ3TgMASC9WFYpspNLd0Dggs6G0C
   4IRfcfSTeOlpMWzCN4AzBPhebQlAIynFTVVjCTmIGvGj9MLxawIpaX0bi
   gLUklEP7EbNmRbb32cBNCivNTbhPXab/jMnOUpNLDrIgpzeZDMKFi2Afc
   Q==;
X-CSE-ConnectionGUID: /wDAKkzJRQm2waxvoqkXZg==
X-CSE-MsgGUID: xCY47SMqRCmrGufkqJIqsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90534540"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="90534540"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 14:09:49 -0700
X-CSE-ConnectionGUID: 8av0VsPhTCqXhjSJqqzqEA==
X-CSE-MsgGUID: nZIVucqnQWCGTAFbfjo3Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="241559254"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.220.210])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 14:09:48 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "David E . Box" <david.e.box@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [RFC PATCH v2 3/4] pcie/aspm: Enable all hardware power-saving states by default
Date: Mon, 11 May 2026 16:09:33 -0500
Message-ID: <20260511210936.562622-4-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511210936.562622-1-thomas.falcon@intel.com>
References: <20260511210936.562622-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For systems with a BIOS release date starting in 2025, default
ASPM policy to powersupersave if supported in the ACPI FADT.
Provide a flag, aspm_user_policy, tracking whether a user has
requested a specific power state to give those precedence.
Do not enable all states if user has chosen a specific policy
or disabled ASPM using the pcie_aspm module parameter.

Suggested-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
v2: -- Removed extra whitespace
    -- Fixed unbalanced brackets
    -- Replaced second dmi_bios_year_check() with pcie_aspm_legacy_config_check()
---
 drivers/pci/pci-acpi.c  |  3 +++
 drivers/pci/pcie/aspm.c | 16 ++++++++++++++++
 include/linux/pci.h     |  1 +
 3 files changed, 20 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 4d0f2cb6c695..c73a6b06fc43 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1523,6 +1523,9 @@ static int __init acpi_pci_init(void)
 	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
 		pr_info("ACPI FADT declares the system doesn't support PCIe ASPM, so disable it\n");
 		pcie_no_aspm();
+	} else {
+		/* If ASPM is supported, configure the default policy here. */
+		pcie_aspm_policy_config_init();
 	}
 
 	if (acpi_pci_disabled)
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index e93b72494534..063ebe81a9cd 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -267,6 +267,8 @@ static int aspm_policy = POLICY_POWER_SUPERSAVE;
 #else
 static int aspm_policy;
 #endif
+static int aspm_default_policy = POLICY_POWER_SUPERSAVE;
+static bool aspm_user_policy;
 
 static const char *policy_str[] = {
 	[POLICY_DEFAULT] = "default",
@@ -1609,6 +1611,7 @@ static int pcie_aspm_set_policy(const char *val,
 	down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	aspm_policy = i;
+	aspm_user_policy = true;
 	list_for_each_entry(link, &link_list, sibling) {
 		pcie_config_aspm_link(link, policy_to_aspm_state(link));
 		pcie_set_clkpm(link, policy_to_clkpm_state(link));
@@ -1810,6 +1813,19 @@ static int __init pcie_aspm_disable(char *str)
 
 __setup("pcie_aspm=", pcie_aspm_disable);
 
+void __init pcie_aspm_policy_config_init(void)
+{
+	/*
+	 * Set ASPM policy here, enabling all power-saving states
+	 * unless ASPM has been disabled or the user has already
+	 * requested a policy or the systems BIOS release date
+	 * is before the year 2025. Otherwise use BIOS defaults.
+	 */
+	if (!aspm_disabled && !aspm_user_policy &&
+	    !pcie_aspm_legacy_config_check())
+		aspm_policy = aspm_default_policy;
+}
+
 void pcie_no_aspm(void)
 {
 	/*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..36fa5579709c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1915,6 +1915,7 @@ int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
 int pci_enable_link_state(struct pci_dev *pdev, int state);
 int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
+void pcie_aspm_policy_config_init(void);
 bool pcie_aspm_support_enabled(void);
 bool pcie_aspm_enabled(struct pci_dev *pdev);
 #else
-- 
2.43.0

