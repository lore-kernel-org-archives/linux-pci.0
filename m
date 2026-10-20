Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520370;
	b=aLppWj4S0FVgaSqSz36rH//Cae8Rmb5xCLzOU8Jydb/FuVgqf/hPh2+HuYJsQU8xA7Pb
	 jPfoTqamS5xCxQyxzaEjRSyTtnaFyc9Fj3TXab+W/GCvPyfiE/9+wgUDyg6FZx1DRM/Kx
	 nG0vJoY3XpaLMh23+US/klTmBy+pNw1t6k+K8hAGA/z4lljgrgKIgCFwnRu7opUmCl+zY
	 F1hldbE+01Es5oqc+Bhdr2JGxo9AKJqBJ71bv8oAbIbAerkIn1eLjwuzD1UvF0zxhM7z0
	 nHXEVNDVH9i3v0TdgyGNQaRIguwUpt1F2ao5r8UjSl3lwqMQujukHhIg/wBMKKzGlEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520370;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GRzB4Gh0KO4clTWNujo0oSv7TNUgMjCnbwAg2/2BJDY=;
	b=ZhoNYgUL4lJHuFKrLgOZSxYfN+DLNNybk75XHA6JpU/wFystKMJCkf6fxu0DjEC21Yji
	 1COs0sJlRRU18gnjJeV90MrKhg+dX/5i28SQcwbUwZibqC1vTdLw9pHXq8ITY1Eo0y3B1
	 YBH0XuSmpknrSakA3CxbLwB1A84hVsKsJYZmF/VKxSXoCOj4kVW8PZgjISSDJrgWtokFw
	 OVuxqJ/RB+RprgVbMcdmrLQfps6D7+yS/wEUKGDyxPBLmWxIdqTpsSdC8yZ1w0VYEA0f1
	 1dEfHPOl9hmwiDa52XJe2tBXVDS8nxj6d3KW5xX6AOYLxyIFb9ypNkcQMzLfUrz0Yhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iJJ95Lps;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63C606A321;
	Tue, 20 Oct 2026 18:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A63C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iJJ95Lps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792520371; x=1824056371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ebhwX0Z2FEr1mbC5QVjJWX1b66Er3lV9yWDqjbRc684=;
  b=iJJ95Lps69cSQkm6whmPoxghxkCaMN+DloykeLM9B80au+y7abeupVrQ
   GUXhzI97U0s3MXjVg++G+TjVXxmHSJY/MhC1YlmX5jpaXAbEGb6iI4gHo
   H+EFmtZ+jG/X6n2gjXjT64elNnAgB3dyvKjMEfO1Jk7rncR+Fg7tdXP34
   NKWdrQJEfkbKSLvvDfuFps02SUvhRcV20TTPIF+rFdBGRxXihgffFZQbN
   rwo2qHHY44SGPg71SuQlPf7KE0aqjxyeWi7HcrbcJdecFswgsXguaJdCq
   XdxLo2HzvJUV2r15JB0a8nfWh3NmpiZOHlnATKlwMSZkkr+ajgWexDBb2
   g==;
X-CSE-ConnectionGUID: JecUlm8FTgCu7IvQ3rLXRQ==
X-CSE-MsgGUID: +n/MeQPQQeqZGWqiEfwAKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1119662"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1119662"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:19:29 -0700
X-CSE-ConnectionGUID: WQtJSQdNRk6PGakkY9W1sg==
X-CSE-MsgGUID: h3NtTP3ITla98cuHZtbDWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3283604"
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
Subject: [PATCH v2 1/6] PCI/DPC: Avoid access to non-existent AER capability
Date: Tue, 20 Oct 2026 11:19:18 -0700
Message-ID: <20261020181924.3003553-2-sathyanarayanan.kuppuswamy@linux.intel.com>
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

From: Lukas Wunner <lukas@wunner.de>

Downstream Port Containment does not mandate presence of an Advanced Error
Reporting capability, so a Downstream Port may support DPC, but not AER
(PCIe r7.1 sec 6.2.11.2).

In February 2019, commit 9f08a5d896ce ("PCI/DPC: Fix print AER status in
DPC event handling") amended the DPC driver to access the AER capability
without checking for its presence.

In May 2020, commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST
parsing for AER ownership") fixed it by inserting a call to
pcie_aer_is_native() in dpc_probe(), which implicitly checks for presence
of an AER capability.

However already in October 2019, commit 35a0b2378c19 ("PCI/DPC: Add
"pcie_ports=dpc-native" to allow DPC without AER control") made it
possible to override the check:  The DPC driver may access a non-existent
AER capability if "pcie_ports=dpc-native" is passed on the command line.

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
---
 drivers/pci/pcie/dpc.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861..793a799053f1 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -236,21 +236,15 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 					  struct aer_err_info *info)
 {
-	int pos = dev->aer_cap;
-	u32 status, mask, sev;
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
+	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
+	if (devsta & PCI_EXP_DEVSTA_FED)
 		info->severity = AER_FATAL;
-	else
+	else if (devsta & PCI_EXP_DEVSTA_NFED)
 		info->severity = AER_NONFATAL;
+	else
+		return 0;
 
 	info->level = KERN_ERR;
 
@@ -275,7 +269,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
 			 status);
 		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
-		    aer_get_device_error_info(&info, 0)) {
+		    (aer_get_device_error_info(&info, 0) || !pdev->aer_cap)) {
 			aer_print_error(&info, 0);
 			pci_aer_clear_nonfatal_status(pdev);
 			pci_aer_clear_fatal_status(pdev);
@@ -353,6 +347,9 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
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

