Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A411139478B;
	Wed,  1 Jul 2026 20:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936960; cv=none; b=R2q7JlIy3UeVA7tdmriNKHVMKCdHpNFZl2dYYEUmTZCXA3ZlXGPLKyuLveHFQEqh4YzwRp/T86Vd/IVVj/QDUy8/PO0+CajJJa89RWFwua2eqjxj7ry50mdIHFlgFgA91sxZFD9LXAKo2aWxqZBmY0ODYYx7mB5q1PRIhyFNIPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936960; c=relaxed/simple;
	bh=ww+876KOyCaTFEZOXknUVpXnhh8uarR97qv0FHoe12M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYeB2KVAvA4XEDF1XyBTOFiH3WYeaG5wTd748SoKZ/u+zf/AiSqh6JRA2/kKjfLpNhGq895xoONbGUDIR2D4GrnE0ceb1A+cl2CgbdTarUKM4ZLaEAWPmk58Dg/7xfiAPOSPctt+yzims1ZjIv5xMc/Mfmh2miteGG1vY5XK/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ffKBVcyy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ffKBVcyy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782936959; x=1814472959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ww+876KOyCaTFEZOXknUVpXnhh8uarR97qv0FHoe12M=;
  b=ffKBVcyy+BWyswlBnVEm1jKQaqf8/8p6KzVHj7ozFtRHGAnrQoZUOQCG
   eoRLApK//feMe0rosij+GA7L0QvZUdI9wpSxdWHvoNwilFX1zIcFd9J+M
   c3xWfQ/lixsqU4ULG01tvu+/+GvWUXDXh9ZNVZUvjxA/v1JHqytb5DBVY
   yfXlzB10x2y7OtXs58eE+shwZbC3R9CKk63j8p/T0J9cjAuC7ZkUvrzRp
   pHh12SG852qVNokgKIqLP/QKkfbkfY4fyL8yI0H8ZX0r8zHHbhuz0+jSS
   b4gv/WqN7hexjMrnjiHEVRbhrT2ZUEqTIc1A8epYtYxEBsB80NB8S92wz
   g==;
X-CSE-ConnectionGUID: h6kDQsXpRnKFvfwKsxrhqQ==
X-CSE-MsgGUID: JbMsY9MnRByBz6SP2QuA2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="82671813"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="82671813"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 13:15:59 -0700
X-CSE-ConnectionGUID: ZebfcMPnRRuVAP+HfqOaig==
X-CSE-MsgGUID: YTbxNE7rT/ePdRtqbsfnLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="282737070"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 13:15:56 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH RFC RESEND 6/7] i3c: mipi-i3c-hci: Factor out i3c_hci_sysdev()
Date: Wed,  1 Jul 2026 23:15:32 +0300
Message-ID: <20260701201533.220818-7-adrian.hunter@intel.com>
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

The MIPI I3C HCI driver needs to identify the underlying system device
used for DMA mapping and PM operations. The logic for determining that
device is currently embedded in the DMA implementation.

Factor this code out into i3c_hci_sysdev() so it can be shared by other
parts of the driver and keep the device-selection logic in one place.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 12 ++++++++++++
 drivers/i3c/master/mipi-i3c-hci/dma.c  | 15 +--------------
 drivers/i3c/master/mipi-i3c-hci/hci.h  |  2 ++
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index e80aa1f5722e..4e17b1480362 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/platform_data/mipi-i3c-hci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -117,6 +118,17 @@ static inline struct i3c_hci *to_i3c_hci(struct i3c_master_controller *m)
 	return container_of(m, struct i3c_hci, master);
 }
 
+/*
+ * Determine the device that does PM / DMA and has IOMMU setup done for it in
+ * case of enabled IOMMU (for use with the DMA API).
+ * Such device is either "mipi-i3c-hci" platform device (OF/ACPI enumeration)
+ * parent or grandparent (PCI enumeration).
+ */
+struct device *i3c_hci_sysdev(struct device *dev)
+{
+	return dev->parent && dev_is_pci(dev->parent) ? dev->parent : dev;
+}
+
 static void i3c_hci_set_master_dyn_addr(struct i3c_hci *hci)
 {
 	reg_write(MASTER_DEVICE_ADDR,
diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index 0672ed1132f8..7c2b20474130 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -15,7 +15,6 @@
 #include <linux/errno.h>
 #include <linux/i3c/master.h>
 #include <linux/io.h>
-#include <linux/pci.h>
 
 #include "hci.h"
 #include "cmd.h"
@@ -301,23 +300,11 @@ static int hci_dma_init(struct i3c_hci *hci)
 {
 	struct hci_rings_data *rings;
 	struct hci_rh_data *rh;
-	struct device *sysdev;
 	u32 regval;
 	unsigned int i, nr_rings, xfers_sz, resps_sz;
 	unsigned int ibi_status_ring_sz, ibi_data_ring_sz;
 	int ret;
 
-	/*
-	 * Set pointer to a physical device that does DMA and has IOMMU setup
-	 * done for it in case of enabled IOMMU and use it with the DMA API.
-	 * Here such device is either
-	 * "mipi-i3c-hci" platform device (OF/ACPI enumeration) parent or
-	 * grandparent (PCI enumeration).
-	 */
-	sysdev = hci->master.dev.parent;
-	if (sysdev->parent && dev_is_pci(sysdev->parent))
-		sysdev = sysdev->parent;
-
 	regval = rhs_reg_read(CONTROL);
 	nr_rings = FIELD_GET(MAX_HEADER_COUNT_CAP, regval);
 	dev_dbg(&hci->master.dev, "%d DMA rings available\n", nr_rings);
@@ -332,7 +319,7 @@ static int hci_dma_init(struct i3c_hci *hci)
 		return -ENOMEM;
 	hci->io_data = rings;
 	rings->total = nr_rings;
-	rings->sysdev = sysdev;
+	rings->sysdev = i3c_hci_sysdev(hci->master.dev.parent);
 
 	for (i = 0; i < rings->total; i++) {
 		u32 offset = rhs_reg_read(RHn_OFFSET(i));
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index b3d9803b1968..b8d2a3d680f8 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -184,6 +184,8 @@ void amd_set_resp_buf_thld(struct i3c_hci *hci);
 void i3c_hci_sync_irq_inactive(struct i3c_hci *hci);
 int i3c_hci_process_xfer(struct i3c_hci *hci, struct hci_xfer *xfer, int n);
 
+struct device *i3c_hci_sysdev(struct device *dev);
+
 #define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
 
 int i3c_hci_rpm_suspend(struct device *dev);
-- 
2.53.0

