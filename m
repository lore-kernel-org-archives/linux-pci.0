Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E474D2EFA;
	Mon, 11 May 2026 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533793; cv=none; b=ijCn+rd/aHA8/y2C8Mwlhp45IWPMNODAXVfRppdigkWVgyISDpaFP6nb3x9gXT/A0EjQWKRsObwtRxexs0MePJvLT/hgJBnBGxhdCLFUwRQFg2ZZ4IdqprNzemO+xkc7iiPs4uN7Dy9Z3DGPk0wXiFGSUS82HaM2Q42OImZROFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533793; c=relaxed/simple;
	bh=5vlW8i9B35i+84jUFlbY9V1baOQ6A58XThDU8o5p0eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLSs7mkru7u/MmPGC8l4AiIl5eUY+FRvawgyMbG7poWSanFgGCuFv/tO/1iG6XjpG35ks0l2zAB33Jvm1/kJ4xtMqVXjRSbSBr61RHQYQLsgHqXajleXINtdBv7sOqGOkcZd/vlvXun7jb7vrepwi672OMbqmObyjyNrMonQ+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7EK513b; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7EK513b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778533790; x=1810069790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5vlW8i9B35i+84jUFlbY9V1baOQ6A58XThDU8o5p0eI=;
  b=V7EK513bIKjWksdt8bptz6W5Ehwa36pjc2sHm8UxEdpxF/m9IepEoHfb
   NDDsfGRC1n54rdgfO8HDLNdoVJFK2l0YqIDDlKL2XZ9s5agSf4pL6y5gu
   5WKE6bZxuNCxdK30oxvZvyCngIFhiK/kOVu7/mTXTMPD3JaI8+G6zgO0u
   D1Xqu4vjiQjwRM+x9k764Dv+2tDKfXH+6WSxQDCaaYJspVwbogGoH6iiq
   RzgzfYZiTwDJQFWGIN2oMbuJ6KkAR8XfpvAKg3ek8OBOtfZmBzy25mYSi
   ak59mWQsR5NsfnmaB8Cdm6p0TV/MTxhgh3loazeU3gIqLeLc5ZrUzx/iD
   A==;
X-CSE-ConnectionGUID: RD9sWk4ySfSUZy1o2W4k7Q==
X-CSE-MsgGUID: vnnK2b+UQ6qpa5CJTdQdQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90534545"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="90534545"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 14:09:50 -0700
X-CSE-ConnectionGUID: InPz/bmNT4OLd8o7kIEKJg==
X-CSE-MsgGUID: enhRJpf9R0aaa0o8Ug07ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="241559257"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.220.210])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 14:09:49 -0700
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
Subject: [RFC PATCH v2 4/4] pcie/aspm: Remove CONFIG_PCIEASPM_* policy definitions
Date: Mon, 11 May 2026 16:09:34 -0500
Message-ID: <20260511210936.562622-5-thomas.falcon@intel.com>
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
index 063ebe81a9cd..4502f56f2314 100644
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

