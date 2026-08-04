Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A4046D0AD;
	Tue,  4 Aug 2026 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850736; cv=none; b=C9HSkx6TnG7ZvWd0rcpn2AEzfbeLwQPc/gRA4RQAZANfm18Nkzt5GSJnnk/hhRP/dChX6teQpO7MgzszTe/ppejkBxAKDUYengsEi5JYjLE7mHoeaBBVWcB5iBiRUcelalYaeyK4EWYgzj9lhphSs/KY/sCoGs1DCCMd/fMLpds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850736; c=relaxed/simple;
	bh=qVCDtVw4YXVPC2Lgfv+Ullr3SJrYay9qNnR41X2bZPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtUGCm9upBsQ8wE4R0y0hMrYqGmloodeAvuEFndOrJyF9QogusqHG6ydgV05IrzgZjqz/iXg77w1pBmEB4mo3J+0gyaUr1/mk+DWcw4zgoybA8ezrb6S2RkIJRbHtAkzmO8e8F8SHRUYxrZtNaPOwERpUGYNUiYkwzseU9tBSiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1WH23uJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1WH23uJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785850735; x=1817386735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qVCDtVw4YXVPC2Lgfv+Ullr3SJrYay9qNnR41X2bZPc=;
  b=n1WH23uJt/C9A8MzD2xTRBu2Nc+dNhH9gDbMT/Ust6suJEUXVN8rhsfM
   u/D1RbhNDOZMU/YpLAmHJvUipsXCarwVz3ppjkZKcBjX3leyOgFIZNxFO
   WVNDgKTtD1VgLrgLPR2bJfdfnR97H9Bfi1aMlsCfPlM3gnYe3aSKlB7wT
   VnnjxAy2mos3guIsxxXjPgwX3eGW4TdU5/I1F+zxAGYCpWq4axdu4iwpE
   Y10JqblR5jF2d5NxM1sCQ2xO7qjo4iom4/b38kHP1VG8TOCijA+YqpLL9
   cfWSjoAKEL6ihXnmUAVrMaZ6BMr5+r4UDZdE7cY/C1EtSZ33KIlQvYDlp
   w==;
X-CSE-ConnectionGUID: JPN3u7mfRbWMNpri4h49jw==
X-CSE-MsgGUID: GxtXM+7DT6aZtTnJo0OriQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86410184"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86410184"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:55 -0700
X-CSE-ConnectionGUID: ZO6mh3C7R1GaEHjcXJHSPg==
X-CSE-MsgGUID: xJXLWcKXTgidilOngklmhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="263501068"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.132])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:52 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	akhilrajeev@nvidia.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V3 13/14] i3c: mipi-i3c-hci: Factor out i3c_hci_sysdev()
Date: Tue,  4 Aug 2026 16:38:09 +0300
Message-ID: <20260804133810.184905-14-adrian.hunter@intel.com>
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

The MIPI I3C HCI driver needs to identify the underlying system device
used for DMA mapping and PM operations. The logic for determining that
device is currently embedded in the DMA implementation.

Factor this code out into i3c_hci_sysdev() so it can be shared by other
parts of the driver and keep the device-selection logic in one place.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V2 and V3:

	None


 drivers/i3c/master/mipi-i3c-hci/core.c | 12 ++++++++++++
 drivers/i3c/master/mipi-i3c-hci/dma.c  | 15 +--------------
 drivers/i3c/master/mipi-i3c-hci/hci.h  |  2 ++
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index cfe9b5390b56..0212c9e984cf 100644
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

