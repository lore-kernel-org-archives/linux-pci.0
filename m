Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8084A45D186;
	Tue, 28 Jul 2026 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254014; cv=none; b=BS1YEuPD27Xc+CqQFsAzIQxLpDaVexR2/KyoiQni1P/tZr2KKK4EACapGsXKxEGpT3PhFM8q4iwZxDKAF7GeXIba53mvMylOHQ/a5IW2vRl1n6bfVTSihVeSH7a63avOO+UOdQ/ZOTUZPA8PGLqsQXpcUZsBeciB7fU/w/m5hNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254014; c=relaxed/simple;
	bh=GyQHeubSRZqQQ2yo6w+X4EKYG7SA6gkZFStluoIGdZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhPIWPgKwwGnQXdNNJJsmK2jbNolFXFHB4axejnmDCqVN+IcyIjWxCspSR7pb0JhNc3esmpTRqy7vUWv1QJc7sl1cBqrg6R+sTiRFeGdbt/63cdiqkE34DqjqkKstAe/urexWxbskQDCdRm4LlXOP3ng+eUxdwMRIM+mdLGpi0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mF4rzCEp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mF4rzCEp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785254012; x=1816790012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GyQHeubSRZqQQ2yo6w+X4EKYG7SA6gkZFStluoIGdZo=;
  b=mF4rzCEp0dubWiH3rRvOryXFDe7tfQpAfH8HHHEGeu9SiDtteOAdS4UH
   QxqcqGm0grfeREJ6bni0ynb63gqKPLb8HCRS2V5Cnk2tPBKbA5RNNlqzS
   dJrdA5L+C46igxg4ju8GQ0AebTBgkk3qHayoBVXUFpW0UcRK7EZKj7/BW
   Fr334IwpH11EHCZpatalgvFwqB35kJEVP9Nyc4MhO/CS3UNoDjna+RwyR
   WNTB+29hUg2+OoaOxH7n+Nm69ajkbHJ9KR8jUgmJztiMS569QS6mveQ6G
   LTT7oaJzjmjlz0N946PW3zuBUK7ioPFb0FWD2VUpXbyWJy6nvRgUJRFMa
   A==;
X-CSE-ConnectionGUID: k041EntoSHWGIXbTAnXWxQ==
X-CSE-MsgGUID: YJ9/2xVIRjqpvHVP6bBJUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85696674"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85696674"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 08:53:31 -0700
X-CSE-ConnectionGUID: VLg11lL0TA2RDGulLAa/WQ==
X-CSE-MsgGUID: 3i051EavRmaRr85RZlfRrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="255817615"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.126])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 08:53:29 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V2 5/8] i3c: master: Reject IBI requests from non-IBI-capable devices
Date: Tue, 28 Jul 2026 18:53:05 +0300
Message-ID: <20260728155308.142713-6-adrian.hunter@intel.com>
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

i3c_device_request_ibi() does not verify that a device advertises IBI
support before attempting to set up IBI handling.

Add a check for I3C_BCR_IBI_REQ_CAP and fail with -EOPNOTSUPP when IBI
support is not reported by the device.  This keeps IBI setup consistent
with other IBI-related functionality, such as exposing wakeup capability
only for IBI-capable devices.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V2:

	None


 drivers/i3c/device.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 101eaa77de68..307ca6dc04ca 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -205,12 +205,14 @@ int i3c_device_request_ibi(struct i3c_device *dev,
 		return ret;
 
 	i3c_bus_normaluse_lock(dev->bus);
-	if (dev->desc) {
+	if (!dev->desc) {
+		ret = -ENOENT;
+	} else if (!(dev->desc->info.bcr & I3C_BCR_IBI_REQ_CAP)) {
+		ret = -EOPNOTSUPP;
+	} else {
 		mutex_lock(&dev->desc->ibi_lock);
 		ret = i3c_dev_request_ibi_locked(dev->desc, req);
 		mutex_unlock(&dev->desc->ibi_lock);
-	} else {
-		ret = -ENOENT;
 	}
 	i3c_bus_normaluse_unlock(dev->bus);
 
-- 
2.53.0

