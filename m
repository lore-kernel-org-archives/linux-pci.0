Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAA7373BE0;
	Thu,  6 Aug 2026 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022380; cv=none; b=M9ecUfca1WMy3XloLpRz8HYZFLx2Lj3kZ+hOn+MAAE0oC4H7K+SaYpnC4lRaU9Sb/EIovXlB0Z57CB3/I3d3XPeFt7FxiM0ChbsldcUQr5kq5pb+jb819QYmYuJSfYlIFNxvmIN6UQMounm/HSWNDe00mMCY6UqMbrxyYEaKLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022380; c=relaxed/simple;
	bh=dRpafqq+wNMr/EYQqjCT5QMFngA9hTqwKopSC/ZJKuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTA6DOZROnmhu/9w3gON6vSSUdWiV9SDz9CKjqHherCIksZWkgzCnz1NQKDA4NOW1EsVMp86en6Vhg/VJCzHdJbMXWS5W7q1BXEgNDvN6xic4G5sr7mTvgup6t3NNi/CtOEPVuWSC3/d5r7ItkWGDCqXzH2rosx3AAQD3YeOuZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AC5fFtkD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AC5fFtkD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786022376; x=1817558376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dRpafqq+wNMr/EYQqjCT5QMFngA9hTqwKopSC/ZJKuc=;
  b=AC5fFtkDoEExmuktDl7U6Zi1C+a2T0FclDALLf5bfYaNow9GIlAH4gGb
   l3cpphExw2ldn55PYIUyU2xZKkj5zUvy58YhiVDL21NH5HETbck+0WOBU
   sogzD8qPeD2R+9oKIKp8KPsvVbqdh78a881QhEhsMkfdueW7Muv2htghP
   S5IXvJEF2EUopRFlQSRExYYLocAApRvOPgCUUh1QXKzG350W1M93x8Izx
   174bGUeMQvAnj03xm5sTDq3Cfv//K5Z34PzuIFWJfjqflpsSy4vI0eHIA
   H9GtdeTwckOCHzc6xrbCiLafXw2bw0rE8ZCX0yvxhjqrq7MOsyIoRr+zO
   g==;
X-CSE-ConnectionGUID: 2jct0b4lSZK+db6nFX+8Yg==
X-CSE-MsgGUID: WCjHHs/XRPCuQeTUSrp+EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74149590"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="74149590"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:29 -0700
X-CSE-ConnectionGUID: YwbflQISQ5GUyI0E/WfZEA==
X-CSE-MsgGUID: /fyyX5WEStKvq9ym9PXVKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="260338186"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:26 -0700
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
Subject: [PATCH V4 07/14] i3c: master: Fix potential UAF in i3c_device_match()
Date: Thu,  6 Aug 2026 16:18:50 +0300
Message-ID: <20260806131857.119830-8-adrian.hunter@intel.com>
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

i3c_device_match() dereferences i3cdev->desc without holding the bus
normal-use lock.  Since the descriptor pointer can be replaced
concurrently, the dereference can race with descriptor replacement and
result in a use-after-free.

Protect access to i3cdev->desc with the normal-use lock.  While the lock
is held, the descriptor is guaranteed to remain valid, so the NULL check
is also unnecessary and can be removed.

This change depends on "i3c: master: Fix recursive locking during device
registration".  Prior to that change, taking the normal-use lock in
i3c_device_match() could recurse on bus->lock during device
registration.

This fixes "i3c: master: match I3C device through DT and ACPI".

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V4:

	None

Changes in V3:

	New patch


 drivers/i3c/master.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index ee771ac0b203..83e04a2c202a 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -347,8 +347,10 @@ static int i3c_device_match(struct device *dev, const struct device_driver *drv)
 	i3cdev = dev_to_i3cdev(dev);
 	i3cdrv = drv_to_i3cdrv(drv);
 
-	if (i3cdev->desc && i3cdev->desc->boardinfo)
+	i3c_bus_normaluse_lock(i3cdev->bus);
+	if (i3cdev->desc->boardinfo)
 		static_addr_method = i3cdev->desc->boardinfo->static_addr_method;
+	i3c_bus_normaluse_unlock(i3cdev->bus);
 
 	/*
 	 * SETAASA-based devices need not always have a matching ID since
-- 
2.53.0

