Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037803BFACE;
	Wed,  1 Jul 2026 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936948; cv=none; b=YYIOjmfvn7Z8JV1mDPdtb4TsCxsrog7yY3U8/r5FaDeHoJbuI+KM4l68MP69VrfGJemuk9TwJfyIVAI/DTW9xBeKs0GnhF1+UxF2Njv93n+WH1b65xS3Qy1BjC28PZ34d807v/Z7y0Z0MdUBF4WLN7PtZBrZVwq8B9UQPOUd+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936948; c=relaxed/simple;
	bh=xpKgPGn7FASAl8THDfEQnPWCZu586ywBfc3bGU/xi4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFk/De6yu9GcWn5QFSgzPY8XEOeLB+HBXOaZTMWpxZ1aiKMiKA2xxM0j+zKX/PBInzJFMpPlh1tNBNoC/DXrg7MI0T4sCa7QRvGANrsNWXTBMt15fYmVttWblk9fVZJJ1lWBemZks1G+0EIc5WilroVhDWuaR5usTVNy10OcDS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIIQtiYY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIIQtiYY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782936946; x=1814472946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xpKgPGn7FASAl8THDfEQnPWCZu586ywBfc3bGU/xi4k=;
  b=SIIQtiYYlmKPJeCRS9jRI2ajgYWjQL9NfyZz/s+Mf+g6owLb5oRpK1tl
   jxm8qXwAbNtbxs6qdQFWcqrD4gu82Iz5oJD4OEBH49E+2wKQRf9IsIoIu
   2jntIvjHco6ZH2d5yds0hnSDYhnhu/mYZLviNE0Q5/2ZEHWOgq7XxIL49
   u6Bo8O3oP2ghNSPI+bbmETWOnUIUmGTBWSta1AhaF1uUYNx/AiJS3lHxd
   e7x5Gcx5swt7dqKHHNASNjEwAqeuOLNPdbanyJ54j5LEaYyitv8jwwX9U
   HdZIbxjkm3fcbrpgR8LmcV5YkkElLs/7VSzKMvJh6zpzZUSBjLspA4nfk
   w==;
X-CSE-ConnectionGUID: dUdV3ohsRPu54dMQHR2sdA==
X-CSE-MsgGUID: jt6pVbEBTlCxMVJbvvG/aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="82671784"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="82671784"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 13:15:46 -0700
X-CSE-ConnectionGUID: bztpNFPZRFyTDZ929/440Q==
X-CSE-MsgGUID: +wmrM7/hQ3uKWso7miGTEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="282737047"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 13:15:44 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH RFC RESEND 1/7] i3c: master: Support IBI-based wakeup capability
Date: Wed,  1 Jul 2026 23:15:27 +0300
Message-ID: <20260701201533.220818-2-adrian.hunter@intel.com>
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
---
 drivers/i3c/master.c       | 8 ++++++++
 include/linux/i3c/master.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index f1be38a640ca..a47e2924bb70 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -17,6 +17,7 @@
 #include <linux/list.h>
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeup.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
@@ -1930,6 +1931,13 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 		if (desc->boardinfo)
 			desc->dev->dev.of_node = desc->boardinfo->of_node;
 
+		/*
+		 * In the case of IBI wakeup, any IBI-capable device can
+		 * wakeup.
+		 */
+		if (master->ibi_wakeup && (desc->info.bcr & I3C_BCR_IBI_REQ_CAP))
+			device_set_wakeup_capable(&desc->dev->dev, true);
+
 		ret = device_register(&desc->dev->dev);
 		if (ret) {
 			dev_err(&master->dev,
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 4d2a68793324..af3c35a8e7b6 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -511,6 +511,7 @@ struct i3c_master_controller_ops {
  * @hotjoin: true if the master support hotjoin
  * @rpm_allowed: true if Runtime PM allowed
  * @rpm_ibi_allowed: true if IBI and Hot-Join allowed while runtime suspended
+ * @ibi_wakeup: IBI can wakeup the system
  * @shutting_down: set to true when master begins shutdown or unregister
  * @boardinfo.i3c: list of I3C  boardinfo objects
  * @boardinfo.i2c: list of I2C boardinfo objects
@@ -545,6 +546,7 @@ struct i3c_master_controller {
 	unsigned int hotjoin: 1;
 	unsigned int rpm_allowed: 1;
 	unsigned int rpm_ibi_allowed: 1;
+	unsigned int ibi_wakeup: 1;
 	bool shutting_down;
 	struct {
 		struct list_head i3c;
-- 
2.53.0

