Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209686;
	b=3iuHCjkxgY2N5DkDuGhI+uxgxesE2RXa1WBCwkv2pGxwu9xYxfKtWHLqOSy83wioN/nH
	 1WpaRZFn3UiL0UXO1ZNOJ5cVVmwdZrgP2lCvCiQosBm9SSZZTawQSz25GACPhTPAk8M79
	 6iNRu8tpHi7uTs2aAvft821xFJscUbXNtDHaaUGZHsnl+SZOQnwnaZDPxUMZHiF1Xwztk
	 03TLbAQFIgs7qPIT/0/y2MyNt+S+vdYNu+wKaxFKk9X4DV1ZWDBHn1EAEgs0rmb3r39FK
	 cjP1eTEjkaeJxQd3m+WsvQOOCW/4vm1ypN0bW1sXEerTq1TmVca6+uhKUAmPkD3b1+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209686;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=8+GjAGqVGGrVEmxTFmo19CS4mbZigZ8n7vWgNxCXmyI=;
	b=yn0Zzt+IwUmeSlCSQ4fS4H8Eknv5poz2WEj6z1YoEzLgxRCgXe1yb2eBAS/i31ckD/Pr
	 1HyhWDMahX3qbIwdaGm1oDpQYi5IPbRCeSf6OwLxlpYir90061A3vkAaICX2C3vjy/7YB
	 pUKRyEZSzQfIrjVPjtIbvF4LR+7mWza5VFbvLb1YaaQ5zvk+4xSGzbqbmhoIO7Cvu6i7j
	 O3+1ru2ytZCs6mUd5tSYoD77NvO7TmsuS0oLzxl3+Y7aT5QrygyJ/ZeV1+MF+p4IN+e9P
	 LIYQXTE958EYJ0JMDv7wvFNlOnQ7FQiFzFRKN9UXv0mMvXBHgKwU0ye2KyUMdL8pW6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4oYfi73;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61507606A81F;
	Mon,  9 Nov 2026 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4oYfi73
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E851F008A2;
	Mon,  9 Nov 2026 07:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209686;
	bh=8+GjAGqVGGrVEmxTFmo19CS4mbZigZ8n7vWgNxCXmyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a4oYfi73pw6ysr4OG1ZNSZWWDqhLMNiGh96Ug8f7DR0EB1zv7EH5FWhQLfMiOCOe0
	 RlBaMY1jN2gtr0wkoejutAILHqnupTigC1t+GE9Csy2Zdj60fbvvI94dLAGnXU5y+y
	 JOK6/IDplAQz/bz6X+wcq0QpOqKPXuxXWOB35EFlE8hJL6bDk+5elHHIyEC8gpvLxH
	 uOb7aHiE1UXBe+FRduWhqLov7bzDv6bA0JkguqoQS2EH08gWESX1IQUtynLmktyVcl
	 FnscTUVmABDCwIV14dj9l9pQAOrvavD9eEsUYzDnd9DxAId3Q7oLQZQsjaAcyHO3Nw
	 aY+nnAY4ArU+g==
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
Subject: [PATCH v2 14/19] driver core: Accept device trust policy by driver name
Date: Mon,  9 Nov 2026 09:33:44 +0200
Message-ID: <20261109-device-trust-core-v2-14-3b12d9a9f861@nvidia.com>
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

Device addresses can change between boots, while userspace arrives too
late to choose policy for built-in drivers.

Add driver-wide boot rules beneath explicit device policy and existing
authorization. Refuse full-only manual attachment when pending driver
rules could change policy outside subsystem locks; an explicit device
boot entry excludes those rules. Check unregistered USB claims against
policy without admitting the device before registration.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/ABI/testing/sysfs-devices-trust   |  7 +-
 Documentation/admin-guide/kernel-parameters.txt | 25 +++++--
 drivers/base/base.h                             |  5 ++
 drivers/base/trust.c                            | 99 +++++++++++++++++++++----
 drivers/usb/core/driver.c                       |  4 +
 drivers/usb/core/message.c                      |  2 +
 include/linux/device/trust.h                    |  1 +
 7 files changed, 119 insertions(+), 24 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-trust b/Documentation/ABI/testing/sysfs-devices-trust
index fd523bbe7bdc6..2d4bc96ed0d0f 100644
--- a/Documentation/ABI/testing/sysfs-devices-trust
+++ b/Documentation/ABI/testing/sysfs-devices-trust
@@ -14,8 +14,11 @@ Description:
 		value may be selected by the bus before the device is
 		registered; otherwise it is "default". The policy is resolved
 		to an active trust level before the device is probed.
-		A matching device_trust= kernel command-line entry overrides
-		the initial requested policy before registration.
+		A non-default device_trust.default= kernel command-line value
+		replaces the bus policy before registration. A matching
+		device_trust= entry takes precedence over both, regardless
+		of command-line order. Boot policy also applies to new devices
+		discovered after boot.
 
 		The values are "default", "disabled", "adversary", and
 		"full". "default" lets the bus select the active trust level.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fbc0cd21bf09f..6d8b427c69914 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1265,17 +1265,28 @@ Kernel parameters
 			Format: <bus>:<device>=<policy>[,...]
 			Names match exactly as in /sys/bus/<bus>/devices/<device>.
 			Policies are default, disabled, adversary, and full.
-			Entries override bus policy and device_trust.default.
+			Entries override bus policy, device_trust.default, and
+			device_trust.driver.
 			See Documentation/driver-api/driver-model/device-trust.rst.
 
 	device_trust.default=
-			[KNL] Set the initial trust policy for all devices.
+			[KNL] Set initial trust policy for devices without a
+			matching device_trust= entry, including hotplugged devices.
+			A matching device_trust.driver= rule can replace this
+			initial policy at the first binding attempt.
 			Format: { default | disabled | adversary | full }
-			If omitted or set to default, preserve bus policy.
-			Other values replace bus policy. The last valid value wins.
-			Full-only manual driver attachment requires full; other
-			global policies reject it before the probe callback.
-			With full, runtime trust policy changes are unavailable.
+			default preserves bus-initialized policy (the default).
+			Other values override bus-initialized policy before
+			probing, including for built-in drivers.
+			See Documentation/driver-api/driver-model/device-trust.rst.
+
+	device_trust.driver=
+			[KNL] Set initial device trust policy by driver name,
+			including for drivers built into the kernel.
+			Format: <bus>:<driver>=<policy>[,...]
+			Names match exactly as in /sys/bus/<bus>/drivers/<driver>.
+			Policies are default, disabled, adversary, and full.
+			Rules remain available for hotplug and modules.
 
 	dfltcc=		[HW,S390]
 			Format: { on | off | def_only | inf_only | always }
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 59da537462a57..f82403d0438f2 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -114,6 +114,7 @@ enum device_trust_state {
  * @device: pointer back to the struct device that this structure is
  *	    associated with.
  * @trust_state: policy admission state
+ * @trust_policy_override: explicit policy prevents deferred driver boot policy
  * @dead: This device is currently either in the process of or has been
  *	  removed from the system. Any asynchronous events scheduled for this
  *	  device should exit without taking any action.
@@ -131,6 +132,7 @@ struct device_private {
 	char *deferred_probe_reason;
 	struct device *device;
 	enum device_trust_state trust_state;
+	u8 trust_policy_override:1;
 	u8 dead:1;
 };
 #define to_device_private_parent(obj)	\
@@ -181,6 +183,9 @@ extern const struct attribute_group device_trust_attr_group;
 #if IS_ENABLED(CONFIG_KUNIT)
 int device_trust_parse_cmdline(const char *options, const struct device *dev,
 			       enum device_trust_policy *policy);
+void device_trust_apply_driver_policy(struct device *dev,
+				      const struct device_driver *drv,
+				      const char *options);
 void device_trust_apply_boot_policy(struct device *dev,
 				    enum device_trust_policy policy,
 				    const char *options);
diff --git a/drivers/base/trust.c b/drivers/base/trust.c
index f581857642493..2bec6825ef31e 100644
--- a/drivers/base/trust.c
+++ b/drivers/base/trust.c
@@ -13,6 +13,11 @@
 
 static enum device_trust_policy device_trust_default_policy __ro_after_init;
 
+static bool device_trust_full_allowed(const struct device *dev);
+
+static void device_trust_init_driver_policy(struct device *dev,
+					   const struct device_driver *drv);
+
 void device_trust_init_state(struct device *dev)
 {
 	dev->p->trust_state = dev->trust_policy == DEVICE_TRUST_POLICY_DISABLED ?
@@ -26,8 +31,8 @@ static int __device_trust_prepare(struct device *dev,
 	enum device_trust_level level;
 	int ret;
 
+	device_trust_init_driver_policy(dev, drv);
 	policy = dev->trust_policy;
-
 	if (policy == DEVICE_TRUST_POLICY_DISABLED)
 		return -EPERM;
 	if (dev->bus && dev->bus->trust_resolve) {
@@ -60,7 +65,7 @@ int device_trust_prepare(struct device *dev, const struct device_driver *drv)
 
 int device_trust_prepare_full(struct device *dev, const struct device_driver *drv)
 {
-	if (device_trust_default_policy != DEVICE_TRUST_POLICY_FULL)
+	if (!device_trust_full_allowed(dev))
 		return -EPERM;
 
 	return __device_trust_prepare(dev, drv, true);
@@ -137,7 +142,7 @@ static ssize_t trust_policy_show(struct device *dev,
  * A bus can use this to translate its own authorization interface into
  * device trust. Takes the device lock except when the global full policy
  * makes runtime policy changes unavailable. In that mode, writing the current
- * policy is a no-op.
+ * policy is a no-op and does not override a pending driver boot rule.
  *
  * Return: 0 on success, -EBUSY if the policy can no longer change, -ENODEV
  * if the device is being removed outside global full mode.
@@ -155,7 +160,7 @@ int device_trust_set_policy(struct device *dev, enum device_trust_policy policy)
 		goto unlock;
 	}
 	if (policy == dev->trust_policy)
-		goto unlock;
+		goto set_policy;
 
 	/* A driver that claimed the device before registration was not admitted. */
 	if (READ_ONCE(dev->driver)) {
@@ -180,7 +185,9 @@ int device_trust_set_policy(struct device *dev, enum device_trust_policy policy)
 		ret = -EBUSY;
 		goto unlock;
 	}
+set_policy:
 	WRITE_ONCE(dev->trust_policy, policy);
+	dev->p->trust_policy_override = true;
 unlock:
 	device_unlock(dev);
 	return ret;
@@ -214,10 +221,11 @@ const struct attribute_group device_trust_attr_group = {
 };
 
 static const char *device_trust_cmdline __ro_after_init;
+static const char *device_trust_driver_cmdline __ro_after_init;
 
-VISIBLE_IF_KUNIT int device_trust_parse_cmdline(const char *options,
-						const struct device *dev,
-						enum device_trust_policy *policy)
+static int device_trust_parse_policy(const char *options, const char *target_bus,
+				     const char *target_name,
+				     enum device_trust_policy *policy)
 {
 	enum device_trust_policy selected = DEVICE_TRUST_POLICY_DEFAULT;
 	const char *entry = options;
@@ -252,11 +260,11 @@ VISIBLE_IF_KUNIT int device_trust_parse_cmdline(const char *options,
 		if (i == ARRAY_SIZE(device_trust_policy_names))
 			return -EINVAL;
 
-		if (dev && dev->bus && dev_name(dev) &&
-		    strlen(dev->bus->name) == bus_end - entry &&
-		    !strncmp(dev->bus->name, entry, bus_end - entry) &&
-		    strlen(dev_name(dev)) == level - name &&
-		    !strncmp(dev_name(dev), name, level - name)) {
+		if (target_bus && target_name &&
+		    strlen(target_bus) == bus_end - entry &&
+		    !strncmp(target_bus, entry, bus_end - entry) &&
+		    strlen(target_name) == level - name &&
+		    !strncmp(target_name, name, level - name)) {
 			selected = i;
 			matched = true;
 		}
@@ -266,12 +274,59 @@ VISIBLE_IF_KUNIT int device_trust_parse_cmdline(const char *options,
 		entry = end + 1;
 	}
 
-	if (matched)
+	if (matched && policy)
 		*policy = selected;
 	return matched;
 }
+
+VISIBLE_IF_KUNIT int device_trust_parse_cmdline(const char *options,
+						const struct device *dev,
+						enum device_trust_policy *policy)
+{
+	return device_trust_parse_policy(options, dev && dev->bus ? dev->bus->name : NULL,
+					 dev ? dev_name(dev) : NULL, policy);
+}
 EXPORT_SYMBOL_IF_KUNIT(device_trust_parse_cmdline);
 
+static bool device_trust_full_allowed(const struct device *dev)
+{
+	if (device_trust_default_policy != DEVICE_TRUST_POLICY_FULL)
+		return false;
+
+	/* Driver rules can otherwise change policy outside subsystem locks. */
+	return !device_trust_driver_cmdline ||
+		(device_trust_cmdline &&
+		 device_trust_parse_cmdline(device_trust_cmdline, dev, NULL) > 0);
+}
+
+VISIBLE_IF_KUNIT void device_trust_apply_driver_policy(struct device *dev,
+						     const struct device_driver *drv,
+						     const char *options)
+{
+	enum device_trust_policy policy;
+
+	if (!options || dev->p->trust_policy_override ||
+	    (dev->p->trust_state != DEVICE_TRUST_SELECTABLE &&
+	     dev->p->trust_state != DEVICE_TRUST_WAITING))
+		return;
+
+	if (device_trust_parse_policy(options, drv->bus->name,
+				      drv->name, &policy) <= 0)
+		return;
+
+	WRITE_ONCE(dev->trust_policy, policy);
+	dev->p->trust_state = policy == DEVICE_TRUST_POLICY_DISABLED ?
+		DEVICE_TRUST_WAITING : DEVICE_TRUST_SELECTABLE;
+	dev->p->trust_policy_override = true;
+}
+EXPORT_SYMBOL_IF_KUNIT(device_trust_apply_driver_policy);
+
+static void device_trust_init_driver_policy(struct device *dev,
+					   const struct device_driver *drv)
+{
+	device_trust_apply_driver_policy(dev, drv, device_trust_driver_cmdline);
+}
+
 static int __init device_trust_setup(char *str)
 {
 	if (device_trust_parse_cmdline(str, NULL, NULL) < 0) {
@@ -285,6 +340,18 @@ static int __init device_trust_setup(char *str)
 }
 __setup("device_trust=", device_trust_setup);
 
+static int __init device_trust_driver_setup(char *str)
+{
+	if (device_trust_parse_policy(str, NULL, NULL, NULL) < 0) {
+		pr_warn("device_trust: ignoring invalid driver policy list '%s'\n", str);
+		return 1;
+	}
+
+	device_trust_driver_cmdline = str;
+	return 1;
+}
+__setup("device_trust.driver=", device_trust_driver_setup);
+
 static int __init device_trust_default_setup(char *str)
 {
 	int policy = match_string(device_trust_policy_names,
@@ -306,8 +373,10 @@ VISIBLE_IF_KUNIT void device_trust_apply_boot_policy(struct device *dev,
 {
 	if (policy != DEVICE_TRUST_POLICY_DEFAULT)
 		dev->trust_policy = policy;
-	if (options)
-		device_trust_parse_cmdline(options, dev, &dev->trust_policy);
+	if (options &&
+	    device_trust_parse_cmdline(options, dev, &dev->trust_policy) > 0 &&
+	    dev->p)
+		dev->p->trust_policy_override = true;
 }
 EXPORT_SYMBOL_IF_KUNIT(device_trust_apply_boot_policy);
 
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index ee36eae34bdcc..04b77691fbd7d 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -563,6 +563,10 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 	if (!iface->authorized)
 		return -ENODEV;
 
+	if (!device_is_registered(dev) &&
+	    dev->trust_policy == DEVICE_TRUST_POLICY_DISABLED)
+		return -EPERM;
+
 	dev->driver = &driver->driver;
 	usb_set_intfdata(iface, data);
 	iface->needs_binding = 0;
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index d35a7710c8ef4..2d75b85b2d139 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -2209,6 +2209,8 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 		pm_runtime_no_callbacks(&intf->dev);
 		dev_set_name(&intf->dev, "%d-%s:%d.%d", dev->bus->busnum,
 				dev->devpath, configuration, ifnum);
+		/* A sibling may claim the interface before it is registered */
+		device_trust_init(&intf->dev);
 		/*
 		 * Make sure the interface does not outlive its parent (e.g.
 		 * as needed for usb_queue_reset_device() and
diff --git a/include/linux/device/trust.h b/include/linux/device/trust.h
index eb36970289e84..9d6d387d01203 100644
--- a/include/linux/device/trust.h
+++ b/include/linux/device/trust.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 
 struct device;
+struct device_driver;
 
 /**
  * enum device_trust_level - active trust level for a device

-- 
2.56.0

