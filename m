Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06DF4A68A0;
	Fri, 11 Sep 2026 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148764; cv=none; b=gw6//7GdwHzF9OK426ew6B+hUga4vrGaERwYVfcKZxfWr6ZLEwcGQRlmnKZ9gphvCj8BmzG4mjfWHu2dnnXuf+CnjL7nxFn6FANak8ZKiwQK2+5GIc7p5RAhBPNb555G9lGA5mLTTN0mMvfnbxkjZzemIrAsak0E66tTWIH8xeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148764; c=relaxed/simple;
	bh=6Jm+/yA08ADWx8YuefYsn7Jfo5CbJtNY4gBhQGkg/n8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAQ37zvqHiTZMebBNUNPaZvPyFhcbDUa8CTOMklx7T4U4U44VW3/LkCcSg8dQNhdHNbt+RwGpYigwr9YbKeX8FWWBNmOWDHwa1SNNRecbceN4bkD60yVykqMxaxNL+4IEVM+MXKRxiQVI2/QMme7p0iurIZY/rDtsQwmVSSy/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=sMtp+Vln; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="sMtp+Vln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789148762; x=1820684762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uG/E/cyk03CM0gEHgOG/UKkzaznPxEh34D8eww4v9Bk=;
  b=sMtp+VlnB6z205i3Ecl3rpTJbfomut7os2MWVyQe63f89r7MTM+rVdHH
   BhJK9cgUDyu3It5pzqERidA0WMMQrHxGSGCoU/JVmMLSzBTk9XkK+GNnQ
   w1KhsjhPPhyIiQyMCLsSAnw1VSXPiR7E+xtAT15gPYwfQXh6PfsEyiJbr
   3pKGHwg/99uLAsA35yvGYBg017kIiV2KrRJ+Z1jM/fhxqXqsQOnLzAg9V
   vqrJklBqlq3IWKCW2OTJ9dZv549xgj5sgsFriIAlboFmLdORc/moXzxTU
   iM1RnxSjiOsXpUx2Aptn698O8RqvlP8xsvGXLwiSkME6MMuj2Z/O3p+Ol
   w==;
X-CSE-ConnectionGUID: jKIpnsKwRmC2bq01T329Vw==
X-CSE-MsgGUID: 3bWMuIMSTQSq3/49ZGqnNA==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28234943"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 17:46:00 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:21540]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.236:2525] with esmtp (Farcaster)
 id 24028455-f724-4a4f-9274-2dc7c3f15751; Fri, 11 Sep 2026 17:46:00 +0000 (UTC)
X-Farcaster-Flow-ID: 24028455-f724-4a4f-9274-2dc7c3f15751
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 17:46:00 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 17:45:57 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo
	<tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>
CC: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Alex Williamson
	<alex@shazbot.org>, <kvm@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 4/8] driver core: Register opted-in devices through the staged sysfs path
Date: Fri, 11 Sep 2026 19:43:36 +0200
Message-ID: <20260911174414.97060-4-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911-vfopt-s5-v1-0-fa4cacdb6ca8@amazon.de>
References: <20260911-vfopt-s5-v1-0-fa4cacdb6ca8@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

dev_set_sysfs_staged() opts a device in to staged registration before
device_add(). struct device gains one flag, DEV_FLAG_SYSFS_STAGED, in
the existing flags bitmap, so the struct does not grow.

device_add() stays a single code path with a staged bracket: it arms
staged creation once the parent kobject is resolved, everything it builds
in between lands in the staged subtree through unchanged code, and after
device_pm_add() sysfs_publish_dir() makes the whole subtree visible in
one step, before anything announces the device. bus_add_device() defers
its bus-klist insertion until just after publication, because
driver_attach() walks that klist and must not see a not-yet-published
device.

A class device with no parent lands under a class glue directory and
needs no special casing: cleanup_glue_dir() cannot see a staged child
through kobject_has_children(), but since commit ac43432cb1f5 ("driver
core: Fix use-after-free and double free on glue directory") that gate
also requires the caller's reference to be the last one, and a staged
device holds two.

Two transients are new and bounded. A symlink pointing at this device
from an already-published directory resolves -ENOENT until publication,
and an eager device_add() nested under the still-staged device fires its
KOBJ_ADD before its own path resolves. Neither opt-in reaches that
second case; code the opt-in caller does not control can, through the
two wakeup-source routes named in the uevent-deferral patch. Both close
at publication, before the ancestor's own KOBJ_ADD. The symlink
transient announces nothing; the nested child's KOBJ_ADD does announce
a path that does not yet resolve, and a later commit defers and replays
exactly these events. Opt-in is therefore appropriate for devices
whose nested children, if any, tolerate being fully registered,
enumerable and bindable, while their sysfs tree is not yet visible.

Publish-side code reads the kobject's sd_staged snapshot rather than this
flag, which is free to change once device_add() has sampled it.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/base/base.h    |  1 +
 drivers/base/bus.c     | 29 ++++++++++++++++++++++++++++-
 drivers/base/core.c    | 27 +++++++++++++++++++++++++++
 include/linux/device.h | 11 +++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index f5d608f4aaa5..5c8266dad7f8 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -157,6 +157,7 @@ static inline void auxiliary_bus_init(void) { }
 struct kobject *virtual_device_parent(void);
 
 int bus_add_device(struct device *dev);
+void bus_add_device_publish(struct device *dev);
 void bus_probe_device(struct device *dev);
 void bus_remove_device(struct device *dev);
 void bus_notify(struct device *dev, enum bus_notifier_event value);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index d17bd91490ee..f5af3b1e2ee3 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -588,7 +588,16 @@ int bus_add_device(struct device *dev)
 	if (error)
 		goto out_subsys;
 
-	klist_add_tail(&dev->p->knode_bus, &sp->klist_devices);
+	/*
+	 * A staged device must not appear on the bus klist (walked by
+	 * driver_attach()) until it has been published, or a driver could bind
+	 * to a not-yet-visible device.  Defer the insertion to
+	 * bus_add_device_publish().  The sp reference taken above is held until
+	 * device removal in both cases, and bus_remove_device() already
+	 * tolerates a never-inserted knode_bus via klist_node_attached().
+	 */
+	if (!kobject_sd_staged(&dev->kobj))
+		klist_add_tail(&dev->p->knode_bus, &sp->klist_devices);
 	return 0;
 
 out_subsys:
@@ -603,6 +612,24 @@ int bus_add_device(struct device *dev)
 	return error;
 }
 
+/**
+ * bus_add_device_publish - finish bus registration deferred past publication
+ * @dev: the now-published staged device
+ *
+ * Performs the bus klist insertion bus_add_device() deferred for a staged
+ * device; see the comment there.
+ */
+void bus_add_device_publish(struct device *dev)
+{
+	struct subsys_private *sp = bus_to_subsys(dev->bus);
+
+	if (!sp)
+		return;
+
+	klist_add_tail(&dev->p->knode_bus, &sp->klist_devices);
+	subsys_put(sp);
+}
+
 /**
  * bus_probe_device - probe drivers for a new device
  * @dev: device to probe
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5dea641cbdb6..caba5610a04d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3740,6 +3740,14 @@ int device_add(struct device *dev)
 	if (kobj)
 		dev->kobj.parent = kobj;
 
+	/*
+	 * Glue-dir parents are safe: cleanup_glue_dir() only reaps a glue
+	 * dir whose kref is 1, and this device holds a glue-dir reference
+	 * from get_device_parent() for the whole staged window.  Assigned
+	 * unconditionally so a reused kobject cannot carry a stale bit.
+	 */
+	kobject_set_sd_staged(&dev->kobj, dev_sysfs_staged(dev));
+
 	/* use parent numa_node */
 	if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
 		set_dev_node(dev, dev_to_node(parent));
@@ -3773,6 +3781,25 @@ int device_add(struct device *dev)
 		goto DPMError;
 	device_pm_add(dev);
 
+	/*
+	 * Publish the staged directory before anything makes the device
+	 * observable: the /sys/dev entry, the devtmpfs node,
+	 * BUS_NOTIFY_ADD_DEVICE, the KOBJ_ADD uevent and driver probing all
+	 * follow.  Once published, the deferred bus klist insertion puts the
+	 * device where driver_attach() can see it.  (The outside-in symlinks
+	 * whose target is this device -- class/bus/ACPI -- are created earlier
+	 * and resolve only at publication.)  Children added by notify hooks
+	 * inside the staged window were created staged-interior and are
+	 * published together with this device; their uevents may precede
+	 * their sysfs visibility.
+	 */
+	if (kobject_sd_staged(&dev->kobj)) {
+		error = sysfs_publish_dir(&dev->kobj);
+		if (error)
+			goto DevAttrError;
+		bus_add_device_publish(dev);
+	}
+
 	if (MAJOR(dev->devt)) {
 		error = device_create_file(dev, &dev_attr_dev);
 		if (error)
diff --git a/include/linux/device.h b/include/linux/device.h
index aee79fd6b32b..74701a8aa9d2 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -599,6 +599,15 @@ struct device_physical_location {
  *		ancestor device.
  * @DEV_FLAG_OFFLINE_DISABLED: If set, the device is permanently online.
  * @DEV_FLAG_OFFLINE: Set after successful invocation of bus type's .offline().
+ * @DEV_FLAG_SYSFS_STAGED: Opt in to staged sysfs registration.  device_add()
+ *		then builds the device's sysfs directory and all content added
+ *		before the publication point invisibly and off the sysfs root
+ *		lock, and publishes it in one step before the device becomes
+ *		observable to userspace or to drivers.  The per-device
+ *		sysfs-root lock cost stops scaling with the number of nodes in
+ *		the directory, which matters when many devices (for example
+ *		SR-IOV virtual functions) are registered in parallel.
+ *		Must be set before device_add().
  * @DEV_FLAG_COUNT: Number of defined struct_device_flags.
  */
 enum struct_device_flags {
@@ -612,6 +621,7 @@ enum struct_device_flags {
 	DEV_FLAG_OF_NODE_REUSED = 7,
 	DEV_FLAG_OFFLINE_DISABLED = 8,
 	DEV_FLAG_OFFLINE = 9,
+	DEV_FLAG_SYSFS_STAGED = 10,
 
 	DEV_FLAG_COUNT
 };
@@ -829,6 +839,7 @@ __create_dev_flag_accessors(dma_coherent, DEV_FLAG_DMA_COHERENT);
 __create_dev_flag_accessors(of_node_reused, DEV_FLAG_OF_NODE_REUSED);
 __create_dev_flag_accessors(offline_disabled, DEV_FLAG_OFFLINE_DISABLED);
 __create_dev_flag_accessors(offline, DEV_FLAG_OFFLINE);
+__create_dev_flag_accessors(sysfs_staged, DEV_FLAG_SYSFS_STAGED);
 
 #undef __create_dev_flag_accessors
 
-- 
2.47.3

