Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF7463B85;
	Tue,  4 Aug 2026 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850709; cv=none; b=kLsiwguPDoBBSbVp4CcuyN9ipZ42qc6hTlXzYUaqweuM33QqTNvSLJa5PwrFvL3QX+7zOObWPAi9uMefwEyo3MXWZalhoyBZGHFIQpwnNSyfi4iFuaSQeBXy0oyidPfsC42TNkbsEevYLvgldbHItrv8c0gBk2uGt3GpsaQz+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850709; c=relaxed/simple;
	bh=RQeEDqRk73Kz1GwqhHPaFFYNyEP5mCXJwPZqp7MEZHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnZo5U2VKXVsTnkEaZYFP7q+9ibrb2oIKsXS5w26wJH4ZlHw1RkCAWRyNZ31MkNdFL0Z3qSLmP9kaoyz/kQe1TlOhmL60vPyyVbwTEzqMK+6w9LJxKHiCylLg7t3RJSzDf6y/c0oJ37Czhh5jKkXTDvv1NXi9QfiwEYkrRLJfw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+9IxMc/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+9IxMc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785850706; x=1817386706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RQeEDqRk73Kz1GwqhHPaFFYNyEP5mCXJwPZqp7MEZHA=;
  b=S+9IxMc/A/yvKt06gq7SLo3ys65k7uPw5PvpbmjFehcARiZasT5OEBkG
   1xbAIMVZJSO02+wtxR1CyBQGWPq6/vlcSI2Hb81T8FtvvqSaFS1/0fUgs
   deDvJbzRQvLLsoDIw1SeFhQqgcW/aN1qTMO6Rb2AsL2rKUFJ71Sscit/q
   GKL2t6QkbptaXqnnuGkxXQ7EDCVhFfrV6SjfRwxiTPpzbtW+IQyESoSrA
   sLIGL0FW+ni3m1AYWxIBeldYs/KRsDyTQ9YU97HqLwv9aoSXwREPJD/9k
   NzhaQU3Nb7zrOOLpzpperUHtGmIHeuteh83XfGjCU2Kg/ZEALMvN44yTZ
   g==;
X-CSE-ConnectionGUID: cBY1GeqQSb2DPFk9lK+8ew==
X-CSE-MsgGUID: tygP1DWbTsS4rcfvt9kWhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86410091"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86410091"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:26 -0700
X-CSE-ConnectionGUID: cagky/0kTdWYLuQXSv/GIQ==
X-CSE-MsgGUID: tBEA6V9hRsWhpmv1NdF7kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="263501004"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.132])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:24 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	akhilrajeev@nvidia.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V3 02/14] i3c: Fix unlocked dereference of dev->desc in i3c_device_get_supported_xfer_mode()
Date: Tue,  4 Aug 2026 16:37:58 +0300
Message-ID: <20260804133810.184905-3-adrian.hunter@intel.com>
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

i3c_device_get_supported_xfer_mode() uses dev->desc to obtain the
master controller.  However, dev->desc must not be dereferenced unless
bus->lock is held, and this function does not take that lock.

The function only needs access to the master controller associated with
the device's bus.  Use dev->bus instead, which is always valid for the
lifetime of the device and does not require dereferencing dev->desc.

Fixes: 256a21743d91 ("i3c: Add HDR API support")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V3:

	New patch


 drivers/i3c/device.c    | 2 +-
 drivers/i3c/internals.h | 5 +++++
 drivers/i3c/master.c    | 6 ------
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 101eaa77de68..a3778282e84c 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -309,7 +309,7 @@ EXPORT_SYMBOL_GPL(i3c_device_match_id);
  */
 u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev)
 {
-	return i3c_dev_get_master(dev->desc)->this->info.hdr_cap | BIT(I3C_SDR);
+	return i3c_bus_to_i3c_master(dev->bus)->this->info.hdr_cap | BIT(I3C_SDR);
 }
 EXPORT_SYMBOL_GPL(i3c_device_get_supported_xfer_mode);
 
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 0f1f3f766623..86a36b951e0d 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -72,4 +72,9 @@ static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
 	}
 }
 
+static inline struct i3c_master_controller *i3c_bus_to_i3c_master(struct i3c_bus *i3cbus)
+{
+	return container_of(i3cbus, struct i3c_master_controller, bus);
+}
+
 #endif /* I3C_INTERNAL_H */
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index d2fb1a110521..c7bb52b71d88 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -102,12 +102,6 @@ void i3c_bus_normaluse_unlock(struct i3c_bus *bus)
 	up_read(&bus->lock);
 }
 
-static struct i3c_master_controller *
-i3c_bus_to_i3c_master(struct i3c_bus *i3cbus)
-{
-	return container_of(i3cbus, struct i3c_master_controller, bus);
-}
-
 static struct i3c_master_controller *dev_to_i3cmaster(struct device *dev)
 {
 	return container_of(dev, struct i3c_master_controller, dev);
-- 
2.53.0

