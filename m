Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513550;
	b=NNkpvmTm/J2sbnTy1ij+wT2CTZ+AdYpGil9rLoO+GqryY48TJx1hOfyBf6g6VeEaF05v
	 Aya+jRpVgQVUTv6hrPK+FWc/Nvcm01rpVgXUvmzVnfyBMZcGGRIZb2JCZybp6QxGeTK6M
	 lpzTx9mvIOVteapnk0B/jLw0whSLcKayBb442T4JL0WioabKoCX1lUtHjqdfWU/1SGiek
	 DOSbDBeRBryNgXzNQHhOMBsg6EtbNCwQTDy2UvaAGfw/5nAwTN42SxBxyxPE2Ww3mLYye
	 DxlBJN7DkcdXiAIn/6D9zbyTRkfsjAPN7pwsp3fwonu31SgQp2hlhdf42dZA6QUvHww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513550;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=ZQR5hslpSCQ3GjS9aIiFRGqiZ1yxedX64axMTG0c18A=;
	b=mb2pWaBzWx1sANrt4MXWd1CEoK/PabV1Px9Ygz/ZtYs4rI6XW9hcI5uXVCKnj5kxj1pU
	 25dECvC3KLsz5InlII3NzQtVu8o6REx4ntfROlOaWkLrj0EgkQ8meNdJ+T9VSFcwUXdQW
	 dtdTJKfWHDFWfhF4uZRYHHEpsLz/cU00Nfi5Hyfl1A1qj+WB4pJsyKS9OqW4k+eCruVot
	 Vg36V3GsZLN8Q88SAbmP8Pigsz/t4O4LveE83nUGu19N6pBZKvGP2oLVDEJKcTQe2Ntkm
	 mTD9PFLj80/RBWbE0Qcfpcy1Lg3ofr6rBwsMmMfYSDPOtnfLgiMng41z8jKbt2XzCEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Td38aoPH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC57606CF39;
	Tue, 24 Nov 2026 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Td38aoPH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1301F000C6;
	Tue, 24 Nov 2026 09:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513550;
	bh=ZQR5hslpSCQ3GjS9aIiFRGqiZ1yxedX64axMTG0c18A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Td38aoPH6QpD3z5ywF0DHABFbjsSwiwVRWJmpSGKfjhzWnz8SB1jfhfWrUwulPG/s
	 FyPX3RO56u6gmMmFTp3JexCVBiVv+GWydZ6fhhEKAl2sj4iNuhOnYRU/8Fwjzdx81v
	 +CGv+jET6S+4rHC0jrxaqf/ql833Thl3HplI8Dn0VpvBMOY5LwWQHTe+KefZAUkPtw
	 gJJ7KzG6C6w/idOko5W63XKLlxxpH/mq9gMptW6EP7Y7LrUox5ssqHZ6IrYivsm+zE
	 SRrdgQ2yZ8PDIO3CqPaoi5w03b2DqfD9sMr9WBKuyaNCnnUqeZGYYfsGUQH96ESutQ
	 qryt01TJHRffA==
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
	Jeff Garzik <jeff@garzik.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Dan Williams <djbw@kernel.org>
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
Subject: [PATCH v4 23/33] driver core: Accept device trust policy on the kernel command line
Date: Tue, 24 Nov 2026 11:43:54 +0200
Message-ID: <20261124-device-trust-core-v4-23-037eb0d17b1f@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
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

Blocking devices until initrd attestation also blocks the hardware needed
to reach the initrd and perform that attestation. A global policy alone
cannot allow those dependencies while keeping other devices blocked.

Allow boot policy exceptions for specific bus devices before probing,
including devices discovered later. Keep unmatched devices blocked unless
the administrator explicitly chooses another default. This makes the
exceptions usable with built-in drivers and avoids depending on userspace
winning a race against early probing.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/ABI/testing/sysfs-devices-trust   |   2 +
 Documentation/admin-guide/kernel-parameters.txt |  14 ++-
 drivers/base/base.h                             |   8 ++
 drivers/base/trust.c                            | 116 +++++++++++++++++++++++-
 include/linux/device/trust.h                    |   1 +
 5 files changed, 134 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-trust b/Documentation/ABI/testing/sysfs-devices-trust
index 59b066c2846ba..3bfc85b609a6d 100644
--- a/Documentation/ABI/testing/sysfs-devices-trust
+++ b/Documentation/ABI/testing/sysfs-devices-trust
@@ -15,6 +15,8 @@ Description:
 		value may be selected by the bus before the device is
 		registered; otherwise it is "default". The policy is resolved
 		to an active trust level before the device is probed.
+		A matching device_trust= kernel command-line entry overrides
+		the initial requested policy before registration.
 
 		Changes through this attribute require an explicit device
 		trust boot option. Any such option selects an implicit
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8a94482f0b19b..63831dc40f796 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1262,9 +1262,19 @@ Kernel parameters
 	device_trust	[KNL]
 			Enable device trust with blocked as the implicit default.
 
+	device_trust=	[KNL]
+			Set initial device trust policy before probing, including
+			for devices added after boot.
+			Format: <bus>:<device>=<policy>[,...]
+			Names match exactly as in /sys/bus/<bus>/devices/<device>.
+			Policies are default, blocked, adversarial, and
+			unrestricted.
+			Entries override bus policy and device_trust.default.
+			See Documentation/driver-api/driver-model/device-trust.rst.
+
 	device_trust.default=
-			[KNL] Set initial trust policy for all devices, including
-			hotplugged devices.
+			[KNL] Set initial trust policy for devices without a
+			matching device_trust= entry, including hotplugged devices.
 			Format: { default | blocked | adversarial | unrestricted }
 			No trust options selects legacy unrestricted mode, preserving
 			bus policy and existing authorization. Otherwise blocked is the
diff --git a/drivers/base/base.h b/drivers/base/base.h
index e51637ed37193..761d52f4c9caf 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -197,6 +197,14 @@ int device_private_init(struct device *dev);
 
 extern const struct attribute_group device_trust_attr_group;
 
+#if IS_ENABLED(CONFIG_KUNIT)
+int device_trust_parse_cmdline(const char *options, const struct device *dev,
+			       enum device_trust_policy *policy);
+void device_trust_apply_boot_policy(struct device *dev,
+				    enum device_trust_policy policy,
+				    const char *options);
+#endif
+
 /* Unrestricted-only manual attachment uses the caller's subsystem serialization. */
 void device_trust_init_state(struct device *dev);
 int device_trust_prepare_unrestricted(struct device *dev,
diff --git a/drivers/base/trust.c b/drivers/base/trust.c
index d8af34e95ea09..2e339e5ca0122 100644
--- a/drivers/base/trust.c
+++ b/drivers/base/trust.c
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/ctype.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
+#include <kunit/visibility.h>
 
 #include "base.h"
 
@@ -13,6 +15,17 @@ static enum device_trust_policy device_trust_default_policy __ro_after_init =
 	DEVICE_TRUST_POLICY_UNRESTRICTED;
 static bool device_trust_configured __ro_after_init;
 
+/**
+ * device_trust_enabled - Test whether boot options enabled device trust
+ *
+ * Return: True if any device trust option was supplied at boot.
+ */
+bool device_trust_enabled(void)
+{
+	return device_trust_configured;
+}
+EXPORT_SYMBOL_GPL(device_trust_enabled);
+
 static void __init device_trust_configure(void)
 {
 	if (device_trust_configured)
@@ -284,6 +297,88 @@ static struct attribute *device_trust_attrs[] = {
 const struct attribute_group device_trust_attr_group = {
 	.attrs = device_trust_attrs,
 };
+
+static const char *device_trust_cmdline __ro_after_init;
+
+static int device_trust_parse_policy(const char *options, const char *target_bus,
+				     const char *target_name,
+				     enum device_trust_policy *policy)
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
+		if (target_bus && target_name &&
+		    strlen(target_bus) == bus_end - entry &&
+		    !strncmp(target_bus, entry, bus_end - entry) &&
+		    strlen(target_name) == level - name &&
+		    !strncmp(target_name, name, level - name)) {
+			selected = i;
+			matched = true;
+		}
+
+		if (!*end)
+			break;
+		entry = end + 1;
+	}
+
+	if (matched && policy)
+		*policy = selected;
+	return matched;
+}
+
+VISIBLE_IF_KUNIT int device_trust_parse_cmdline(const char *options,
+						const struct device *dev,
+						enum device_trust_policy *policy)
+{
+	return device_trust_parse_policy(options, dev && dev->bus ? dev->bus->name : NULL,
+					 dev ? dev_name(dev) : NULL, policy);
+}
+EXPORT_SYMBOL_IF_KUNIT(device_trust_parse_cmdline);
+
+static int __init device_trust_setup(char *str)
+{
+	device_trust_configure();
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
@@ -300,17 +395,28 @@ static int __init device_trust_default_setup(char *str)
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
 	if (dev->trust_committed_level != DEVICE_TRUST_BLOCKED)
 		return;
 
-	if (device_trust_configured &&
-	    device_trust_default_policy != DEVICE_TRUST_POLICY_DEFAULT)
-		dev->trust_policy = device_trust_default_policy;
+	if (device_trust_configured)
+		device_trust_apply_boot_policy(dev, device_trust_default_policy,
+					       device_trust_cmdline);
 }
 EXPORT_SYMBOL_GPL(device_trust_init);
diff --git a/include/linux/device/trust.h b/include/linux/device/trust.h
index 52fd9e7c4dd5b..a3a583eeb484c 100644
--- a/include/linux/device/trust.h
+++ b/include/linux/device/trust.h
@@ -40,6 +40,7 @@ enum device_trust_policy {
 	DEVICE_TRUST_POLICY_UNRESTRICTED,
 };
 
+bool device_trust_enabled(void);
 void device_trust_init(struct device *dev);
 int device_trust_prepare(struct device *dev, const struct device_driver *drv);
 void device_trust_clear(struct device *dev);

-- 
2.56.1

