Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D346AA6D;
	Tue,  4 Aug 2026 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850720; cv=none; b=fq/g8T4/L3TvXq+2QmWZSg8H49tBm8QAOuiR4d+cPB8jfTy/tAMyqBUNoODI/O8LYHOrSZzNmw8MWdu/rMIS7qPjVGdckniS3IwNnlAPHWoA8pFAqCVc6pYw2i00jnWdMQo5sviWlvZVuoFSkrsZXtwuMnvJbro+hWokqawWSAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850720; c=relaxed/simple;
	bh=5NmvrefdJdFqJwX9A5ehFBhEleFx9mtAtJU4G6VWcEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Afy8CTLAsNTTOpKEL5DhagPJEtdl3PxFNEjoXrEWJ8dGkQ6hXyMTsNNCH68nbjIZlSK6oA8umhYi1npNZiq/Qmb+Ha+WCJv/bLc0OELU98gPJbvPBa4bwjuxGvnIYS9rrA853z0XZB9FE9TL9qoE1gpqD9RzMBLW7GUzc3+v/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrgiX1Xy; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrgiX1Xy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785850719; x=1817386719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5NmvrefdJdFqJwX9A5ehFBhEleFx9mtAtJU4G6VWcEI=;
  b=JrgiX1XyGep9nmD0v7xu8k8LYA6VM/IJODbodU1zGCpk4/vmtmlE8cyV
   iOMD1riZHFEPHWEYz37VwpP5XZUvwdx36wVPUfNN3I4TpJjHQAGV7dr6c
   GRRONyuAMOrCO6kGE1w0fskQ2raZI5fjwKNIRg+a8UGZmM3hBvIGDWqV8
   756IBi4EteDlYTiOMAQQEfO2WL9I2T3pOE4PUyfZAhFRq0DbpFCBHazfe
   jAqxdxD7dvj9gBx81RO7mGJDqSc5gQT/vsL2h+YD62R/PBbumW+oAZgmZ
   CSaXy+o+i1RgvuBmathHD9RF4xXJ48RRVdRYYjYu1WDAC1QMLSC0Lw7so
   Q==;
X-CSE-ConnectionGUID: 29ZzI3J4Qb2vDQDE/BHGJQ==
X-CSE-MsgGUID: 04YiLBUgQauwQ8Dq55+wbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86410128"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86410128"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:39 -0700
X-CSE-ConnectionGUID: dt4O0ijsQAW1J5NR3MJFOw==
X-CSE-MsgGUID: o3PUtclpQjiye19KAn9NzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="263501024"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.132])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:37 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	akhilrajeev@nvidia.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V3 07/14] i3c: master: Fix potential UAF in i3c_device_match()
Date: Tue,  4 Aug 2026 16:38:03 +0300
Message-ID: <20260804133810.184905-8-adrian.hunter@intel.com>
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


Changes in V3:

	New patch


 drivers/i3c/master.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 947ab3c681d5..e7ea41007889 100644
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

