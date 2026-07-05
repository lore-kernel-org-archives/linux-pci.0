Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7F363089
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289315; cv=none; b=nWCo75cKavi4CvjC0xbt3wg6rf4k4kVG0MDY+CM8boWL1pLMjaDcs3UyvlTXbVEGEiM2jo/Nr5Q4nzSxEDiEZ3Ty6AkrVFp0H/pVmWjrL+ju0Sd9HnaPPdjJhYJaAFt9HIaWdAZa9ohHAADajLEbhyZJ/Iih9/o5CMXp4QshaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289315; c=relaxed/simple;
	bh=lB0Uwdd49bTxuSCetp8JhbpabVUwT9m9GvHRDConO6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lW/KyV/b0XXqnea8mlPXG2rl9RIYwNnncb47d4euAhFEpOc95oG6HfnrVMAR2beIJuSEmMxeTw30c3NllBbUe44aOKpF+Qtn7kyKP2TDhLv7UtwwFCz3+Fw6KTva1UHXWcKxs4X8chRFF34luGdO9vfH8OTPd+ZL8r9YBBIrx2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPRPxtir; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPRPxtir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBD31F000E9;
	Sun,  5 Jul 2026 22:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289314;
	bh=vGvTccp18slMQK+gRwx0VSmoMI6t2tnpqPg8n2OFhJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cPRPxtirceqpsFpa0pEH5WeD82gpkkVfrk+oe3Cbzoe6slPChx65U5jEkK5SaNeU5
	 kdCe08P4Sddk/Gpdja2Sh4TG1Q0iW64Y2ZZQ+qehAYV61p/+Ru6SFTLz9DnmTW/qR/
	 Lcmki0dRxW840m7zwcyUA4PalTeaExnmG2qhwY/ooRznKiLfc40SL0vGE11W+xq83d
	 NxP5EMAbSFu6laYNU5aRhcytNr6GAk7Y/mpKqIow2OQEtTHTE4LgjtjHgoChE+9Z4Z
	 KSCRfsBi5xNgVv6Ms/f03OMfZMy6G61/cyT7o+L2TJchCr6YxcWOXAjaU6qdJiZDjb
	 kZCQOxkRfiAGw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id C86D2F40068;
	Sun,  5 Jul 2026 18:08:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 05 Jul 2026 18:08:32 -0400
X-ME-Sender: <xms:4NVKahBFYg3S24ERXf9eU2y4mrZofd48osPe0fj8nlnPcPFzWrjCQw>
    <xme:4NVKarYWp2PcKWlyc7dRQQOzWLzaoRDrsgrqEf8UZkC4wIRyOHSTmL6sqL1KRa4o6
    sqRe6NbvcOnC2EwJ5NuTbEeCxnz7IbaCyXFFjwCo6m2d0aXzOquUbk>
X-ME-Received: <xmr:4NVKaoEWaFmmQ2a-2CmhVm7Gn5a4L3nLS-x14vzhWCeDbkWbJK1Riv7SIMD0t2J1M2LzamloCuo_HOO-NReGBQpJe1bLuuDrD_Y>
X-ME-Proxy-Cause: dmFkZTFW4DrwsoA7jiPQ/SYxavjnKvTVwJOvM8+n4Cymh77lN7HIpr25Nt433UIQsF1QRC
    TtK3JnGUBp3zX2SJnjWLV8YEWH5/n64nuTY+54qwlL5101cxawSFo1WJ8SjJCy8ZoRC8kc
    DpuD7J09e/T4vo0cHPFPH7vWIClVAcN6vERTMn+gJKrEEItEHHoEBxN1IX93vsoLKnXgAv
    P1Pqz583odCRFNMps31OlwzygSPPLVlg3lbc/6i7nGVlb7Vx9dk75jHQ6SmV37tvlgoJuN
    7OTkIW2lBpFRLxtqFq/WmDjpwUnVU5zxWqsPn75cQxnjchBgJuZK1TY7jrbnd/27KnuvF/
    Mmh+kzl/HHWCNTcZfzWOSqa10ROspmHwyW6UZvfoBjrTA6roN82s/TZeOIadeUk/E3dd6T
    Gsid3xf8mXAhNCHiPo8VnJ/Yqea8paxc8v4pccMRSstaWq8gCHQ/w2MGQkFJCb2VGefc4O
    uXaD8YrTw3ylnD8/FLQjjs8ZJWl8PSOHGH+GWdRHGDYS7o2yzhnvMYXLR4pQOb82K5BEMr
    e/5vR4Gcl0ebP2ggnnv+K2Dd+efm6C9OGUp5f9Sq2etaJXO+2Y9stAnMNkPLaTQ7smNJ7L
    ZSoboQM47QKUK4mCTWEpt802OQZ0cAu8eOqFY8P03kW5W10rKG0epxeqWycA
X-ME-Proxy: <xmx:4NVKavtk6IX88i3arGfOuhu91Vbj2WNPAwvC7H9YhqSSnzyVWarrnw>
    <xmx:4NVKauI5fAuDfPFckes0AXdyEHkCEh7n6yFoVL4mfUO77WpQaJXD0Q>
    <xmx:4NVKatNHmZhsUpG0wmX_P6Oud6Jl0lEWGJlXNjNJuYEjkYH3TipGTQ>
    <xmx:4NVKamZIGeqyxfzzgyP_Mfk_gYdTWGS3K10kY1wWievu1pofi9mUnQ>
    <xmx:4NVKapwr5l9OhRHsqAkiLzLqG5qMKKklmFop61PyK0CyA71o6rIwg4qy>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:08:32 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 08/15] device core: Initial device trust infrastructure
Date: Sun,  5 Jul 2026 15:08:12 -0700
Message-ID: <20260705220819.2472765-9-djbw@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705220819.2472765-1-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a per-device trust concept [1]. To start, it plumbs "auto" and
"none" levels to enable a scheme of requiring explicit opt-in to operate a
device. This supports a Confidential Computing use case of operating a
limited / vetted device and driver set to bootstrap the environment. It
leans on module policy to effect changes to device's trust level.

The motivations for using module policy to effect trust are:

1/ It exists, no new ABI needed to inject "device firewall" policy into the
   kernel [2].
2/ Trust is a function of how the device is operated. A driver can be
   trusted to carefully operate an untrusted device.

It may prove too coarse for some situations, like a driver that talks to a
mix of trusted and untrusted devices, or a module that contains multiple
drivers, but it is a place to start.

Specifically this "module trust" scheme allows for only attaching drivers
from built-in modules by default, or modules that explicitly pass a
"trust=auto" option by building with CONFIG_DEVICE_TRUST_NONE=y. Modules
can also be configured to skip device attach by default by setting
/sys/module/module/parameters/require_trust.

The new dev->p->trust level is the operational trust level of a device. It is
only in effect after device_add(). It is private to the device core because
the "tcb" level is not suitable to be changed while a driver is attached to
the device. The result force_dma_unencrypted() must be stable while the
device is attached to its driver. That core coordination responsibility is
not suitable to export to non-core code.

Note that the overly trivial helper builtin_driver_trust() grows support
for another trust level in a follow-on change.

Also note that the IOMMU claims in the Kconfig commentary, where it says
"possible" and "where available" imply follow-on work to assign
DEVICE_TRUST_NONE devices to an IOMMU blocked domain.

Link: http://lore.kernel.org/2026032621-astound-mounted-07a6@gregkh [1]
Link: https://lwn.net/Articles/865918/ [2]
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Daniel Gomez <da.gomez@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 drivers/base/Kconfig                  | 57 ++++++++++++++++++++
 drivers/base/Makefile                 |  1 +
 Documentation/ABI/stable/sysfs-module |  7 +++
 drivers/base/base.h                   | 15 ++++++
 include/linux/device/trust.h          | 42 +++++++++++++++
 include/linux/module.h                |  6 ++-
 drivers/base/core.c                   |  7 +++
 drivers/base/dd.c                     |  5 ++
 drivers/base/trust.c                  | 77 +++++++++++++++++++++++++++
 kernel/module/main.c                  | 13 +++++
 10 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/device/trust.h
 create mode 100644 drivers/base/trust.c

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index e3929fe6b240..a08523d348d8 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -262,4 +262,61 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
 	  command line option on every system/board your kernel is expected to
 	  work on.
 
+config DEVICE_TRUST
+	bool "Device core support for specifying trust levels for devices"
+	help
+	  Enable support for generic device trust levels when building a kernel
+	  that needs to operate in the presence of potentially adversarial
+	  devices. This is selected by buses that want to operate devices with
+	  reduced privileges, like externally connected devices, and it is a
+	  pre-requisite for operating devices with access to private memory in a
+	  Confidential Computing VM. See
+	  Documentation/ABI/testing/sysfs-kernel-iommu_groups for the type of
+	  IOMMU enforcement in effect.
+
+choice
+	prompt "Default device trust"
+	default DEVICE_TRUST_AUTO
+	depends on DEVICE_TRUST
+	help
+	  Specify the device trust level at initial attachment. Any choice other
+	  than "Auto" assumes auditing the built-in driver set for trusted
+	  drivers, and an enlightened userspace modprobe policy for other
+	  devices + drivers.
+
+config DEVICE_TRUST_NONE
+	bool "None"
+	help
+	  Devices are disallowed from attaching to a driver, and where
+	  possible, the device is blocked by an IOMMU from accessing
+	  assets.
+
+config DEVICE_TRUST_AUTO
+	bool "Auto"
+	help
+	  Typical historical driver model, devices eagerly attempt to attach to
+	  a driver and deploy all available mechanisms to allow performant
+	  direct memory access.
+
+endchoice
+
+choice
+	prompt "Trust devices with built-in drivers"
+	default BUILTIN_DEVICE_TRUST_AUTO
+	depends on DEVICE_TRUST
+	help
+	  Built-in drivers always bind to devices they match. Only
+	  select a setting other than "Auto" when building a kernel image
+	  targeted for use in Confidential Computing or other known
+	  adversarial environments.
+
+config BUILTIN_DEVICE_TRUST_AUTO
+	bool "Auto"
+	help
+	  Typical historical driver model, devices eagerly attempt to attach to
+	  a driver and deploy all available mechanisms to allow performant
+	  direct memory access This trust level does not grant TCB privileges.
+
+endchoice
+
 endmenu
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 02bdc4f74019..0744511c0599 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -8,6 +8,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   topology.o container.o property.o cacheinfo.o \
 			   swnode.o faux.o
 obj-$(CONFIG_AUXILIARY_BUS) += auxiliary.o
+obj-$(CONFIG_DEVICE_TRUST) += trust.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-y			+= power/
 obj-$(CONFIG_ISA_BUS_API)	+= isa.o
diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
index 397c5c850894..5c4863f65d03 100644
--- a/Documentation/ABI/stable/sysfs-module
+++ b/Documentation/ABI/stable/sysfs-module
@@ -55,3 +55,10 @@ Description:
 		requests, the "driver_async_probe=..." kernel command line, the
 		"async_probe" module option, then this default. Write a valid
 		boolean value to toggle this policy.
+
+What:		/sys/module/module/parameters/require_trust
+Description:
+		(RW) Emits "1" if modules are required to specify a trust=
+		option on load to permit driver(s) in the module to attach to
+		matched devices. By default drivers always attach on match
+		unless the kernel was compiled with DEVICE_TRUST_NONE.
diff --git a/drivers/base/base.h b/drivers/base/base.h
index a5b7abc10ff0..e9d508521b5e 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -103,6 +103,7 @@ struct driver_private {
  *			   dev_err_probe() for later retrieval via debugfs
  * @device: pointer back to the struct device that this structure is
  *	    associated with.
+ * @trust: device operational trust level
  * @dead: This device is currently either in the process of or has been
  *	  removed from the system. Any asynchronous events scheduled for this
  *	  device should exit without taking any action.
@@ -119,6 +120,7 @@ struct device_private {
 	const struct device_driver *async_driver;
 	char *deferred_probe_reason;
 	struct device *device;
+	enum device_trust	trust;
 	u8 dead:1;
 };
 #define to_device_private_parent(obj)	\
@@ -149,6 +151,19 @@ void auxiliary_bus_init(void);
 #else
 static inline void auxiliary_bus_init(void) { }
 #endif
+#ifdef CONFIG_DEVICE_TRUST
+bool device_trust_bind(const struct device_driver *drv, struct device *dev);
+void device_initialize_trust(struct device *dev);
+#else
+static inline void device_initialize_trust(struct device *dev)
+{
+}
+static inline bool device_trust_bind(const struct device_driver *drv,
+				     struct device *dev)
+{
+	return true;
+}
+#endif
 
 struct kobject *virtual_device_parent(void);
 
diff --git a/include/linux/device/trust.h b/include/linux/device/trust.h
new file mode 100644
index 000000000000..3377d26dc485
--- /dev/null
+++ b/include/linux/device/trust.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2026 NVIDIA Corporation & Affiliates */
+#ifndef __DEVICE_TRUST_H__
+#define __DEVICE_TRUST_H__
+
+/**
+ * enum device_trust - Level of restrictions and privileges for a
+ * device. Trust is initially assigned by the bus, and the bus is
+ * responsible for coordinating transitions between trust levels with
+ * DMA/IOMMU and its own device security mechanisms.
+ *
+ * @DEVICE_TRUST_UNSET: Unregistered device object with no current bus
+ * @DEVICE_TRUST_NONE: Blocked when idle, cannot bind
+ * @DEVICE_TRUST_AUTO: All typical privileges granted
+ */
+enum device_trust {
+	DEVICE_TRUST_UNSET,
+	DEVICE_TRUST_NONE,
+	DEVICE_TRUST_AUTO,
+};
+
+#define DEVICE_DEFAULT_TRUST                                        \
+	(IS_ENABLED(CONFIG_DEVICE_TRUST_NONE) ? DEVICE_TRUST_NONE : \
+						DEVICE_TRUST_AUTO)
+
+struct device;
+struct device_driver;
+
+#ifdef CONFIG_DEVICE_TRUST
+void module_driver_trust(struct module *mod, const char *val);
+void module_driver_trust_init(struct module *mod, bool distrust);
+#else
+static inline void module_driver_trust(struct module *mod, const char *val)
+{
+	pr_warn("module: %s: trust= support disabled\n", mod->name);
+}
+static inline void module_driver_trust_init(struct module *mod, bool distrust)
+{
+}
+#endif
+
+#endif /* __DEVICE_TRUST_H__ */
diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..0315035e6b3b 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -29,6 +29,7 @@
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
 #include <linux/dynamic_debug.h>
+#include <linux/device/trust.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -443,6 +444,10 @@ struct module {
 #endif
 
 	bool async_probe_requested;
+#ifdef CONFIG_DEVICE_TRUST
+	/* Trust level override for devices matching this module's drivers. */
+	enum device_trust trust;
+#endif
 
 	/* Exception table */
 	unsigned int num_exentries;
@@ -865,7 +870,6 @@ static inline bool module_requested_async_probing(struct module *module)
 	return false;
 }
 
-
 /* Dereference module function descriptor */
 static inline
 void *dereference_module_function_descriptor(struct module *mod, void *ptr)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4d026682944f..155ff5852286 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3754,6 +3754,13 @@ int device_add(struct device *dev)
 		fw_devlink_link_device(dev);
 	}
 
+	/*
+	 * The bus and all device add notifiers have had a chance to
+	 * initialize trust, set a fallback default in case the trust
+	 * level is not yet established.
+	 */
+	device_initialize_trust(dev);
+
 	/*
 	 * The moment the device was linked into the bus's "klist_devices" in
 	 * bus_add_device() then it's possible that probe could have been
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 60c005223844..f0b2d58c89a0 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -857,6 +857,11 @@ static int __driver_probe_device(const struct device_driver *drv, struct device
 	dev_dbg(dev, "bus: '%s': %s: matched device with driver %s\n",
 		drv->bus->name, __func__, drv->name);
 
+	if (!device_trust_bind(drv, dev)) {
+		dev_dbg(dev, "not trusted to bind\n");
+		return -ENODEV;
+	}
+
 	pm_runtime_get_suppliers(dev);
 	if (dev->parent)
 		pm_runtime_get_sync(dev->parent);
diff --git a/drivers/base/trust.c b/drivers/base/trust.c
new file mode 100644
index 000000000000..0fd494e1557d
--- /dev/null
+++ b/drivers/base/trust.c
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2026 NVIDIA Corporation & Affiliates */
+
+#include <linux/device.h>
+#include <linux/device/trust.h>
+#include <linux/module.h>
+#include "base.h"
+
+void device_initialize_trust(struct device *dev)
+{
+	if (dev->p->trust == DEVICE_TRUST_UNSET)
+		dev->p->trust = DEVICE_DEFAULT_TRUST;
+}
+
+/* Driver trust policy requires modules, builtin drivers always attach */
+static enum device_trust builtin_driver_trust(void)
+{
+	return DEVICE_TRUST_AUTO;
+}
+
+static enum device_trust driver_trust(struct module *mod)
+{
+	if (!mod)
+		return builtin_driver_trust();
+	return mod->trust;
+}
+
+/*
+ * @dev matches @drv and is locked for probe. Check if the driver has
+ * policy on trusting devices it attaches, update the device's trust
+ * level from that policy. Trust privileges beyond driver bind are
+ * realized in a bus's ->dma_configure().
+ */
+bool device_trust_bind(const struct device_driver *drv, struct device *dev)
+{
+	enum device_trust drv_trust = driver_trust(drv->owner);
+
+	if (drv_trust != DEVICE_TRUST_UNSET)
+		dev->p->trust = drv_trust;
+	return dev->p->trust > DEVICE_TRUST_NONE;
+}
+
+static const char * const device_trust_names[] = {
+	[DEVICE_TRUST_NONE]	 = "none",
+	[DEVICE_TRUST_AUTO]	 = "auto",
+};
+
+static enum device_trust device_trust_parse(const char *name)
+{
+	int i;
+
+	if (!name)
+		return DEVICE_TRUST_UNSET;
+
+	for (i = 0; i < ARRAY_SIZE(device_trust_names); i++)
+		if (device_trust_names[i] &&
+		    sysfs_streq(name, device_trust_names[i]))
+			return i;
+	return DEVICE_TRUST_UNSET;
+}
+
+void module_driver_trust(struct module *mod, const char *val)
+{
+	mod->trust = device_trust_parse(val);
+}
+
+/*
+ * Honor the module core forcing all modules to no trust by default,
+ * otherwise fallback to the compile-time default for all devices
+ */
+void module_driver_trust_init(struct module *mod, bool require_trust)
+{
+	if (require_trust)
+		mod->trust = DEVICE_TRUST_NONE;
+	else
+		mod->trust = DEVICE_DEFAULT_TRUST;
+}
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..3e1fe9966d50 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -36,6 +36,7 @@
 #include <linux/notifier.h>
 #include <linux/sched.h>
 #include <linux/device.h>
+#include <linux/device/trust.h>
 #include <linux/string.h>
 #include <linux/mutex.h>
 #include <linux/rculist.h>
@@ -3068,6 +3069,12 @@ void flush_module_init_free_work(void)
 static bool async_probe;
 module_param(async_probe, bool, 0644);
 
+#ifdef CONFIG_DEVICE_TRUST
+/* Default value for module trust. When true, trust= override required */
+static bool require_trust;
+module_param(require_trust, bool, 0644);
+#endif
+
 /*
  * This is where the real work happens.
  *
@@ -3375,6 +3382,11 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
 		return 0;
 	}
 
+	if (strcmp(param, "trust") == 0) {
+		module_driver_trust(mod, val);
+		return 0;
+	}
+
 	/* Check for magic 'dyndbg' arg */
 	ret = ddebug_dyndbg_module_param_cb(param, val, modname);
 	if (ret != 0)
@@ -3544,6 +3556,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 		goto bug_cleanup;
 
 	mod->async_probe_requested = async_probe;
+	module_driver_trust_init(mod, require_trust);
 
 	/* Module is ready to execute: parsing args may do that. */
 	after_dashes = parse_args(mod->name, mod->args, mod->kp, mod->num_kp,
-- 
2.54.0

