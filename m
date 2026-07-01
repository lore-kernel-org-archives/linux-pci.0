Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06EC3C09F2;
	Wed,  1 Jul 2026 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936950; cv=none; b=HXUKV/B8EHLavH4MvHOM5PjynhBXw6sTVoF+smGGhRZxtPA2EgdqDPs1RxdmMXj9lFInOjYWibEMnIn+CWMd9WBZAxCCRPDR3V7WrmqvLe3CMh56WwRXeF1VLC/O1w1uP4XvzuiXPp1AcDqK1uD4cblreqgcx+xteiJPbqcK7d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936950; c=relaxed/simple;
	bh=fUJQmeO30dZmNsYhdWgV/Cb07B9pDkcedp1zvYifsZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/EhGwo3F1/DTynQEY1LkD0tSduOnlkuPucvhtNCwpWDy6j5lWajYxtG9XKdc+pwuvzmH5FCJSJy6kaP+zRR8aD0sDXTQFN4S/Uvlce35yVN2eNig0fomVg/sU7Xp+x0eO/adc0GMQOp/WnpnDObEMtT8x0D11MSvusmoo/iK+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QztX+sS1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QztX+sS1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782936949; x=1814472949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fUJQmeO30dZmNsYhdWgV/Cb07B9pDkcedp1zvYifsZg=;
  b=QztX+sS1ycXG316grWt4EIdkCyGrpMGDGYMvJtqiIsr+X8Zl0a3e3h14
   wFa1uFC3ljqzpBVKj3ldlfbH4CYZCvOfF73bfUUANbFg1H/7YPyoUuPYe
   sjdaIKMcNA8mxN8vFGfFrpZqUIhqGJVuUupjeAycQjnu9p810CwCGVx+j
   g0Rb6I7KRtZY2azZOVoCbLS+9ZK6bZwiKygZ2Llf0V8qhkDopBtkI7IAj
   17mNU/O4O3/5w8x/slhLBnFB8XupMtsrJmFnuKCtSM4esrzhEIuxEjdNM
   SNXuU9pnzNgKEcOrFpvtmRJH61Ez4dw9V6zkcqJC3sQ1BTyMYvWIMF33/
   w==;
X-CSE-ConnectionGUID: yaSU8tpNSsi5t8VErsZGyA==
X-CSE-MsgGUID: UwDdbxhLSC+cIWIOdZt6bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="82671789"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="82671789"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 13:15:48 -0700
X-CSE-ConnectionGUID: EMboBcFmTP2KZKekYgsSDA==
X-CSE-MsgGUID: U9dQtbuORxuGn5dDFu35XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="282737053"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 13:15:46 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH RFC RESEND 2/7] i3c: master: Report wakeup events for IBIs
Date: Wed,  1 Jul 2026 23:15:28 +0300
Message-ID: <20260701201533.220818-3-adrian.hunter@intel.com>
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

An I3C device configured as a wakeup source can wake the system by
generating an In-Band Interrupt (IBI).

When an IBI is queued for processing, record a wakeup event for the
device if wakeup is enabled.  Use a 100 ms processing interval to give
the I3C device driver time to process the IBI.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/i3c/master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index a47e2924bb70..a36f9b617cbf 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2994,6 +2994,9 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
 	}
 }
 
+/* Approximate time for IBI handler to run */
+#define I3C_WAKEUP_PROCESSING_TIME_MS 100
+
 /**
  * i3c_master_queue_ibi() - Queue an IBI
  * @dev: the device this IBI is coming from
@@ -3007,6 +3010,9 @@ void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
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

