Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527144DB95;
	Tue, 28 Jul 2026 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254008; cv=none; b=kihBXjxmxYGSatCEUHvpyjBFRL/rquZhGg8N5QFaNr5OZWiKinCMtZnh+s3xLOLQXZBez1UjGQ+IPrprqxTZbtHphd8564/T1S4kKfhlaX9cmiCjAdpLb5SSaMAPpBe2g254tmohw7OEm1L4i5SNOiBPEFAxoZO30sxx5tY2INI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254008; c=relaxed/simple;
	bh=0EBtWuBQlGKuNMxcLbHMlP+7SpipqmE1T979hPNe/Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ox+dUdaHTychxqQaqDjtUsTWeBYh4mc7UmB/3b0Lk9CaGrQW0oodqm+g7SAQq11KP/mNIT+6q1ObX3NhJYFSAFojQczUseLFv/+x8pwv9BVElZ1Ojm+XscIW+LJ+jpFSoW8gfpks3427nTFsUuQulN243+nPiQn48437nzoYjiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+NbASaJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+NbASaJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785254006; x=1816790006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0EBtWuBQlGKuNMxcLbHMlP+7SpipqmE1T979hPNe/Yg=;
  b=S+NbASaJwc921P3QNtQjjR/IZxRHnQySbcdnnuHp5R8F/TJVXX0Ak8ww
   CbyR0azDiWHNy+yZ3eWjfbIfJmXiDd6VkPsDsrQLlybPJFknwCID6cWs3
   Xun4wyYTEgxXQe+hKrZcPkKbzKDjKhvP8mE28C2cd1qKVj4VQ6M8BNBdR
   4NdOvm6FPwnhMAt+FvB6RFH60LXyEK+SUTRKH+gRDf9ZBHoPUVv1m3a9y
   hYPej/Hnoa5AiubzIh3saUAAke1VupJ6f/XeTKTkmKs1ru5CEQhpFem14
   BOahUUAIiZPNL0XUKhUp5ncpxozmRK4frbBSG8bXurWCxanSSYrdOyA5U
   w==;
X-CSE-ConnectionGUID: 8y0wNmBoSpy0J6H+7L5+lw==
X-CSE-MsgGUID: wgsvTdIOS1CKP4FS9z/4qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85696535"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85696535"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 08:53:24 -0700
X-CSE-ConnectionGUID: qlf5VOKNSfOx5q06RUn29Q==
X-CSE-MsgGUID: jkbz94joQyKTilJGQYcjrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="255817453"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.126])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 08:53:21 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V2 2/8] i3c: master: Support IBI-based wakeup capability
Date: Tue, 28 Jul 2026 18:53:02 +0300
Message-ID: <20260728155308.142713-3-adrian.hunter@intel.com>
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


Changes in V2:

	Dropped the redundant #include <linux/pm_wakeup.h>.  That header
	must not be included directly, and linux/device.h, which is
	already included, provides device_set_wakeup_capable().


 drivers/i3c/master.c       | 7 +++++++
 include/linux/i3c/master.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 874f6e11b296..cf3345265ac0 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2008,6 +2008,13 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 		if (desc->boardinfo)
 			desc->dev->dev.of_node = desc->boardinfo->of_node;
 
+		/*
+		 * In the case of IBI wakeup, any IBI-capable device can
+		 * wakeup.
+		 */
+		if (master->ibi_wakeup && (desc->info.bcr & I3C_BCR_IBI_REQ_CAP))
+			device_set_wakeup_capable(&desc->dev->dev, true);
+
 		list_add_tail(&desc->dev->node, &i3c_unreg_devs);
 	}
 
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index fa1c98f0f5c1..99f89fef7653 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -513,6 +513,7 @@ struct i3c_master_controller_ops {
  * @hotjoin: true if the master support hotjoin
  * @rpm_allowed: true if Runtime PM allowed
  * @rpm_ibi_allowed: true if IBI and Hot-Join allowed while runtime suspended
+ * @ibi_wakeup: IBI can wakeup the system
  * @shutting_down: set to true when master begins shutdown or unregister
  * @boardinfo.i3c: list of I3C  boardinfo objects
  * @boardinfo.i2c: list of I2C boardinfo objects
@@ -547,6 +548,7 @@ struct i3c_master_controller {
 	unsigned int hotjoin: 1;
 	unsigned int rpm_allowed: 1;
 	unsigned int rpm_ibi_allowed: 1;
+	unsigned int ibi_wakeup: 1;
 	bool shutting_down;
 	struct {
 		struct list_head i3c;
-- 
2.53.0

