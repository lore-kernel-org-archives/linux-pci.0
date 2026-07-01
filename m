Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9ED3C10B2;
	Wed,  1 Jul 2026 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936962; cv=none; b=aWzWvmikTzoNKPLxC3qHu61M0Mwd3gksQlzI5/QBvF9l1cMX2RGy97Bm2cHuSiX2hY7oq0ywf6Xel/3g/LXc0W3rVTeugH8i/eYkP7KhTUUx7ChAHOMyeFmac5D2iwEGWtXbGNbeFcjjjYzfTUs+SeOelJ2rd54hzGpr9/U02qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936962; c=relaxed/simple;
	bh=ebGfPmyiAwYoSiWiq257o+B7NcSMheMY6PP0hEPRA2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgUxowLu22HNO3uMyf7gZE/+FTVBdX9D7oov1BANr2czdUK+H1NDRG2xi5/8dSeKsg2a3+qRLpfP309NOoUqboS3+1/vt6qpWezCSFao0FhT1nIeXxSKWPu57UE1lfop9peDwXyA3zmXdRgspIkqFuRkz0zJtT3oozyeXX5ABPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYIOuaw4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYIOuaw4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782936961; x=1814472961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ebGfPmyiAwYoSiWiq257o+B7NcSMheMY6PP0hEPRA2w=;
  b=JYIOuaw4mpdXO0VPh1uy12UF40GHKsFBT4ybl1p8bldt5Y2ZeCWHM2GX
   mS7ZpVwMMcsBMB3/pf4CAS6E7m4XzUvs/yZ1vfgkdXkm5avOJW1EXfxrl
   A+Qui2gqpQgBXdS4NO8fqhgX0UIK9aMkVCUmpnNYPPUuPKf1onxwJG0Hi
   4KhVIiigQJ3UpjOS7KXSaZIdlmlcWlhMsf5LtAygNw+KMWSQwkljyBXL2
   U78JBLFxt0qHSr1eOPT+oIZkiyMh3AtahF+OV5s7BX0nIc+vXYypayLun
   OqV6DW4NBAae6NJZfA/PIn6lvf4cr0z8cyfpUEp7t6CeoQTd2d/IgzxLk
   g==;
X-CSE-ConnectionGUID: kAaD42EBRp6h4oUiJQq5tA==
X-CSE-MsgGUID: IK3DJ31QRs+v4zT4C6rvYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="82671819"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="82671819"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 13:16:01 -0700
X-CSE-ConnectionGUID: 4ZAhvxweTBS+7S3RUwUQyA==
X-CSE-MsgGUID: 8lc5MO1RTWalRmh5wu3V9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="282737169"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 13:15:59 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH RFC RESEND 7/7] i3c: mipi-i3c-hci: Advertise IBI wakeup capability
Date: Wed,  1 Jul 2026 23:15:33 +0300
Message-ID: <20260701201533.220818-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701201533.220818-1-adrian.hunter@intel.com>
References: <20260701201533.220818-1-adrian.hunter@intel.com>
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
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 4e17b1480362..55724a986f90 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -120,9 +120,9 @@ static inline struct i3c_hci *to_i3c_hci(struct i3c_master_controller *m)
 
 /*
  * Determine the device that does PM / DMA and has IOMMU setup done for it in
- * case of enabled IOMMU (for use with the DMA API).
- * Such device is either "mipi-i3c-hci" platform device (OF/ACPI enumeration)
- * parent or grandparent (PCI enumeration).
+ * case of enabled IOMMU (for use with the DMA API). It is also used to check
+ * for wakeup capability. Such device is either "mipi-i3c-hci" platform device
+ * (OF/ACPI enumeration) parent or grandparent (PCI enumeration).
  */
 struct device *i3c_hci_sysdev(struct device *dev)
 {
@@ -1175,6 +1175,9 @@ static int i3c_hci_probe(struct platform_device *pdev)
 	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
 		hci->master.rpm_ibi_allowed = true;
 
+	if (device_can_wakeup(i3c_hci_sysdev(&pdev->dev)))
+		hci->master.ibi_wakeup = true;
+
 	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, false);
 }
 
-- 
2.53.0

