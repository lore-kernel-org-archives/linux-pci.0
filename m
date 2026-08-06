Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6421E2F8EA1;
	Thu,  6 Aug 2026 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022373; cv=none; b=g/7fWd+ujtXgSLDXx766SMTb8aCyMdCvADZay1LuVLXWTZ6nzEx/IHX6PVBKQEafvVvZBTq+i7uvUQW6y0c03yX3+Db9iu6MIDZeGyBYOXysAZV/HKfYr1x4U6XHFc31kImPDgaZ0OfoANC6g8a2cX71zQ8HtVuTmg25SqmfWcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022373; c=relaxed/simple;
	bh=m+vaP+hUhXQyQtti8rw2K8d44e4Og780oMqT54taEy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PancwcQ7zhb21MzpOKCn/6RWg/BLKvzlfdWpQHhx9uOmpvmN6b20kWXU2r8T4rJn91/BKFx6Nibknl7lOekIusboTGiY34x4QUeQuT5gcpwA3TYu/r4haPVvfSC+YEQ8UCEI/QTeOx1MvZUPohz5HUL+9r7iBS4rC4MvVoJS4WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PlWj2KDx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlWj2KDx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786022363; x=1817558363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m+vaP+hUhXQyQtti8rw2K8d44e4Og780oMqT54taEy0=;
  b=PlWj2KDxNOjTtxHbHLml7T7gPJ0qn89zWx1rLHhYjlq1iuiMtyrjnbyJ
   7N8hNBtr+I9liLrm3p6C4CNbklRtpONLLw8bILQR66TjR38zP9iPrM+L6
   dyHg6hD6BXtGecSTXEgQSEk5NCJjtFFSEvxUbV1m2qU0zf+Qnk4+POq+5
   9LJqk2H/F9yFYSeQzZGonbtnKKVQ77jCWEeIjtZhnVLPn4ZiB2zy0JYYT
   aP7VkA1gw7+6wi6Eu1TIC+srxII3mMxtKWJFSLxc1uA102GtVlgkSxdES
   skOWyj5IihbdWeDvea7ZOzkNRYgeirUfx4nmbPxMSFUtFSw9DIU8vR7MG
   Q==;
X-CSE-ConnectionGUID: pAD6bb9lSOyFGPs8JjSHqQ==
X-CSE-MsgGUID: rUf8cEIsRTym0qOBmLsh0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74149526"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="74149526"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:14 -0700
X-CSE-ConnectionGUID: MxIAstuiTqe+XZrgiAh09Q==
X-CSE-MsgGUID: EAitVmDZRfeBsJWc2EOqCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="260338080"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:11 -0700
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
Subject: [PATCH V4 02/14] i3c: Fix unlocked dereference of dev->desc in i3c_device_get_supported_xfer_mode()
Date: Thu,  6 Aug 2026 16:18:45 +0300
Message-ID: <20260806131857.119830-3-adrian.hunter@intel.com>
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


Changes in V4:

	None

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

