Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577EE3C343B;
	Wed,  1 Jul 2026 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936952; cv=none; b=LfRoURSax4xGmLyE2ujW5N1PIrj8ADqjtXq8dAD7GPUmJUcf2hJ+djkmG3zKEyswtMmM7tiid/MZcn74lozlmGVK60Hv1y/QD11a7nnPsm5mdokpaXzb6YorgmECFH9GzrpnvERw5Hl+d17vVSZMTixnixvKxD/qgIYdFRVxbuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936952; c=relaxed/simple;
	bh=3P3wdcp+8UpuSxAdjYoys5NJLGvY0xP8Nj5ewS+gK0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7UPybVIKNN8KU4rxkp9zf3UZ8VldSzR0jXTjYUcKDxSohIHtomatjYKbpL3v+L+hU4gmLEAEAu6W5HyjvkIquCpHghh+cxF8K0JL3XsbrqStghGSJ+kBG3yoHFu/3uXB5UCNYxSAXDs7lGEzucEuSZcltCTHs3GvFfUfhajukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yy3x5v1A; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yy3x5v1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782936952; x=1814472952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3P3wdcp+8UpuSxAdjYoys5NJLGvY0xP8Nj5ewS+gK0c=;
  b=Yy3x5v1Avg17dv4bLLeqhhbyHQTGyTy5hrp73gVq8iQQxoMEkCQRNwDD
   iiaTP0HNvZcXW0NucRGFDVkFxomKNOxc6Bk9AeR5Jrd1jmSLq09YOfk3b
   +UThsGQIBj2fGZ6s5d8CWd80agq2u72w+laOMQvysjhRWK0xbEUT80i2H
   1hb748sLdj3w2PslmmrMAOssJ1HIqNHe9kih9BcezxLEZ+Zm4EJ6qoX+l
   tUA30BILe5wT1TID+Jd6dfbJ9B3aJG/KdUAVzN23TJl5HYzmOBJOy6jEi
   4ERZ1qmtjaJ5lFMAPnjhft8mU7hPPZBusyFj2pIO/6NVDxrWgbIZq8msd
   g==;
X-CSE-ConnectionGUID: 9vQWBP27SnOEJsmp8ZWBaw==
X-CSE-MsgGUID: FicjRDXbQqeWpkqrqCfIgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="82671797"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="82671797"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 13:15:51 -0700
X-CSE-ConnectionGUID: 8kmrO+GfQJemH6zcQwrQRQ==
X-CSE-MsgGUID: lHCmGmRPQqif7vrg0ouOpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="282737057"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 13:15:49 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH RFC RESEND 3/7] i3c: master: Add helper to query bus wakeup requirements
Date: Wed,  1 Jul 2026 23:15:29 +0300
Message-ID: <20260701201533.220818-4-adrian.hunter@intel.com>
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

Add i3c_master_any_wakeup_enabled(), which iterates over the devices on
an I3C bus and reports whether any of them are enabled for system
wakeup.

Controller drivers can use this helper to determine whether wakeup
support must remain available while the system is suspended.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/i3c/master.c       | 27 +++++++++++++++++++++++++++
 include/linux/i3c/master.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index a36f9b617cbf..979457e635bd 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1957,6 +1957,33 @@ static void i3c_master_reg_work_fn(struct work_struct *work)
 	i3c_bus_normaluse_unlock(&master->bus);
 }
 
+/**
+ * i3c_master_any_wakeup_enabled() - check if any device can wake the system
+ * @master: I3C master controller
+ *
+ * Iterate over devices on the bus and return true if any device has
+ * system wakeup enabled.
+ *
+ * Return: true if any device may wake the system, false otherwise.
+ */
+bool i3c_master_any_wakeup_enabled(struct i3c_master_controller *master)
+{
+	struct i3c_dev_desc *desc;
+	bool wakeup = false;
+
+	i3c_bus_normaluse_lock(&master->bus);
+	i3c_bus_for_each_i3cdev(&master->bus, desc) {
+		if (desc->dev && device_may_wakeup(&desc->dev->dev)) {
+			wakeup = true;
+			break;
+		}
+	}
+	i3c_bus_normaluse_unlock(&master->bus);
+
+	return wakeup;
+}
+EXPORT_SYMBOL_GPL(i3c_master_any_wakeup_enabled);
+
 /**
  * i3c_master_dma_map_single() - Map buffer for single DMA transfer
  * @dev: device object of a device doing DMA
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index af3c35a8e7b6..b9f2d84ac276 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -746,6 +746,7 @@ void i3c_generic_ibi_recycle_slot(struct i3c_generic_ibi_pool *pool,
 				  struct i3c_ibi_slot *slot);
 
 void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot);
+bool i3c_master_any_wakeup_enabled(struct i3c_master_controller *master);
 
 struct i3c_ibi_slot *i3c_master_get_free_ibi_slot(struct i3c_dev_desc *dev);
 
-- 
2.53.0

