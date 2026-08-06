Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE7E36F421;
	Thu,  6 Aug 2026 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022394; cv=none; b=nXlBQd/KjRNzLOGAcE4XYw6gpFPSchO+icVQCcdonCc35unJMzo98xufFqQvVhtG1l1IDx0n2Gb5ZzFzUGDCAT6wUW6eJo+OLJ6dW+WuzclXIzbY6gT2TV2DnbTAV0fMtJB0rZSKRNxTQyh+rjGWiofxvl/BWEwvBfnhOgszX+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022394; c=relaxed/simple;
	bh=K7NPEV3ObsYKOG8K3U8wEY/ilmXqqMrt/n2CH0sksYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7Wx8CoX4NADV5OgCI5pybgYYSXu+P7g9bpRTAsD2YFyUIZpMI8z+VwSe7fNtBZcVCoKcx0b7I0Ruzzq85ToB59Fsex9L5OSRcnUUshvQyvernPSqNETiLgCnkGMZHWpx72hV8m/D1FJflbY5OKRCSZEz9NiC6osGEyhXpols+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=enI6yHfm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="enI6yHfm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786022389; x=1817558389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K7NPEV3ObsYKOG8K3U8wEY/ilmXqqMrt/n2CH0sksYg=;
  b=enI6yHfmzhfAdtXaXi5vT93lUpp2uVBg8UdALAbUp6WZwi8kNCdVBb1D
   DAzDqqYrl3TyYXe56jf/T/E4nIgnHcxV9BThkDABxmjGeh1cMo49WwxgG
   cLxdrJz+3n+lzR4VfQPCBtWRMODWtIBc5PAmPqcqJnIrJfYVvRfuO4rqJ
   xVBfCJH2JIvh4xTQcEcP6V2J2ylPaxsvnU9cjCnpoYnOrMQb9QSt3EHAK
   DH9+VqxisgmIIB5/ya3SkBGpU3xJcKSc2YcyaWbMc0LYWXfCG09ZflmnX
   O2+U5t5okJcazrUll73SY5xfpXF2/N5+urzxXoMKRkrijdrbe0V9eWOlk
   g==;
X-CSE-ConnectionGUID: OJUpaBDJT127OVZVJioVRA==
X-CSE-MsgGUID: X6WNZEV9Q6i1KUYsdXB9oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74149652"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="74149652"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:46 -0700
X-CSE-ConnectionGUID: AyVsNykyTlGGOBu/3kRn7g==
X-CSE-MsgGUID: etoWJgFJQf6EY70zWJX3fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="260338340"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:43 -0700
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
Subject: [PATCH V4 13/14] i3c: mipi-i3c-hci: Factor out i3c_hci_sysdev()
Date: Thu,  6 Aug 2026 16:18:56 +0300
Message-ID: <20260806131857.119830-14-adrian.hunter@intel.com>
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

The MIPI I3C HCI driver needs to identify the underlying system device
used for DMA mapping and PM operations. The logic for determining that
device is currently embedded in the DMA implementation.

Factor this code out into i3c_hci_sysdev() so it can be shared by other
parts of the driver and keep the device-selection logic in one place.

The explanatory comment moves with the code, reworked as kernel-doc now
that it documents a function rather than an inline block.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V4:

	Reworked the comment that moves with the code into kernel-doc,
	and mentioned that in the commit message.

Changes in V2 and V3:

	None


 drivers/i3c/master/mipi-i3c-hci/core.c | 16 ++++++++++++++++
 drivers/i3c/master/mipi-i3c-hci/dma.c  | 15 +--------------
 drivers/i3c/master/mipi-i3c-hci/hci.h  |  2 ++
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index cfe9b5390b56..f95da427d7a9 100644
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
@@ -117,6 +118,21 @@ static inline struct i3c_hci *to_i3c_hci(struct i3c_master_controller *m)
 	return container_of(m, struct i3c_hci, master);
 }
 
+/**
+ * i3c_hci_sysdev() - Get the device to use for DMA
+ * @dev: Device the HCI controller is bound to
+ *
+ * When an IOMMU is enabled, DMA API calls must use the device that IOMMU
+ * setup was done for.  Under PCI enumeration that is the PCI device, not
+ * the "mipi-i3c-hci" platform device below it.
+ *
+ * Return: @dev's parent if it is a PCI device, otherwise @dev.
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

