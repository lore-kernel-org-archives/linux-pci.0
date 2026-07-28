Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1BE33F58D;
	Tue, 28 Jul 2026 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254011; cv=none; b=RYYoQ2csHeD/NYemL2qwG1wpXkPncy3SDgXsFZQfC+/x73xS/C5doIEW4mo0fP2DUpkRmQmPfhBdgYlSf4H7xiAPVdAB5LrIqyDCFsasSicjEMUYdGdgE7t5MvYY57yZM/kZEBU8IEj8E5/GZGuauO1Bx2bKIUiQn8USEBYfEdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254011; c=relaxed/simple;
	bh=U//LNM0JF380/UWtxZO62C4GqoySdCbLHUzAYHrU9Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1rwb4RRiEh8MLdTSO1Y2dxwTozFXi9vig+cxq1hBfPpRWbTnR743CbRTasJq4OeWDhgh8dxg5xjDEejPN/I65L4CVAYkBFVfFqdvXUUt0OqC62nIOqtREhtBVy1OWQhiVyVoM1QpktY+6fdvw1nPpdkWYXc3XAtQMjcG1xuYDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eno3NKeg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eno3NKeg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785254009; x=1816790009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U//LNM0JF380/UWtxZO62C4GqoySdCbLHUzAYHrU9Ww=;
  b=eno3NKegJfnQKP7QmyM28heg+Vny3dILsmE5hEt5ihi/Eo8uORGR8ZeP
   K2HipkNi/Ze8T+0yglfP0/2wgeL1Cxuk6eRdEKKppcmA/0eeMRL0ehDh0
   TO0Sh10xKRQ8XcMWnRQvRGnmlkWUt6AQjsJQsXHatxaNVZpCvoghN/3Ve
   I2Y9JY+fR7iXbsELKgTFUv/YEYzorIn/s2ABnXQh3EZ8GA5utPzZBv/KV
   97AgNyBniCRSxG4Cf0jFoLNxxRsTE8z+uQvc3wT+O6c6fnBG+ItCf1xIG
   poHv8YDIWAC+FGTA+6CayqLvpoc8Z8OMCP7pFRRR5LthzrN8snLwA2zoO
   g==;
X-CSE-ConnectionGUID: TgmLQQJzTqemSLbXZupULQ==
X-CSE-MsgGUID: MOrf5fZNSjmRvMhaVZPfXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85696624"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85696624"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 08:53:29 -0700
X-CSE-ConnectionGUID: FJ/ciscGRV+GkvAN9yIR7Q==
X-CSE-MsgGUID: DSommHvKT62yYTSCInOmtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="255817568"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.126])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 08:53:27 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V2 4/8] i3c: master: Add helper to query bus wakeup requirements
Date: Tue, 28 Jul 2026 18:53:04 +0300
Message-ID: <20260728155308.142713-5-adrian.hunter@intel.com>
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

Add i3c_master_any_wakeup_enabled(), which iterates over the devices on
an I3C bus and reports whether any of them are enabled for system
wakeup and have IBI enabled.

Controller drivers can use this helper to determine whether wakeup
support must remain available while the system is suspended.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V2:

	i3c_master_any_wakeup_enabled() now also requires the device to
	have IBI enabled, not just system wakeup enabled, so that a
	device with no active IBI request does not keep PCI PME enabled.
	desc->ibi_lock is taken while checking.  The commit message and
	kernel-doc are updated to match.


 drivers/i3c/master.c       | 30 ++++++++++++++++++++++++++++++
 include/linux/i3c/master.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 9d56ca08569a..dd49652425b4 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2048,6 +2048,36 @@ static void i3c_master_reg_work_fn(struct work_struct *work)
 	i3c_master_register_new_i3c_devs(master);
 }
 
+/**
+ * i3c_master_any_wakeup_enabled() - check if any device can wake the system
+ * @master: I3C master controller
+ *
+ * Iterate over devices on the bus and return true if any device has
+ * system wakeup enabled and IBI enabled.
+ *
+ * Return: true if any device may wake the system via IBI, false otherwise.
+ */
+bool i3c_master_any_wakeup_enabled(struct i3c_master_controller *master)
+{
+	struct i3c_dev_desc *desc;
+	bool wakeup = false;
+
+	i3c_bus_normaluse_lock(&master->bus);
+	i3c_bus_for_each_i3cdev(&master->bus, desc) {
+		if (!desc->dev || !device_may_wakeup(&desc->dev->dev))
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
+EXPORT_SYMBOL_GPL(i3c_master_any_wakeup_enabled);
+
 /**
  * i3c_master_dma_map_single() - Map buffer for single DMA transfer
  * @dev: device object of a device doing DMA
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 99f89fef7653..d8cdc7ff2459 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -748,6 +748,7 @@ void i3c_generic_ibi_recycle_slot(struct i3c_generic_ibi_pool *pool,
 				  struct i3c_ibi_slot *slot);
 
 void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot);
+bool i3c_master_any_wakeup_enabled(struct i3c_master_controller *master);
 
 struct i3c_ibi_slot *i3c_master_get_free_ibi_slot(struct i3c_dev_desc *dev);
 
-- 
2.53.0

