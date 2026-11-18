Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030157;
	b=C6XPy9APZ05kRN34dg2pyUaH0qyrtyV8R1cEtlMSCt84iAA6XDuEPhDaWbNmixmekAg2
	 rMRtfOaJrXkat885HY3hnASOxk5wLiwMrmDEvWUHZbN3kbyEGpVbUtwi7zZoPc8fpCLn2
	 R8CZEtKcZBNmbdbqK3aY9A1yRd2/Gp8XG4voYxXRpl++WolxEK+eotkbmJgwaqf5AoJcg
	 sy7VbK8Z/de2JYLCu8NWk8Jm0TDptD5TR0nTo3adH5BM8aJ1+pEP0G9g3hpDxIg9g0UZp
	 cENDjO7H5tQ9coazPQriOS8K8KNF40Dzg8RbyQl3rkqCawTRNrqNsFLQ4ATPhBES2Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030157;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=D5gqkjDp5BO5ocz9IVzVjGxTkJJIN7olSvao6ddNnII=;
	b=AxXfrgtYWIz31ghUVdPrzTWSD7CMtdWqdf8d15Y9h6OLRWFOdQjPNIvp7iViRgyXfsfS
	 dMzjxNeAAyl8QNIiOekM6HKrVCJSP8xO5wVyVMmOMWcuD/SitUo1/Q4HhS4+aQYYCJz2D
	 xH/HvDwqzW0yCJALW9Kbskj/4aRYYgqlMZF1+PacOi3E8Pb9VqY0pw30/5LLCsZ72Ram/
	 6aOv/QPzLLhP0qHTu85sgEBu5b4CIhs+C4Rbb7T9jqV/p6DK3BJ2/BH1uLIhvuI4Nza8e
	 km2q1qgfUGe/rm2LC6sndF/mrwpY5tDM3LPD7QY0EKp0/w+jqET5uyXuVAXnwo3glIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwl+cH69;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DA96079A88;
	Wed, 18 Nov 2026 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwl+cH69
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00141F000C8;
	Wed, 18 Nov 2026 19:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030157;
	bh=D5gqkjDp5BO5ocz9IVzVjGxTkJJIN7olSvao6ddNnII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hwl+cH69xqwMJjyiJYAHw37b6Xn3thBYH6GlYeSDKBD6lxZtAI0CQT+EhmzawqWeF
	 OPCuvbKjbCn2NapvEcaNit6zR9XpTPzKfUo4mWSLIgLiIJxkeupt0UcuZSIQQHf3Wm
	 xuJeXWVzPgM88tUBR3gziPtuZNFGQKdeGr7S/vZwWL6ofHeXGm6r4MqV413lm7X8pg
	 n5L+zilTuPuQ9vsEGo6Y13+67cXOUQczHxUtCdDHopcpVssiCDVSZ5Ja4BPrL9911f
	 uCDxcSm1rAHjQzSu7aswOzu+pWoJRE4nmGxkR3rk+VGx3YwTMGeGWvrU35XLJC8SBU
	 YA1+i2TNgWqMA==
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
Subject: [PATCH v3 31/31] USB: Authorize devices through device trust
Date: Wed, 18 Nov 2026 21:27:01 +0200
Message-ID: <20261118-device-trust-core-v3-31-d655875c4bfb@nvidia.com>
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

USB authorization can configure a device and expose its interfaces. With
generic trust enabled, that must wait until the device driver has been
admitted; otherwise configuration bypasses policy.

Keep authorization, attachment and the configuration result under the
device lock so concurrent requests cannot report each other's failures.
Allow configuration retries after failure while preserving authorization
and any active configuration. Retain the existing flow on legacy boots.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/ABI/testing/sysfs-bus-usb | 13 +++++++++++
 Documentation/usb/authorization.rst     | 26 ++++++++++++++++++++++
 drivers/usb/core/driver.c               | 10 +++++----
 drivers/usb/core/generic.c              |  2 +-
 drivers/usb/core/hub.c                  | 39 +++++++++++++++++++++++++++------
 drivers/usb/core/message.c              |  7 ++++--
 drivers/usb/core/sysfs.c                |  2 +-
 drivers/usb/core/trace.h                |  2 +-
 drivers/usb/core/usb.c                  |  5 +++++
 include/linux/usb.h                     | 12 +++++-----
 10 files changed, 97 insertions(+), 21 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 62e326710ef5f..dbe70c481e7c8 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -33,6 +33,19 @@ Description:
 		drivers, non-authorized one are not.  By default, wired
 		USB devices are authorized.
 
+		With device trust enabled at boot, a device that is not
+		authorized by default starts with the "blocked" trust policy
+		(see sysfs-devices-trust). Writing 1 requests the "unrestricted" policy
+		if the policy is blocked, then binds and configures the device.
+		Configuration errors leave authorization granted. If setup failed
+		and no configuration remains, write 1 again to retry, or select a
+		configuration through bConfigurationValue after driver admission.
+		Writing 1 preserves an existing configuration. Finding no suitable
+		configuration remains successful authorization without setup.
+		Writing 0 deconfigures it without changing its committed trust
+		level. Without trust boot options, the existing authorization
+		flow is unchanged.
+
 What:		/sys/bus/usb/drivers/.../new_id
 Date:		October 2011
 Contact:	linux-usb@vger.kernel.org
diff --git a/Documentation/usb/authorization.rst b/Documentation/usb/authorization.rst
index 31ff34df29717..b886b2da85605 100644
--- a/Documentation/usb/authorization.rst
+++ b/Documentation/usb/authorization.rst
@@ -92,6 +92,32 @@ can fake descriptors and device info. Don't trust that. You are
 welcome.
 
 
+Device trust
+------------
+
+Without device trust boot options, USB authorization is unchanged. With
+device trust enabled, authorization uses the policy described in
+Documentation/driver-api/driver-model/device-trust.rst. A device that the
+authorized_default setting does not authorize starts with the "blocked"
+trust policy and reads 0 in "authorized". Boot device rules can replace
+this initial policy.
+
+Writing 1 to "authorized" for such a device requests the "unrestricted" policy and
+binds the device, which configures it. To operate it as an adversary,
+enable trust policy writes at boot, for example with
+``device_trust.default=default``, and write "adversary" to its
+"trust_policy" attribute before writing 1. The choice is fixed for the life
+of the device: writing 0 deconfigures it, and a later 1 configures it again
+at the same trust level.
+
+Configuration errors leave authorization granted. If setup failed and no
+configuration remains, write 1 again to retry, or use "bConfigurationValue"
+to select a configuration after the device driver has been admitted.
+Writing 1 preserves an existing configuration. As before, failure to choose
+a suitable configuration is not an authorization error; an explicit
+"bConfigurationValue" selection remains available.
+
+
 Interface authorization
 -----------------------
 
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 893bcdb430878..1bd2b3e120708 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -335,7 +335,7 @@ static int usb_probe_interface(struct device *dev)
 	if (usb_device_is_owned(udev))
 		return error;
 
-	if (udev->authorized == 0) {
+	if (!usb_device_authorized(udev)) {
 		dev_info(&intf->dev, "Device is not authorized for usage\n");
 		return error;
 	} else if (!usb_interface_authorized(intf)) {
@@ -1351,8 +1351,7 @@ static int usb_resume_device(struct usb_device *udev, pm_message_t msg)
 	if (udev->state == USB_STATE_NOTATTACHED)
 		goto done;
 
-	/* Can't resume it if it doesn't have a driver. */
-	if (udev->dev.driver == NULL) {
+	if (!udev->dev.driver && !device_trust_enabled()) {
 		status = -ENOTCONN;
 		goto done;
 	}
@@ -1367,7 +1366,10 @@ static int usb_resume_device(struct usb_device *udev, pm_message_t msg)
 	if (udev->quirks & USB_QUIRK_RESET_RESUME)
 		udev->reset_resume = 1;
 
-	udriver = to_usb_device_driver(udev->dev.driver);
+	if (udev->dev.driver)
+		udriver = to_usb_device_driver(udev->dev.driver);
+	else
+		udriver = &usb_generic_driver;
 	if (udriver->generic_subclass)
 		status = usb_generic_driver_resume(udev, msg);
 	if (status == 0 && udriver->resume)
diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index a48994e11ef3d..bcfc01eefd09c 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -242,7 +242,7 @@ int usb_generic_driver_probe(struct usb_device *udev)
 	/* Choose and set the configuration.  This registers the interfaces
 	 * with the driver core and lets interface drivers bind to them.
 	 */
-	if (udev->authorized == 0)
+	if (!usb_device_authorized(udev))
 		dev_info(&udev->dev, "Device is not authorized for usage\n");
 	else {
 		c = usb_choose_configuration(udev);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 199d3f535a891..62eedae9d0077 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2770,7 +2770,8 @@ int usb_new_device(struct usb_device *udev)
 int usb_deauthorize_device(struct usb_device *usb_dev)
 {
 	usb_lock_device(usb_dev);
-	if (usb_dev->authorized == 0)
+	if (!usb_dev->authorized &&
+	    (!device_trust_enabled() || !usb_dev->config_error))
 		goto out_unauthorized;
 
 	usb_dev->authorized = 0;
@@ -2784,17 +2785,41 @@ int usb_deauthorize_device(struct usb_device *usb_dev)
 
 int usb_authorize_device(struct usb_device *usb_dev)
 {
+	bool attach;
 	int result = 0, c;
 
 	usb_lock_device(usb_dev);
-	if (usb_dev->authorized == 1)
-		goto out_authorized;
+	if (device_policy_is_blocked(&usb_dev->dev)) {
+		result = device_trust_set_policy_locked(&usb_dev->dev,
+							DEVICE_TRUST_POLICY_UNRESTRICTED);
+		if (result)
+			goto out_unlock;
+	}
+
+	attach = device_trust_enabled() && !usb_dev->dev.driver;
+	if (!attach && usb_dev->authorized == 1 &&
+	    (!device_trust_enabled() || !usb_dev->config_error ||
+	     usb_dev->actconfig))
+		goto out_unlock;
 
 	result = usb_autoresume_device(usb_dev);
 	if (result < 0) {
 		dev_err(&usb_dev->dev,
 			"can't autoresume for authorization: %d\n", result);
-		goto error_autoresume;
+		goto out_unlock;
+	}
+
+	if (attach) {
+		usb_dev->authorized = 1;
+		usb_dev->config_error = 0;
+		result = device_attach_locked(&usb_dev->dev);
+		if (result <= 0) {
+			if (result >= 0)
+				result = -ENODEV;
+		} else {
+			result = usb_dev->config_error;
+		}
+		goto out_autosuspend;
 	}
 
 	usb_dev->authorized = 1;
@@ -2813,10 +2838,10 @@ int usb_authorize_device(struct usb_device *usb_dev)
 	}
 	dev_info(&usb_dev->dev, "authorized to connect\n");
 
+out_autosuspend:
 	usb_autosuspend_device(usb_dev);
-error_autoresume:
-out_authorized:
-	usb_unlock_device(usb_dev);	/* complements locktree */
+out_unlock:
+	usb_unlock_device(usb_dev);
 	return result;
 }
 
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index d388d7371a247..b201356309e17 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -2081,7 +2081,7 @@ static int usb_set_configuration_internal(struct usb_device *dev, int configurat
  * channels are available independently; and choosing between open
  * standard device protocols (like CDC) or proprietary ones.
  *
- * Note that a non-authorized device (dev->authorized == 0) will only
+ * Note that a non-authorized device (see usb_device_authorized()) will only
  * be put in unconfigured mode.
  *
  * Note that USB has an additional level of device configurability,
@@ -2115,7 +2115,7 @@ static int usb_set_configuration_internal(struct usb_device *dev, int configurat
 	struct usb_hcd *hcd = bus_to_hcd(dev->bus);
 	int n, nintf;
 
-	if (dev->authorized == 0 || configuration == -1)
+	if (!usb_device_authorized(dev) || configuration == -1)
 		configuration = 0;
 	else {
 		for (i = 0; i < dev->descriptor.bNumConfigurations; i++) {
@@ -2128,6 +2128,9 @@ static int usb_set_configuration_internal(struct usb_device *dev, int configurat
 	}
 	if ((!cp && configuration != 0))
 		return -EINVAL;
+	if (cp && device_trust_enabled() &&
+	    device_get_trust_level(&dev->dev) == DEVICE_TRUST_BLOCKED)
+		return -EPERM;
 
 	/* The USB spec says configuration 0 means unconfigured.
 	 * But if a device includes a configuration numbered 0,
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index b8974e9db3a22..189fb917b81ee 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -728,7 +728,7 @@ static ssize_t authorized_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct usb_device *usb_dev = to_usb_device(dev);
-	return sysfs_emit(buf, "%u\n", usb_dev->authorized);
+	return sysfs_emit(buf, "%u\n", usb_device_authorized(usb_dev));
 }
 
 /*
diff --git a/drivers/usb/core/trace.h b/drivers/usb/core/trace.h
index 903e57dc273af..42f9cfcd8b0f2 100644
--- a/drivers/usb/core/trace.h
+++ b/drivers/usb/core/trace.h
@@ -27,7 +27,7 @@ DECLARE_EVENT_CLASS(usb_core_log_usb_device,
 		__entry->speed = udev->speed;
 		__entry->state = udev->state;
 		__entry->bus_mA = udev->bus_mA;
-		__entry->authorized = udev->authorized;
+		__entry->authorized = usb_device_authorized(udev);
 	),
 	TP_printk("usb %s speed %s state %s %dmA [%s]",
 		__get_str(name),
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 2559a180fdeec..ed71f1155e2ed 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -748,6 +748,11 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 #endif
 
 	dev->authorized = usb_dev_authorized(dev, usb_hcd);
+	if (device_trust_enabled()) {
+		if (!dev->authorized)
+			dev->dev.trust_policy = DEVICE_TRUST_POLICY_BLOCKED;
+		dev->authorized = 1;
+	}
 	trace_usb_alloc_dev(dev);
 	return dev;
 }
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 9399c816b367d..34ee4d6f91c19 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -617,11 +617,8 @@ struct usb3_lpm_parameters {
  * @persist_enabled:  USB_PERSIST enabled for this device
  * @reset_in_progress: the device is being reset
  * @have_langid: whether string_langid is valid
- * @authorized: policy has said we can use it;
- *	(user space) policy determines if we authorize this device to be
- *	used or not. By default, wired USB devices are authorized.
- *	WUSB devices are not, until we authorize them from user space.
- *	FIXME -- complete doc
+ * @authorized: USB authorization flag; trust policy may also restrict use,
+ *	see usb_device_authorized().
  * @authenticated: Crypto authentication passed
  * @tunnel_mode: Connection native or tunneled over USB4
  * @usb4_link: device link to the USB4 host interface
@@ -756,6 +753,11 @@ struct usb_device {
 
 #define to_usb_device(__dev)	container_of_const(__dev, struct usb_device, dev)
 
+static inline bool usb_device_authorized(const struct usb_device *udev)
+{
+	return udev->authorized && !device_policy_is_blocked(&udev->dev);
+}
+
 static inline struct usb_device *__intf_to_usbdev(struct usb_interface *intf)
 {
 	return to_usb_device(intf->dev.parent);

-- 
2.56.1

