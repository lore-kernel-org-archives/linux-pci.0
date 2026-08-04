Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2066C46C831;
	Tue,  4 Aug 2026 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850729; cv=none; b=VqmpF72RgDV99yJQ/g90fLjjMHcNTqEULLigIJ7kXbRReGagta5V4JTXAOOlML4tv4YiObeN7KVbCF8S2nuu59W0UuU6vk45e5STeKqj01+1H7DnSbODV4wW0QPihqMJQ/kecRht21W3SQb0uPc6atB22bzCt0lF6q/Sz/lL5L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850729; c=relaxed/simple;
	bh=epDNLfNxo0HhdOoHHk2SD/KTa8Th+00oBB7qdIaaf4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMqJNRQVPfey9/6X/6vNvW/1psWl68KSeZ1Lp7Zvf2LbqKBoSCbe6rqJFwjOR8VPFylS5UwtRqaDmWSwU3VKdp1DqV1v6X+/yxLzEQpcXqPhSvV1wm+dCpbz4zmFrr1Ot3wBerAWQnBTYOGtCfA9PD+Fy5wTZdjELgfiWugc0hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpihDY0T; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpihDY0T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785850727; x=1817386727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=epDNLfNxo0HhdOoHHk2SD/KTa8Th+00oBB7qdIaaf4Q=;
  b=VpihDY0TbatEL5tJkTqsbvmKiuSRA84kmXQVej0SXymK7D1UMSX1z3tA
   3Qsq27ShqHOWGqtOnzup/h/KB83J6nyjSTuJv05qrCNu2yZKvhLlg+IzX
   hjACh3lQcQYwcsHSiQMh/DEKSyhqkqem+TdevpgEYa3AOBXL00BFwGVPd
   +cl0+5Dqa/Lzd5WnPCF4zLsFHvWqcBYXaDJZJ8zxtQUkGftt6tU0QDPgM
   Yp947xmTVq73Kl/LS2RDJQE60MefNr3sdZA0L1ZpehtsA2wsbptNxyHSx
   r52ARGk2J0TrHnQonfY0uY6md/1/Zju/RlxsvGcLziO6oxUZ1ZSgl9jy8
   Q==;
X-CSE-ConnectionGUID: B3Xv6gVRRmGbYOq/w8hWZg==
X-CSE-MsgGUID: V745IWAmTceQPMozg2COFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86410158"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86410158"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:47 -0700
X-CSE-ConnectionGUID: NnwHN2WpR96FBui+4ERNbg==
X-CSE-MsgGUID: fkVMsxPQSNWLVdnGMMFWBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="263501038"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.132])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:44 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	akhilrajeev@nvidia.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V3 10/14] i3c: master: Add helper to query bus wakeup requirements
Date: Tue,  4 Aug 2026 16:38:06 +0300
Message-ID: <20260804133810.184905-11-adrian.hunter@intel.com>
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

Add i3c_master_any_wakeup_enabled(), which iterates over the devices on
an I3C bus and reports whether any of them are enabled for system
wakeup and have IBI enabled.

Controller drivers can use this helper to determine whether wakeup
support must remain available while the system is suspended.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


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
index 8c9e62e6f146..baf4769f0512 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2150,6 +2150,41 @@ static void i3c_master_reg_work_fn(struct work_struct *work)
 	i3c_master_register_new_i3c_devs(master);
 }
 
+/**
+ * i3c_master_any_wakeup_enabled() - check if any device can wake the system
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
+bool i3c_master_any_wakeup_enabled(struct i3c_master_controller *master)
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
+EXPORT_SYMBOL_GPL(i3c_master_any_wakeup_enabled);
+
 /**
  * i3c_master_dma_map_single() - Map buffer for single DMA transfer
  * @dev: device object of a device doing DMA
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 16394aca7230..a579a2b3feeb 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -764,6 +764,7 @@ void i3c_generic_ibi_recycle_slot(struct i3c_generic_ibi_pool *pool,
 				  struct i3c_ibi_slot *slot);
 
 void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot);
+bool i3c_master_any_wakeup_enabled(struct i3c_master_controller *master);
 
 struct i3c_ibi_slot *i3c_master_get_free_ibi_slot(struct i3c_dev_desc *dev);
 
-- 
2.53.0

