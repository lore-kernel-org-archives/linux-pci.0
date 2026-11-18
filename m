Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030118;
	b=u63iz2lRZELgIT4Fot4Q2QJwfezQEpgUOFomW3gfLNwW8tebRM/Xx90Q483aAtboi7Ls
	 FK3NjMX2cOblDKkIg38Ne4sWSFe+jf+oEwGtQLb34TE+CPbHzGjXAVxQZQ1PRP7UZpVOY
	 /eud91yj5DtDh779N78DfYcd+wsYH/45CJukOYhkeA2zel+/fj2n9kyNkWlBcunUC5zPO
	 kcHgDkM3TYplp639m4P3YyHVNaBEWX97a7t7BFBDRTdCPoCo0gpZGzZXDxPUQFXUqwStk
	 kmUpG4Vd2rFCC3VzE+dc+K8Jdim0as8by/b9hI+1Vm2gc2QetnmjuSoln48hxW0NCvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030118;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=Q0+puJYVaBWZ2IKUYwn0Ow6mUeUZmKSPMVZbJf6pzyg=;
	b=tO5Tv8wQbSCCLVu4bi+N1uRad5FO6SghIk1+Jvhq0B2JwTDDXndmTA36BLwv/B7zSCeX
	 rXqpggh6j9lP1oMaEpXD3gPqLgYwq0u+cr10zK3W20xgr8D5wOcb3+6/B2YpGmE5ELE39
	 PO+Hx9lrbp1apeSuKwwtcFggwTnjx6WSpdm2hol8+aFK2RyRR7RNl/ODy0GCLZi7YAaHw
	 0PiIiplCLIzaCrUol1DO+WTGQ+XsNPBSTp2oYJxWJag55zvTPFGD6Bf4NDchG1S6FxxFa
	 qF11oxyaR9toI1MlbZaT/CWqzFZybWNO1g4V/G1m5krgqJ/fGBl6DBbEkmZYW3xtBDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVnuau4L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358E1606A7C1;
	Wed, 18 Nov 2026 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVnuau4L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475AD1F000C4;
	Wed, 18 Nov 2026 19:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030118;
	bh=Q0+puJYVaBWZ2IKUYwn0Ow6mUeUZmKSPMVZbJf6pzyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LVnuau4LCZOyEh7Zn3m2RpOScMVZKqULdvphuswGIvY0bBC4bYjwvnEStmYXXN/jK
	 fj2/6owbStnAbAcBH66K3zzrrhKm0kfaI/B5/qRDQS26wXg8QtlZKHSyGuuHlGWrh5
	 9p4odGf0SJQyYAyyT9GWFCrYf7PxxZvorhUO4x5ZSXSabkvCKfL4sUtP5RN0P56q2e
	 2+ocVe/BZpll5np1Uczv18ztQ996yU6CAyKzCihwV8utJy8w2sCYaSowdhB8fwfA6A
	 jLLXwh2WXioMK9CaB2aGTOlfEa5MzdIugaV6jgE/QA7bxWZbOGKSG2VuaIftF+Uohi
	 0hUsG1iFjan5g==
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
Subject: [PATCH v3 20/31] driver core: Expose device trust authorization interfaces
Date: Wed, 18 Nov 2026 21:26:50 +0200
Message-ID: <20261118-device-trust-core-v3-20-d655875c4bfb@nvidia.com>
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

An initrd must be able to authorize a blocked device after attestation and
distinguish that permission from a successful driver binding. Existing bus
authorization interfaces also need a way to grant access without bypassing
the common policy.

Expose policy and active trust through sysfs, with shared authorization
rules for bus callers. Authorizing a blocked device fixes the choice for
its lifetime, so a failed probe cannot reopen the decision. Require boot
opt-in for the new writable interface to preserve legacy attachment
assumptions.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/ABI/testing/sysfs-devices-trust |  32 +++++++
 MAINTAINERS                                   |   1 +
 drivers/base/base.h                           |   2 +
 drivers/base/core.c                           |  15 ++-
 drivers/base/trust.c                          | 129 ++++++++++++++++++++++++++
 include/linux/device.h                        |   5 +
 include/linux/device/trust.h                  |   3 +
 7 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-trust b/Documentation/ABI/testing/sysfs-devices-trust
new file mode 100644
index 0000000000000..154c5577c65e0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-trust
@@ -0,0 +1,32 @@
+What:		/sys/devices/.../trust
+Date:		September 2026
+Contact:	driver-core@lists.linux.dev
+Description:
+		(RO) The active trust level for the device. The values are
+		"blocked", "adversary", and "unrestricted". Driver core resolves
+		the level before driver setup and retains it through DMA
+		cleanup. It is "blocked" outside a binding transaction.
+
+What:		/sys/devices/.../trust_policy
+Date:		September 2026
+Contact:	driver-core@lists.linux.dev
+Description:
+		(RW) The requested trust policy for the device. The initial
+		value may be selected by the bus before the device is
+		registered; otherwise it is "default". The policy is resolved
+		to an active trust level before the device is probed.
+
+		Changes through this attribute require an explicit device
+		trust boot option. Any such option selects an implicit
+		blocked default; use device_trust.default=default to
+		enable them while preserving bus policy. Without one,
+		only writing the current policy succeeds. Existing bus
+		authorization interfaces remain available. Explicit unrestricted
+		policy disables runtime policy changes.
+
+		The values are "default", "blocked", "adversary", and
+		"unrestricted". "default" lets the bus select the operating level.
+		"blocked" prevents driver binding. "adversary" requests
+		classification as potentially malicious. "unrestricted" requests
+		normal operation. Adversary protections depend on bus, DMA,
+		and driver support; classification alone adds none.
diff --git a/MAINTAINERS b/MAINTAINERS
index b726344362b41..a145aaaca2ef3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8150,6 +8150,7 @@ L:	driver-core@lists.linux.dev
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git
 F:	Documentation/ABI/testing/sysfs-bus-drivers-probe
+F:	Documentation/ABI/testing/sysfs-devices-trust
 F:	Documentation/core-api/kobject.rst
 F:	Documentation/driver-api/driver-model/
 F:	drivers/base/
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 56f1a9c73964b..1e7ee9856fe6f 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -195,6 +195,8 @@ void device_release_driver_internal(struct device *dev, const struct device_driv
 
 int device_private_init(struct device *dev);
 
+extern const struct attribute_group device_trust_attr_group;
+
 /* Unrestricted-only manual attachment uses the caller's subsystem serialization. */
 void device_trust_init_state(struct device *dev);
 int device_trust_prepare_unrestricted(struct device *dev,
diff --git a/drivers/base/core.c b/drivers/base/core.c
index c0006b3aa38f7..e72424618d622 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2999,10 +2999,14 @@ static int device_add_attrs(struct device *dev)
 	if (error)
 		goto err_remove_type_groups;
 
+	error = device_add_group(dev, &device_trust_attr_group);
+	if (error)
+		goto err_remove_dev_groups;
+
 	if (device_supports_offline(dev) && !dev_offline_disabled(dev)) {
 		error = device_create_file(dev, &dev_attr_online);
 		if (error)
-			goto err_remove_dev_groups;
+			goto err_remove_dev_trust_group;
 	}
 
 	if (fw_devlink_flags && !fw_devlink_is_permissive() && dev->fwnode) {
@@ -3032,6 +3036,8 @@ static int device_add_attrs(struct device *dev)
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
  err_remove_dev_online:
 	device_remove_file(dev, &dev_attr_online);
+ err_remove_dev_trust_group:
+	device_remove_group(dev, &device_trust_attr_group);
  err_remove_dev_groups:
 	device_remove_groups(dev, dev->groups);
  err_remove_type_groups:
@@ -3057,6 +3063,7 @@ static void device_remove_attrs(struct device *dev)
 	device_remove_file(dev, &dev_attr_removable);
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 	device_remove_file(dev, &dev_attr_online);
+	device_remove_group(dev, &device_trust_attr_group);
 	device_remove_groups(dev, dev->groups);
 
 	if (type)
@@ -4809,6 +4816,12 @@ static int device_attrs_change_owner(struct device *dev, kuid_t kuid,
 	if (error)
 		return error;
 
+	/* Change the trust attributes of @dev to @kuid/@kgid. */
+	error = sysfs_group_change_owner(kobj, &device_trust_attr_group, kuid,
+					 kgid);
+	if (error)
+		return error;
+
 	if (device_supports_offline(dev) && !dev_offline_disabled(dev)) {
 		/* Change online device attributes of @dev to @kuid/@kgid. */
 		error = sysfs_file_change_owner(kobj, dev_attr_online.attr.name,
diff --git a/drivers/base/trust.c b/drivers/base/trust.c
index 35893786a163d..215ea6151ecfc 100644
--- a/drivers/base/trust.c
+++ b/drivers/base/trust.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 
 #include "base.h"
 
@@ -155,6 +156,134 @@ static const char * const device_trust_policy_names[] = {
 	[DEVICE_TRUST_POLICY_UNRESTRICTED] = "unrestricted",
 };
 
+static const char * const device_trust_level_names[] = {
+	[DEVICE_TRUST_BLOCKED] = "blocked",
+	[DEVICE_TRUST_ADVERSARY] = "adversary",
+	[DEVICE_TRUST_UNRESTRICTED] = "unrestricted",
+};
+
+static ssize_t trust_show(struct device *dev,
+			  const struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+			  device_trust_level_names[device_get_trust_level(dev)]);
+}
+static DEVICE_ATTR_RO(trust);
+
+static ssize_t trust_policy_show(struct device *dev,
+				 const struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+			  device_trust_policy_names[READ_ONCE(dev->trust_policy)]);
+}
+
+static bool device_trust_policy_frozen(void)
+{
+	return device_trust_configured &&
+		device_trust_default_policy == DEVICE_TRUST_POLICY_UNRESTRICTED;
+}
+
+/**
+ * device_trust_set_policy_locked - Request policy with the device locked
+ * @dev: registered device
+ * @policy: requested policy
+ *
+ * Apply the admission rules while the caller holds the device lock.
+ *
+ * Return: 0 on success, -EBUSY if the policy can no longer change, or
+ * -ENODEV if the device is being removed outside explicit unrestricted mode.
+ */
+int device_trust_set_policy_locked(struct device *dev,
+				   enum device_trust_policy policy)
+{
+	device_lock_assert(dev);
+	if (device_trust_policy_frozen())
+		return policy == dev->trust_policy ? 0 : -EBUSY;
+	if (dev->p->dead)
+		return -ENODEV;
+	if (policy == dev->trust_policy)
+		goto set_policy;
+
+	if (dev->driver)
+		return -EBUSY;
+
+	switch (dev->p->trust_state) {
+	case DEVICE_TRUST_SELECTABLE:
+		if (policy == DEVICE_TRUST_POLICY_BLOCKED)
+			dev->p->trust_state = DEVICE_TRUST_WAITING;
+		break;
+	case DEVICE_TRUST_WAITING:
+		if (policy != DEVICE_TRUST_POLICY_ADVERSARY &&
+		    policy != DEVICE_TRUST_POLICY_UNRESTRICTED)
+			return -EBUSY;
+		dev->p->trust_state = DEVICE_TRUST_AUTHORIZED;
+		break;
+	default:
+		return -EBUSY;
+	}
+set_policy:
+	WRITE_ONCE(dev->trust_policy, policy);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(device_trust_set_policy_locked);
+
+/**
+ * device_trust_set_policy - Request a trust policy for a device
+ * @dev: registered device
+ * @policy: requested policy
+ *
+ * Apply admission rules, including on legacy boots where trust_policy writes
+ * are unavailable. Buses with their own authorization interfaces may use this
+ * API. Callers of device_driver_attach_unrestricted() must preserve its invariants.
+ *
+ * Takes the device lock except in explicit unrestricted mode, where a same-policy
+ * request is a no-op and does not override a pending driver boot rule.
+ *
+ * Return: 0 on success, -EBUSY if the policy can no longer change, or
+ * -ENODEV if the device is being removed outside explicit unrestricted mode.
+ */
+int device_trust_set_policy(struct device *dev, enum device_trust_policy policy)
+{
+	int ret;
+
+	if (device_trust_policy_frozen())
+		return policy == READ_ONCE(dev->trust_policy) ? 0 : -EBUSY;
+
+	device_lock(dev);
+	ret = device_trust_set_policy_locked(dev, policy);
+	device_unlock(dev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(device_trust_set_policy);
+
+static ssize_t trust_policy_store(struct device *dev,
+				  const struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	int policy, ret;
+
+	policy = sysfs_match_string(device_trust_policy_names, buf);
+	if (policy < 0)
+		return policy;
+
+	if (!device_trust_configured)
+		return policy == READ_ONCE(dev->trust_policy) ? count : -EBUSY;
+
+	ret = device_trust_set_policy(dev, policy);
+
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_RW(trust_policy);
+
+static struct attribute *device_trust_attrs[] = {
+	&dev_attr_trust.attr,
+	&dev_attr_trust_policy.attr,
+	NULL,
+};
+
+const struct attribute_group device_trust_attr_group = {
+	.attrs = device_trust_attrs,
+};
 static int __init device_trust_default_setup(char *str)
 {
 	int policy = match_string(device_trust_policy_names,
diff --git a/include/linux/device.h b/include/linux/device.h
index 702eb66b81bf3..2914b7191d342 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -933,6 +933,11 @@ static inline bool device_iommu_mapped(struct device *dev)
 	return (dev->iommu_group != NULL);
 }
 
+static inline bool device_policy_is_blocked(const struct device *dev)
+{
+	return READ_ONCE(dev->trust_policy) == DEVICE_TRUST_POLICY_BLOCKED;
+}
+
 /* Get the wakeup routines, which depend on struct device */
 #include <linux/pm_wakeup.h>
 
diff --git a/include/linux/device/trust.h b/include/linux/device/trust.h
index 32071f12ed257..b940dddf10e46 100644
--- a/include/linux/device/trust.h
+++ b/include/linux/device/trust.h
@@ -43,6 +43,9 @@ enum device_trust_policy {
 void device_trust_init(struct device *dev);
 int device_trust_prepare(struct device *dev, const struct device_driver *drv);
 void device_trust_clear(struct device *dev);
+int device_trust_set_policy_locked(struct device *dev,
+				   enum device_trust_policy policy);
+int device_trust_set_policy(struct device *dev, enum device_trust_policy policy);
 enum device_trust_level device_get_trust_level(const struct device *dev);
 bool device_is_adversarial(const struct device *dev);
 

-- 
2.56.1

