Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795025843;
	b=t3htkcgC+sHC6jxBsyHAhd0ybkPX7u6SCTyiGq5QsHmJErxiN9/BpcXq6fwII6WgkB3Z
	 bN7ScYp5CfCqh46vbPuh0/ZcLA1d90EyWCMiu+fCXdcf31p25sDC2a0Q/eDWZ0Szc7V17
	 bK8OHshCrq8bs29yQuWX28RgyCsnsJ8+zaXvpgYgbY91I4Mmtv/9egbK/+g0gyagkaYga
	 EpOHY2BtpM3uvqhplKaBLq8HKPZnOhow6LCyECK6hYfshdvhnAq4cq/Xm8Bv0bcvdjNyN
	 K3bLFho0ALuIAyLIuoAOivyGqYWJZUUeJ7FY/Wk4h5ELfM62wXv386+8fZ50C/UAe1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025843;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ngG38jkftsJfyMk8I3/xh7WzNpvt70r47s1WK17J9nc=;
	b=3BHSHhOv8jmGiyJoefNbvBXfFYN0RgzV6QwjloACRIi74AvOc2/oVXfIz5UzcRxPEIKQ
	 FfXFBhOq1/5sa9q8jyQm0PWmw8BzjBP1uzLuTTnZin/xP5OefUsaunOwltQJKlLTmLZS8
	 oM9edLIHpFSsoy6iSi/RllgkTNyjEReHhOZJIxhx8I6jd1IIlpe7q/baDWrr6J5XfwpSM
	 BysFJxAr3ae9ew5EjME6+xxae7QfKclLBMoWBmYOr7T/1flZjFmwwvmaHuSnIHgvGuoPo
	 ptxlsWv/gKzE6pK1SCtoJFrNDX+5/7JOmpBCOUPxkYVLn+vzR3vet6pgVBWvOQJcEuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W5CyToh7;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C75D60A2600;
	Wed, 18 Nov 2026 18:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C75D60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W5CyToh7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795025843; x=1826561843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dph6fob5dCknQ0JUlC9TiW2dOS3Wc6wVs7UBEIxddXs=;
  b=W5CyToh7RtTZecB3uQebcdKYcy00AhV+MUEZgosDe+EDvZdd1tZipPMG
   Fwe4e86oidcV91JLZXPCh4IlISmakVqrVKhVOYkqpChozT/L/j827iXT7
   rP7rQira/Y29ItqW5Zoq4OsyQpcJK255vpOeWZnvenqloxy0t6isK1iNT
   z/6D7E4K23/I7dJs+1mBd1RHJAMfHrDsDolCUUJBQsWJbjmwKxAMGo/lJ
   y+oamSGxC8sPlgcM0rzbtbut/BNGZHIK5igq6suJVpn5axV8Sjga0gVbg
   /fVTNiOfIlb92GEe0duPyt4X5FBZGnVEgfIbJYSStFpo1lO0N/hFPkvrI
   A==;
X-CSE-ConnectionGUID: r4tN9jnkTle540xosHr65g==
X-CSE-MsgGUID: t3s7/yD1SQeo3Cj/I25r9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3744958"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3744958"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 10:17:21 -0800
X-CSE-ConnectionGUID: OlL6QJW2QWmV+C5I0bn7+A==
X-CSE-MsgGUID: 9WyY9J63T6mWAnK00y+U1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10087024"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 10:17:21 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] PCI/EDR: Build EDR whenever DPC is enabled on ACPI
Date: Wed, 18 Nov 2026 10:17:15 -0800
Message-ID: <20261118181718.3907441-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118181718.3907441-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261118181718.3907441-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Make CONFIG_PCIE_EDR a hidden option that is enabled whenever
CONFIG_PCIE_DPC and CONFIG_ACPI are both enabled, like CONFIG_PCIE_PME.

pci_dpc_recovered() gave up if firmware owned DPC and EDR was not
enabled.  EDR is now always enabled with DPC on ACPI, and native_dpc is
only cleared by the _OSC negotiation, so remove that check.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
Changes since v2:
 - Keep CONFIG_PCIE_EDR as a hidden option instead of removing it (Yazen)
 - Remove the pci_dpc_recovered() check that becomes dead (Yazen)
 - New subject, was "PCI/EDR: Remove CONFIG_PCIE_EDR"

 drivers/pci/pcie/Kconfig |  8 +-------
 drivers/pci/pcie/dpc.c   | 10 ----------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 207c2deae35f..4d097c53f140 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -138,11 +138,5 @@ config PCIE_PTM
 	  is safe to enable even if you don't.
 
 config PCIE_EDR
-	bool "PCI Express Error Disconnect Recover support"
+	def_bool y
 	depends on PCIE_DPC && ACPI
-	help
-	  This option adds Error Disconnect Recover support as specified
-	  in the Downstream Port Containment Related Enhancements ECN to
-	  the PCI Firmware Specification r3.2.  Enable this if you want to
-	  support hybrid DPC model which uses both firmware and OS to
-	  implement DPC.
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a0880e3cd68c..1e917febcbf3 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -102,19 +102,9 @@ static bool dpc_completed(struct pci_dev *pdev)
  */
 bool pci_dpc_recovered(struct pci_dev *pdev)
 {
-	struct pci_host_bridge *host;
-
 	if (!pdev->dpc_cap)
 		return false;
 
-	/*
-	 * Synchronization between hotplug and DPC is not supported
-	 * if DPC is owned by firmware and EDR is not enabled.
-	 */
-	host = pci_find_host_bridge(pdev->bus);
-	if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
-		return false;
-
 	/*
 	 * Need a timeout in case DPC never completes due to failure of
 	 * dpc_wait_rp_inactive().  The spec doesn't mandate a time limit,
-- 
2.43.0

