Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA1035F198
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496060; cv=none; b=u0XG+ndky0WXYT95dbHtyOnc8oc7edJni2Qo8KHsixFzPyPS7Dv8CJerYuPbuFT5SPN/74u9+16jvG6CD6+HI4632De6rGYBjaRW8PJ2wmNPjzeyVmZt2LP7kRMwNjbXhBgzsAkn7FhyFmVcMW4S/gQFN3KzcVMTKDOWNxIG0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496060; c=relaxed/simple;
	bh=D/0yi+CtqY4hDPDAw3TlST2b+9hFuF91sxba99zcYHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kgq0F8tuDPtT5Ikax1ZBEKugZEjtlkrV05sVPZ5j3sMnaRApruYNI11hDrmdeO5oZAvCgT3MDhyiO5VB0/eKkI7gngf7mim0lcJp5Y6lxjmn+rKDepdLXxYJpwlFdpWWeWCA9fSsrfMkyY8JGWioxnPJU2wv7Ddlp0U7QhkRem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aa9yNKu4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aa9yNKu4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496058; x=1804032058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D/0yi+CtqY4hDPDAw3TlST2b+9hFuF91sxba99zcYHc=;
  b=aa9yNKu4PdENQucSMIS2+qFOO+HUyrVdULuR/pfMiS1Hmy+1W1xWeh9/
   3aeO4wQYabfczxGmnuP093XSBpI6thMWIie//gtM3g3juE1gilmgBv8lD
   zH/kxK8DO0slFEKDKHoFeBLGIbfWdnQh7J+h0S1MOdXRn84IzmeVR2E00
   lcGw6Mf01ySbXfqHQQHCbpDljbL38RahHb78/U3c9gX0EddIkBOgqj8NP
   BwOL7/vGsPd1t+0Rf3MvPTnFJylzbQscjTRUkDwS8rLHlOxpZ/fk06lnM
   JRfAsNyzK4d5PppX9qD7pURFrUbtyMn2ydaR/Ue6zjT44eImZSwGgKcnV
   A==;
X-CSE-ConnectionGUID: 1qO1GXX2T5WS/EZsSI6EgA==
X-CSE-MsgGUID: qj45eLIlQZeXIm+Prr28eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73482882"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73482882"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:00:55 -0800
X-CSE-ConnectionGUID: EzC8QYZ3TamMb+WbOkMk6g==
X-CSE-MsgGUID: Cj8Fy/z4TJmLulUGpPd4kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="214967087"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2026 16:00:55 -0800
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
	jgg@nvidia.com,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 05/19] device core: Autoprobe considered harmful?
Date: Mon,  2 Mar 2026 16:01:53 -0800
Message-ID: <20260303000207.1836586-6-dan.j.williams@intel.com>
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

The threat model of PCI Trusted Execution Environment Device Interface
Security Protocol (TDISP), is that an adversary may be impersonating the
device's identity, redirecting the device's MMIO interface, and/or
snooping/manipulating the physical link. Outside of PCI TDISP, PCI ATS
(that allows IOMMU bypass) comes to mind as another threat vector that
warrants additional device verification beyond whether ACPI enumerates the
device as "internal" [1].

The process of verifying a device ranges from the traditional default
"accept everything" to gathering signed evidence from a locked device,
shipping it to a relying party and acting on that disposition. That policy
belongs in userspace. A natural way for userspace to get a control point
for verifying a device before use is when the driver for the device comes
from a module.

For deployments that are concerned about adversarial devices, introduce a
mechanism to disable autoprobe. When a driver originates from a module,
consult that driver's autoprobe policy at initial device or driver attach.

Note that with TDISP, unaccepted devices do not have access to private
memory (so called "T=0" mode). However, a deployment may still not want to
operate more than a handful of boot devices until confirming the system
device topology with a verifier.

Yes, this is a security vs convenience tradeoff. Yes, devices with
non-modular drivers are out of scope. Yes, there are known regression cases
for subsystems where device objects are expected to auto-attach outside of
fatal probe failure. For navigating regressions, a per-module "autoprobe"
option is included to allow fine grained policy.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Roman Kisel <romank@linux.microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Link: http://lore.kernel.org/6971b9406d069_1d33100df@dwillia2-mobl4.notmuch [1]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/Kconfig                  | 24 ++++++++++++++++++++++++
 Documentation/ABI/stable/sysfs-module | 10 ++++++++++
 drivers/base/base.h                   |  1 +
 include/linux/module.h                | 14 ++++++++++++++
 drivers/base/bus.c                    |  7 ++++++-
 drivers/base/dd.c                     | 26 +++++++++++++++++++++++---
 kernel/module/main.c                  | 13 +++++++++++++
 7 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index d4743bf978ec..7c1da5df9745 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -253,4 +253,28 @@ config CONFIDENTIAL_DEVICES
 	depends on ARCH_HAS_CC_PLATFORM
 	bool
 
+config MODULES_AUTOPROBE
+	bool "Automatic probe of drivers from modules"
+	default y
+	help
+	  Say Y for the typical and traditional Linux behavior of automatically
+	  attaching devices to drivers when a module is loaded.
+
+	  Say N to opt into a threat model where userspace verification of a
+	  device is required before driver attach. This includes Confidential
+	  Computing use cases where the device needs to have its configuration
+	  locked and verified by a relying party. It also includes use cases
+	  like leaving devices with Address Translation (IOMMU protection
+	  bypass) capability disabled until userspace attests the device and
+	  binds a driver.
+
+	  This default value can be overridden by the "autoprobe" module option.
+	  Note that some subsystems may not be prepared for autoprobe to be
+	  disabled, take care to test your selected drivers.  Built-in drivers are
+	  unaffected by this policy and will autoprobe unless the bus itself has
+	  disabled autoprobe.
+
+	  If in doubt, say Y. The N case is only for expert configurations, and
+	  selective "autoprobe=0" in modprobe policy is the common expectation.
+
 endmenu
diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
index 397c5c850894..1085d0942b17 100644
--- a/Documentation/ABI/stable/sysfs-module
+++ b/Documentation/ABI/stable/sysfs-module
@@ -55,3 +55,13 @@ Description:
 		requests, the "driver_async_probe=..." kernel command line, the
 		"async_probe" module option, then this default. Write a valid
 		boolean value to toggle this policy.
+
+What:		/sys/module/module/parameters/modules_autoprobe
+Description:
+		(RW) Emits "1" if drivers from loadable modules automatically
+		attach to their devices. Emits "0" if userspace is responsible
+		to attach devices to drivers post module load, or device
+		arrival. This value defaults to CONFIG_MODULES_AUTOPROBE compile
+		to configuration and is overridden by either a bus's autoprobe
+		policy or the per-module "autoprobe" option. Write a valid
+		boolean value to toggle this policy.
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 1ae9a1679504..908ba366b8d2 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -230,6 +230,7 @@ void device_block_probing(void);
 void device_unblock_probing(void);
 void deferred_probe_extend_timeout(void);
 void driver_deferred_probe_trigger(void);
+bool driver_autoprobe(struct device_driver *drv);
 const char *device_get_devnode(const struct device *dev, umode_t *mode,
 			       kuid_t *uid, kgid_t *gid, const char **tmp);
 
diff --git a/include/linux/module.h b/include/linux/module.h
index d80c3ea57472..7db34ef0400c 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -450,6 +450,7 @@ struct module {
 #endif
 
 	bool async_probe_requested;
+	bool autoprobe;
 
 	/* Exception table */
 	unsigned int num_exentries;
@@ -761,6 +762,14 @@ static inline bool module_requested_async_probing(struct module *module)
 	return module && module->async_probe_requested;
 }
 
+static inline bool module_requested_autoprobe(struct module *module)
+{
+	/* Built-in modules autoprobe by default. */
+	if (!module)
+		return true;
+	return module->autoprobe;
+}
+
 static inline bool is_livepatch_module(struct module *mod)
 {
 #ifdef CONFIG_LIVEPATCH
@@ -865,6 +874,11 @@ static inline bool module_requested_async_probing(struct module *module)
 	return false;
 }
 
+static inline bool module_requested_autoprobe(struct module *module)
+{
+	/* Built-in modules autoprobe by default. */
+	return true;
+}
 
 static inline void set_module_sig_enforced(void)
 {
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 9eb7771706f0..26ca98cd2a74 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -677,6 +677,11 @@ static ssize_t uevent_store(struct device_driver *drv, const char *buf,
 }
 static DRIVER_ATTR_WO(uevent);
 
+bool driver_autoprobe(struct device_driver *drv)
+{
+	return module_requested_autoprobe(drv->owner);
+}
+
 /**
  * bus_add_driver - Add a driver to the bus.
  * @drv: driver.
@@ -711,7 +716,7 @@ int bus_add_driver(struct device_driver *drv)
 		goto out_unregister;
 
 	klist_add_tail(&priv->knode_bus, &sp->klist_drivers);
-	if (sp->drivers_autoprobe) {
+	if (sp->drivers_autoprobe && driver_autoprobe(drv)) {
 		error = driver_attach(drv);
 		if (error)
 			goto out_del_list;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 349f31bedfa1..926e120b3cc4 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -917,6 +917,12 @@ struct device_attach_data {
 	 * driver, we'll encounter one that requests asynchronous probing.
 	 */
 	bool have_async;
+
+	/*
+	 * On initial device arrival driver attach is subject to
+	 * driver_autoprobe() policy.
+	 */
+	bool initial_probe;
 };
 
 static int __device_attach_driver(struct device_driver *drv, void *_data)
@@ -926,6 +932,13 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 	bool async_allowed;
 	int ret;
 
+	/*
+	 * At initial probe of a newly arrived device, honor the policy to defer
+	 * attachment to explicit userspace bind request.
+	 */
+	if (data->initial_probe && !driver_autoprobe(drv))
+		return 0;
+
 	ret = driver_match_device(drv, dev);
 	if (ret == 0) {
 		/* no match */
@@ -998,8 +1011,13 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 	put_device(dev);
 }
 
-static int __device_attach(struct device *dev, bool allow_async)
+#define DEVICE_ATTACH_F_ASYNC BIT(0)
+#define DEVICE_ATTACH_F_INITIAL BIT(1)
+
+static int __device_attach(struct device *dev, unsigned long flags)
 {
+	bool allow_async = flags & DEVICE_ATTACH_F_ASYNC;
+	bool initial_probe = flags & DEVICE_ATTACH_F_INITIAL;
 	int ret = 0;
 	bool async = false;
 
@@ -1023,6 +1041,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			.dev = dev,
 			.check_async = allow_async,
 			.want_async = false,
+			.initial_probe = initial_probe,
 		};
 
 		if (dev->parent)
@@ -1071,7 +1090,7 @@ static int __device_attach(struct device *dev, bool allow_async)
  */
 int device_attach(struct device *dev)
 {
-	return __device_attach(dev, false);
+	return __device_attach(dev, 0);
 }
 EXPORT_SYMBOL_GPL(device_attach);
 
@@ -1083,7 +1102,8 @@ void device_initial_probe(struct device *dev)
 		return;
 
 	if (sp->drivers_autoprobe)
-		__device_attach(dev, true);
+		__device_attach(dev, DEVICE_ATTACH_F_INITIAL |
+					     DEVICE_ATTACH_F_ASYNC);
 
 	subsys_put(sp);
 }
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 710ee30b3bea..3fca2bc3217d 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3001,6 +3001,10 @@ void flush_module_init_free_work(void)
 static bool async_probe;
 module_param(async_probe, bool, 0644);
 
+/* Default value for module->autoprobe */
+bool modules_autoprobe = IS_ENABLED(CONFIG_MODULES_AUTOPROBE);
+module_param(modules_autoprobe, bool, 0644);
+
 /*
  * This is where the real work happens.
  *
@@ -3304,6 +3308,14 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
 		return 0;
 	}
 
+	if (strcmp(param, "autoprobe") == 0) {
+		bool autoprobe;
+
+		if (kstrtobool(val, &autoprobe) >= 0)
+			mod->autoprobe = autoprobe;
+		return 0;
+	}
+
 	/* Check for magic 'dyndbg' arg */
 	ret = ddebug_dyndbg_module_param_cb(param, val, modname);
 	if (ret != 0)
@@ -3473,6 +3485,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 		goto bug_cleanup;
 
 	mod->async_probe_requested = async_probe;
+	mod->autoprobe = modules_autoprobe;
 
 	/* Module is ready to execute: parsing args may do that. */
 	after_dashes = parse_args(mod->name, mod->args, mod->kp, mod->num_kp,
-- 
2.52.0

