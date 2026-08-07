Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348354749EF;
	Fri,  7 Aug 2026 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114661; cv=none; b=V+EvYzsAc29CEzEJs8n+rNfB6++Xw7yMKiG90RxB5yT25aZAlTARU54dlcAl9NAJDSV5xeuNHU5D68p8pqTLsLE+traREmnz+o2J2Q0VDwu6LWFb80KjpKfYip9dKYL9zWq17ueiRji92bKcW1HeLnV7UZAxJZbM6u2JN00h2jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114661; c=relaxed/simple;
	bh=3YumbivJ97gedr33UQLGzZZ9HmKGhUq7z+4nWTxukeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBBx/7hiyeookdKdazALYoKGBYvwVXOJlsC5cLMT4vKwlix2wrn/tWsZ0a01KNcIJdIIOUtAfuKxf9gf6l01r6sQqkPpuAlByDb9ykBtsjtQpURoLXEev+8Rei8MXrIkm3g6bmbsltQhrt+tNFWurCMyxrZ/lyt5c2xx0HEE9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VO3YoW5D; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VO3YoW5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786114660; x=1817650660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3YumbivJ97gedr33UQLGzZZ9HmKGhUq7z+4nWTxukeo=;
  b=VO3YoW5DtORaAga4DynmrNayK+fmn+ZtboGXMOa9YREg/Oz6LEVF46qb
   /es5ZC7F2Ckx4O0x5RvpAkd5t/H7rjbY46rIKNijq1+Dik2uHS1MO/y9h
   M0jxnTQPimNM6A1T7WG/eIRghc/ELhIq6080wqezLNBHUVV4DuyNeUYx7
   xBO90EPKD7PeDSkPGnMZO2DalQkrD7WiZ9e9mqrt2JA7x4y7tGmcVouHt
   BUOWZztMrcM3dppk8JHrXP7AQS/6B0hWvT8SuSuAv96gETqnhZA5Ym55m
   YKnM1zCe8JdyO0gtgyfrLq+0/T2fASihEkJB8Aly44ihMFIu+fswOVpIv
   A==;
X-CSE-ConnectionGUID: R3Pb47Q4RgCxntZsYBO+MA==
X-CSE-MsgGUID: z4tvnLkHRfSzuVPNRfTT4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86485239"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86485239"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:40 -0700
X-CSE-ConnectionGUID: 4fbKvVegQLK4jH6l8hSZMg==
X-CSE-MsgGUID: Vz6NQqQ5Sl2PQMy0eTRKJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="259809938"
Received: from amilburn-desk.amilburn-desk (HELO ahunter6-desk) ([10.245.245.114])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:08 -0700
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
Subject: [PATCH V5 08/14] i3c: master: Support IBI-based wakeup capability
Date: Fri,  7 Aug 2026 17:56:32 +0300
Message-ID: <20260807145638.168865-9-adrian.hunter@intel.com>
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

An I3C controller acts as a bus controller for one or more I3C devices.
If the controller can wake the system in response to an In-Band
Interrupt (IBI), then any device on that bus that is capable of
generating IBIs can potentially be used as a wakeup source.

Add an ibi_wakeup flag to struct i3c_master_controller so controller
drivers can advertise support for IBI-based wakeup.

If set, mark IBI-capable I3C devices as wakeup capable when they are
registered, allowing wakeup management through the standard device
wakeup framework.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
---


Changes in V5:

	Added Mukesh's Ack'd-by

Changes in V4:

	Shortened the comment about IBI-capable devices being wakeup
	capable.

Changes in V3:

	None

Changes in V2:

	Dropped the redundant #include <linux/pm_wakeup.h>.  That header
	must not be included directly, and linux/device.h, which is
	already included, provides device_set_wakeup_capable().


 drivers/i3c/master.c       | 4 ++++
 include/linux/i3c/master.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 83e04a2c202a..2616354dbe54 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2110,6 +2110,10 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 		if (desc->boardinfo)
 			device_set_node(&desc->dev->dev, desc->boardinfo->fwnode);
 
+		/* If the device has IBI capability, set as wakeup capable */
+		if (master->ibi_wakeup && (desc->info.bcr & I3C_BCR_IBI_REQ_CAP))
+			device_set_wakeup_capable(&desc->dev->dev, true);
+
 		list_add_tail(&desc->dev->node, &i3c_unreg_devs);
 	}
 
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 26535beb1e77..9d675d01522c 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -524,6 +524,7 @@ struct i3c_master_controller_ops {
  * @hotjoin: true if the master support hotjoin
  * @rpm_allowed: true if Runtime PM allowed
  * @rpm_ibi_allowed: true if IBI and Hot-Join allowed while runtime suspended
+ * @ibi_wakeup: IBI can wakeup the system
  * @shutting_down: set to true when master begins shutdown or unregister
  * @boardinfo.i3c: list of I3C  boardinfo objects
  * @boardinfo.i2c: list of I2C boardinfo objects
@@ -563,6 +564,7 @@ struct i3c_master_controller {
 	unsigned int hotjoin: 1;
 	unsigned int rpm_allowed: 1;
 	unsigned int rpm_ibi_allowed: 1;
+	unsigned int ibi_wakeup: 1;
 	bool shutting_down;
 	struct {
 		struct list_head i3c;
-- 
2.53.0

