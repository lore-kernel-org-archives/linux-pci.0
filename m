Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030125;
	b=113COvXEUkHU/gF2r96T05NX+ze+pUeC1WB8isiAjn5VDI8reKPBkK7LFMKKD+6/sYsg
	 0+2PXZxOK6GdmHftj4l6+GVQukyBOLcO9Yok9ZItROKi5RdzcCjT+656Iv7LGy4DVq9f8
	 uGJ3mG1hhs5qV4Bc5waCGBTTyS85VJb6PHvJoXTRvjRuQOt9xMA9wI7CmZBykccs2j5wL
	 yvVy51G6nngejD/oFngMWM64IPPer6knLbDTurUWxyWG+/RAlgpodpHgUjISSPGVodf0b
	 /N+sj66NYLHp20s+vxNCL6aSNkFtPPYvWq0YZsxXwdLA0DCjq/c7gv/v7zWUVgD4NAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030125;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=+I0PP7h/VXxxBgGejuUBMUoUX9YUgUbitpYnq0tJXBc=;
	b=nJmSPnlauHSMXcn1lvMC6lDdjp7AgtgUaQbf3BnvV9bIxHReNN95k2OAJL5/EylAEwuH
	 dVuVjYoQTlqmKW/noS1yDnH9yHUb2bWkHHJXd+nJ177nPE3vR8oXnaN8rzwVRmg+YeyWw
	 fYB+nrKTNTqF1FEZoPKJj2zyy5dtqVfmdXiLD2BItS+QMFxN+/j9uTzFATqUoY5343Tr1
	 Qs3iFz+npy97MiZY7VBLdJ8pReE4jLsgT10lB1Aa4gvTTUPH9j34thBAkLJKUFCzcktTt
	 TCl2SiNNYpmLv3l+LHDtHvyuvWTt0DV+QiVpA7I18LhGytULDom/gWuXGlvYqoa4wPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b1+Q0drT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ADF606B109;
	Wed, 18 Nov 2026 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b1+Q0drT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2831F000CE;
	Wed, 18 Nov 2026 19:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030125;
	bh=+I0PP7h/VXxxBgGejuUBMUoUX9YUgUbitpYnq0tJXBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b1+Q0drTIj9cA5OZLfc3VN7Zc7poJqgb6eTm/+5+7N1AvnEGvu7T1WI79LPA6EPGm
	 nHujmmAvHMdFL1SYKpU6+5jXV84t7HQOD3rqplR94wGu/cYUBBSatA+vbZQxTajKdN
	 xQnspdA9WrEJTLElh+4x8zRfWx0YIz/irY6h3rwauggk5J2sjne7cdlg29xILRvqrB
	 wH8DcQTg5PLFUhNgquRLsRKqUy240O7w00TAjkAvhVdZq4QiOmOvv1pgZiASN0tRRl
	 YLVaYb4xIgMnaZHUdY36KBL0lVUtrAZB6wXM6hIAVhB0vN4osgd6rDwbkVCtHmNLDl
	 Su+9jOTKdCxsQ==
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
Subject: [PATCH v3 22/31] driver core: Accept device trust policy by driver name
Date: Wed, 18 Nov 2026 21:26:52 +0200
Message-ID: <20261118-device-trust-core-v3-22-d655875c4bfb@nvidia.com>
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

Device names can depend on enumeration order, making device-specific boot
exceptions difficult to reuse across machines. Userspace is also too late
to establish policy for drivers that probe during boot.

Allow exceptions selected by bus and driver name, using the names published
in sysfs so policy does not depend on module aliases. Preserve more
specific device rules and prior authorization. Keep a matched rule fixed
across retries so changing the candidate driver cannot replace that choice.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/ABI/testing/sysfs-devices-trust   |  7 +-
 Documentation/admin-guide/kernel-parameters.txt | 14 +++-
 drivers/base/base.h                             |  8 +++
 drivers/base/trust.c                            | 88 ++++++++++++++++++++++---
 4 files changed, 106 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-trust b/Documentation/ABI/testing/sysfs-devices-trust
index 130e5b0d712c2..504fe77be4ac1 100644
--- a/Documentation/ABI/testing/sysfs-devices-trust
+++ b/Documentation/ABI/testing/sysfs-devices-trust
@@ -15,8 +15,11 @@ Description:
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
 
 		Changes through this attribute require an explicit device
 		trust boot option. Any such option selects an implicit
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e77ce08ac8f79..18708190e2a9b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1268,12 +1268,15 @@ Kernel parameters
 			Format: <bus>:<device>=<policy>[,...]
 			Names match exactly as in /sys/bus/<bus>/devices/<device>.
 			Policies are default, blocked, adversary, and unrestricted.
-			Entries override bus policy and device_trust.default.
+			Entries override bus policy, device_trust.default, and
+			device_trust.driver.
 			See Documentation/driver-api/driver-model/device-trust.rst.
 
 	device_trust.default=
 			[KNL] Set initial trust policy for devices without a
 			matching device_trust= entry, including hotplugged devices.
+			A matching device_trust.driver= rule can replace this
+			initial policy at the first binding attempt.
 			Format: { default | blocked | adversary | unrestricted }
 			No trust options selects legacy unrestricted mode, preserving
 			bus policy and existing authorization. Otherwise blocked is the
@@ -1282,6 +1285,15 @@ Kernel parameters
 			unrestricted disables runtime policy changes.
 			See Documentation/driver-api/driver-model/device-trust.rst.
 
+	device_trust.driver=
+			[KNL] Set initial device trust policy by driver name,
+			including for drivers built into the kernel.
+			Format: <bus>:<driver>=<policy>[,...]
+			Names match exactly as in /sys/bus/<bus>/drivers/<driver>.
+			Quote the option value for driver names containing spaces.
+			Policies are default, blocked, adversary, and unrestricted.
+			Rules remain available for hotplug and modules.
+
 	dfltcc=		[HW,S390]
 			Format: { on | off | def_only | inf_only | always }
 			on:       s390 zlib hardware support for compression on
diff --git a/drivers/base/base.h b/drivers/base/base.h
index e8c24d02a5390..b7768f5679c3b 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -129,6 +129,7 @@ enum device_trust_state {
  *	    associated with.
  * @driver_lock: serializes binding and removal, including compatibility attach
  * @trust_state: policy admission state
+ * @trust_policy_override: explicit policy prevents deferred driver boot policy
  * @dead: This device is currently either in the process of or has been
  *	  removed from the system. Any asynchronous events scheduled for this
  *	  device should exit without taking any action.
@@ -148,6 +149,7 @@ struct device_private {
 	/* Taken after the device mutex, except by compatibility attach. */
 	struct mutex driver_lock;
 	enum device_trust_state trust_state;
+	u8 trust_policy_override:1;
 	u8 dead:1;
 };
 #define to_device_private_parent(obj)	\
@@ -200,6 +202,12 @@ extern const struct attribute_group device_trust_attr_group;
 #if IS_ENABLED(CONFIG_KUNIT)
 int device_trust_parse_cmdline(const char *options, const struct device *dev,
 			       enum device_trust_policy *policy);
+int device_trust_parse_driver_cmdline(const char *options,
+				      const struct device_driver *drv,
+				      enum device_trust_policy *policy);
+void device_trust_apply_driver_policy(struct device *dev,
+				      const struct device_driver *drv,
+				      const char *options);
 void device_trust_apply_boot_policy(struct device *dev,
 				    enum device_trust_policy policy,
 				    const char *options);
diff --git a/drivers/base/trust.c b/drivers/base/trust.c
index 8211a869fc82e..03a56f85f0f33 100644
--- a/drivers/base/trust.c
+++ b/drivers/base/trust.c
@@ -43,6 +43,11 @@ static int __init device_trust_detect_setup(char *str)
 }
 __setup("device_trust", device_trust_detect_setup);
 
+static bool device_trust_unrestricted_allowed(const struct device *dev);
+
+static void device_trust_init_driver_policy(struct device *dev,
+					   const struct device_driver *drv);
+
 void device_trust_init_state(struct device *dev)
 {
 	if (dev->trust_committed_level != DEVICE_TRUST_BLOCKED)
@@ -59,8 +64,8 @@ static int __device_trust_prepare(struct device *dev,
 	enum device_trust_level level;
 	int ret;
 
+	device_trust_init_driver_policy(dev, drv);
 	policy = dev->trust_policy;
-
 	if (policy == DEVICE_TRUST_POLICY_BLOCKED)
 		return -EPERM;
 	if (dev->bus && dev->bus->trust_resolve) {
@@ -115,7 +120,7 @@ EXPORT_SYMBOL_GPL(device_trust_prepare);
 int device_trust_prepare_unrestricted(struct device *dev,
 				      const struct device_driver *drv)
 {
-	if (device_trust_default_policy != DEVICE_TRUST_POLICY_UNRESTRICTED)
+	if (!device_trust_unrestricted_allowed(dev))
 		return -EPERM;
 
 	return __device_trust_prepare(dev, drv, true);
@@ -236,6 +241,7 @@ int device_trust_set_policy_locked(struct device *dev,
 	}
 set_policy:
 	WRITE_ONCE(dev->trust_policy, policy);
+	dev->p->trust_policy_override = true;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(device_trust_set_policy_locked);
@@ -299,10 +305,11 @@ const struct attribute_group device_trust_attr_group = {
 };
 
 static const char *device_trust_cmdline __ro_after_init;
+static const char *device_trust_driver_cmdline __ro_after_init;
 
 static int device_trust_parse_policy(const char *options, const char *target_bus,
 				     const char *target_name,
-				     enum device_trust_policy *policy)
+				     enum device_trust_policy *policy, bool driver_name)
 {
 	enum device_trust_policy selected = DEVICE_TRUST_POLICY_DEFAULT;
 	const char *entry = options;
@@ -326,7 +333,8 @@ static int device_trust_parse_policy(const char *options, const char *target_bus
 			return -EINVAL;
 
 		for (p = entry; p < end; p++)
-			if (isspace(*p) || iscntrl(*p) || *p == '"')
+			if (iscntrl(*p) || *p == '"' ||
+			    (isspace(*p) && (!driver_name || p < name || p >= level)))
 				return -EINVAL;
 
 		for (i = 0; i < ARRAY_SIZE(device_trust_policy_names); i++)
@@ -361,10 +369,58 @@ VISIBLE_IF_KUNIT int device_trust_parse_cmdline(const char *options,
 						enum device_trust_policy *policy)
 {
 	return device_trust_parse_policy(options, dev && dev->bus ? dev->bus->name : NULL,
-					 dev ? dev_name(dev) : NULL, policy);
+					 dev ? dev_name(dev) : NULL, policy, false);
 }
 EXPORT_SYMBOL_IF_KUNIT(device_trust_parse_cmdline);
 
+VISIBLE_IF_KUNIT int device_trust_parse_driver_cmdline(const char *options,
+						       const struct device_driver *drv,
+						       enum device_trust_policy *policy)
+{
+	return device_trust_parse_policy(options, drv ? drv->bus->name : NULL,
+					 drv ? kobject_name(&drv->p->kobj) : NULL,
+					 policy, true);
+}
+EXPORT_SYMBOL_IF_KUNIT(device_trust_parse_driver_cmdline);
+
+static bool device_trust_unrestricted_allowed(const struct device *dev)
+{
+	if (device_trust_default_policy != DEVICE_TRUST_POLICY_UNRESTRICTED)
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
+	if (device_trust_parse_driver_cmdline(options, drv, &policy) <= 0)
+		return;
+
+	WRITE_ONCE(dev->trust_policy, policy);
+	dev->p->trust_state = policy == DEVICE_TRUST_POLICY_BLOCKED ?
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
 	device_trust_configure();
@@ -379,6 +435,19 @@ static int __init device_trust_setup(char *str)
 }
 __setup("device_trust=", device_trust_setup);
 
+static int __init device_trust_driver_setup(char *str)
+{
+	device_trust_configure();
+	if (device_trust_parse_driver_cmdline(str, NULL, NULL) < 0) {
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
@@ -401,8 +470,10 @@ VISIBLE_IF_KUNIT void device_trust_apply_boot_policy(struct device *dev,
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
 
@@ -412,7 +483,8 @@ EXPORT_SYMBOL_IF_KUNIT(device_trust_apply_boot_policy);
  */
 void device_trust_init(struct device *dev)
 {
-	if (dev->trust_committed_level != DEVICE_TRUST_BLOCKED)
+	if (dev->trust_committed_level != DEVICE_TRUST_BLOCKED ||
+	    (dev->p && dev->p->trust_policy_override))
 		return;
 
 	if (device_trust_configured)

-- 
2.56.1

