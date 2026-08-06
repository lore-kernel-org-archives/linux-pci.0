Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6F0333439;
	Thu,  6 Aug 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022371; cv=none; b=d1paPT22FKzCV6X2AdD3tYnFYWGzClKUUTtvLmJWBlYWuSMGD0HicEedX4R7GZvXxPNMmxrGxTEbSRE+q05jgcG7ANsS78RYd9PuBnhavD7NNr51FLCFs1k0jHBdNfDDlTEnZiCBOhoGAb5JGJZl93VCvLDVsyfpc0xHUSEQLxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022371; c=relaxed/simple;
	bh=Mggui0CLcJI+CXEJWoxkotbs7prYgBI6zApoIT2r0N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpMWWAJvHjHvJ/cvHQjiz2buPa9ld8XS3mp3DK6Ymh6ngXSw9XwOvw+uvIOBQpxnIdb/E+wAZXq5qDTzalQGwOaKDARxRUydevZW2hUGb+DXhFBSy2icVEoi+ISAv2jHx8iMpxcCqU3a3PGh85FkdQtRNpQUCgkIFd83y37HGAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhOa7L5y; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhOa7L5y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786022367; x=1817558367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mggui0CLcJI+CXEJWoxkotbs7prYgBI6zApoIT2r0N4=;
  b=EhOa7L5yu924GgvduD0/WUjNLJYMngg8CZHnXtN8VCFUrRShuuEX5VRa
   tQK2Cj6c9xaYmOWpFRZBL18jkbThj1BP9++kXZ+YWROKrYdGWqT+d9RhW
   cOy8nyk7OyyAR3Yks3qAdME/jyqlDuQ2FXTmKWy1MrglkmuEPlJAUcvVG
   4l5LFifDVKScVocDSf95reA4Wdbscn8nz/mXj/ugYBMAUrrJrD+s3Aoy8
   RZX+FEFTY5rgEvZosEEDzBDNt2WrLZ1K2mpV19vEcfu6xblkYsRA64Jit
   L/in7qyP1rLrnSqO8qdm2HyCHMS36X7u3ebEEKQDmBmy4P6KtO98+IRZz
   A==;
X-CSE-ConnectionGUID: +UwBV44lQcShBvBycxFQ2A==
X-CSE-MsgGUID: Qw4DSP6LQiyYke8NA35rNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74149544"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="74149544"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:17 -0700
X-CSE-ConnectionGUID: DIQmaE+GQOuhRgUD+m1RbQ==
X-CSE-MsgGUID: o+XS/H4RSC2+lGKUsYIoxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="260338101"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:14 -0700
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
Subject: [PATCH V4 03/14] i3c: master: Do not treat master device as a duplicate target
Date: Thu,  6 Aug 2026 16:18:46 +0300
Message-ID: <20260806131857.119830-4-adrian.hunter@intel.com>
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

i3c_master_search_i3c_dev_duplicate() searches the bus for another I3C
device with the same PID as the reference device.  The search can match
master->this, causing the controller itself to be returned as a
duplicate.

Since the controller is not a target device, it cannot be a duplicate of
one.  Exclude master->this from matching so that the function only
returns real duplicate target devices.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
---


Changes in V4:

	Added Frank's Rev-by and Mukesh's Acked-by tags

Changes in V3:

	New patch


 drivers/i3c/master.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index c7bb52b71d88..abb582645a2e 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2545,7 +2545,8 @@ i3c_master_search_i3c_dev_duplicate(struct i3c_dev_desc *refdev)
 
 	i3c_bus_for_each_i3cdev(&master->bus, i3cdev) {
 		if (i3cdev != refdev && i3cdev->info.pid &&
-		    i3cdev->info.pid == refdev->info.pid)
+		    i3cdev->info.pid == refdev->info.pid &&
+		    i3cdev != master->this)
 			return i3cdev;
 	}
 
-- 
2.53.0

