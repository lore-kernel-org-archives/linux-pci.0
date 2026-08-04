Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D74C46C4AE;
	Tue,  4 Aug 2026 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850725; cv=none; b=rmQeEAtnEYs5pjj1I33v7oxumMVl4VltORdT5bop3En23CIZgqBdJzN2y+rpaMcqG9813sOJwm1XHeWB0bPFquQEvrHMsIHvOb5CEgLopzAxf/QM+5qjMI/zmyAqBGtHHPTyxySOGS0uJ9MC0Wq5dtBDjktXpSN6ChuxNZSo+Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850725; c=relaxed/simple;
	bh=UaMLbZ0IzXimDx+Nc2/VUT4yVPyc/sRZ6Ky7fCkM2UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwXaqXlPt2iMNttI3maskN4u6DKkFmHES9nERLXS4kYU21jw+bpaXY3+sjwQ6sVYje3Ggw1iiaM6mN7fTvTcn8kqbfmgFAoTQe1J/7bApa59IcjeebZzF2k7tzd26z3dSp0iiH/npnCwZYVieNKkM6cijWIcwLLLWlq5dvrh4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elWlTu7D; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elWlTu7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785850725; x=1817386725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UaMLbZ0IzXimDx+Nc2/VUT4yVPyc/sRZ6Ky7fCkM2UA=;
  b=elWlTu7DqSKrIBruryIugTuxD0HVOz6klVQjz7sv0mdZqz2nmdylzOn0
   MleS+ow2B4c5r2CKd/dzZJEG9mG2jWgxgCyGD4s/I68KD5T3mbZa+NgeW
   W8fuKZGPQOh6H0BvpIu58WuUAgR2wcZgbAnXpPjRp3tSkOEP0m0a9W1BG
   UfE2Q7GUwPpumI1hwPGyaQfrUhCrnzi/awGBsDnrXc4RUTyFbU6pdjgC+
   0TnSj73qm3w1OGCCzQ9LLddJcMByWxn7vNWLPFUO7g28kZi13gHDLoeY6
   2kTWkfbzPkxALBj9sqkn1UPyBMOP5NGYXs+p8w9KhLxG8MsF2fcv28/Ke
   w==;
X-CSE-ConnectionGUID: GutXkr/NS+ibP2sakxbv1A==
X-CSE-MsgGUID: +M8oM0eMTXuOh/CccoQeRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86410149"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86410149"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:44 -0700
X-CSE-ConnectionGUID: wQ3+E0FYQy+92Wey6uHwCA==
X-CSE-MsgGUID: 7ppwyp02T+S1JLi9peccvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="263501033"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.132])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:42 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	akhilrajeev@nvidia.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V3 09/14] i3c: master: Report wakeup events for IBIs
Date: Tue,  4 Aug 2026 16:38:05 +0300
Message-ID: <20260804133810.184905-10-adrian.hunter@intel.com>
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

An I3C device configured as a wakeup source can wake the system by
generating an In-Band Interrupt (IBI).

When an IBI is queued for processing, record a wakeup event for the
device if wakeup is enabled.  Use a 100 ms processing interval to give
the I3C device driver time to process the IBI.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V2 and V3:

	None


 drivers/i3c/master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index e6b320da475e..8c9e62e6f146 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -3385,6 +3385,9 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
 	}
 }
 
+/* Approximate time for IBI handler to run */
+#define I3C_WAKEUP_PROCESSING_TIME_MS 100
+
 /**
  * i3c_master_queue_ibi() - Queue an IBI
  * @dev: the device this IBI is coming from
@@ -3398,6 +3401,9 @@ void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
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

