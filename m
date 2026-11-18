Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030114;
	b=bevWNoDeIOvEH+670wfRDQgvaLLNkkTR4o87VnbvMoa4wDoLDUothmYp7Pkac2EYgSqz
	 BwJxY//7sjd25KRX2hNsJ/56OqkDNlzZvl2HBYFBETWH4VtoQ4QepdPJvHPyjxo9tNSRI
	 HPmKShPMpZDFJ9mYRBq4NflH2nnDTt3TtNgf+Z7BuOMAz8/DqZxvJ9ghJdHPCJPz8NEF1
	 5+XaV5vDC80tZmeNzj5oPXYwcmFtWNROYbuPqj4+RcOApUkxwRfD6uXwNTtPHQnUuOOG5
	 lKIkjrYcTcvixOVO1cECYx+3S/iy6BsUchWwnJSp98EPhOhi2j6Y4Pp15NIh7UYaHNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030114;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=rwDo3owb0uSw/n8c6MyAn1xBtuXOUbj/MPanaB0/w+0=;
	b=hq15UTvyywNEWItnMJlwzYMW2gQG7H48gfBfnlsH7e09FzrI0u34RXOtCvaTbBOfSBYz
	 tldO3/ccL/r1HCyRzK8EQp8sIizS/xvjCOuM6PxoVxP5dIH6bmkL4yDjs7sLCBFgSwPnX
	 z0po9emlO6fhHuu1aB6wSf3UaWDEgQCf50M9pHhmgtAeeSEs7ekLKeT4Ahc9oJiDLclEs
	 HCMvgySYWlqXEyu0GKp6qIKQFn86UVUVRlIKzuymJktXEUS022R0vbuhDUYLi9/V68MPG
	 PhpextRyyDDXgzku1OaE0IZADeY3Vtl0ErhDukZfayDl3ItzVnBEUv3PqaZXVFcGOUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W0AV/m5l";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48BE606A7FD;
	Wed, 18 Nov 2026 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0AV/m5l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58251F000C4;
	Wed, 18 Nov 2026 19:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030114;
	bh=rwDo3owb0uSw/n8c6MyAn1xBtuXOUbj/MPanaB0/w+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W0AV/m5lnDUgxV1iIlxpGnd7H5wcXjJcA9eg/ac7AB4uMxttWrzMMuxozlEg6DEFW
	 RadOneQTVSGK4i/cP1qWxHGgH94TTqtKCD0vpWuSzU+Sus1+IupWvMc/oTpyg98XSP
	 QXPv97M3fB26qC+GU4RRr7f2anYRx7606tesc4NSbZvq4+lG1S4HIWxkldMvcbdy1a
	 Gfqv3VaXOKeqTM/ud743cPUlvsRSWBBIH03TOle12n/fNtWGJT/H3dImAX5Aya1vjM
	 xyasNwQOdtzXNiDxvS1lUcq22tUXw+FFi1IP5hcu53ZJu73q/xTvRc0XFa3qcGft03
	 VyfeDfC5RYEsg==
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
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Chris Lu <chris.lu@mediatek.com>,
	Mans Rullgard <mans@mansr.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Cornelia Huck <cornelia.huck@de.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jeff@garzik.org>
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
	linux-coco@lists.linux.dev,
	Alexey Kardashevskiy <aik@amd.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-sound@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v3 19/31] driver core: Introduce a generic device trust level
Date: Wed, 18 Nov 2026 21:26:49 +0200
Message-ID: <20261118-device-trust-core-v3-19-d655875c4bfb@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
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

Attestation needs to hold devices before driver probing and DMA setup.
Authorization on individual buses does not provide a common policy that
drivers and infrastructure can use.

Introduce a shared admission policy and operating trust level. Keep the
accepted level fixed for the device's lifetime because unbind or failed
setup does not necessarily undo hardware configuration. Retain active trust
through teardown so cleanup uses the same assumptions as setup. Preserve
existing behavior when no trust boot options are supplied.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  14 ++
 drivers/base/Makefile                           |   2 +-
 drivers/base/base.h                             |  31 ++++
 drivers/base/core.c                             |   5 +-
 drivers/base/dd.c                               |  47 +++++-
 drivers/base/trust.c                            | 187 ++++++++++++++++++++++++
 drivers/usb/core/driver.c                       |   8 +
 drivers/usb/core/message.c                      |   5 +
 include/linux/device.h                          |   8 +
 include/linux/device/bus.h                      |  10 ++
 include/linux/device/trust.h                    |  49 +++++++
 11 files changed, 361 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd94..81f98655f5297 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1259,6 +1259,20 @@ Kernel parameters
 	dell_smm_hwmon.fan_max=
 			[HW] Maximum configurable fan speed.
 
+	device_trust	[KNL]
+			Enable device trust with blocked as the implicit default.
+
+	device_trust.default=
+			[KNL] Set initial trust policy for all devices, including
+			hotplugged devices.
+			Format: { default | blocked | adversary | unrestricted }
+			No trust options selects legacy unrestricted mode, preserving
+			bus policy and existing authorization. Otherwise blocked is the
+			implicit default. An explicit value wins regardless of option
+			order. default preserves bus policy; other values replace it.
+			unrestricted disables runtime policy changes.
+			See Documentation/driver-api/driver-model/device-trust.rst.
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
index 61f49fc142f45..56f1a9c73964b 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -10,6 +10,7 @@
  * shared outside of the drivers/base/ directory.
  *
  */
+#include <linux/device/trust.h>
 #include <linux/notifier.h>
 
 /**
@@ -88,6 +89,27 @@ struct driver_private {
 };
 #define to_driver(obj) container_of(obj, struct driver_private, kobj)
 
+/**
+ * enum device_trust_state - Device trust authorization and commitment
+ * @DEVICE_TRUST_SELECTABLE: No authorization or commitment. When runtime
+ *	policy changes are enabled, any policy can be selected. Selecting
+ *	blocked enters %DEVICE_TRUST_WAITING.
+ * @DEVICE_TRUST_WAITING: Blocked policy without commitment. Runtime
+ *	authorization requires adversary or unrestricted and enters
+ *	%DEVICE_TRUST_AUTHORIZED; selecting default is rejected.
+ * @DEVICE_TRUST_AUTHORIZED: Adversary or unrestricted selected from
+ *	%DEVICE_TRUST_WAITING. Policy is fixed, but no operating level has
+ *	been committed.
+ * @DEVICE_TRUST_COMMITTED: Policy and operating level accepted before
+ *	driver setup. Both remain fixed through setup failure and unbind.
+ */
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
@@ -106,6 +128,7 @@ struct driver_private {
  * @device: pointer back to the struct device that this structure is
  *	    associated with.
  * @driver_lock: serializes binding and removal, including compatibility attach
+ * @trust_state: policy admission state
  * @dead: This device is currently either in the process of or has been
  *	  removed from the system. Any asynchronous events scheduled for this
  *	  device should exit without taking any action.
@@ -124,6 +147,7 @@ struct device_private {
 	struct device *device;
 	/* Taken after the device mutex, except by compatibility attach. */
 	struct mutex driver_lock;
+	enum device_trust_state trust_state;
 	u8 dead:1;
 };
 #define to_device_private_parent(obj)	\
@@ -169,6 +193,13 @@ void bus_remove_driver(struct device_driver *drv);
 void device_release_driver_internal(struct device *dev, const struct device_driver *drv,
 				    struct device *parent);
 
+int device_private_init(struct device *dev);
+
+/* Unrestricted-only manual attachment uses the caller's subsystem serialization. */
+void device_trust_init_state(struct device *dev);
+int device_trust_prepare_unrestricted(struct device *dev,
+				      const struct device_driver *drv);
+
 void driver_detach(const struct device_driver *drv);
 void driver_deferred_probe_del(struct device *dev);
 void device_set_deferred_probe_reason(const struct device *dev, struct va_format *vaf);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 92d25bf4f8632..c0006b3aa38f7 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3613,7 +3613,7 @@ static void device_remove_sys_dev_entry(struct device *dev)
 	}
 }
 
-static int device_private_init(struct device *dev)
+int device_private_init(struct device *dev)
 {
 	dev->p = kzalloc_obj(*dev->p);
 	if (!dev->p)
@@ -3694,6 +3694,9 @@ int device_add(struct device *dev)
 	if (error)
 		goto name_error;
 
+	device_trust_init(dev);
+	device_trust_init_state(dev);
+
 	pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
 
 	parent = get_device(dev->parent);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 6ac1486b9fbb5..4c4723384dc66 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -541,6 +541,25 @@ static int __device_bind_driver(struct device *dev)
 	return 0;
 }
 
+static int device_bind_driver_locked(struct device *dev)
+{
+	bool admitted = dev->trust_level != DEVICE_TRUST_BLOCKED;
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
+	/* An early claimant remains active until its bus finishes cleanup. */
+	if (ret && !admitted)
+		device_trust_clear(dev);
+	return ret;
+}
+
 /**
  * device_bind_driver - bind a driver to one device.
  * @dev: device.
@@ -561,14 +580,14 @@ int device_bind_driver(struct device *dev)
 	int ret;
 
 	mutex_lock(&dev->p->driver_lock);
-	ret = __device_bind_driver(dev);
+	ret = device_bind_driver_locked(dev);
 	mutex_unlock(&dev->p->driver_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(device_bind_driver);
 
 /**
- * device_driver_attach_unrestricted - attach a driver using subsystem serialization
+ * device_driver_attach_unrestricted - attach under a fixed unrestricted policy
  * @drv: driver to attach
  * @dev: device to attach it to
  *
@@ -583,6 +602,12 @@ EXPORT_SYMBOL_GPL(device_bind_driver);
  * It calls the bus or driver probe callback and publishes the binding without
  * performing the normal driver-core DMA, pinctrl or power-domain setup.
  *
+ * Requires an unrestricted operating level and either no device trust boot options
+ * or device_trust.default=unrestricted. Changes through trust_policy are disabled
+ * in both modes. The caller must exclude bus-specific policy changes.
+ * When driver boot rules exist, an explicit device boot rule must exclude
+ * them for @dev. Buses with a trust resolver must use device_driver_attach().
+ *
  * Return: 0 on success, -EAGAIN if registration or probing must be retried,
  * or another negative error before binding.
  */
@@ -608,6 +633,10 @@ int device_driver_attach_unrestricted(const struct device_driver *drv,
 		goto unlock;
 	}
 
+	ret = device_trust_prepare_unrestricted(dev, drv);
+	if (ret)
+		goto unlock;
+
 	device_set_driver(dev, drv);
 	if (dev->bus->probe)
 		ret = dev->bus->probe(dev);
@@ -632,6 +661,7 @@ int device_driver_attach_unrestricted(const struct device_driver *drv,
 	devres_release_all(dev);
 	device_set_driver(dev, NULL);
 	dev_set_drvdata(dev, NULL);
+	WRITE_ONCE(dev->trust_level, DEVICE_TRUST_BLOCKED);
 	if (ret == -EPROBE_DEFER)
 		ret = -EAGAIN;
 unlock:
@@ -763,6 +793,14 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
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
@@ -829,6 +867,7 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
 		if (dev->bus && dev->bus->dma_cleanup)
 			dev->bus->dma_cleanup(dev);
 		device_unbind_cleanup(dev);
+		device_trust_clear(dev);
 
 		goto re_probe;
 	}
@@ -855,6 +894,7 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
 pinctrl_bind_failed:
 	device_links_no_driver(dev);
 	device_unbind_cleanup(dev);
+	device_trust_clear(dev);
 done:
 	return ret;
 }
@@ -1196,7 +1236,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			ret = 1;
 			goto out_unlock;
 		}
-		ret = __device_bind_driver(dev);
+		ret = device_bind_driver_locked(dev);
 		if (ret == 0)
 			ret = 1;
 		else {
@@ -1448,6 +1488,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 			dev->bus->dma_cleanup(dev);
 
 		device_unbind_cleanup(dev);
+		device_trust_clear(dev);
 		device_links_driver_cleanup(dev);
 
 		klist_remove(&dev->p->knode_driver);
diff --git a/drivers/base/trust.c b/drivers/base/trust.c
new file mode 100644
index 0000000000000..35893786a163d
--- /dev/null
+++ b/drivers/base/trust.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/string.h>
+
+#include "base.h"
+
+static enum device_trust_policy device_trust_default_policy __ro_after_init =
+	DEVICE_TRUST_POLICY_UNRESTRICTED;
+static bool device_trust_configured __ro_after_init;
+
+static void __init device_trust_configure(void)
+{
+	if (device_trust_configured)
+		return;
+
+	device_trust_default_policy = DEVICE_TRUST_POLICY_BLOCKED;
+	device_trust_configured = true;
+}
+
+static int __init device_trust_detect_setup(char *str)
+{
+	if (!*str || *str == '=' || *str == '.')
+		device_trust_configure();
+	return !*str;
+}
+__setup("device_trust", device_trust_detect_setup);
+
+void device_trust_init_state(struct device *dev)
+{
+	if (dev->trust_committed_level != DEVICE_TRUST_BLOCKED)
+		dev->p->trust_state = DEVICE_TRUST_COMMITTED;
+	else
+		dev->p->trust_state = dev->trust_policy == DEVICE_TRUST_POLICY_BLOCKED ?
+			DEVICE_TRUST_WAITING : DEVICE_TRUST_SELECTABLE;
+}
+
+static int __device_trust_prepare(struct device *dev,
+				  const struct device_driver *drv, bool unrestricted_only)
+{
+	enum device_trust_policy policy;
+	enum device_trust_level level;
+	int ret;
+
+	policy = dev->trust_policy;
+
+	if (policy == DEVICE_TRUST_POLICY_BLOCKED)
+		return -EPERM;
+	if (dev->bus && dev->bus->trust_resolve) {
+		ret = dev->bus->trust_resolve(dev, drv, policy, &level);
+		if (ret)
+			return ret;
+	} else {
+		level = policy == DEVICE_TRUST_POLICY_ADVERSARY ?
+			DEVICE_TRUST_ADVERSARY : DEVICE_TRUST_UNRESTRICTED;
+	}
+	if (level == DEVICE_TRUST_BLOCKED)
+		return -EPERM;
+	if (unrestricted_only && level != DEVICE_TRUST_UNRESTRICTED)
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
+/**
+ * device_trust_prepare - Admit a driver before operating a device
+ * @dev: initialized device with its bus, name and initial policy set
+ * @drv: driver claiming or probing the device
+ *
+ * The caller must hold the device lock. Buses may admit a claim before
+ * device_add(); registration preserves the resulting policy and commitment.
+ * Clear the active level after the driver has stopped operating the device.
+ *
+ * Return: 0 on admission, or a negative error before driver setup.
+ */
+int device_trust_prepare(struct device *dev, const struct device_driver *drv)
+{
+	int ret;
+
+	device_lock_assert(dev);
+	if (!dev->p) {
+		ret = device_private_init(dev);
+		if (ret)
+			return ret;
+		device_trust_init(dev);
+		device_trust_init_state(dev);
+	}
+	return __device_trust_prepare(dev, drv, false);
+}
+EXPORT_SYMBOL_GPL(device_trust_prepare);
+
+int device_trust_prepare_unrestricted(struct device *dev,
+				      const struct device_driver *drv)
+{
+	if (device_trust_default_policy != DEVICE_TRUST_POLICY_UNRESTRICTED)
+		return -EPERM;
+
+	return __device_trust_prepare(dev, drv, true);
+}
+
+/**
+ * device_trust_clear - End a device's active operating level
+ * @dev: device whose driver setup and cleanup have finished
+ *
+ * The caller must hold the device lock. Lifetime commitment is retained.
+ */
+void device_trust_clear(struct device *dev)
+{
+	device_lock_assert(dev);
+	WRITE_ONCE(dev->trust_level, DEVICE_TRUST_BLOCKED);
+}
+EXPORT_SYMBOL_GPL(device_trust_clear);
+
+/**
+ * device_get_trust_level - Return a device's active trust level
+ * @dev: device to inspect
+ *
+ * The value is stable from the start of DMA configuration through the end of
+ * DMA cleanup. An unbound device has %DEVICE_TRUST_BLOCKED as its active
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
+	[DEVICE_TRUST_POLICY_BLOCKED] = "blocked",
+	[DEVICE_TRUST_POLICY_ADVERSARY] = "adversary",
+	[DEVICE_TRUST_POLICY_UNRESTRICTED] = "unrestricted",
+};
+
+static int __init device_trust_default_setup(char *str)
+{
+	int policy = match_string(device_trust_policy_names,
+				  ARRAY_SIZE(device_trust_policy_names), str);
+
+	device_trust_configure();
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
+	if (dev->trust_committed_level != DEVICE_TRUST_BLOCKED)
+		return;
+
+	if (device_trust_configured &&
+	    device_trust_default_policy != DEVICE_TRUST_POLICY_DEFAULT)
+		dev->trust_policy = device_trust_default_policy;
+}
+EXPORT_SYMBOL_GPL(device_trust_init);
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index e2a120c64f6e1..b10b80b5fd6d4 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -583,6 +583,12 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 		iface->claim_owner = driver->driver.owner;
 	}
 
+	retval = device_trust_prepare(dev, &driver->driver);
+	if (retval) {
+		usb_put_claim_owner(iface);
+		goto unlock;
+	}
+
 	dev->driver = &driver->driver;
 	usb_set_intfdata(iface, data);
 	iface->needs_binding = 0;
@@ -620,6 +626,7 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 		if (driver->supports_autosuspend)
 			pm_runtime_disable(dev);
 		pm_runtime_set_suspended(dev);
+		device_trust_clear(dev);
 	}
 
 unlock:
@@ -635,6 +642,7 @@ static void usb_unbind_claim(struct usb_interface *iface)
 	usb_unbind_interface(dev);
 	dev_set_drvdata(dev, NULL);
 	dev->driver = NULL;
+	device_trust_clear(dev);
 	usb_put_claim_owner(iface);
 }
 
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index b2e5ed35a4a59..b8e2d864faa46 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -2237,6 +2237,8 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 		pm_runtime_no_callbacks(&intf->dev);
 		dev_set_name(&intf->dev, "%d-%s:%d.%d", dev->bus->busnum,
 				dev->devpath, configuration, ifnum);
+		/* A sibling may claim the interface before it is registered */
+		device_trust_init(&intf->dev);
 		/*
 		 * Make sure the interface does not outlive its parent (e.g.
 		 * as needed for usb_queue_reset_device() and
@@ -2324,6 +2326,9 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 			get_device(&intf->dev);
 			if (unconfigure)
 				usb_set_configuration(dev, -1);
+			device_lock(&intf->dev);
+			device_trust_clear(&intf->dev);
+			device_unlock(&intf->dev);
 			module_put(claim_owner);
 			put_device(&intf->dev);
 			if (unconfigure) {
diff --git a/include/linux/device.h b/include/linux/device.h
index 5433b2609ab30..702eb66b81bf3 100644
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
+ * @trust_level: Active trust level through driver setup and cleanup, see
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
index 0000000000000..32071f12ed257
--- /dev/null
+++ b/include/linux/device/trust.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DEVICE_TRUST_H_
+#define _DEVICE_TRUST_H_
+
+#include <linux/types.h>
+
+struct device;
+struct device_driver;
+
+/**
+ * enum device_trust_level - active trust level for a device
+ * @DEVICE_TRUST_BLOCKED: The device cannot be operated by a driver
+ * @DEVICE_TRUST_ADVERSARY: Classify the operating device as potentially malicious
+ * @DEVICE_TRUST_UNRESTRICTED: Operate the device with the usual kernel privileges
+ *
+ * Active trust levels are discrete states, not an ordered privilege scale.
+ * Adversary classification alone adds no protections; these depend on bus,
+ * DMA and driver support.
+ */
+enum device_trust_level {
+	DEVICE_TRUST_BLOCKED,
+	DEVICE_TRUST_ADVERSARY,
+	DEVICE_TRUST_UNRESTRICTED,
+};
+
+/**
+ * enum device_trust_policy - requested device trust policy
+ * @DEVICE_TRUST_POLICY_DEFAULT: Let the bus select the active trust level
+ * @DEVICE_TRUST_POLICY_BLOCKED: Request that the device remain blocked
+ * @DEVICE_TRUST_POLICY_ADVERSARY: Request adversary classification
+ * @DEVICE_TRUST_POLICY_UNRESTRICTED: Request normal operation
+ *
+ * A requested policy is resolved to an active trust level before a driver is
+ * probed.
+ */
+enum device_trust_policy {
+	DEVICE_TRUST_POLICY_DEFAULT,
+	DEVICE_TRUST_POLICY_BLOCKED,
+	DEVICE_TRUST_POLICY_ADVERSARY,
+	DEVICE_TRUST_POLICY_UNRESTRICTED,
+};
+
+void device_trust_init(struct device *dev);
+int device_trust_prepare(struct device *dev, const struct device_driver *drv);
+void device_trust_clear(struct device *dev);
+enum device_trust_level device_get_trust_level(const struct device *dev);
+bool device_is_adversarial(const struct device *dev);
+
+#endif /* _DEVICE_TRUST_H_ */

-- 
2.56.1

