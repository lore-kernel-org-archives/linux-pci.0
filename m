Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265B133F588;
	Tue, 28 Jul 2026 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254009; cv=none; b=pYuZHYbhShJGgUN716Xzl9kySOSWeitWZvYdOH9jzQ2qRe2JNYBmtAxsABUaOL7YocLKwRJriMdkItHQWNB/+YR9gBnvyEmwHlljjzLyJ4nOY2/ruedESxeZ31aKv+DfVp3Fvum+dJ0HJJIj++3tH/As1Svyby0l7J6CXXhYzU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254009; c=relaxed/simple;
	bh=Rs3eLDm/z0MDQyS8v2EoxoDJjXfLNNwsxGZf+12I8AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvNG9kX4PPqiQqiTq2cSznECYk7+XgxOSaVPsKdLt7MXvESqOV0EGL8Dem79z/xdtVWiLn8unmFbKL+88uA0k1WQH3VxqZIimVaXzt5Hxs57ulTKvI7t2cUIiYnOzzuMWpvtJQcVumFzobjkTLZaKPRZQdwE6Fz0MjQ5YrHuZog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dovrgIll; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dovrgIll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785254008; x=1816790008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rs3eLDm/z0MDQyS8v2EoxoDJjXfLNNwsxGZf+12I8AU=;
  b=dovrgIllQzZC1+IJVD+b1dTcjK4BsPN2M2aJM1XVSFfDPKqim7U7P9lc
   OYGyCaUf7McmM//eAYDChCkX3H2fiKNeiAJyY94dqpO2guKdis79dIa1N
   Wi1vlkjF5x6C6spIJpVM+POuBiaLlLA1GXf44xQHDYEEyF42vSv7TJExZ
   xqkK2csVBmEWtoC/WWSwg//RiccQ0L2XTEB0IeLS+j+sKugpZ2yAXcw1o
   VaStk/8kVZd2XAJqoJyb/TTOwkLhvYaiwXkvUWtwj7U2c2Eujs+h4hZRx
   UpLSTeJKVafBMgqtEnLLHueV2eoPIZrDX0gP1jVNOC0x13LlOtFS9ZGFw
   Q==;
X-CSE-ConnectionGUID: UzCK04sOShurDSiEMQISlw==
X-CSE-MsgGUID: v0+qoa4fQ9mjxpOJSsiUjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85696577"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85696577"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 08:53:27 -0700
X-CSE-ConnectionGUID: 4SQ7yB0wR32ZjYvt+EYDFw==
X-CSE-MsgGUID: 97EhECoDS9isdhJDyCVbSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="255817524"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.126])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 08:53:24 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V2 3/8] i3c: master: Report wakeup events for IBIs
Date: Tue, 28 Jul 2026 18:53:03 +0300
Message-ID: <20260728155308.142713-4-adrian.hunter@intel.com>
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

An I3C device configured as a wakeup source can wake the system by
generating an In-Band Interrupt (IBI).

When an IBI is queued for processing, record a wakeup event for the
device if wakeup is enabled.  Use a 100 ms processing interval to give
the I3C device driver time to process the IBI.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V2:

	None


 drivers/i3c/master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index cf3345265ac0..9d56ca08569a 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -3085,6 +3085,9 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
 	}
 }
 
+/* Approximate time for IBI handler to run */
+#define I3C_WAKEUP_PROCESSING_TIME_MS 100
+
 /**
  * i3c_master_queue_ibi() - Queue an IBI
  * @dev: the device this IBI is coming from
@@ -3098,6 +3101,9 @@ void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
 	if (!dev->ibi || !slot)
 		return;
 
+	if (device_may_wakeup(&dev->dev->dev))
+		pm_wakeup_event(&dev->dev->dev, I3C_WAKEUP_PROCESSING_TIME_MS);
+
 	atomic_inc(&dev->ibi->pending_ibis);
 	queue_work(dev->ibi->wq, &slot->work);
 }
-- 
2.53.0

