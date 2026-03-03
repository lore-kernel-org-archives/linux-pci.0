Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF25358D37
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496057; cv=none; b=DTFJjXvqhCToPsCR1KwR9djC+UqrBnZEeQ9GBEWB/tsBZqCp2kuwceQ68xbtLYd7wbaloqC8U6sg0+cT7FcSCCqGvonlanbdjxrV3KqCUAIfY4Fz1n5togvf9QYqRt36hMBJ/cv5Fng3Fed5I8vCgvyIOEe2s3wL9jVZcwnntzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496057; c=relaxed/simple;
	bh=yLI1lJvwnpgHrzjTK9BMKLAk8Om+DpRVGtJGW5WJZyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XO4VaJhNpQcHwnmdgjFQ34/6yQhnV1Ll7uL8ewhGMEtGHcY0TC4qeR5bZ+ucxYCtDmxhDdjszksIQ/gNUBXfJdQq5pMIjMkmR80LO6XDq9qNWa1ivEhETwUkKjXLDmCE81jUADoLnRdCkBzJo8tgmVBfOkRUH5piozYoG8sZE7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ufb4GzIO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ufb4GzIO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496056; x=1804032056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yLI1lJvwnpgHrzjTK9BMKLAk8Om+DpRVGtJGW5WJZyQ=;
  b=Ufb4GzIOCRHfzs85O6zIs0wcHJpBLnDGYYxP2yrAs3hEB2mPTDqbcqrw
   PaPXtxU32kmRWIXni9m/fcBZo16cAmqXLNek25v2RH2GpTbISdT3CBm+o
   9DUrUWCgwXnRlTUhUJpRwtc6rzswjY/+klvoR4TV38GW9P1aW2drT2bkk
   nVihm0zLXPY1uJpTEdCnwEDpL6B7reVWMc6xLkkPshiPm6bPxlyl+pKCS
   VodbvMdINNBvciYNBiutapxxEMF+wSQckEAN2eBI/tj5hyFGilq5QkhRe
   NAncvxPrv5pg6CfGFDA2QTZWCwScEaNYgqp9IVcnSnMYbCmJqAG5dNDQh
   Q==;
X-CSE-ConnectionGUID: YSCk0SPzRNeut1BVGv3qFA==
X-CSE-MsgGUID: 0LDFvbLFSayh+z2F5sBJMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73482843"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73482843"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:00:54 -0800
X-CSE-ConnectionGUID: LH1PTraqRcyJRLGzwq3E9w==
X-CSE-MsgGUID: Qfd575iASxCXLVKgdXAT2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="214967076"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2026 16:00:53 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	aik@amd.com,
	aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com,
	bhelgaas@google.com,
	alistair23@gmail.com,
	lukas@wunner.de,
	jgg@nvidia.com
Subject: [PATCH v2 02/19] device core: Fix kernel-doc warnings in base.h
Date: Mon,  2 Mar 2026 16:01:50 -0800
Message-ID: <20260303000207.1836586-3-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303000207.1836586-1-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding new fields to 'struct device_private' fix up
existing kernel-doc warnings in this header file of the form:

Warning: drivers/base/base.h:59 struct member 'subsys' not described in
'subsys_private'
Warning: drivers/base/base.h:59 struct member 'devices_kset' not described
in 'subsys_private'
Warning: drivers/base/base.h:59 struct member 'interfaces' not described in
'subsys_private'
Warning: drivers/base/base.h:59 struct member 'mutex' not described in
'subsys_private'

...which are simple replacements of " - " with ": ".

Add new descriptions for these previously undescribed fields:

Warning: drivers/base/base.h:58 struct member 'drivers_autoprobe' not
described in 'subsys_private'
Warning: drivers/base/base.h:117 struct member 'deferred_probe_reason' not
described in 'device_private'

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/base.h | 79 +++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 430cbefbc97f..b68355f5d6e3 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -13,27 +13,28 @@
 #include <linux/notifier.h>
 
 /**
- * struct subsys_private - structure to hold the private to the driver core portions of the bus_type/class structure.
- *
- * @subsys - the struct kset that defines this subsystem
- * @devices_kset - the subsystem's 'devices' directory
- * @interfaces - list of subsystem interfaces associated
- * @mutex - protect the devices, and interfaces lists.
- *
- * @drivers_kset - the list of drivers associated
- * @klist_devices - the klist to iterate over the @devices_kset
- * @klist_drivers - the klist to iterate over the @drivers_kset
- * @bus_notifier - the bus notifier list for anything that cares about things
- *                 on this bus.
- * @bus - pointer back to the struct bus_type that this structure is associated
- *        with.
+ * struct subsys_private - structure to hold the private to the driver core
+ *			   portions of the bus_type/class structure.
+ * @subsys: the struct kset that defines this subsystem
+ * @devices_kset: the subsystem's 'devices' directory
+ * @interfaces: list of subsystem interfaces associated
+ * @mutex: protect the devices, and interfaces lists.
+ * @drivers_kset: the list of drivers associated
+ * @klist_devices: the klist to iterate over the @devices_kset
+ * @klist_drivers: the klist to iterate over the @drivers_kset
+ * @bus_notifier: the bus notifier list for anything that cares about things
+ *		  on this bus.
+ * @drivers_autoprobe: gate whether new devices are automatically attached to
+ *		       registered drivers, or new drivers automatically attach
+ *		       to existing devices.
+ * @bus: pointer back to the struct bus_type that this structure is associated
+ *	 with.
  * @dev_root: Default device to use as the parent.
- *
- * @glue_dirs - "glue" directory to put in-between the parent device to
- *              avoid namespace conflicts
- * @class - pointer back to the struct class that this structure is associated
- *          with.
- * @lock_key:	Lock class key for use by the lock validator
+ * @glue_dirs: "glue" directory to put in-between the parent device to
+ *	       avoid namespace conflicts
+ * @class: pointer back to the struct class that this structure is associated
+ *	   with.
+ * @lock_key: Lock class key for use by the lock validator
  *
  * This structure is the one that is the actual kobject allowing struct
  * bus_type/class to be statically allocated safely.  Nothing outside of the
@@ -98,24 +99,26 @@ struct driver_type {
 #endif
 
 /**
- * struct device_private - structure to hold the private to the driver core portions of the device structure.
- *
- * @klist_children - klist containing all children of this device
- * @knode_parent - node in sibling list
- * @knode_driver - node in driver list
- * @knode_bus - node in bus list
- * @knode_class - node in class list
- * @deferred_probe - entry in deferred_probe_list which is used to retry the
- *	binding of drivers which were unable to get all the resources needed by
- *	the device; typically because it depends on another driver getting
- *	probed first.
- * @async_driver - pointer to device driver awaiting probe via async_probe
- * @device - pointer back to the struct device that this structure is
- * associated with.
- * @driver_type - The type of the bound Rust driver.
- * @dead - This device is currently either in the process of or has been
- *	removed from the system. Any asynchronous events scheduled for this
- *	device should exit without taking any action.
+ * struct device_private - structure to hold the private to the driver core
+ *			   portions of the device structure.
+ * @klist_children: klist containing all children of this device
+ * @knode_parent: node in sibling list
+ * @knode_driver: node in driver list
+ * @knode_bus: node in bus list
+ * @knode_class: node in class list
+ * @deferred_probe: entry in deferred_probe_list which is used to retry the
+ *		    binding of drivers which were unable to get all the
+ *		    resources needed by the device; typically because it depends
+ *		    on another driver getting probed first.
+ * @async_driver: pointer to device driver awaiting probe via async_probe
+ * @deferred_probe_reason: capture the -EPROBE_DEFER message emitted with
+ *			   dev_err_probe() for later retrieval via debugfs
+ * @device: pointer back to the struct device that this structure is
+ *	    associated with.
+ * @driver_type: The type of the bound Rust driver.
+ * @dead: This device is currently either in the process of or has been
+ *	  removed from the system. Any asynchronous events scheduled for this
+ *	  device should exit without taking any action.
  *
  * Nothing outside of the driver core should ever touch these fields.
  */
-- 
2.52.0

