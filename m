Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520371;
	b=fx2RDaK4jfGmLvaVicb18/cJ5s67eH8ffB7jyYGE4UxxzX+lGB8L8sxmZx9+EeBAhTbF
	 LRy6kXc5dOFU7hgMRux+spg17KflltPO9+33eBRTjAy7mrhmr40LxL9iTALYjFJjfLIjT
	 4dehoGKYzZplD0WkROfzzxIr1AsK9LlxFf9h5PX+C5Z6C7rx7aAclN8/331UkaUy5HepZ
	 v+fOBNfHW+ZGXRS82TxbzhaMDIkTwdTnaFzvqq05I5uyxXbqtrXwkqR5BbOdYDJ9owI6X
	 E6vQSD47AyvYaFG4zgmOtu1RwO7TNTHwdoGZRznMm7qKx5tAtKosU+k/IOGavWuITmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520371;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Dg5gFyHUrVL2oc3jKDY+FlV+GkPO1tLUcMTXMAHc7i0=;
	b=PpdwvYQxbtZPVcQiYfrAu29vw46ME9Py+AIgXgu/ITG4zuiZ9nILPgw7ntJb4t31IUJG
	 W6T607QS1V/gRzxoe3yFPx56kuXHy0qBTOgNO7MnngzmzL/fo7JkYVE8l1Z1CFnHjRZWb
	 8Iyg8XWSlKBw3KZapWzrbLjGAG4R44gnNJoFBZNLXR1qpdV0V8tE078iCGfAErPI0JxrB
	 nGrPvbD+eLtiRv35FVoWqdWM5XJ9M3PDpiT95fIIK0BT75KbCAot2QP/qXL4Ee06pW3Me
	 Yu9oyfDJX30F7hAVKFcuZLrUeZ+YQhFn5xPWKR28JKlDRqiW+WWimZxxHAuST2Zjl9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fAj0lH2s;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA9F60A2615;
	Tue, 20 Oct 2026 18:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBA9F60A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fAj0lH2s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792520371; x=1824056371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cVq0ut23LFrzXs7D1+Kz/argD7JmUvDKAsHxmIXO5LI=;
  b=fAj0lH2saUnJ1iZz0pY0rnOK8MizaxqGfdMH4N7P84FLjmRsER/6penP
   s2jpIIfnMZsHdW0IgG5aYkdPS74480BNZX8HEItcjzgIb7rTK9CKXdU/o
   K2EyhplrMA6reoiKDp7w2r1W5Y5wj5p6M52Qu8egQTsswobTRwEdENqgs
   5TjPPBDkXkNBjfVeujQh+sZIgNsxg751uOVNFjsldaZ+XVAQJW5d2yN51
   hm9Dw3Mtc53leQrRxW6vxxuSJKqHMGQFFuUQ3xPOxaBVbhECokoPh/q19
   /PtBo/B2PTJFFXRGa4nHzb6vK7/6Yh8Dg600Z8m3cCt+7gHQR2pfnIJZ5
   Q==;
X-CSE-ConnectionGUID: ZZznga6pSuiUFCA8TVDMJg==
X-CSE-MsgGUID: M1JpnxCYTcCduDHn/rkstA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1119675"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1119675"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:19:30 -0700
X-CSE-ConnectionGUID: wJEwSuXmQmiu1QqQGiQT2g==
X-CSE-MsgGUID: AZ+hEs4UR5ORD4/+Tiw6kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3283606"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:19:29 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] PCI/EDR: Remove CONFIG_PCIE_EDR
Date: Tue, 20 Oct 2026 11:19:20 -0700
Message-ID: <20261020181924.3003553-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
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
index 104ff2b91f1f..71adc0e94bca 100644
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

