Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209697;
	b=2b6BFHu6cHfx4zfEo8WqMhZXx0EJBbgh/4hMKLl1EFsizYufJCB2KFJ3NlVzxqmw4wo2
	 dDvpKH+AmKSdnYuoDaXO/S3+1UxzByoBa+SZzdy2BgaNA01JGiFb16L9AM4nRnWnnUzuF
	 dfWI+iYv8ksoQ7QiwgyVRXNmTxxfIRmBduvfJWv/JG+ZHFqLPXbilnpDHLZC+2xObHuoc
	 GPhtDk4Aim84Qj2lnL+Nox56+u/CWkdSJzeR9tXZ4S6pBudnbOmydnCCVucRtFTBhPe0P
	 A9qGTDrstzeQn3OzeMXHMPP26ItpkH2KM+hV/lWPTt4+b7fcyfqGDlLaSbt7VTvg7Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209697;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=JXKtvIbL0K2IZDNlPsE68VhyZMr10s51jGVWYtoazCA=;
	b=eWJWld1aMHMTGzMjISON0aDEFPsb9paWj96jLPClzYkIQGDtdyyZxhjrM9GJmx2zs0mv
	 B3l21kdAX/i8aDV3XB9wrOIUBd5ocj2hwnis82xZjLuP7HJ/Ni8SKKOaOI5Z7SUgkYZ5s
	 pHun9RZWWCxHSClvLJ/E/tjXRtbUQ9FrMZ53MOMMeekSzAS9/zbtLBntQcCOg2PyzBh9U
	 BRZQv/Dj5Lk8nShGdlzt6DZ1wGk58bmLZesmvgirxSkoPTIwIWRFBZbIdAmqk/6J7zy0h
	 Brrx740f/JYmRjzChKo59jYw5OMgiWBtd5XDaKskrNEx9LrFl1OUGsW69kz/a/T+LNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QgjZctuj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0328C606C4D2;
	Mon,  9 Nov 2026 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QgjZctuj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C284C1F0089F;
	Mon,  9 Nov 2026 07:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209696;
	bh=JXKtvIbL0K2IZDNlPsE68VhyZMr10s51jGVWYtoazCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QgjZctuj7XAbnRPlfytiYDlObXFcdAJFzq2JrMGgvRdjLeF5Oc1sd2mMdMmXnQr/s
	 FphjJsNuqNe6pb3+5P6v5iJuNN7tItUAlU5R+9bex4Q0EytCkbhNfVyRf0mx+ipOhn
	 sRa/0cM2NUliM14OowhNh6OWyscF0HVa5oiyinFcFnjRcVS+ZwGVYVuh2ea4H+0Zya
	 dWvbRz0A7o2gVMSIPwkG/iFaoW0AheJMSnUIUVbF14gwYDzWflRB4P3xOgq87XDWtr
	 1ofzFthYFiZjCetGk8kOJVNZ3YLaofaI74s0wKTPSdxRjGtqhCBjaJwY+ijoCxAT7l
	 kto4fVuCuUSzg==
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
Subject: [PATCH v2 13/19] driver core: Accept device trust policy on the kernel command line
Date: Mon,  9 Nov 2026 09:33:43 +0200
Message-ID: <20261109-device-trust-core-v2-13-3b12d9a9f861@nvidia.com>
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

Built-in drivers can probe before initrd policy agents start. Fresh
attestation therefore requires disabled policy before those attempts.

Add device_trust=<bus>:<device>=<policy>[,...] to initialize requested
policy before registration. Apply PCI overrides during discovery so IOMMU
and ACS decisions use the same initial policy as binding. Retain rules for
hotplug, preserve admission history when a device object is reused, and
leave unlisted devices unchanged.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/ABI/testing/sysfs-devices-trust   |  2 +
 Documentation/admin-guide/kernel-parameters.txt |  9 +++
 drivers/base/base.h                             |  8 +++
 drivers/base/trust.c                            | 93 +++++++++++++++++++++++--
 drivers/pci/probe.c                             |  1 +
 5 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-trust b/Documentation/ABI/testing/sysfs-devices-trust
index d68113b0d6b08..fd523bbe7bdc6 100644
--- a/Documentation/ABI/testing/sysfs-devices-trust
+++ b/Documentation/ABI/testing/sysfs-devices-trust
@@ -14,6 +14,8 @@ Description:
 		value may be selected by the bus before the device is
 		registered; otherwise it is "default". The policy is resolved
 		to an active trust level before the device is probed.
+		A matching device_trust= kernel command-line entry overrides
+		the initial requested policy before registration.
 
 		The values are "default", "disabled", "adversary", and
 		"full". "default" lets the bus select the active trust level.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2d046c79becd9..fbc0cd21bf09f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1259,6 +1259,15 @@ Kernel parameters
 	dell_smm_hwmon.fan_max=
 			[HW] Maximum configurable fan speed.
 
+	device_trust=	[KNL]
+			Set initial device trust policy before probing, including
+			for devices added after boot.
+			Format: <bus>:<device>=<policy>[,...]
+			Names match exactly as in /sys/bus/<bus>/devices/<device>.
+			Policies are default, disabled, adversary, and full.
+			Entries override bus policy and device_trust.default.
+			See Documentation/driver-api/driver-model/device-trust.rst.
+
 	device_trust.default=
 			[KNL] Set the initial trust policy for all devices.
 			Format: { default | disabled | adversary | full }
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 623444c7a3be8..59da537462a57 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -178,6 +178,14 @@ void device_release_driver_internal(struct device *dev, const struct device_driv
 
 extern const struct attribute_group device_trust_attr_group;
 
+#if IS_ENABLED(CONFIG_KUNIT)
+int device_trust_parse_cmdline(const char *options, const struct device *dev,
+			       enum device_trust_policy *policy);
+void device_trust_apply_boot_policy(struct device *dev,
+				    enum device_trust_policy policy,
+				    const char *options);
+#endif
+
 /* Full-only manual attachment uses the caller's subsystem serialization. */
 void device_trust_init_state(struct device *dev);
 int device_trust_prepare(struct device *dev, const struct device_driver *drv);
diff --git a/drivers/base/trust.c b/drivers/base/trust.c
index 86ce2751f30a3..f581857642493 100644
--- a/drivers/base/trust.c
+++ b/drivers/base/trust.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/ctype.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/export.h>
@@ -211,6 +212,79 @@ static struct attribute *device_trust_attrs[] = {
 const struct attribute_group device_trust_attr_group = {
 	.attrs = device_trust_attrs,
 };
+
+static const char *device_trust_cmdline __ro_after_init;
+
+VISIBLE_IF_KUNIT int device_trust_parse_cmdline(const char *options,
+						const struct device *dev,
+						enum device_trust_policy *policy)
+{
+	enum device_trust_policy selected = DEVICE_TRUST_POLICY_DEFAULT;
+	const char *entry = options;
+	bool matched = false;
+
+	if (!*entry)
+		return -EINVAL;
+
+	for (;;) {
+		const char *end = entry + strcspn(entry, ",");
+		const char *bus_end, *name, *level, *p;
+		unsigned int i;
+
+		bus_end = memchr(entry, ':', end - entry);
+		if (!bus_end || bus_end == entry ||
+		    memchr(entry, '=', bus_end - entry))
+			return -EINVAL;
+		name = bus_end + 1;
+		level = memchr(name, '=', end - name);
+		if (!level || level == name || level + 1 == end)
+			return -EINVAL;
+
+		for (p = entry; p < end; p++)
+			if (isspace(*p) || iscntrl(*p) || *p == '"')
+				return -EINVAL;
+
+		for (i = 0; i < ARRAY_SIZE(device_trust_policy_names); i++)
+			if (strlen(device_trust_policy_names[i]) == end - level - 1 &&
+			    !strncmp(level + 1, device_trust_policy_names[i],
+				     end - level - 1))
+				break;
+		if (i == ARRAY_SIZE(device_trust_policy_names))
+			return -EINVAL;
+
+		if (dev && dev->bus && dev_name(dev) &&
+		    strlen(dev->bus->name) == bus_end - entry &&
+		    !strncmp(dev->bus->name, entry, bus_end - entry) &&
+		    strlen(dev_name(dev)) == level - name &&
+		    !strncmp(dev_name(dev), name, level - name)) {
+			selected = i;
+			matched = true;
+		}
+
+		if (!*end)
+			break;
+		entry = end + 1;
+	}
+
+	if (matched)
+		*policy = selected;
+	return matched;
+}
+EXPORT_SYMBOL_IF_KUNIT(device_trust_parse_cmdline);
+
+static int __init device_trust_setup(char *str)
+{
+	if (device_trust_parse_cmdline(str, NULL, NULL) < 0) {
+		pr_warn("device_trust: ignoring invalid policy list '%s'\n", str);
+		return 1;
+	}
+
+	/* The command-line buffer survives init. */
+	device_trust_cmdline = str;
+	return 1;
+}
+__setup("device_trust=", device_trust_setup);
+
 static int __init device_trust_default_setup(char *str)
 {
 	int policy = match_string(device_trust_policy_names,
@@ -226,13 +300,24 @@ static int __init device_trust_default_setup(char *str)
 }
 __setup("device_trust.default=", device_trust_default_setup);
 
+VISIBLE_IF_KUNIT void device_trust_apply_boot_policy(struct device *dev,
+						   enum device_trust_policy policy,
+						   const char *options)
+{
+	if (policy != DEVICE_TRUST_POLICY_DEFAULT)
+		dev->trust_policy = policy;
+	if (options)
+		device_trust_parse_cmdline(options, dev, &dev->trust_policy);
+}
+EXPORT_SYMBOL_IF_KUNIT(device_trust_apply_boot_policy);
+
 /**
- * device_trust_init - Apply global boot policy before registration
- * @dev: unregistered device with its initial policy set
+ * device_trust_init - Apply boot policy before registration or bus policy use
+ * @dev: unregistered device with its bus, name, and default policy set
  */
 void device_trust_init(struct device *dev)
 {
-	if (device_trust_default_policy != DEVICE_TRUST_POLICY_DEFAULT)
-		dev->trust_policy = device_trust_default_policy;
+	device_trust_apply_boot_policy(dev, device_trust_default_policy,
+				       device_trust_cmdline);
 }
 EXPORT_SYMBOL_GPL(device_trust_init);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f4..5b6960bbb35bc 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2083,6 +2083,7 @@ int pci_setup_device(struct pci_dev *dev)
 	set_pcie_cxl(dev);
 
 	set_pcie_untrusted(dev);
+	device_trust_init(&dev->dev);
 
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;

-- 
2.56.0

