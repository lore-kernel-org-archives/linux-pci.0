Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51047402BAC;
	Wed, 29 Apr 2026 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486026; cv=none; b=UOgDHpA61BaYzbRvzCzuljToPx+y67IQnB6/8cxrOjcbAHNCLr4MXl8lD73nL2M9oVgNy4DgJbbVofBT4Jk+tn0WpSkMBx4w1XI/fu4aO+GOPPbgPi0+gdFSiBWV8yCzzdtCzz3XH2PSs+/bVXM+4CYLMhV4yvfPVMHc+eNGMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486026; c=relaxed/simple;
	bh=I7KLo2BSP/NmxfPhvBY24w3mWqQHMkCVhmxUuigSc34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDkWv77cEmH8/1f8MOlWEbh5WJOwZmQanQbHRyR6XLO6/XZ2Y3n/9Zf/KgOezm1NGCMrLGSqmt21eJCFHCbOVS7wtBEMUzKUolK6ZbWedVMqtOCOwJvA2k4feNMaiVbxO9PuRLEVkLopp4R8BE058uAAHwnDzMS/fFP4aNFdk9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxAfiXc2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxAfiXc2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777486024; x=1809022024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I7KLo2BSP/NmxfPhvBY24w3mWqQHMkCVhmxUuigSc34=;
  b=RxAfiXc252OLzkihqnB16CvAfGV8WBYEEtgYjwgeHHg9kzdne+AsP6Ur
   T6GhR9FcrpN2za/bWoan2Gpncc8/Tc+MSLndm2fk7x9phcAsU3s5PF36j
   zBlPZFl3nlLxwxRfGTb2BSO9su6JN0EQuIrBqxji/rO27QyRDrNDjwdCY
   t3t1CP1oRtPssAftoxlTVMAEphQu0aM8R5nZkeb3TMZs8sAJzIBOmCMdd
   xrQDPfwRJj3mThBDoTDbudj7N2CO5B55N+BDDBuVMftwLp6m1L9kowqCI
   lqHO+ZUtvswbtTs/EQl56IV8V1MGt+4O/N01UQF4Ksfg+ZlkmZhDT3O95
   Q==;
X-CSE-ConnectionGUID: FFJ2sVoZRFqCfE4ByOWCZQ==
X-CSE-MsgGUID: O1wDWRM0S36dqo3LedTH1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78532284"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78532284"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:06:56 -0700
X-CSE-ConnectionGUID: BTx9jMfHRpe7XRmhbK+aXA==
X-CSE-MsgGUID: HmB0qf4xQmCz2anyQdoshA==
X-ExtLoop1: 1
Received: from iherna2-mobl4.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.221.251])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:06:55 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: "David E . Box" <david.e.box@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [RFC PATCH 3/4] pcie/aspm: Enable all hardware power-saving states by default
Date: Wed, 29 Apr 2026 13:06:45 -0500
Message-ID: <20260429180647.197072-4-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429180647.197072-1-thomas.falcon@intel.com>
References: <20260429180647.197072-1-thomas.falcon@intel.com>
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
 drivers/pci/pci-acpi.c  |  4 +++-
 drivers/pci/pcie/aspm.c | 17 +++++++++++++++++
 include/linux/pci.h     |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 4d0f2cb6c695..d849bc6d0c0c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1523,7 +1523,9 @@ static int __init acpi_pci_init(void)
 	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
 		pr_info("ACPI FADT declares the system doesn't support PCIe ASPM, so disable it\n");
 		pcie_no_aspm();
-	}
+	} else
+		/* If ASPM is supported, configure the default policy here. */
+		pcie_aspm_policy_config_init();
 
 	if (acpi_pci_disabled)
 		return 0;
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 84d49aa8a5ba..1c81e2f2e589 100644
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
@@ -1810,6 +1813,20 @@ static int __init pcie_aspm_disable(char *str)
 
 __setup("pcie_aspm=", pcie_aspm_disable);
 
+
+
+void __init pcie_aspm_policy_config_init(void)
+{
+	/*
+	 * Set ASPM policy here, enabling all power-saving states
+	 * unless ASPM has been disabled or the user has already
+	 * requested a policy or the systems BIOS release date
+	 * is before the year 2025. Otherwise use BIOS defaults.
+	 */
+	if (!aspm_disabled && !aspm_user_policy && dmi_get_bios_year() >= 2025)
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

