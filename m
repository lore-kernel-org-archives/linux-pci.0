Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0962F3E5EDB;
	Wed,  7 Oct 2026 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791392330; cv=none; b=FN+2yd2rMxHnauFq/OERU0s82c2qZLp1P9zEbFZU42yAXG+tPgyMJhWj+GMyyaeIiVmAJ/DZAj3Ya8TQ3VdQmKX5soaGdTEvighqNECoRXKdtpNcV0SS3NeGGnzey8S5TI4QteaNkr6NBogZ6PPindKpnCJSshf9q/W1T05jQVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791392330; c=relaxed/simple;
	bh=LXj48tPcJM1i99kjG1AbXXh92VCh2wY/HQfGrFbZiyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1zs7x6pBoKNAiYd1W9vwmXXHMHXoyp6Nxk3xXd6KVDG3AA3utZhDIF0zL4C7FJlJ+aoOjURNmZfJrl5GTCVXwueoiN7DYF7H0KFdHZxCIPyv9TwH/IhelpqeSolVSyElxmdx0QvuhbCVGklzqcihfwWSzUQ6tZGIk+jnXnm6JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0NtgML/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0NtgML/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791392328; x=1822928328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LXj48tPcJM1i99kjG1AbXXh92VCh2wY/HQfGrFbZiyc=;
  b=c0NtgML/kHYCGwPG1geo8sC7kyOrNdJ9BnN57hCAcs9e9SI1PFcrl+80
   C8FiDehEtBIkj1rfuUqihdEFrKiMWMOJdWROP0IFdUr27NjJ4G9z2Oeiq
   VmRSrNp9klcOUvWlHNU9w358KMQW9Gb1ZoT6cIWbtkwn6opC7Ua/o3OZz
   z73guUwpmOwadSqQKlE8zX8qwzBPphYKigUOJEO1HIetruBSAlRy9Iy5Q
   Uw7Fo8Ke/y64BOxPMpLToUAqfblrG/QBpsUx9gsDKNSm16gvVRuTlVZ2C
   ylJnTzTcw8m8H/tvi3OTseDWFe8tvKH7N8Qr0wWBUDtfuoAvjR+uE6kcb
   w==;
X-CSE-ConnectionGUID: SSqDTC5VSremMuIZQqbE0Q==
X-CSE-MsgGUID: dxK/ABRuQY6a3DcI6i+e6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="263213"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="263213"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 09:58:47 -0700
X-CSE-ConnectionGUID: bnXnWEp3SlG9wOFiQfiRNQ==
X-CSE-MsgGUID: +q8U9VafTcusBhy0zM6gCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="306958465"
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
Subject: [PATCH 1/4] PCI/EDR: Remove CONFIG_PCIE_EDR
Date: Wed,  7 Oct 2026 09:58:37 -0700
Message-ID: <20261007165840.1604136-2-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Error Disconnect Recover (EDR) is the ACPI half of the hybrid DPC model,
where firmware owns DPC and notifies the OS of containment events.

CONFIG_PCIE_EDR made EDR optional on top of CONFIG_PCIE_DPC.  This adds
another knob to the decision to request DPC control in _OSC.  The OS
requests DPC control only if it also supports EDR, so with
CONFIG_PCIE_EDR=n it never requests DPC control.  There is little reason
to build DPC without EDR on ACPI systems.

Remove the option and build edr.c whenever CONFIG_PCIE_DPC and
CONFIG_ACPI are both enabled.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/pci_root.c   | 6 +++---
 drivers/pci/pcie/Kconfig  | 9 ---------
 drivers/pci/pcie/Makefile | 5 ++++-
 drivers/pci/pcie/dpc.c    | 5 +++--
 include/linux/pci-acpi.h  | 4 ++--
 5 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index a1a9c06012f8..b0e0b33e3254 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -438,7 +438,7 @@ static u32 calculate_support(void)
 		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
 	if (pci_msi_enabled())
 		support |= OSC_PCI_MSI_SUPPORT;
-	if (IS_ENABLED(CONFIG_PCIE_EDR))
+	if (IS_ENABLED(CONFIG_PCIE_DPC))
 		support |= OSC_PCI_EDR_SUPPORT;
 
 	return support;
@@ -515,9 +515,9 @@ static u32 calculate_control(void)
 	 * Per the Downstream Port Containment Related Enhancements ECN to
 	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
 	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
-	 * and EDR.
+	 * and EDR.  EDR is always built with DPC on ACPI systems.
 	 */
-	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
+	if (IS_ENABLED(CONFIG_PCIE_DPC))
 		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
 
 	return control;
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 207c2deae35f..de4ea33b4524 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -137,12 +137,3 @@ config PCIE_PTM
 	  This is only useful if you have devices that support PTM, but it
 	  is safe to enable even if you don't.
 
-config PCIE_EDR
-	bool "PCI Express Error Disconnect Recover support"
-	depends on PCIE_DPC && ACPI
-	help
-	  This option adds Error Disconnect Recover support as specified
-	  in the Downstream Port Containment Related Enhancements ECN to
-	  the PCI Firmware Specification r3.2.  Enable this if you want to
-	  support hybrid DPC model which uses both firmware and OS to
-	  implement DPC.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index b0b43a18c304..46b24311f659 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -13,4 +13,7 @@ obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
-obj-$(CONFIG_PCIE_EDR)		+= edr.o
+
+ifdef CONFIG_ACPI
+obj-$(CONFIG_PCIE_DPC)		+= edr.o
+endif
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index fdea3db61a4a..b4fb45ca559d 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -109,10 +109,11 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
 
 	/*
 	 * Synchronization between hotplug and DPC is not supported
-	 * if DPC is owned by firmware and EDR is not enabled.
+	 * if DPC is owned by firmware and there is no EDR, i.e., on
+	 * non-ACPI systems.
 	 */
 	host = pci_find_host_bridge(pdev->bus);
-	if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
+	if (!host->native_dpc && !IS_ENABLED(CONFIG_ACPI))
 		return false;
 
 	/*
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index c0c54baadf04..9715351c0d51 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -123,13 +123,13 @@ extern const guid_t pci_acpi_dsm_guid;
 #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
 #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
 
-#ifdef CONFIG_PCIE_EDR
+#ifdef CONFIG_PCIE_DPC
 void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
 void pci_acpi_remove_edr_notifier(struct pci_dev *pdev);
 #else
 static inline void pci_acpi_add_edr_notifier(struct pci_dev *pdev) { }
 static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
-#endif /* CONFIG_PCIE_EDR */
+#endif /* CONFIG_PCIE_DPC */
 
 int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
 void pci_acpi_clear_companion_lookup_hook(void);
-- 
2.43.0

