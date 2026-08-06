Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1FB3382DA;
	Thu,  6 Aug 2026 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022376; cv=none; b=EXbkYc7CBLDMM8jWuQZzJlxqBffGmcQiShIu2riGjEqpc3Jt7d9Fxr+7lkoLSO6eaIubgy+hl2kqlX2yVmDgiYPwHisMBADRlimXAJ9kGqpj0bwDFIO6v4x5P6a7f5OqkNrXRiScwFD+ldFpvm3Y9B9PMJUWAuphVpZfGTczduo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022376; c=relaxed/simple;
	bh=ABmprPYDSs94JgmPD621KnGiMs78sdq749qZ4lkLmek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJpkIT4M/AxQsbhqNybrsoNLgDtHxxC6fMQh6yMZwe4+wECcdcrhSbIww5QPWFsZzq7fAaFD8/8ZtrZVVCqsJJSmKt7jcP7bAQ1387RfCQiUs+cfD7zuBzW9QaeDYWMNAG7wIpdNM7PylWKdJxFoMXcXfYwbXux7xX1uKfgTJf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtFIE6Jv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtFIE6Jv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786022374; x=1817558374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ABmprPYDSs94JgmPD621KnGiMs78sdq749qZ4lkLmek=;
  b=TtFIE6JvJZbZz9tXcNLO5VZKQwawqCh9752i1jXbJC/FF+Z7AJKb3YWB
   LoCO2WIoABLZhRMnhymv20cJP8fclnHbTqS+yqNgbyLoT/5q1lX5vxWtJ
   6J3xZV3O3Um0Xkh3+NWaE0DfVgjsc/odoIS5IKQIGTw9uQThR8I7sWZlP
   wdEsFj4TeZpsyHI33IZZoCnksviIimV5og6jmUe+wim52PaVqUNu1T+4L
   wSiR/YMt6wJZSlsEiaT8t+bu7ry+5hqtROSjUscUmkhAAZFmhaaeluBWh
   2s/TkqskwBfPPnIzfnbC18vN+3CA7vYCfyDtV3Nt3U92499TKtLD9MbzR
   A==;
X-CSE-ConnectionGUID: WBGFVekRRsWdqqPUwaCLIA==
X-CSE-MsgGUID: qo1rvv+NTvKTTosQjl7GjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74149567"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="74149567"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:23 -0700
X-CSE-ConnectionGUID: hxxvVUh9TtWk+NcT2tyG7A==
X-CSE-MsgGUID: GBW5ajFkQ7a/wN46BVX+NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="260338139"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:20 -0700
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
Subject: [PATCH V4 05/14] i3c: Make dev->desc locking assumptions explicit
Date: Thu,  6 Aug 2026 16:18:48 +0300
Message-ID: <20260806131857.119830-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806131857.119830-1-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

i3c_device_get_info() takes the bus normal-use lock before accessing
dev->desc. Under that lock, the descriptor pointer is guaranteed to be
valid for the duration of the access.

Remove the unnecessary NULL check on dev->desc so the code more clearly
reflects the locking rules and expected descriptor lifetime.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
---


Changes in V4:

	Added Mukesh's Acked-by tag

Changes in V3:

	New patch


 drivers/i3c/device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index a3778282e84c..5e6df6de0283 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -101,8 +101,7 @@ void i3c_device_get_info(const struct i3c_device *dev,
 		return;
 
 	i3c_bus_normaluse_lock(dev->bus);
-	if (dev->desc)
-		*info = dev->desc->info;
+	*info = dev->desc->info;
 	i3c_bus_normaluse_unlock(dev->bus);
 }
 EXPORT_SYMBOL_GPL(i3c_device_get_info);
-- 
2.53.0

