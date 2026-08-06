Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78F73769E4;
	Thu,  6 Aug 2026 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022383; cv=none; b=TAWGCM2YU1oiQJ59JKdCLElHWGJaTCAQlFnaLetormRZIafYjYWoS0wbUqeOc+lWHMYHZKtEcLMhpHCWi5uLN/irmI4Vr2j6RBl/QS0lsuB4zU4wDdMb0d/vsdU5u13amiT0S7A0KRWc1kQ6maIyd41dUUPlJuD2LDsGF2bZWow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022383; c=relaxed/simple;
	bh=/i0Yn5fg2OAPraeuV4Q5SOyPrE1P3/F/uvz9vi20wXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jARmrhEbnzogvmf3eFFOk+vrA0s2g76bjtS6wcnkem+5KZRLSuofF4z6g1m7c3dqF67yh24rvI7hMwDjpEDv8kWjSUGzcukU6oa21JpSe6VrzGwYZlsqstFHlWk68oaCrfG6fjsRb2th58lZ05SxsF1zbjoFL+f2tlJSbc62wbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDBodqv1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDBodqv1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786022378; x=1817558378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/i0Yn5fg2OAPraeuV4Q5SOyPrE1P3/F/uvz9vi20wXo=;
  b=cDBodqv1lQRJR+8wFj9xC23Yuxpk5M7VCKOavFWDk31nyxG0w8wc6+e2
   rIju1kDBa+Kb79AbzWEicKF26Ej5or7qpbUE3gpusw84rqzssP96L5TYg
   cTDmNZ8EXotZSl4iC9F5q9QezERFPKmht8IN1Ya4FAn1xOQCz+q4Czve9
   YT7GvgKtqvklqFv8SB6XP4e+t1ijjOh7iM7nFZJnhMNVpmNNTZw8IUb2h
   l24Rv1BCGT+o6Rq0w8PXBfuyo7r+aYUSF+geRGD/HVec1GfqmxJ0Ct9CQ
   iNHmIdiohUiIH2RymojAgEChnSroAU3tagJfbpDIQk4DagdD1dVsQK4Uv
   g==;
X-CSE-ConnectionGUID: atWiyGMAQfCHnPg9yukTgA==
X-CSE-MsgGUID: 8gKqYH+cTxWjcuqoaSHeGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74149602"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="74149602"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:31 -0700
X-CSE-ConnectionGUID: FIeopfLGQG29bRMHq5QZgQ==
X-CSE-MsgGUID: YmKWhKUHR3qlAG8A/YfDJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="260338203"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:29 -0700
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
Subject: [PATCH V4 08/14] i3c: master: Support IBI-based wakeup capability
Date: Thu,  6 Aug 2026 16:18:51 +0300
Message-ID: <20260806131857.119830-9-adrian.hunter@intel.com>
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

An I3C controller acts as a bus controller for one or more I3C devices.
If the controller can wake the system in response to an In-Band
Interrupt (IBI), then any device on that bus that is capable of
generating IBIs can potentially be used as a wakeup source.

Add an ibi_wakeup flag to struct i3c_master_controller so controller
drivers can advertise support for IBI-based wakeup.

If set, mark IBI-capable I3C devices as wakeup capable when they are
registered, allowing wakeup management through the standard device
wakeup framework.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---


Changes in V4:

	Shortened the comment about IBI-capable devices being wakeup
	capable.

Changes in V3:

	None

Changes in V2:

	Dropped the redundant #include <linux/pm_wakeup.h>.  That header
	must not be included directly, and linux/device.h, which is
	already included, provides device_set_wakeup_capable().


 drivers/i3c/master.c       | 4 ++++
 include/linux/i3c/master.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 83e04a2c202a..2616354dbe54 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2110,6 +2110,10 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 		if (desc->boardinfo)
 			device_set_node(&desc->dev->dev, desc->boardinfo->fwnode);
 
+		/* If the device has IBI capability, set as wakeup capable */
+		if (master->ibi_wakeup && (desc->info.bcr & I3C_BCR_IBI_REQ_CAP))
+			device_set_wakeup_capable(&desc->dev->dev, true);
+
 		list_add_tail(&desc->dev->node, &i3c_unreg_devs);
 	}
 
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 26535beb1e77..9d675d01522c 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -524,6 +524,7 @@ struct i3c_master_controller_ops {
  * @hotjoin: true if the master support hotjoin
  * @rpm_allowed: true if Runtime PM allowed
  * @rpm_ibi_allowed: true if IBI and Hot-Join allowed while runtime suspended
+ * @ibi_wakeup: IBI can wakeup the system
  * @shutting_down: set to true when master begins shutdown or unregister
  * @boardinfo.i3c: list of I3C  boardinfo objects
  * @boardinfo.i2c: list of I2C boardinfo objects
@@ -563,6 +564,7 @@ struct i3c_master_controller {
 	unsigned int hotjoin: 1;
 	unsigned int rpm_allowed: 1;
 	unsigned int rpm_ibi_allowed: 1;
+	unsigned int ibi_wakeup: 1;
 	bool shutting_down;
 	struct {
 		struct list_head i3c;
-- 
2.53.0

