Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795025843;
	b=KFeOlBCVF9z+GtjwGNuQ24ArX35pN7TAviKcXvecl7/xf4dZTNEgcuRAx72OmvdMQzHa
	 yir4UNMxuVIloW4i3Y4/bAtgo/ZgwbjXVplS+C023syMsJ7qs0SMsxWD7ZdRmjdw6I/z8
	 xC5oWr/kE4wnfq8ui6no0wh6OHMePjyU/1rFpKNQxsTrcpxTy4iU+h3oR1iP/2BYqClak
	 bz76v7T8hzT9/8x5k5BvyLbdwrwUnOSC8IoqX3gIen7BhCUG3sJittbQ5j53vmeIm+hzU
	 pFnTzSK7jFozazwAjTduTJ0IEwUlsvtmrjLBJzvUGVJ0mEMa22CwW0DwaOA/2UZNTCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025843;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sIBydllVXTOaZO8LtnBhWlkRhFDalbS5d/0Cj4yaZO4=;
	b=QHjYKZ2YaZD1kaVXbFkyFnyJmSzalZBAvXt7S/45OAvfFckuOaA2rGMtSfOgC5FdxsLY
	 frhSqqym+/1ihfarBVPtYGUpcnsWtO7RJ/d7ZSXDjAzWPl7oxGt4oh77sJKTIe1i9Doru
	 wG551EQgnJGS2FOTEKYHHtFf55IX/jCy7e7sm7REVLG4qx6QPbLgFgcAlX4zeV+qBG6UU
	 Vx3YSSKddBsivYUt7dheRhG5D2Wf6Q8Gqsed07KSskamey9GpeY4i8hgwBHqOFsdNdblq
	 Bf0vEwlv7DeuCvtMG6ljc3eFIRrKqwAgtgzwcL1T+WfvjI/C9BaeLvphFsaBoS62YIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OGwAB5xm;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A72606A331;
	Wed, 18 Nov 2026 18:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6A72606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OGwAB5xm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795025843; x=1826561843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4hu5NvPT1eCSivKxdWkSohtzRGftFnOE7Bb7+2XAb6g=;
  b=OGwAB5xm7k5UsPMurYIhY9tzyXErxuWjT6vrUHSfhKR36yZAEz5bpt+t
   1FhcKiFQiIKec7chZfk8U70/WXaLWVqMOQIsqx2aZC5hvNxnLexRCDAzA
   YWi6ihRFSJGh7DDjjvVebTdR/orjT3tRKRjIBGkTJYD+5caF/owhHONcF
   ChIQdoCRNZ2deo+ZSKdXfjA3HU3k8hoRni0PHiE1iQltd+UYLMKlz3YwQ
   TF2w7QSGpINYQuTMcOwCWKIb34Q9Kn+ZpkVxHZN5rzsy+Kq2x/29PxZas
   rXFyEGOMFXX3fED5KvxIAfH0F/tGzXASFM4YZPJehKuwnXCb4TPEK8wWZ
   g==;
X-CSE-ConnectionGUID: AU6trsv7Su+ex+SUMgmDAw==
X-CSE-MsgGUID: rqXs2m/3TTmgtwml4t/gOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3744941"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3744941"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 10:17:20 -0800
X-CSE-ConnectionGUID: L4xIKs+PSReBR+ps/xXBlg==
X-CSE-MsgGUID: ZQSHiP3JTXuU7BJbTDtpsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10087020"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 10:17:20 -0800
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
Subject: [PATCH v3 1/6] PCI/DPC: Avoid access to non-existent AER capability
Date: Wed, 18 Nov 2026 10:17:13 -0800
Message-ID: <20261118181718.3907441-2-sathyanarayanan.kuppuswamy@linux.intel.com>
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

From: Lukas Wunner <lukas@wunner.de>

Downstream Port Containment does not mandate presence of an Advanced Error
Reporting capability, so a Downstream Port may support DPC, but not AER
(PCIe r7.1 sec 6.2.11.2).

In February 2019, commit 9f08a5d896ce ("PCI/DPC: Fix print AER status in
DPC event handling") amended the DPC driver to access the AER capability
without checking for its presence.

This did not cause actual problems because in March 2018, commit
4e5fad429bd1 ("PCI/DPC: Do not enable DPC if AER control is not allowed by
the BIOS") had seemingly inadvertently prevented instantiation of a DPC
port service on AER-incapable ports.

However in October 2019, commit 35a0b2378c19 ("PCI/DPC: Add
"pcie_ports=dpc-native" to allow DPC without AER control") made it
possible to override this:  The DPC driver may access a non-existent AER
capability if "pcie_ports=dpc-native" is passed on the command line.

Fix it by making the DPC driver cope with AER-unsupporting Downstream
Ports.

There are two places where the AER capability is accessed:

- dpc_get_aer_uncorrect_severity() uses it to discern whether a Fatal or
  Non-Fatal Error triggered DPC.  Access the Device Status Register
  instead, in accordance with PCIe r7.1 sec 6.2.5.

- dpc_is_surprise_removal() uses it to detect whether a Surprise Down
  Error triggered DPC.  Return false on AER-unsupporting devices.  The
  function works around an AMD-specific quirk and it seems reasonable to
  assume that all affected products are AER-supporting.  In any case the
  detection is not possible without AER capability.

Insert a temporary check for an AER capability after the call to
aer_get_device_error_info() because the function currently returns false
for AER-unsupporting devices.  The check will become obsolete and will be
removed with the imminent baseline capability error reporting.

Fixes: 35a0b2378c19 ("PCI/DPC: Add "pcie_ports=dpc-native" to allow DPC without AER control")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.5+
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/dpc.c | 45 ++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861..d02cbbbe3143 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -238,19 +238,35 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 {
 	int pos = dev->aer_cap;
 	u32 status, mask, sev;
+	u16 devsta;
 
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
-	status &= ~mask;
-	if (!status)
-		return 0;
-
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
-	status &= sev;
-	if (status)
-		info->severity = AER_FATAL;
-	else
-		info->severity = AER_NONFATAL;
+	/*
+	 * Infer severity from AER Extended Capability if present, else from
+	 * Device Status register.  The latter cannot be used on AER-capable
+	 * ports because it also logs masked errors (PCIe r7.1 sec 7.5.3.5).
+	 */
+	if (pos) {
+		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
+		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
+		status &= ~mask;
+		if (!status)
+			return 0;
+
+		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
+		status &= sev;
+		if (status)
+			info->severity = AER_FATAL;
+		else
+			info->severity = AER_NONFATAL;
+	} else {
+		pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
+		if (devsta & PCI_EXP_DEVSTA_FED)
+			info->severity = AER_FATAL;
+		else if (devsta & PCI_EXP_DEVSTA_NFED)
+			info->severity = AER_NONFATAL;
+		else
+			return 0;
+	}
 
 	info->level = KERN_ERR;
 
@@ -275,7 +291,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
 			 status);
 		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
-		    aer_get_device_error_info(&info, 0)) {
+		    (aer_get_device_error_info(&info, 0) || !pdev->aer_cap)) {
 			aer_print_error(&info, 0);
 			pci_aer_clear_nonfatal_status(pdev);
 			pci_aer_clear_fatal_status(pdev);
@@ -353,6 +369,9 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
 	if (!pdev->is_hotplug_bridge)
 		return false;
 
+	if (!pdev->aer_cap)
+		return false;
+
 	if (pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS,
 				 &status))
 		return false;
-- 
2.43.0

