Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C42435EF2;
	Fri,  7 Aug 2026 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114674; cv=none; b=DNvfn80tZMOUVXODjYsL+VVXxy/y323Jp1IWdCXbRNrQtjNnrm2EzfcXD6tJYkoRB7jgGSBgv5SHfS0EV1HJ1G3jnWZgvD5/Oncw7S4R3ncFIYd6T9QHDlG6dHA7EFQmg7lSozzq+xsScU1tGGSyB2RMRx7a7ssH9tdRMEgG5Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114674; c=relaxed/simple;
	bh=WCBP3RYMvYq8dw77nVtVu31W3Qa1sdE1j3BBwSPtGt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBqKl1JFWcjYf4VuWIIv4KGkDVDdjdkTMJpMcrnSQx4TtGawzA36kPUnHkHPJNcjF2dOOLqZ3dVejxJDbxkdhQt9nDlBgSGjJnDfvxKHl75FsKlnpiA58jCptd9KJdLASLTHaG1NX7sIhyDqm1xKVaIjH9nfGFryLuSrZ7GvEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fiv7E5zS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiv7E5zS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786114673; x=1817650673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WCBP3RYMvYq8dw77nVtVu31W3Qa1sdE1j3BBwSPtGt0=;
  b=fiv7E5zSDS/iEnfVEHfgj+rf6QlnWwC0PA2HYauz3Cjgf24FjT46h22z
   uyYbjfXwSsPGVcrfh73jQBL3lX9XKym2N374+1/DGZ4M8Gn8t8RTbPfeT
   x61AaI8b0vlDT0DU76RCq1ORngAHufxqdsRMmvZwuIoRwIv8c4r3zc0VK
   7NF6TP+W0HWApmBbJiorYD7douxVB+lu7w3khAZ907oRPPc0UX7fVhlee
   aLkDE9ENZ/FrdtI+2mfU1+94Y/lITOCCogpGJRqnc02xNLG6Ec2HjAw/p
   c2JHPdXp+dzZONE11dWyV03wtDksyPzhtqGaJo0eznBik61cAlPYCICzI
   Q==;
X-CSE-ConnectionGUID: jRREpk2MQaORw5RjTvp40A==
X-CSE-MsgGUID: bjOSRlFHTVmTfDG4T43RjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86485300"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86485300"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:50 -0700
X-CSE-ConnectionGUID: ozuY+Q+DSiSnCvilsCLGDw==
X-CSE-MsgGUID: lKRgqdkhROupl7Yov/of0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="259809956"
Received: from amilburn-desk.amilburn-desk (HELO ahunter6-desk) ([10.245.245.114])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:27 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	akhilrajeev@nvidia.com,
	mukesh.savaliya@oss.qualcomm.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V5 14/14] i3c: mipi-i3c-hci: Advertise IBI wakeup capability
Date: Fri,  7 Aug 2026 17:56:38 +0300
Message-ID: <20260807145638.168865-15-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807145638.168865-1-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Set master->ibi_wakeup during probe when the associated system device
advertises wakeup capability, allowing the I3C core to mark IBI-capable
I3C devices as wakeup capable.

Tweak the comment for i3c_hci_sysdev() to mention the new usage.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---


Changes in V5:

	None

Changes in V4:

	Updated the i3c_hci_sysdev() kernel-doc to mention system PM
	and wakeup, in place of the old comment tweak.

Changes in V3:

	Added Frank's Rev-by tag

Changes in V2:

	None


 drivers/i3c/master/mipi-i3c-hci/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index f95da427d7a9..06acf6cf5a0d 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -119,12 +119,13 @@ static inline struct i3c_hci *to_i3c_hci(struct i3c_master_controller *m)
 }
 
 /**
- * i3c_hci_sysdev() - Get the device to use for DMA
+ * i3c_hci_sysdev() - Get the device to use for DMA and system PM
  * @dev: Device the HCI controller is bound to
  *
  * When an IOMMU is enabled, DMA API calls must use the device that IOMMU
  * setup was done for.  Under PCI enumeration that is the PCI device, not
- * the "mipi-i3c-hci" platform device below it.
+ * the "mipi-i3c-hci" platform device below it.  The same device owns
+ * system PM and wakeup configuration.
  *
  * Return: @dev's parent if it is a PCI device, otherwise @dev.
  */
@@ -1180,6 +1181,9 @@ static int i3c_hci_probe(struct platform_device *pdev)
 	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
 		hci->master.rpm_ibi_allowed = true;
 
+	if (device_can_wakeup(i3c_hci_sysdev(&pdev->dev)))
+		hci->master.ibi_wakeup = true;
+
 	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, false);
 }
 
-- 
2.53.0

