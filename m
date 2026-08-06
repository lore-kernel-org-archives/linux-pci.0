Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7CD336EC0;
	Thu,  6 Aug 2026 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022364; cv=none; b=kRFasMSDIQquGrtA1igI9Uc2hxV7DM6sYNZHlkoXRSqRzHgWitXh9JFoOTQ3jeVNArPpUSBNCxDuB+gITCbm1o5/qPMHv19s4hEnOKBFQ9Rd/kK14qGOOw6P8OtFIDYyJT7Tto3kvyf2w0KKUFoK4C6s2MvpBJPGHlXnoz/DiG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022364; c=relaxed/simple;
	bh=8qnas1z0yzFN13YNJ/JLjoAtaKWli/KcWEU4XZkGZg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsveZx9ELPWbph3rkzacppFTiLSDPjzC0J/8T3IC74tBTQyfJvA1SYMcq4S2kWY7mqOV2aL2O0pmiG2wt37rpvWbpXYwsM8jjbwqGD/mrm4Afo9Xjg4iZPhCYDnZjFedJyR+1PPlJYdIJANAXIh51akyqh+OVF/QTv1r74XTf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXqWuE9C; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXqWuE9C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786022360; x=1817558360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8qnas1z0yzFN13YNJ/JLjoAtaKWli/KcWEU4XZkGZg4=;
  b=lXqWuE9COGOAw4UA2n2IuItTXNIiWo9wyOMLHlCkecFxarZ6NLEUHVEU
   Z+qQucHVKB4XfAT5Dem9ajBj+rFUmUW0VX0ORgbXt1JhM3DsTpML+qSBT
   VNkLGf6XN5AjvGqV3u8eP+PXurnHvXTnCsagABMzkFk4/gttX6P2O+CR/
   Zx6OLTsFtIhtIzuzE43F7YhAMl0fcbOcPDzfoE5l+FACof1MWfjH1S5jn
   kNnX8mmVgIBMLhyRyi9S3+eBsxw0rN/Tmm9V2UHNzFqw0WPZwn2GgoVlu
   /sXQ/0fdblGs1mOImBBLXHLIqoNrCL8OpS2FUAmzzzeVIdLfFAt+5DSwh
   Q==;
X-CSE-ConnectionGUID: s2dDDLr+SKuxZW9BJ6q4EQ==
X-CSE-MsgGUID: 4mIFs2lTQz2mTKKmOG4KqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74149511"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="74149511"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:11 -0700
X-CSE-ConnectionGUID: 9ZPlh3lCTs6KcgQ5p0szrg==
X-CSE-MsgGUID: vBveXvr1SjOXi5CNKQYXuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="260338057"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:08 -0700
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
Subject: [PATCH V4 01/14] i3c: master: Fix recursive locking during device registration
Date: Thu,  6 Aug 2026 16:18:44 +0300
Message-ID: <20260806131857.119830-2-adrian.hunter@intel.com>
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

i3c_master_register_new_i3c_devs() registers newly discovered devices
while holding i3c_bus_normaluse_lock(), a down_read().  device_register()
can immediately probe the device, and probe callbacks typically invoke
I3C helpers that take i3c_bus_normaluse_lock() again, leading to a
recursive acquisition of the same rwsem.  rwsems do not support recursive
read locking and can deadlock when a writer is waiting.  See the
"Recursive read locks" section of Documentation/locking/lockdep-design.rst.

For example, with Intel LPSS I3C, LOCKDEP generates a WARNING like:
  # echo intel-lpss-i3c.0 > /sys/bus/platform/drivers/mipi-i3c-hci/unbind
  # echo intel-lpss-i3c.0 > /sys/bus/platform/drivers/mipi-i3c-hci/bind
  WARNING: possible recursive locking detected
  kworker/5:1/94 is trying to acquire lock:
  ffff88811c810d78 (&i3cbus->lock){++++}-{4:4}, at: i3c_device_match_id+0x45/0x370
  but task is already holding lock:
  ffff88811c810d78 (&i3cbus->lock){++++}-{4:4}, at: i3c_master_reg_work_fn+0x21/0x5f0

Fix this by separating device creation from device registration.
Populate desc->dev under the maintenance lock, collect the devices that
still need registration into a local list, then release the lock before
calling device_register().  Finally retake the lock and clean up any
devices that failed to register.

Use the maintenance lock rather than the normal-use lock while adding
device objects.  A write-side maintenance lock prevents readers from
observing a partially initialized desc->dev during initial device
population, or desc->dev disappearing if registration fails.

The local list requires a list node, so add a list node member to struct
i3c_device.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V4:

	Expanded the kernel-doc for the new struct i3c_device @node
	member to note that it is only for use by
	i3c_master_register_new_i3c_devs() and is not protected by a
	lock.

Changes in V3:

	Added Cc: stable@vger.kernel.org

Changes in V2:

	New patch


 drivers/i3c/master.c       | 45 ++++++++++++++++++++++++++++----------
 include/linux/i3c/master.h |  3 +++
 2 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index f485b98805cf..d2fb1a110521 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2069,12 +2069,21 @@ static int i3c_master_early_i3c_dev_add(struct i3c_master_controller *master,
 static void
 i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 {
+	struct i3c_device *i3cdev, *tmp;
 	struct i3c_dev_desc *desc;
+	LIST_HEAD(i3c_unreg_devs);
 	int ret;
 
 	if (!master->init_done)
 		return;
 
+	i3c_bus_maintenance_lock(&master->bus);
+
+	if (master->shutting_down) {
+		i3c_bus_maintenance_unlock(&master->bus);
+		return;
+	}
+
 	i3c_bus_for_each_i3cdev(&master->bus, desc) {
 		if (desc->dev || !desc->info.dyn_addr || desc == master->this)
 			continue;
@@ -2104,25 +2113,37 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 		if (desc->boardinfo)
 			device_set_node(&desc->dev->dev, desc->boardinfo->fwnode);
 
-		ret = device_register(&desc->dev->dev);
-		if (ret) {
-			dev_err(&master->dev,
-				"Failed to add I3C device (err = %d)\n", ret);
-			desc->dev->desc = NULL;
-			put_device(&desc->dev->dev);
-			desc->dev = NULL;
-		}
+		list_add_tail(&desc->dev->node, &i3c_unreg_devs);
+	}
+
+	i3c_bus_maintenance_unlock(&master->bus);
+
+	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
+		ret = device_register(&i3cdev->dev);
+		if (ret)
+			dev_err(&master->dev, "Failed to add I3C device (err = %d)\n", ret);
+		else
+			list_del_init(&i3cdev->node);
+	}
+
+	i3c_bus_maintenance_lock(&master->bus);
+
+	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
+		list_del(&i3cdev->node);
+		desc = i3cdev->desc;
+		i3cdev->desc = NULL;
+		put_device(&i3cdev->dev);
+		desc->dev = NULL;
 	}
+
+	i3c_bus_maintenance_unlock(&master->bus);
 }
 
 static void i3c_master_reg_work_fn(struct work_struct *work)
 {
 	struct i3c_master_controller *master = container_of(work, typeof(*master), reg_work);
 
-	i3c_bus_normaluse_lock(&master->bus);
-	if (!master->shutting_down)
-		i3c_master_register_new_i3c_devs(master);
-	i3c_bus_normaluse_unlock(&master->bus);
+	i3c_master_register_new_i3c_devs(master);
 }
 
 /**
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 2dc139a217bf..26535beb1e77 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -238,6 +238,8 @@ struct i3c_dev_desc {
  *	  every time the I3C device is rediscovered with a different dynamic
  *	  address assigned
  * @bus: I3C bus this device is attached to
+ * @node: unregistered device list node, only for use by
+ *	  i3c_master_register_new_i3c_devs(), it is not protected by a lock
  *
  * I3C device object exposed to I3C device drivers. The takes care of linking
  * this object to the relevant &struct_i3c_dev_desc one.
@@ -248,6 +250,7 @@ struct i3c_device {
 	struct device dev;
 	struct i3c_dev_desc *desc;
 	struct i3c_bus *bus;
+	struct list_head node;
 };
 
 /*
-- 
2.53.0

