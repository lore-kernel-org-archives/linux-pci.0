Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209676;
	b=hab14laZzL118zI9WKcGdd/BQeb8irX7qZSEujmkB34Ml3Di3zIBbvIemsiJQEy1KPNZ
	 ZhEphzKuNegAMS3weBPhyj7iDky4oYRkzvynjQVDwSHLDNabHqxitmEbH5QO4efpV7FjW
	 S0ppdOvtlJtLO9mdgdChEhgoGendsToJrS4XQ6hhBrkHFU+SAwIhLDWSh1xw501y5Kf2a
	 nMQYh7fWa5GMOvcjENnyQ8ZYKRZeP1goLfPh/aMWeXQm3vESDOeoC1GjAcS7gC3Tunkcp
	 VH+4Vf3T1+BzL3wZ5i9x5bZRkP2g/a/gpQi1Osfu2pQXe1a7PiuIbGCIv5ZjUge6IAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209676;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=tKDYbVteP+Srj8vprL7bCD/bYRRDUmpJQCoSqvhOKYo=;
	b=ZV1NbTJZi/xc3tWXkijxsjvY4owbD6k6o9UUDveAO7SKH1WJk2QvCqaWSfAwPxeBbVjx
	 C7fAjPiBkz6xrrnQUIK7BNqt1r85hXVa6yfgLkWJ1G5odqActzqSRR91JPdxGoA8ax+/A
	 3H/v0VIkewwDf0omp/6YsqBwgDGb0NFKZRpQC2ZDk2AYiiHbsQWzs7iHrzqpYi3o32JlY
	 iSux+Lsw93Azto30IU6abdOVCBVWRCviE0BExnWJdICuWRfwjxYlc82+AOCoc3PWYM5mf
	 flE5W+1J2n7q21akc2Nl/YRnd7kIzaWl5U2IiHwbSwTRhlmO+rd/IypQlCAqfqi8ABA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QhxFYuRy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23D860A3817;
	Mon,  9 Nov 2026 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QhxFYuRy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CD91F0089F;
	Mon,  9 Nov 2026 07:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209675;
	bh=tKDYbVteP+Srj8vprL7bCD/bYRRDUmpJQCoSqvhOKYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QhxFYuRyFKaX0kw+eJ0ZIeKZMv8wZQRiIdrB28HTSQVaJTkSXU36YXgIzt8rab6Xs
	 qPVN/G9t6nqHYRQcdyGKRjTY5CP/wEpXmI6jQi+ziEiIUqnUAFm5ZFIQAHw5JD0KAi
	 iPDn0VBOIE33ZNVd58sCnqe+dAIzyP6wvFEQKFaXhP474uzczsLKoXQbq/uqQc+SsH
	 kIWoSnWt7sVY89O9Og/yH614Y4JC2bM/vcw7wFPUp7qdX8icF8l4r2T8nGL7Mo+jaf
	 pG0OJyS/yAH4gElkcXXeveFu6UeMK4w63qc3EJ97hbYxsUMRDNLtZUcNsTvc7sf3yN
	 Yp/2+MovUCvnA==
From: Leon Romanovsky <leon@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Cc: linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 11/19] driver core: Introduce a generic device trust level
Date: Mon,  9 Nov 2026 09:33:41 +0200
Message-ID: <20261109-device-trust-core-v2-11-3b12d9a9f861@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Device setup needs a common operating policy before driver probing or DMA
configuration. Userspace must be able to hold devices disabled until it
authorizes them.

Add generic trust admission with an immutable global boot policy. Restrict
the compatibility attachment API to explicit global full policy and full
operation, checking admission before probe. Keep the operating level
stable until teardown and retain normal locked admission for other callers.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt |   8 ++
 drivers/base/Makefile                           |   2 +-
 drivers/base/base.h                             |  16 +++
 drivers/base/core.c                             |   3 +
 drivers/base/dd.c                               |  38 ++++++-
 drivers/base/trust.c                            | 132 ++++++++++++++++++++++++
 include/linux/device.h                          |   8 ++
 include/linux/device/bus.h                      |  10 ++
 include/linux/device/trust.h                    |  44 ++++++++
 9 files changed, 258 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd94..81a936dca9476 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1259,6 +1259,14 @@ Kernel parameters
 	dell_smm_hwmon.fan_max=
 			[HW] Maximum configurable fan speed.
 
+	device_trust.default=
+			[KNL] Set the initial trust policy for all devices.
+			Format: { default | disabled | adversary | full }
+			If omitted or set to default, preserve bus policy.
+			Other values replace bus policy. The last valid value wins.
+			Full-only manual driver attachment requires full; other
+			global policies reject it before the probe callback.
+
 	dfltcc=		[HW,S390]
 			Format: { on | off | def_only | inf_only | always }
 			on:       s390 zlib hardware support for compression on
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 435710f643a5c..cb3bd5fa2287a 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -3,7 +3,7 @@
 
 obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   driver.o class.o platform.o \
-			   cpu.o firmware.o init.o map.o devres.o \
+			   cpu.o firmware.o init.o map.o devres.o trust.o \
 			   attribute_container.o transport_class.o \
 			   topology.o container.o property.o cacheinfo.o \
 			   swnode.o faux.o
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 866b2beb6baa2..ba8b5b3c51a65 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -10,6 +10,7 @@
  * shared outside of the drivers/base/ directory.
  *
  */
+#include <linux/device/trust.h>
 #include <linux/notifier.h>
 
 /**
@@ -88,6 +89,13 @@ struct driver_private {
 };
 #define to_driver(obj) container_of(obj, struct driver_private, kobj)
 
+enum device_trust_state {
+	DEVICE_TRUST_SELECTABLE,
+	DEVICE_TRUST_WAITING,
+	DEVICE_TRUST_AUTHORIZED,
+	DEVICE_TRUST_COMMITTED,
+};
+
 /**
  * struct device_private - structure to hold the private to the driver core
  *			   portions of the device structure.
@@ -105,6 +113,7 @@ struct driver_private {
  *			   dev_err_probe() for later retrieval via debugfs
  * @device: pointer back to the struct device that this structure is
  *	    associated with.
+ * @trust_state: policy admission state
  * @dead: This device is currently either in the process of or has been
  *	  removed from the system. Any asynchronous events scheduled for this
  *	  device should exit without taking any action.
@@ -121,6 +130,7 @@ struct device_private {
 	const struct device_driver *async_driver;
 	char *deferred_probe_reason;
 	struct device *device;
+	enum device_trust_state trust_state;
 	u8 dead:1;
 };
 #define to_device_private_parent(obj)	\
@@ -166,6 +176,12 @@ void bus_remove_driver(struct device_driver *drv);
 void device_release_driver_internal(struct device *dev, const struct device_driver *drv,
 				    struct device *parent);
 
+/* Full-only manual attachment uses the caller's subsystem serialization. */
+void device_trust_init_state(struct device *dev);
+int device_trust_prepare(struct device *dev, const struct device_driver *drv);
+int device_trust_prepare_full(struct device *dev, const struct device_driver *drv);
+void device_trust_clear(struct device *dev);
+
 void driver_detach(const struct device_driver *drv);
 void driver_deferred_probe_del(struct device *dev);
 void device_set_deferred_probe_reason(const struct device *dev, struct va_format *vaf);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index cbe05197d4a0b..6b94a163cda8d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3681,6 +3681,9 @@ int device_add(struct device *dev)
 	if (error)
 		goto name_error;
 
+	device_trust_init(dev);
+	device_trust_init_state(dev);
+
 	pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
 
 	parent = get_device(dev->parent);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 0f56c3d825731..449986f741009 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -558,12 +558,24 @@ static int __device_bind_driver(struct device *dev)
  */
 int device_bind_driver(struct device *dev)
 {
-	return __device_bind_driver(dev);
+	int ret;
+
+	if (dev->bus && dev->bus->trust_resolve)
+		return -EOPNOTSUPP;
+
+	ret = device_trust_prepare(dev, dev->driver);
+	if (ret)
+		return ret;
+
+	ret = __device_bind_driver(dev);
+	if (ret)
+		device_trust_clear(dev);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(device_bind_driver);
 
 /**
- * device_driver_attach_full - attach a driver using subsystem serialization
+ * device_driver_attach_full - attach a driver under the global full policy
  * @drv: driver to attach
  * @dev: device to attach it to
  *
@@ -576,6 +588,12 @@ EXPORT_SYMBOL_GPL(device_bind_driver);
  * It calls the bus or driver probe callback and publishes the binding without
  * performing the normal driver-core DMA, pinctrl or power-domain setup.
  *
+ * Requires device_trust.default=full and a full operating level. Runtime
+ * policy writes are disabled in this mode; boot policy exceptions still
+ * apply. When driver boot rules exist, an explicit device boot rule must
+ * exclude them for @dev. Buses with a trust resolver must use
+ * device_driver_attach().
+ *
  * Return: 0 on success, or a negative error before binding.
  */
 int device_driver_attach_full(const struct device_driver *drv, struct device *dev)
@@ -587,6 +605,10 @@ int device_driver_attach_full(const struct device_driver *drv, struct device *de
 	if (dev->driver)
 		return -EBUSY;
 
+	ret = device_trust_prepare_full(dev, drv);
+	if (ret)
+		return ret;
+
 	device_set_driver(dev, drv);
 	if (dev->bus->probe)
 		ret = dev->bus->probe(dev);
@@ -610,6 +632,7 @@ int device_driver_attach_full(const struct device_driver *drv, struct device *de
 	devres_release_all(dev);
 	device_set_driver(dev, NULL);
 	dev_set_drvdata(dev, NULL);
+	WRITE_ONCE(dev->trust_level, DEVICE_TRUST_DISABLED);
 	if (ret == -EPROBE_DEFER)
 		return -EAGAIN;
 	return ret;
@@ -739,6 +762,14 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
 	}
 
 re_probe:
+	ret = device_trust_prepare(dev, drv);
+	if (ret) {
+		device_links_no_driver(dev);
+		/* Report it like a probe error so a scan tries the next driver. */
+		ret = -ret;
+		goto done;
+	}
+
 	device_set_driver(dev, drv);
 
 	/* If using pinctrl, bind pins now before probing */
@@ -805,6 +836,7 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
 		if (dev->bus && dev->bus->dma_cleanup)
 			dev->bus->dma_cleanup(dev);
 		device_unbind_cleanup(dev);
+		device_trust_clear(dev);
 
 		goto re_probe;
 	}
@@ -831,6 +863,7 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
 pinctrl_bind_failed:
 	device_links_no_driver(dev);
 	device_unbind_cleanup(dev);
+	device_trust_clear(dev);
 done:
 	return ret;
 }
@@ -1420,6 +1453,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 			dev->bus->dma_cleanup(dev);
 
 		device_unbind_cleanup(dev);
+		device_trust_clear(dev);
 		device_links_driver_cleanup(dev);
 
 		klist_remove(&dev->p->knode_driver);
diff --git a/drivers/base/trust.c b/drivers/base/trust.c
new file mode 100644
index 0000000000000..6a71abf10b3bb
--- /dev/null
+++ b/drivers/base/trust.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <kunit/visibility.h>
+
+#include "base.h"
+
+static enum device_trust_policy device_trust_default_policy __ro_after_init;
+
+void device_trust_init_state(struct device *dev)
+{
+	dev->p->trust_state = dev->trust_policy == DEVICE_TRUST_POLICY_DISABLED ?
+		DEVICE_TRUST_WAITING : DEVICE_TRUST_SELECTABLE;
+}
+
+static int __device_trust_prepare(struct device *dev,
+				  const struct device_driver *drv, bool full_only)
+{
+	enum device_trust_policy policy;
+	enum device_trust_level level;
+	int ret;
+
+	policy = dev->trust_policy;
+
+	if (policy == DEVICE_TRUST_POLICY_DISABLED)
+		return -EPERM;
+	if (dev->bus && dev->bus->trust_resolve) {
+		ret = dev->bus->trust_resolve(dev, drv, policy, &level);
+		if (ret)
+			return ret;
+	} else {
+		level = policy == DEVICE_TRUST_POLICY_ADVERSARY ?
+			DEVICE_TRUST_ADVERSARY : DEVICE_TRUST_FULL;
+	}
+	if (level == DEVICE_TRUST_DISABLED)
+		return -EPERM;
+	if (full_only && level != DEVICE_TRUST_FULL)
+		return -EPERM;
+	if (dev->p->trust_state == DEVICE_TRUST_COMMITTED &&
+	    dev->trust_committed_level != level)
+		return -EINVAL;
+
+	WRITE_ONCE(dev->trust_committed_level, level);
+	dev->p->trust_state = DEVICE_TRUST_COMMITTED;
+	WRITE_ONCE(dev->trust_level, level);
+	return 0;
+}
+
+int device_trust_prepare(struct device *dev, const struct device_driver *drv)
+{
+	device_lock_assert(dev);
+	return __device_trust_prepare(dev, drv, false);
+}
+
+int device_trust_prepare_full(struct device *dev, const struct device_driver *drv)
+{
+	if (device_trust_default_policy != DEVICE_TRUST_POLICY_FULL)
+		return -EPERM;
+
+	return __device_trust_prepare(dev, drv, true);
+}
+
+void device_trust_clear(struct device *dev)
+{
+	device_lock_assert(dev);
+	WRITE_ONCE(dev->trust_level, DEVICE_TRUST_DISABLED);
+}
+
+/**
+ * device_get_trust_level - Return a device's active trust level
+ * @dev: device to inspect
+ *
+ * The value is stable from the start of DMA configuration through the end of
+ * DMA cleanup. An unbound device has %DEVICE_TRUST_DISABLED as its active
+ * trust level.
+ *
+ * Return: The active trust level for the current bind transaction.
+ */
+enum device_trust_level device_get_trust_level(const struct device *dev)
+{
+	return READ_ONCE(dev->trust_level);
+}
+EXPORT_SYMBOL_GPL(device_get_trust_level);
+
+/**
+ * device_is_adversarial - Test whether a device is operated as an adversary
+ * @dev: device to inspect
+ *
+ * Return: True when the active trust level is %DEVICE_TRUST_ADVERSARY.
+ */
+bool device_is_adversarial(const struct device *dev)
+{
+	return device_get_trust_level(dev) == DEVICE_TRUST_ADVERSARY;
+}
+EXPORT_SYMBOL_GPL(device_is_adversarial);
+
+static const char * const device_trust_policy_names[] = {
+	[DEVICE_TRUST_POLICY_DEFAULT] = "default",
+	[DEVICE_TRUST_POLICY_DISABLED] = "disabled",
+	[DEVICE_TRUST_POLICY_ADVERSARY] = "adversary",
+	[DEVICE_TRUST_POLICY_FULL] = "full",
+};
+
+static int __init device_trust_default_setup(char *str)
+{
+	int policy = match_string(device_trust_policy_names,
+				  ARRAY_SIZE(device_trust_policy_names), str);
+
+	if (policy < 0) {
+		pr_warn("device_trust: ignoring invalid default policy '%s'\n", str);
+		return 1;
+	}
+
+	device_trust_default_policy = policy;
+	return 1;
+}
+__setup("device_trust.default=", device_trust_default_setup);
+
+/**
+ * device_trust_init - Apply global boot policy before registration
+ * @dev: unregistered device with its initial policy set
+ */
+void device_trust_init(struct device *dev)
+{
+	if (device_trust_default_policy != DEVICE_TRUST_POLICY_DEFAULT)
+		dev->trust_policy = device_trust_default_policy;
+}
+EXPORT_SYMBOL_GPL(device_trust_init);
diff --git a/include/linux/device.h b/include/linux/device.h
index 42e966ebaa2d3..57d2e1b0d98ad 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -30,6 +30,7 @@
 #include <linux/device/class.h>
 #include <linux/device/devres.h>
 #include <linux/device/driver.h>
+#include <linux/device/trust.h>
 #include <linux/cleanup.h>
 #include <asm/device.h>
 
@@ -695,6 +696,10 @@ enum struct_device_flags {
  * @removable:  Whether the device can be removed from the system. This
  *              should be set by the subsystem / bus driver that discovered
  *              the device.
+ * @trust_policy: Requested operating policy, resolved before driver probe.
+ * @trust_level: Active trust level while a driver is bound, see
+ *		device_get_trust_level().
+ * @trust_committed_level: Operating level retained across bind transactions.
  * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
@@ -798,6 +803,9 @@ struct device {
 	struct device_physical_location *physical_location;
 
 	enum device_removable	removable;
+	enum device_trust_policy trust_policy;
+	enum device_trust_level trust_level;
+	enum device_trust_level trust_committed_level;
 
 	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
 };
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 9ef7538a9a7f2..ba2b5743a47cd 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -17,6 +17,7 @@
 #include <linux/kobject.h>
 #include <linux/klist.h>
 #include <linux/pm.h>
+#include <linux/device/trust.h>
 
 struct device_driver;
 struct fwnode_handle;
@@ -59,6 +60,11 @@ struct fwnode_handle;
  * @resume:	Called to bring a device on this bus out of sleep mode.
  * @num_vf:	Called to find out how many virtual functions a device on this
  *		bus supports.
+ * @trust_resolve: Resolve a requested trust policy to an active trust level
+ *		immediately before driver probe. The device lock is held and
+ *		@drv is the candidate driver, which dev->driver does not name
+ *		yet. Return 0 on success or a negative errno. This callback
+ *		must not enable the device.
  * @dma_configure:	Called to setup DMA configuration on a device on
  *			this bus.
  * @dma_cleanup:	Called to cleanup DMA configuration on a device on
@@ -102,6 +108,10 @@ struct bus_type {
 
 	int (*num_vf)(struct device *dev);
 
+	int (*trust_resolve)(struct device *dev,
+			     const struct device_driver *drv,
+			     enum device_trust_policy policy,
+			     enum device_trust_level *level);
 	int (*dma_configure)(struct device *dev);
 	void (*dma_cleanup)(struct device *dev);
 
diff --git a/include/linux/device/trust.h b/include/linux/device/trust.h
new file mode 100644
index 0000000000000..b8f5514cacec3
--- /dev/null
+++ b/include/linux/device/trust.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DEVICE_TRUST_H_
+#define _DEVICE_TRUST_H_
+
+#include <linux/types.h>
+
+struct device;
+
+/**
+ * enum device_trust_level - active trust level for a device
+ * @DEVICE_TRUST_DISABLED: The device cannot be operated by a driver
+ * @DEVICE_TRUST_ADVERSARY: Operate the device with adversarial restrictions
+ * @DEVICE_TRUST_FULL: Operate the device with the usual kernel privileges
+ *
+ * Active trust levels are discrete states, not an ordered privilege scale.
+ */
+enum device_trust_level {
+	DEVICE_TRUST_DISABLED,
+	DEVICE_TRUST_ADVERSARY,
+	DEVICE_TRUST_FULL,
+};
+
+/**
+ * enum device_trust_policy - requested device trust policy
+ * @DEVICE_TRUST_POLICY_DEFAULT: Let the bus select the active trust level
+ * @DEVICE_TRUST_POLICY_DISABLED: Request that the device remain disabled
+ * @DEVICE_TRUST_POLICY_ADVERSARY: Request adversarial operation
+ * @DEVICE_TRUST_POLICY_FULL: Request normal operation
+ *
+ * A requested policy is resolved to an active trust level before a driver is
+ * probed.
+ */
+enum device_trust_policy {
+	DEVICE_TRUST_POLICY_DEFAULT,
+	DEVICE_TRUST_POLICY_DISABLED,
+	DEVICE_TRUST_POLICY_ADVERSARY,
+	DEVICE_TRUST_POLICY_FULL,
+};
+
+void device_trust_init(struct device *dev);
+enum device_trust_level device_get_trust_level(const struct device *dev);
+bool device_is_adversarial(const struct device *dev);
+
+#endif /* _DEVICE_TRUST_H_ */

-- 
2.56.0

