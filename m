Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A5F41A909;
	Fri,  7 Aug 2026 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114650; cv=none; b=oMRxx9F/JsTVmGweDtGD/AutVzgcLQMXD+hhv/B78z+OhzfO5h2Yw1Zge1dl+RLsqascG+Ig9YlcvyY38SBB8Gkgh2masHjKJ9ThI1IUraN6Sy4l0cTJ/C2YCVIO0qIx4qbO4PptTU9W5U6/Q+GvfyNS2aGY9hbLjYtfdkpwbXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114650; c=relaxed/simple;
	bh=ctrlY3FM28tivUxIv2sCpxma8DQO19RH1AD6gnz/0ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2E7JP3loJUBhO/PyJcsVNpwHRWl6suCkNl5Ty3l09L0SEiVjgJLjngLttKdglCfmn2j7kNuVGOpIbjvcTlP4QZCRstPCq5dB4tck+l4iUvbpt5XQWXU8MTN1mqGOPlGat9Ar2tiUHGni4y8DEl6pYtd/8U2mjU1nvt82RtrblA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ti94ir1W; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ti94ir1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786114649; x=1817650649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ctrlY3FM28tivUxIv2sCpxma8DQO19RH1AD6gnz/0ck=;
  b=Ti94ir1WdVoWn93JQKie1d1t8/xdtesQ7qAwo7L1QkuxABT9N2zJOhvG
   iVnQlMD78CkiHjAz8FNJjNE9+jGqjdzkiCsbrGcY5En9xvTtNDsZXopC8
   CNEXCctBlEGPdPqbK6XCoDhlJt7LtwXgMLajrUkRT+fiI4AlHj6E+V+AO
   +OYqQqbnpoofmhtp9o0eExjyiGSFvXpOvE6x29JAFKKqA0axrfRq9vafq
   OC8TRmYe+FVVNWm6YMcATLytpUkq+bYy8cY++0QbqvRRq8F6LD+klW+dZ
   AEq3Hi5nMBDpMgWXG5mOzu7XWT0GKvV9K60FM4uIKx+WT0V0nKVucOvsf
   w==;
X-CSE-ConnectionGUID: 5pMFbz0JQKC++9mUAvqLEw==
X-CSE-MsgGUID: y/VcPs1OT7K0+aTXq9NmQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86485196"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86485196"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:25 -0700
X-CSE-ConnectionGUID: JLBFR8nDTG6LJmPzP2Hqog==
X-CSE-MsgGUID: vwoskQALRtORVlH9McSGhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="259809880"
Received: from amilburn-desk.amilburn-desk (HELO ahunter6-desk) ([10.245.245.114])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:56:54 -0700
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
Subject: [PATCH V5 03/14] i3c: master: Do not treat master device as a duplicate target
Date: Fri,  7 Aug 2026 17:56:27 +0300
Message-ID: <20260807145638.168865-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807145638.168865-1-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
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


Changes in V5:

	None

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

