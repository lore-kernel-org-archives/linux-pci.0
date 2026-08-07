Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89B4756AB;
	Fri,  7 Aug 2026 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114662; cv=none; b=BF0QtgowCiGeuZ9SQn2cpKpDtLhpu1IfVS99tifwDOj64GrP4+qKwT8q3hZrmXTEqSKjCTWORvEPQ4L4De5J8AQXt42J0fp9mwuWuX0rvCLTHmWWwBpMaoKCXZC8GHeHwM0+gE11HfN12Hlm4n0dSl5hmjjQIH97iFnkWht7Ieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114662; c=relaxed/simple;
	bh=6kbZmNFhv7aKt6TdJXjjhnORc9iTFg+AGsRdFJWwHEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+0PldP2Twwslcrm01R4jei8YMX2RQRocLHcMJq0C02vSp3pSwFyvWv1nIypRPSwBGp/PYGh58K5Im+oaZtX8xx0YhBiDdmPXaFJlZ+0GG30M4rgDYDXCxg/rFGx/KD2KPI1MojCI9J+KK1voZB0hT6j/vLDUSfWkjtMcml8J40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dlKMO+hA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dlKMO+hA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786114660; x=1817650660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6kbZmNFhv7aKt6TdJXjjhnORc9iTFg+AGsRdFJWwHEs=;
  b=dlKMO+hAyn5sLovbsVccoTwbPskI9pD2oA1tIX1kbJiAixrqobKv7p03
   erbawkOV9a+BgW32J6oW1xuZTfMFOWmfH5xzVCEAy0SDhMp+NukS/mTrv
   SXdY/MWztZU+35/EmiodQBkXkG/MA5kZTg+yGCp3BQv1zChDTCk6mEdVr
   vY6H7fIpFLwWIU88Phy0GuwOYV+KtOd5wnEZL4d3r8aARw++IFxvJnqYh
   ej7KFYvYyzSEHZgou+7fOGN8WPqi6XpXs8+WRmOuOzFq7chIy62WY0hAI
   dvHuu16dULKGPv++oVCdDrHOuT2xLg9Cvc4CuFPBxOxTyA0Kz+jO7qDBr
   g==;
X-CSE-ConnectionGUID: Pl5O7OovRDamtOvNxJRVVg==
X-CSE-MsgGUID: 3FECLPKdSs+HceHa9j3Vhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86485251"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86485251"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:40 -0700
X-CSE-ConnectionGUID: Q79F2LcjTM68E0/8njSe1w==
X-CSE-MsgGUID: wM5X+FphR5KikkO78S22ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="259809941"
Received: from amilburn-desk.amilburn-desk (HELO ahunter6-desk) ([10.245.245.114])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:11 -0700
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
Subject: [PATCH V5 09/14] i3c: master: Report wakeup events for IBIs
Date: Fri,  7 Aug 2026 17:56:33 +0300
Message-ID: <20260807145638.168865-10-adrian.hunter@intel.com>
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

An I3C device configured as a wakeup source can wake the system by
generating an In-Band Interrupt (IBI).

When an IBI is queued for processing, record a wakeup event for the
device if wakeup is enabled.  Use a 100 ms processing interval to give
the I3C device driver time to process the IBI.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---


Changes in V5:

	Added Frank's Rev'd-by

Changes in V4:

	None

Changes in V2 and V3:

	None


 drivers/i3c/master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 2616354dbe54..6c5341491944 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -3384,6 +3384,9 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
 	}
 }
 
+/* Approximate time for IBI handler to run */
+#define I3C_WAKEUP_PROCESSING_TIME_MS 100
+
 /**
  * i3c_master_queue_ibi() - Queue an IBI
  * @dev: the device this IBI is coming from
@@ -3397,6 +3400,9 @@ void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
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

