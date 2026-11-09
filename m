Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209679;
	b=xeFnU4l12ecPRY39iwIBeZL/KkvFS2uTdvvQFrux4QOrRj9dl9GAAM+g0SBjVXXz31Cc
	 CZSDf7TRjbvEfnvAk6QlaKFVlBIeicWBJRkbGnvR3uv6vdmh8zkSxwBzVAvT+OEWjmOmW
	 3b0w43cWJgN/azVcFPfZRkD+obgWWCH717bv+56ohc4Aov7ibl7cxwCFoLzCswqtKT34K
	 R5s/xBGXvrredI/9RZYmx0Qvh71SpLitRypT8m8VzaoPBobGlfJ3/lcloVDekD5z9XfMU
	 ghqodsCFyc2xa2scT0ky+Ubb5EKVdEREfID55OfYHX+248ZdjPgyCy953PJWAbLjaRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209679;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=4rGATcdkFHVDIIsPGWAGyVXOOtm1+i4aQGdQVAamHuU=;
	b=TJ5FUMSQHfw1Pgg2NXf7206cRaFfoqtxdtidPBlkrqQqALEnEoqhA0cc5wWLEhr50hkx
	 sGyIS3Sc5gLuh7QdidU1tEzmlO+Z8OQ2QsmesIm99sJNOY2Em3W40vxQ57imBSuAbBM6C
	 ATGZ4OeOVEHpE4utGLk64oyJCy9BBD/tx3pj7gdOjT1RJkcbKShvLVz5KNtCdxkJe9Mdu
	 1xXryzmMoi7AjuBUfKOhIWQYXU5WvG0RJpcn8YnkaMtlt8hp2j+V/c8jTKq9y8np2w76B
	 SYYmet6aNY0P4IoZ5qhxP+w5GKBZ8a/+ffUhad17LvROWMDPYSw4eMjhwTrb8XNLjow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6t12SSh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9D60A5BE8;
	Mon,  9 Nov 2026 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6t12SSh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660881F0089F;
	Mon,  9 Nov 2026 07:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209679;
	bh=4rGATcdkFHVDIIsPGWAGyVXOOtm1+i4aQGdQVAamHuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L6t12SShyoy5fNLsK/7yt58iOBG+vbCkNSlA+3QJHMQS8lIxj9xFIAv6fZFfOUD3o
	 xxgJArlgj9nXSzNipTYmebMXsABKSz+uuT3y3lfH4ZjoVmxrRBmnrEDHPaoDl1Oa1l
	 y5jh5WsHe3HuEQG4ha3jOolF1Jwdyb9Qzmr+XzykaZnQIIlrO1PLGTh/xPwN/bHOSz
	 CGEQXpCjE+Zv32fz0kUOtLM+oLGrO8JDSX5jbBpmD/N1aa4iMrwAt0LXiw390WQYK8
	 D1Yt4fGOn39iPRnLGybIobRgeKyRBhrh712cCy+p+0WGf0aIP4/3ZqhxWNPZv3FHi8
	 JpCkXhmR1XvhA==
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
Subject: [PATCH v2 12/19] driver core: Expose device trust authorization interfaces
Date: Mon,  9 Nov 2026 09:33:42 +0200
Message-ID: <20261109-device-trust-core-v2-12-3b12d9a9f861@nvidia.com>
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

An initrd must authorize a disabled device after attestation even if a
built-in driver already attempted to probe it. Buses with their own
authorization interface need to apply the same policy rules.

Expose requested policy and active trust through sysfs, and export
device_trust_set_policy() for bus authorization. Fix explicit authorization
or commitment for the device lifetime and serialize writes with probing.
Under the global full policy, reject changes and leave same-value writes
as no-ops so manual attachment needs no additional lock. Include the
attributes in device ownership changes.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/ABI/testing/sysfs-devices-trust   |  28 +++++++
 Documentation/admin-guide/kernel-parameters.txt |   1 +
 MAINTAINERS                                     |   1 +
 drivers/base/base.h                             |   2 +
 drivers/base/core.c                             |  15 +++-
 drivers/base/trust.c                            | 106 ++++++++++++++++++++++++
 include/linux/device.h                          |   5 ++
 include/linux/device/trust.h                    |   1 +
 8 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-trust b/Documentation/ABI/testing/sysfs-devices-trust
new file mode 100644
index 0000000000000..d68113b0d6b08
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-trust
@@ -0,0 +1,28 @@
+What:		/sys/devices/.../trust
+Date:		September 2026
+Contact:	driver-core@lists.linux.dev
+Description:
+		(RO) The active trust level for the device. The values are
+		"disabled", "adversary", and "full". Driver core resolves
+		the level before probe, and retains it through whole lifetime.
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
+		The values are "default", "disabled", "adversary", and
+		"full". "default" lets the bus select the active trust level.
+		"disabled" prevents a driver from binding and informs the kernel
+		to provide containtment of the device. For example a PCIe device
+		should be unable to DMA to the memory. "adversary" informs the
+		kernel that the userspace wants to opt into any security
+		defences the kernel may have to restrict and further validate
+		interactions with the device. This may have a performance or
+		functional cost compared to "full". As an example the DMA API
+		and IOMMU layers will avoid exposing unrelated nearby memory
+		to the device during DMA. "full" requests normal operation.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 81a936dca9476..2d046c79becd9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1266,6 +1266,7 @@ Kernel parameters
 			Other values replace bus policy. The last valid value wins.
 			Full-only manual driver attachment requires full; other
 			global policies reject it before the probe callback.
+			With full, runtime trust policy changes are unavailable.
 
 	dfltcc=		[HW,S390]
 			Format: { on | off | def_only | inf_only | always }
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
index ba8b5b3c51a65..623444c7a3be8 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -176,6 +176,8 @@ void bus_remove_driver(struct device_driver *drv);
 void device_release_driver_internal(struct device *dev, const struct device_driver *drv,
 				    struct device *parent);
 
+extern const struct attribute_group device_trust_attr_group;
+
 /* Full-only manual attachment uses the caller's subsystem serialization. */
 void device_trust_init_state(struct device *dev);
 int device_trust_prepare(struct device *dev, const struct device_driver *drv);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6b94a163cda8d..bd96d84c2ac2c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2989,10 +2989,14 @@ static int device_add_attrs(struct device *dev)
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
@@ -3022,6 +3026,8 @@ static int device_add_attrs(struct device *dev)
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
  err_remove_dev_online:
 	device_remove_file(dev, &dev_attr_online);
+ err_remove_dev_trust_group:
+	device_remove_group(dev, &device_trust_attr_group);
  err_remove_dev_groups:
 	device_remove_groups(dev, dev->groups);
  err_remove_type_groups:
@@ -3047,6 +3053,7 @@ static void device_remove_attrs(struct device *dev)
 	device_remove_file(dev, &dev_attr_removable);
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 	device_remove_file(dev, &dev_attr_online);
+	device_remove_group(dev, &device_trust_attr_group);
 	device_remove_groups(dev, dev->groups);
 
 	if (type)
@@ -4791,6 +4798,12 @@ static int device_attrs_change_owner(struct device *dev, kuid_t kuid,
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
index 6a71abf10b3bb..86ce2751f30a3 100644
--- a/drivers/base/trust.c
+++ b/drivers/base/trust.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 #include <kunit/visibility.h>
 
 #include "base.h"
@@ -105,6 +106,111 @@ static const char * const device_trust_policy_names[] = {
 	[DEVICE_TRUST_POLICY_FULL] = "full",
 };
 
+static const char * const device_trust_level_names[] = {
+	[DEVICE_TRUST_DISABLED] = "disabled",
+	[DEVICE_TRUST_ADVERSARY] = "adversary",
+	[DEVICE_TRUST_FULL] = "full",
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
+/**
+ * device_trust_set_policy - Request a trust policy for a device
+ * @dev: registered device
+ * @policy: requested policy
+ *
+ * Apply the same rules as a write to the device's trust_policy attribute.
+ * A bus can use this to translate its own authorization interface into
+ * device trust. Takes the device lock except when the global full policy
+ * makes runtime policy changes unavailable. In that mode, writing the current
+ * policy is a no-op.
+ *
+ * Return: 0 on success, -EBUSY if the policy can no longer change, -ENODEV
+ * if the device is being removed outside global full mode.
+ */
+int device_trust_set_policy(struct device *dev, enum device_trust_policy policy)
+{
+	int ret = 0;
+
+	if (device_trust_default_policy == DEVICE_TRUST_POLICY_FULL)
+		return policy == READ_ONCE(dev->trust_policy) ? 0 : -EBUSY;
+
+	device_lock(dev);
+	if (dev->p->dead) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+	if (policy == dev->trust_policy)
+		goto unlock;
+
+	/* A driver that claimed the device before registration was not admitted. */
+	if (READ_ONCE(dev->driver)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	switch (dev->p->trust_state) {
+	case DEVICE_TRUST_SELECTABLE:
+		if (policy == DEVICE_TRUST_POLICY_DISABLED)
+			dev->p->trust_state = DEVICE_TRUST_WAITING;
+		break;
+	case DEVICE_TRUST_WAITING:
+		if (policy != DEVICE_TRUST_POLICY_ADVERSARY &&
+		    policy != DEVICE_TRUST_POLICY_FULL) {
+			ret = -EBUSY;
+			goto unlock;
+		}
+		dev->p->trust_state = DEVICE_TRUST_AUTHORIZED;
+		break;
+	default:
+		ret = -EBUSY;
+		goto unlock;
+	}
+	WRITE_ONCE(dev->trust_policy, policy);
+unlock:
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
index 57d2e1b0d98ad..e3e7457cd50f4 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -933,6 +933,11 @@ static inline bool device_iommu_mapped(struct device *dev)
 	return (dev->iommu_group != NULL);
 }
 
+static inline bool device_policy_is_disabled(const struct device *dev)
+{
+	return READ_ONCE(dev->trust_policy) == DEVICE_TRUST_POLICY_DISABLED;
+}
+
 /* Get the wakeup routines, which depend on struct device */
 #include <linux/pm_wakeup.h>
 
diff --git a/include/linux/device/trust.h b/include/linux/device/trust.h
index b8f5514cacec3..eb36970289e84 100644
--- a/include/linux/device/trust.h
+++ b/include/linux/device/trust.h
@@ -38,6 +38,7 @@ enum device_trust_policy {
 };
 
 void device_trust_init(struct device *dev);
+int device_trust_set_policy(struct device *dev, enum device_trust_policy policy);
 enum device_trust_level device_get_trust_level(const struct device *dev);
 bool device_is_adversarial(const struct device *dev);
 

-- 
2.56.0

