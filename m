Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CB5381E88;
	Thu,  6 Aug 2026 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022388; cv=none; b=ZJGq2LQifdX6RyXOoOyiJ3ZvTjFySer90KL2TO3hz6y51ib9qaLYX9nowVKNGmjmttOFhvgK+pR0ylEUZufKX/ECOXfvSSdlb90100N4WVU/0GNhJNPhtvOVCuW5Ns4RhK0RC0ygzS7XeOCNIvh3b7nUVf6+vX91SAdg6po+0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022388; c=relaxed/simple;
	bh=EtxnJOm3NSmACaS/tiOPyFKADy79NbBD5bCrwvIqOZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fO/Nx45oj6x6WiDCoMIcMFu0AmNuKZd7KDzfn2f2AwFg/74Ug9UsKy0yRDd/miDyMQitXQ4wxU4YIzu6DZzWF1ykkwvzAkFB3nLsgNLy4vLH9RV3yJepwWSYQCyn6dMcxy45zv8RxIgcx2cGlE9HMPWm8xDbp8w7qCtLEAuYrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SVcH2Mix; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVcH2Mix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786022383; x=1817558383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EtxnJOm3NSmACaS/tiOPyFKADy79NbBD5bCrwvIqOZU=;
  b=SVcH2MixhlXgCewfACueeafwx57vmwrAFIkJYlkjpOla4rrL+ecZwVJg
   GKdbRMAT8rcvVrIRLUsWjgd/pHJx70dTOswEpXAltxrn+uZa1WHtchygP
   tGvgwHFJBYiMcbNhmPT1mpQAsPSkG6LvjnPaC+o+ZS2YvbRAtoafPo6sK
   Xa0bmMzoa6UYWgeM/4IZs60RX705aqO6UT/Ga1+Hp8lgj5XJxuQbQOJ4U
   proHkqwwdyviHXOY4V6p8+UPW8x4M2B1d0qN5Tjxvozesac9GOr62Db5K
   eWmXwKRsgS6rWUHWpKcJqAuecAGqgQ7mB2yWPdrcpjNbmXxXtoovr/OYs
   w==;
X-CSE-ConnectionGUID: luHJPCLsTrebu+m9AfpTUg==
X-CSE-MsgGUID: Sw0ZFnzvRJKWI7w7jL5xbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74149622"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="74149622"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:37 -0700
X-CSE-ConnectionGUID: MHq4+90MSm6Hln4i+ou1gA==
X-CSE-MsgGUID: DhgyIspyRsmuZLe3Jlw7vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="260338248"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:35 -0700
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
Subject: [PATCH V4 10/14] i3c: master: Add helper to query bus wakeup requirements
Date: Thu,  6 Aug 2026 16:18:53 +0300
Message-ID: <20260806131857.119830-11-adrian.hunter@intel.com>
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

Add i3c_master_has_wakeup_enabled_devs(), which iterates over the devices
on an I3C bus and reports whether any of them are enabled for system
wakeup and have IBI enabled.

Controller drivers can use this helper to determine whether wakeup
support must remain available while the system is suspended.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V4:

	Renamed i3c_master_any_wakeup_enabled() to
	i3c_master_has_wakeup_enabled_devs().

Changes in V3:

	Skip the master device explicitly.  Added kernel-doc noting
	that wakeup enablement is user space policy, so the helper is
	meant to be called from a system suspend callback.

Changes in V2:

	i3c_master_any_wakeup_enabled() now also requires the device to
	have IBI enabled, not just system wakeup enabled, so that a
	device with no active IBI request does not keep PCI PME enabled.
	desc->ibi_lock is taken while checking.  The commit message and
	kernel-doc are updated to match.


 drivers/i3c/master.c       | 35 +++++++++++++++++++++++++++++++++++
 include/linux/i3c/master.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 6c5341491944..afcd7a21a3e6 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2147,6 +2147,41 @@ static void i3c_master_reg_work_fn(struct work_struct *work)
 	i3c_master_register_new_i3c_devs(master);
 }
 
+/**
+ * i3c_master_has_wakeup_enabled_devs() - check if any device can wake the system
+ * @master: I3C master controller
+ *
+ * Iterate over devices on the bus and return true if any device has
+ * system wakeup enabled and IBI enabled.
+ *
+ * Whether a device is enabled for system wakeup is user space policy,
+ * settable at any time through the device's power/wakeup sysfs attribute,
+ * so the answer is only stable once user space is frozen.  Call this from
+ * a system suspend callback.
+ *
+ * Return: true if any device may wake the system via IBI, false otherwise.
+ */
+bool i3c_master_has_wakeup_enabled_devs(struct i3c_master_controller *master)
+{
+	struct i3c_dev_desc *desc;
+	bool wakeup = false;
+
+	i3c_bus_normaluse_lock(&master->bus);
+	i3c_bus_for_each_i3cdev(&master->bus, desc) {
+		if (!desc->dev || desc == master->this || !device_may_wakeup(&desc->dev->dev))
+			continue;
+		guard(mutex)(&desc->ibi_lock);
+		if (desc->ibi && desc->ibi->enabled) {
+			wakeup = true;
+			break;
+		}
+	}
+	i3c_bus_normaluse_unlock(&master->bus);
+
+	return wakeup;
+}
+EXPORT_SYMBOL_GPL(i3c_master_has_wakeup_enabled_devs);
+
 /**
  * i3c_master_dma_map_single() - Map buffer for single DMA transfer
  * @dev: device object of a device doing DMA
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 9d675d01522c..82d9886e7f12 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -765,6 +765,7 @@ void i3c_generic_ibi_recycle_slot(struct i3c_generic_ibi_pool *pool,
 				  struct i3c_ibi_slot *slot);
 
 void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot);
+bool i3c_master_has_wakeup_enabled_devs(struct i3c_master_controller *master);
 
 struct i3c_ibi_slot *i3c_master_get_free_ibi_slot(struct i3c_dev_desc *dev);
 
-- 
2.53.0

