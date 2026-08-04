Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8646D0B1;
	Tue,  4 Aug 2026 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850739; cv=none; b=V0oJUc6jtVa5f2+GDtZAqRuzS5A2iMNEWsMYKJw/np3ytoqIfyc9qup/JZffK8Kt/gJNWLvAt7jXFWxTHwkwOz+VwlZzYICcpqLSGo1ZV5668U/g45m060s2g9phqqtcwuwjZ3ayQsV5TUYNw9oPBB9dqwZIV6NjbCkVpbXhBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850739; c=relaxed/simple;
	bh=fL5R1x9TZFT+HG95wJ+SGsMrSYKHX0Fo52jLM1Vj45E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiuYAvhUcMMaZX6Ed+kPFF5mKD2NYHBuGwYmO8eFcRdFbzG/t6xIy0MVgBUMdZLeUEYstkvMgF8LYqcJZjho1Cjy08ORPCqMPmCmF+w3EoLzO5ccW6/ntGG3tn4JvSyFrhhNVaJeX+COV0KIE/2iZVvpK+DwRgGdOSXpgxugqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEYC1Ogn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEYC1Ogn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785850739; x=1817386739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fL5R1x9TZFT+HG95wJ+SGsMrSYKHX0Fo52jLM1Vj45E=;
  b=bEYC1OgnvbKmv1p6ZUFXB/975dfV6E2OI0pu+91PkI2M5JXtjckHB9gD
   SWsfOB2Xnikq+WquOSkvC7Q97QAPS8vxPArJ/uFDc4BmjeMxScFXYlwL9
   kNHtYyOcGvxC/Jr/M1R1qbumKoUJhWGnfOI+BO+b/fV4kSGqhxtsX8JTC
   1Ql54r6D27Qx6kf97IUO3mH3jk3rtZ6x+qU+j+RZXymx2AgsjBH/fhBYi
   B8aJeHCLoTt2Eyh/72sfAz8LcMVHUX2BNpoTBJ3VF2vxncHQ2pqT0KSUt
   zNwC9oLRZwl9HX1GsKclcBWXO4PNg3gea/3+w5onnDpP6xBBw8XMvdjiI
   Q==;
X-CSE-ConnectionGUID: qMRvnyTAS9SXZyLYrkKGxg==
X-CSE-MsgGUID: X09rv+wfQrGtn7kz5osaaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86410195"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86410195"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:57 -0700
X-CSE-ConnectionGUID: HvgyCBfORymBzck8FInXbQ==
X-CSE-MsgGUID: s8v2B4aqRKuzsdG0ghgOWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="263501071"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.132])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:55 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	akhilrajeev@nvidia.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V3 14/14] i3c: mipi-i3c-hci: Advertise IBI wakeup capability
Date: Tue,  4 Aug 2026 16:38:10 +0300
Message-ID: <20260804133810.184905-15-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804133810.184905-1-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
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


Changes in V3:

	Added Frank's Rev-by tag

Changes in V2:

	None


 drivers/i3c/master/mipi-i3c-hci/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 0212c9e984cf..5d92cf0645ef 100644
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
@@ -1176,6 +1176,9 @@ static int i3c_hci_probe(struct platform_device *pdev)
 	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
 		hci->master.rpm_ibi_allowed = true;
 
+	if (device_can_wakeup(i3c_hci_sysdev(&pdev->dev)))
+		hci->master.ibi_wakeup = true;
+
 	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, false);
 }
 
-- 
2.53.0

