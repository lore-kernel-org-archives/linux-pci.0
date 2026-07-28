Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3086C45DF56;
	Tue, 28 Jul 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254020; cv=none; b=ZuS2WNb9vj4tlLDwjBKcNH7N0q0+s8xl5+yit0DjyRMz2+83ASCHm0vvu817q1gH894JIQioAt9Xy4ucZ89U6BBtzn/GlbEorlyCJ5L+u9qbrpw50V5SI61Msp2aYQQhu78kSob8ooKR/iu0uknp0Wtd/ITt46xzm28EfiofDcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254020; c=relaxed/simple;
	bh=TCb/nISARFE2W5GFqZKUbYAlrh6G+l/ILM+5Ecvs8Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n96qN/vLrZOxx769yxPmQ2a/tPguN7OzwVL5kes21cVNU66kAGPEYkPeoBh37vj8JvFAa2H5Fs/Nm8/e6Nop1PX3IT9/Yazi3fqCEHsN02WulbCnZUYq/PoPOebTeZG16I5fqT7pXcs1MzHOVKSvBXf1wYkTCRqHM8ruX2wGpFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsJpF5am; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsJpF5am"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785254019; x=1816790019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TCb/nISARFE2W5GFqZKUbYAlrh6G+l/ILM+5Ecvs8Tw=;
  b=GsJpF5amVnszQytQ/cBPpa/SY0IL2BvNrQidWTwrPfqEBVk5cGWfSzpH
   FmzGPAjLkZ6gqI3YuVJwvIeYvXsDfHv4FLGH74B71O71H+hkDM5D0fJRs
   broLGihfkp88xZNqmZhLZuLo5LQt/0Z7Fh1pZpdJ6006OgSyfHfi5fZ4l
   wacnIWotw0bOogaxyTo3nJhiH6mb3WHXl+CHA+lOCVmwHxDoRAtJtporP
   0bOuRsbOTiQMBFA1SR1LyyMY7CR2G94R4OLS+EKNLaRzcE94UjB1DWCzC
   L+NdVWqtMvsklswnQXVtR+oangV6a9R9uLupEyt/XumRvkyY3FoKDDKv8
   w==;
X-CSE-ConnectionGUID: x/wRFBE9Qcu52ubWZsMSvQ==
X-CSE-MsgGUID: 5cXAHonMTiOsM6pbG6g+5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85696816"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85696816"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 08:53:39 -0700
X-CSE-ConnectionGUID: V+mtTotjT/2g1Lo2bFLyiA==
X-CSE-MsgGUID: aPFZ2k8dT2y8u3eoGAZHfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="255817747"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.126])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 08:53:36 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V2 8/8] i3c: mipi-i3c-hci: Advertise IBI wakeup capability
Date: Tue, 28 Jul 2026 18:53:08 +0300
Message-ID: <20260728155308.142713-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728155308.142713-1-adrian.hunter@intel.com>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
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

