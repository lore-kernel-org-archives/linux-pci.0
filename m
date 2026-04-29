Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7671941B36A;
	Wed, 29 Apr 2026 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486027; cv=none; b=SznxlTywf/6R/FU5qXtoJ+m9mUJEkfTs9r3Y29FrZqa+h+DQuNb9Hdxs9huBbFSfKhAL3YR3QzLK/7Ft+kG0FXHDbqTIJ2dZfmm31emPB43HDDwat+AK73UZsegD3K0LrVsu/pdgFr68pXweoWAg2bOahwZPgV4xXQHXmAlgeYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486027; c=relaxed/simple;
	bh=8uRRJsQyi1OO48XlDkSkvbTHBNR4NC4KE68xK6PgRao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqEVdqUrK0h7Qu7r3bGO88uNHAMgn5JeUbAe0N3RWyH4HFXiLub9lVmgUAzCOKKwXu5WdE/WN8fX/sH6k06yj5DXJrc94I7alFRqXCT4mz/gvakDqOI1n/2fhoFabEXambJXKMdfGmCiGdNJLzadMAIRfgxdgowoBmFI378FOi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AYRLeY3w; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYRLeY3w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777486025; x=1809022025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8uRRJsQyi1OO48XlDkSkvbTHBNR4NC4KE68xK6PgRao=;
  b=AYRLeY3whfx7R55LuOnLjHfXoct5iRHjTY0VX1QFsuZBdp5L67Ux5jJ0
   1ufxnaYqrQ1BXqXrjMR2E7loRIfQ4g+8pbAuwZckpDFufTBcI+QF8t1G1
   v+MXuqrkyl248KL9/F9wmvhOv2ejxAM1ORpM0kxocfa7vet6SGwA+8e+K
   5G37M+4EwSmLcsCFq/Yu/NP+eMXiSnX+s6O2t2rHlsvPlQtUgiejlBeGh
   MZfv0FCetzaRpb6LfzfL5kWl4esHGQakffLk2A0gEEl2EPkPPcr88AZr2
   MKLYYepYC7j3uoynkpvL3DB7A6kxtG6/H5g7BDmyMoJ1A3hNO3F4OG3ZM
   A==;
X-CSE-ConnectionGUID: VpHu2iC6S/6IbQObwOkcCQ==
X-CSE-MsgGUID: GSvkjBIrSt6EwaWGlfG+6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78532289"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78532289"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:06:57 -0700
X-CSE-ConnectionGUID: p1i6a/13QHCI0NYooubA0g==
X-CSE-MsgGUID: SjOFropJT16lb8FhHn2hzg==
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
Subject: [RFC PATCH 4/4] pcie/aspm: Remove CONFIG_PCIEASPM_* policy definitions
Date: Wed, 29 Apr 2026 13:06:46 -0500
Message-ID: <20260429180647.197072-5-thomas.falcon@intel.com>
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

ASPM policy now defaults to POLICY_POWER_SUPERSAVE for new systems
and POLICY_DEFAULT for others while allowing the user to change
policy using the existing pcie_aspm module parameter. Safely remove
CONFIG_PCIEASPM_* policy settings.

Suggested-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 Documentation/arch/x86/amd-debugging.rst |  5 ++--
 arch/mips/configs/bmips_stb_defconfig    |  1 -
 arch/mips/configs/loongson2k_defconfig   |  1 -
 drivers/pci/pcie/Kconfig                 | 33 ------------------------
 drivers/pci/pcie/aspm.c                  |  8 ------
 5 files changed, 2 insertions(+), 46 deletions(-)

diff --git a/Documentation/arch/x86/amd-debugging.rst b/Documentation/arch/x86/amd-debugging.rst
index d92bf59d62c7..3f346a46357a 100644
--- a/Documentation/arch/x86/amd-debugging.rst
+++ b/Documentation/arch/x86/amd-debugging.rst
@@ -260,9 +260,8 @@ of the devices.
 ASPM
 ----
 For the best runtime power consumption, ASPM should be programmed as intended
-by the BIOS from the hardware vendor.  To accomplish this the Linux kernel
-should be compiled with ``CONFIG_PCIEASPM_DEFAULT`` set to ``y`` and the
-sysfs file ``/sys/module/pcie_aspm/parameters/policy`` should not be modified.
+by the BIOS from the hardware vendor.  To accomplish this the sysfs file
+``/sys/module/pcie_aspm/parameters/policy`` should not be modified.
 
 Most notably, if L1.2 is not configured properly for any devices, the SoC
 will not be able to enter the deepest idle state.
diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index ecfa7f777efa..bb19073986a8 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -22,7 +22,6 @@ CONFIG_RD_XZ=y
 # CONFIG_RD_LZ4 is not set
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
-CONFIG_PCIEASPM_POWERSAVE=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCIE_BRCMSTB=y
 CONFIG_CPU_FREQ=y
diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
index ca534a6b66de..0a2c123eee69 100644
--- a/arch/mips/configs/loongson2k_defconfig
+++ b/arch/mips/configs/loongson2k_defconfig
@@ -88,7 +88,6 @@ CONFIG_RFKILL=m
 CONFIG_RFKILL_INPUT=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_HOTPLUG_PCI_PCIE=y
-CONFIG_PCIEASPM_PERFORMANCE=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 207c2deae35f..069058870506 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -81,39 +81,6 @@ config PCIEASPM
 
 	  When in doubt, say Y.
 
-choice
-	prompt "Default ASPM policy"
-	default PCIEASPM_DEFAULT
-	depends on PCIEASPM
-
-config PCIEASPM_DEFAULT
-	bool "BIOS default"
-	depends on PCIEASPM
-	help
-	  Use the BIOS defaults for PCI Express ASPM.
-
-config PCIEASPM_POWERSAVE
-	bool "Powersave"
-	depends on PCIEASPM
-	help
-	  Enable PCI Express ASPM L0s and L1 where possible, even if the
-	  BIOS did not.
-
-config PCIEASPM_POWER_SUPERSAVE
-	bool "Power Supersave"
-	depends on PCIEASPM
-	help
-	  Same as PCIEASPM_POWERSAVE, except it also enables L1 substates where
-	  possible. This would result in higher power savings while staying in L1
-	  where the components support it.
-
-config PCIEASPM_PERFORMANCE
-	bool "Performance"
-	depends on PCIEASPM
-	help
-	  Disable PCI Express ASPM L0s and L1, even if the BIOS enabled them.
-endchoice
-
 config PCIE_PME
 	def_bool y
 	depends on PCIEPORTBUS && PM
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 1c81e2f2e589..112904a75a4c 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -258,15 +258,7 @@ static LIST_HEAD(link_list);
 #define POLICY_POWERSAVE 2	/* high power saving */
 #define POLICY_POWER_SUPERSAVE 3 /* possibly even more power saving */
 
-#ifdef CONFIG_PCIEASPM_PERFORMANCE
-static int aspm_policy = POLICY_PERFORMANCE;
-#elif defined CONFIG_PCIEASPM_POWERSAVE
-static int aspm_policy = POLICY_POWERSAVE;
-#elif defined CONFIG_PCIEASPM_POWER_SUPERSAVE
-static int aspm_policy = POLICY_POWER_SUPERSAVE;
-#else
 static int aspm_policy;
-#endif
 static int aspm_default_policy = POLICY_POWER_SUPERSAVE;
 static bool aspm_user_policy;
 
-- 
2.43.0

