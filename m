Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F387374721;
	Thu,  6 Aug 2026 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022406; cv=none; b=VycUu9Djz/87/CyT5beVJXHM/pargy6nm17OtHKTDmFRDELNhuW2shwlkuhuZgbDnDgIITflI9O/OnZJyBhED4HAlauRRWjXsesKzNma5a/8eVJljIvv5HodhdF7IRwdyS2+AaK7ZbETpJ45WHzBeNqOH1q9IRplSxJ7AlAKBAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022406; c=relaxed/simple;
	bh=4rY7IGb0lt7RFyKVZ1S7RTS2cw+M31qnZC70CCtDg4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5klNoni+hc7lWr6sG5fsm/DI7/onldFUtdVueiWqyDoaGd05vmCBB6VU2aaN9gi3EUXchgALgcWmJTxhkut3mTUIajpbOk7uu8xg9vD9Pdk0Tl4TA8Giw5Eyy5z9Z1X3Cw8Sjn651hCnUv0fLsQ2IvQ70X0Inx0BAqt5j/JjEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cedp3dY6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cedp3dY6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786022394; x=1817558394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4rY7IGb0lt7RFyKVZ1S7RTS2cw+M31qnZC70CCtDg4o=;
  b=cedp3dY6trMeCJLxyAagS+sRh6dvZnxbBvdX8FwQyac6oXWcWsKqziWo
   bsVjVZPiq4GukkOiRma8e3Us+snctV7Vm1b3w2ZAjM/L1kWDofNHxAg2R
   aJBsbh/CZp15km5Y6ckfThcIw9YrghFZTVK7v/YYZD30jq/myA3VBYMAx
   a3mHqVNevgmfo2C+S+Mk3CESAFufpRXSty+ybKjsrrae/gAQRA8CYTKVK
   8VJ5xZVeJkQ8zaJU0DeUrxJSDe/SKT3dHTRJHu9+4S1vGXK4OTIVpfv/q
   u1JMQQM9YUFB3xK2ZzK92j9NAbQPh3ViE8t0QfchVwj2U1KuiO3vINxo2
   Q==;
X-CSE-ConnectionGUID: paKDBdEjTJmFjd7DFyrAyA==
X-CSE-MsgGUID: MrEIhZ4pTlmvf5WJK7UhlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74149661"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="74149661"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:49 -0700
X-CSE-ConnectionGUID: 6EkFM2hkTC+Y0OcbD5vnnw==
X-CSE-MsgGUID: 20RDd/bkQNWGFcHBAdXucw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="260338357"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:46 -0700
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
Subject: [PATCH V4 14/14] i3c: mipi-i3c-hci: Advertise IBI wakeup capability
Date: Thu,  6 Aug 2026 16:18:57 +0300
Message-ID: <20260806131857.119830-15-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806131857.119830-1-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
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

