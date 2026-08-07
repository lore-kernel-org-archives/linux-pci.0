Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4129C43B3DE;
	Fri,  7 Aug 2026 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114663; cv=none; b=HiseHGNGpsnvOje9Y4dPDjTfdamKFALTg1xcVk+VkJ/MBmZYpB74ecGNgkSWzHAhB2yLSnci0IppF/DZSoQj3wOSKGJeqSyWF2yyL8z17XZaLIG1Gv0Qv02tXiNWVqwStP3NUcm1zeU/Y9kUz01P3bnTdYg4VfPSlYIWBjDd1M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114663; c=relaxed/simple;
	bh=HMfkNYlkMl4nYVHY/HGi+CKtxHkiK63zKh72UBnUWHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIQxRf6pqtTasbb4Nzq/1n1KpRHBKLDUCS2PhIAx83ANLkwIr/7P2pqDvqG8npgM2TsltYY+L3dvZWFwM5hEROqZGNXLvbIZxNpzGo1MPcXBg5z4HE/42QjTMl5dRekameqmdqSOpkUV2TPmSEaqsBPVwfFKcYjiLfyfMZdrZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yp27lzE7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yp27lzE7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786114661; x=1817650661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HMfkNYlkMl4nYVHY/HGi+CKtxHkiK63zKh72UBnUWHg=;
  b=Yp27lzE7siGlmxBh7fjuA25QFQMLNEOLOpiA9IpQDHSHonbVPq12bbxb
   aQNXba3MyXenT2FZ9qN8F67yTZ22+qL7FqIBLjnL26iMWdfY4T2LkP+Km
   K/X1cJQ5352Um6yzEuIeXtE+rMnoEjc7KRKy7WURzjTWWzqMSjrddeswW
   ms7pQtNWfTPCJailkyVDR6jZ2FCrv6V2gfy9b5Fm/KOLY7wASlBCa2t/E
   EBoUYM4PBA4/kbcCO8AmNvi4dxyQlul4bGV5u7M16rZtQICYtTTQrDKqG
   CB2wij3rLFR+n9C/PT/Rgo1qFWil44enyfTnwrxh7tLeWp3tBAT4YKSc0
   w==;
X-CSE-ConnectionGUID: Io9nFzhQQRa6dt0bAPWK3g==
X-CSE-MsgGUID: QkqV80zUS7iYlcmG6tL7uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86485264"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86485264"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:40 -0700
X-CSE-ConnectionGUID: M5a2VntuQ8+qmc8ar+QlJA==
X-CSE-MsgGUID: rZAJ2+MZT0esXdwK98x56w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="259809945"
Received: from amilburn-desk.amilburn-desk (HELO ahunter6-desk) ([10.245.245.114])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:14 -0700
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
Subject: [PATCH V5 10/14] i3c: master: Add helper to query bus wakeup requirements
Date: Fri,  7 Aug 2026 17:56:34 +0300
Message-ID: <20260807145638.168865-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807145638.168865-1-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by : Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
---


Changes in V5:

	Added Frank's Rev'd-by
	Added Mukesh's Ack'd-by

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

