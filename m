Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209704;
	b=j1BKs1Nz5oSF5TGb1FNouIbNtwa/wNMUXHlRujkr9Ki/Vyd4ZQjRdK8CrGVD5fvfs8yV
	 1/rs6a0Zx0OAoftkMfv3qdEjXFUXojKNudji0q1bc6rAWgvxdUdn2C6c1+lkVKZyx/gKM
	 39Y71fjt+VUnCvo3nM0TWrWD5CqW7afHbbpRjqfuXnorCZDvFGkelTGmBFRpbIJXldFwi
	 HZKnT8iUHZsjOeK2g7GgmrEhTIaDd0Op9khvONkr7nPGxgxQOad00+2DkinuhNZftTPRN
	 iIhddaVZwIFwJQiA3N7Saf4VBoNIBgErHlvHJVfzEhDuJhGiqHhAxhECp32O2YTiHcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209704;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=WD1tmy3UgSAJW1MhiWtCAh8waBml5qRpMehZ0KPIV5o=;
	b=GaU4x59ieU8BQH5PrfiHBJ64yN8U992r1mTS9StHwazfdWI2L9AIqpL1x4xDAU/CiLB6
	 OO7Jpk6mYnQh9pA7vGMiKJ6kfco7jlMqAlkRD/CPcB5Nyqj+RklvPfZfUfxEo59WyUjkf
	 YFlDjF7VAT+GaGUsGExYznsppgSANJuTRrvcrs1UTQ7vumA9X2p5fdcHx5i6r5/2tyacq
	 1Wstj0zkLxCx451770HuF1WkoscHiH73iYMPRWJceklhjr+CK3dFlKIUr7edIJrRoXhAd
	 IiIqIiawAhAjaJ8rHpreJd8q6odUafa0OUk2oI/VltxWMcnabvLtm0NivoAFxnjItZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=muA1K0Rl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37312606DF12;
	Mon,  9 Nov 2026 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=muA1K0Rl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FFD1F008A1;
	Mon,  9 Nov 2026 07:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209703;
	bh=WD1tmy3UgSAJW1MhiWtCAh8waBml5qRpMehZ0KPIV5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=muA1K0Rl1hNLH9hZK9zvX6xeVB9XyRBJY11GriElP9glBmQnkZN5y14zXotxNdG+s
	 3WF2QK2GfShfQc9RfCAIlGvPfD78fdmuJPZ2EglInyzEwrG3IwzDlo36pUMP8mr3F/
	 ct0xxXSZ0P1Lo6/IYgc7q0Y61EUSZaynOq6yAIiB+A1SGcLqT0BHCCd0hYPnLg6Gac
	 at1+kY5dN418B1oOecRDovYXpBeB5tMJuWjbjXrvOLyaVj+Hky5/m0/2M57KCYLkEr
	 puz/mmIbl6nKpK4/kytq5cSHUucHQBOhy0/3eAHFWt6Z0rIy237Ph446nkYhaRbo95
	 RtZPvyzY5dGkw==
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
Subject: [PATCH v2 19/19] USB: Authorize devices and interfaces through device trust
Date: Mon,  9 Nov 2026 09:33:49 +0200
Message-ID: <20261109-device-trust-core-v2-19-3b12d9a9f861@nvidia.com>
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

USB authorization is a second gate next to device trust. An unauthorized
device still binds the generic driver, so trust admission never sees it,
and boot policy cannot authorize USB devices or interfaces.

Make the authorized_default and interface_authorized_default settings the
initial trust policy, so held devices and interfaces start disabled and do
not bind. Writing 1 to authorized requests full trust; for a device it
also binds the generic driver, which configures it. Writing 0 still stops
it and leaves the committed trust level in place.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/ABI/testing/sysfs-bus-usb | 11 +++++++++++
 Documentation/usb/authorization.rst     | 20 ++++++++++++++++++++
 drivers/usb/core/driver.c               | 10 +++-------
 drivers/usb/core/generic.c              |  2 +-
 drivers/usb/core/hub.c                  | 17 ++++++++++++++++-
 drivers/usb/core/message.c              | 24 +++++++++++++++++++-----
 drivers/usb/core/sysfs.c                |  9 ++++++---
 drivers/usb/core/trace.h                |  2 +-
 drivers/usb/core/usb.c                  |  5 ++++-
 drivers/usb/core/usb.h                  |  2 +-
 include/linux/usb.h                     | 29 ++++++++++++++++++++++-------
 11 files changed, 104 insertions(+), 27 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 5213117fd957e..ca66b6a10c054 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -12,6 +12,11 @@ Description:
 
 		A deauthorized interface cannot be probed or claimed.
 
+		An interface that is not authorized by default starts with
+		the "disabled" trust policy (see sysfs-devices-trust).
+		Writing 1 then requests the "full" policy. Deauthorizing
+		does not change the committed trust level.
+
 What:		/sys/bus/usb/devices/usbX/interface_authorized_default
 Date:		August 2015
 Description:
@@ -28,6 +33,12 @@ Description:
 		drivers, non-authorized one are not.  By default, wired
 		USB devices are authorized.
 
+		A device that is not authorized by default starts with the
+		"disabled" trust policy (see sysfs-devices-trust). Writing 1
+		requests the "full" policy if the policy is disabled, then
+		binds and configures the device. Writing 0 deconfigures the
+		device without changing its committed trust level.
+
 What:		/sys/bus/usb/drivers/.../new_id
 Date:		October 2011
 Contact:	linux-usb@vger.kernel.org
diff --git a/Documentation/usb/authorization.rst b/Documentation/usb/authorization.rst
index 150a14970e951..2e07831876fed 100644
--- a/Documentation/usb/authorization.rst
+++ b/Documentation/usb/authorization.rst
@@ -92,6 +92,22 @@ can fake descriptors and device info. Don't trust that. You are
 welcome.
 
 
+Device trust
+------------
+
+Authorization is expressed through device trust, see
+Documentation/driver-api/driver-model/device-trust.rst. A device that the
+authorized_default setting does not authorize starts with the "disabled"
+trust policy and reads 0 in "authorized". Boot options such as
+``device_trust=usb:1-2=full`` replace this initial policy.
+
+Writing 1 to "authorized" for such a device requests the "full" policy and
+binds the device, which configures it. To operate it as an adversary,
+write "adversary" to its "trust_policy" attribute before writing 1. The
+choice is fixed for the life of the device: writing 0 deconfigures it, and
+a later 1 configures it again at the same trust level.
+
+
 Interface authorization
 -----------------------
 
@@ -120,6 +136,10 @@ Deny interfaces per default::
 Per default the interface_authorized_default bit is 1.
 So all interfaces would authorized per default.
 
+As with devices, an interface that is not authorized by default starts
+with the "disabled" trust policy, and writing 1 to its "authorized"
+attribute requests the "full" policy.
+
 Note:
   If a deauthorized interface will be authorized so the driver probing must
   be triggered manually by writing INTERFACE to /sys/bus/usb/drivers_probe
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 04b77691fbd7d..2ebd05d3855f4 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -334,10 +334,10 @@ static int usb_probe_interface(struct device *dev)
 	if (usb_device_is_owned(udev))
 		return error;
 
-	if (udev->authorized == 0) {
+	if (!usb_device_authorized(udev)) {
 		dev_info(&intf->dev, "Device is not authorized for usage\n");
 		return error;
-	} else if (intf->authorized == 0) {
+	} else if (!usb_interface_authorized(intf)) {
 		dev_info(&intf->dev, "Interface %d is not authorized for usage\n",
 				intf->altsetting->desc.bInterfaceNumber);
 		return error;
@@ -560,13 +560,9 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 		return -EBUSY;
 
 	/* reject claim if interface is not authorized */
-	if (!iface->authorized)
+	if (!usb_interface_authorized(iface))
 		return -ENODEV;
 
-	if (!device_is_registered(dev) &&
-	    dev->trust_policy == DEVICE_TRUST_POLICY_DISABLED)
-		return -EPERM;
-
 	dev->driver = &driver->driver;
 	usb_set_intfdata(iface, data);
 	iface->needs_binding = 0;
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
index 199d3f535a891..086b8db36f51a 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2770,7 +2770,7 @@ int usb_new_device(struct usb_device *udev)
 int usb_deauthorize_device(struct usb_device *usb_dev)
 {
 	usb_lock_device(usb_dev);
-	if (usb_dev->authorized == 0)
+	if (!usb_device_authorized(usb_dev))
 		goto out_unauthorized;
 
 	usb_dev->authorized = 0;
@@ -2786,7 +2786,22 @@ int usb_authorize_device(struct usb_device *usb_dev)
 {
 	int result = 0, c;
 
+	/* Authorizing a device that its trust policy holds back admits it */
+	if (device_policy_is_disabled(&usb_dev->dev)) {
+		result = device_trust_set_policy(&usb_dev->dev,
+						 DEVICE_TRUST_POLICY_FULL);
+		if (result)
+			return result;
+	}
+
 	usb_lock_device(usb_dev);
+	if (!usb_dev->dev.driver) {
+		/* Binding the generic driver configures the device */
+		usb_dev->authorized = 1;
+		usb_unlock_device(usb_dev);
+		result = device_attach(&usb_dev->dev);
+		return result < 0 ? result : 0;
+	}
 	if (usb_dev->authorized == 1)
 		goto out_authorized;
 
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 2d75b85b2d139..ddede900dace8 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1857,7 +1857,7 @@ void usb_deauthorize_interface(struct usb_interface *intf)
 
 	device_lock(dev->parent);
 
-	if (intf->authorized) {
+	if (usb_interface_authorized(intf)) {
 		device_lock(dev);
 		intf->authorized = 0;
 		device_unlock(dev);
@@ -1872,16 +1872,27 @@ void usb_deauthorize_interface(struct usb_interface *intf)
  * usb_authorize_interface - authorize an USB interface
  *
  * @intf: USB interface structure
+ *
+ * Return: 0 on success, or the error of the trust policy request.
  */
-void usb_authorize_interface(struct usb_interface *intf)
+int usb_authorize_interface(struct usb_interface *intf)
 {
 	struct device *dev = &intf->dev;
+	int ret;
+
+	/* Authorizing an interface that its trust policy holds back admits it */
+	if (device_policy_is_disabled(dev)) {
+		ret = device_trust_set_policy(dev, DEVICE_TRUST_POLICY_FULL);
+		if (ret)
+			return ret;
+	}
 
 	if (!intf->authorized) {
 		device_lock(dev);
 		intf->authorized = 1; /* authorize interface */
 		device_unlock(dev);
 	}
+	return 0;
 }
 
 static int usb_if_uevent(const struct device *dev, struct kobj_uevent_env *env)
@@ -2043,7 +2054,7 @@ EXPORT_SYMBOL_GPL(usb_set_wireless_status);
  * channels are available independently; and choosing between open
  * standard device protocols (like CDC) or proprietary ones.
  *
- * Note that a non-authorized device (dev->authorized == 0) will only
+ * Note that a non-authorized device (see usb_device_authorized()) will only
  * be put in unconfigured mode.
  *
  * Note that USB has an additional level of device configurability,
@@ -2068,7 +2079,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 	struct usb_hcd *hcd = bus_to_hcd(dev->bus);
 	int n, nintf;
 
-	if (dev->authorized == 0 || configuration == -1)
+	if (!usb_device_authorized(dev) || configuration == -1)
 		configuration = 0;
 	else {
 		for (i = 0; i < dev->descriptor.bNumConfigurations; i++) {
@@ -2173,7 +2184,10 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 		intfc = cp->intf_cache[i];
 		intf->altsetting = intfc->altsetting;
 		intf->num_altsetting = intfc->num_altsetting;
-		intf->authorized = !!HCD_INTF_AUTHORIZED(hcd);
+		/* The authorization default is the interface's initial trust policy */
+		if (!HCD_INTF_AUTHORIZED(hcd))
+			intf->dev.trust_policy = DEVICE_TRUST_POLICY_DISABLED;
+		intf->authorized = 1;
 		kref_get(&intfc->ref);
 
 		alt = usb_altnum_to_altsetting(intf, 0);
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index d22dc78457d79..189fb917b81ee 100644
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
@@ -1213,7 +1213,7 @@ static ssize_t interface_authorized_show(struct device *dev,
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 
-	return sysfs_emit(buf, "%u\n", intf->authorized);
+	return sysfs_emit(buf, "%u\n", usb_interface_authorized(intf));
 }
 
 /*
@@ -1225,12 +1225,15 @@ static ssize_t interface_authorized_store(struct device *dev,
 	struct usb_interface *intf = to_usb_interface(dev);
 	bool val;
 	struct kernfs_node *kn;
+	int ret;
 
 	if (kstrtobool(buf, &val) != 0)
 		return -EINVAL;
 
 	if (val) {
-		usb_authorize_interface(intf);
+		ret = usb_authorize_interface(intf);
+		if (ret)
+			return ret;
 	} else {
 		/*
 		 * Prevent deadlock if another process is concurrently
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
index 2559a180fdeec..8b427209bcc02 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -747,7 +747,10 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 	dev->active_duration = -jiffies;
 #endif
 
-	dev->authorized = usb_dev_authorized(dev, usb_hcd);
+	/* The authorization default is the device's initial trust policy */
+	if (!usb_dev_authorized(dev, usb_hcd))
+		dev->dev.trust_policy = DEVICE_TRUST_POLICY_DISABLED;
+	dev->authorized = 1;
 	trace_usb_alloc_dev(dev);
 	return dev;
 }
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 293340a48b6c5..00771270db523 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -34,7 +34,7 @@ extern void usb_disable_device(struct usb_device *dev, int skip_ep0);
 extern int usb_deauthorize_device(struct usb_device *);
 extern int usb_authorize_device(struct usb_device *);
 extern void usb_deauthorize_interface(struct usb_interface *);
-extern void usb_authorize_interface(struct usb_interface *);
+int usb_authorize_interface(struct usb_interface *intf);
 extern void usb_detect_quirks(struct usb_device *udev);
 extern void usb_detect_interface_quirks(struct usb_device *udev);
 extern void usb_release_quirk_list(void);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 825f03b290670..2ead3234b1301 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -204,8 +204,8 @@ enum usb_wireless_status {
  *	has been deferred.
  * @needs_binding: flag set when the driver should be re-probed or unbound
  *	following a reset or suspend operation it doesn't support.
- * @authorized: This allows to (de)authorize individual interfaces instead
- *	a whole device in contrast to the device authorization.
+ * @authorized: user space has not deauthorized the interface. Whether it may
+ *	be used also depends on its trust policy, see usb_interface_authorized().
  * @wireless_status: if the USB device uses a receiver/emitter combo, whether
  *	the emitter is connected.
  * @wireless_status_work: Used for scheduling wireless status changes
@@ -276,6 +276,15 @@ struct usb_interface {
 
 #define to_usb_interface(__dev)	container_of_const(__dev, struct usb_interface, dev)
 
+/*
+ * An interface is authorized when its trust policy lets it bind and user space
+ * has not deauthorized it since.
+ */
+static inline bool usb_interface_authorized(const struct usb_interface *intf)
+{
+	return intf->authorized && !device_policy_is_disabled(&intf->dev);
+}
+
 static inline void *usb_get_intfdata(struct usb_interface *intf)
 {
 	return dev_get_drvdata(&intf->dev);
@@ -609,11 +618,8 @@ struct usb3_lpm_parameters {
  * @persist_enabled:  USB_PERSIST enabled for this device
  * @reset_in_progress: the device is being reset
  * @have_langid: whether string_langid is valid
- * @authorized: policy has said we can use it;
- *	(user space) policy determines if we authorize this device to be
- *	used or not. By default, wired USB devices are authorized.
- *	WUSB devices are not, until we authorize them from user space.
- *	FIXME -- complete doc
+ * @authorized: user space has not deauthorized the device. Whether the device
+ *	may be used also depends on its trust policy, see usb_device_authorized().
  * @authenticated: Crypto authentication passed
  * @tunnel_mode: Connection native or tunneled over USB4
  * @usb4_link: device link to the USB4 host interface
@@ -747,6 +753,15 @@ struct usb_device {
 
 #define to_usb_device(__dev)	container_of_const(__dev, struct usb_device, dev)
 
+/*
+ * A device is authorized when its trust policy lets it bind and user space has
+ * not deauthorized it since.
+ */
+static inline bool usb_device_authorized(const struct usb_device *udev)
+{
+	return udev->authorized && !device_policy_is_disabled(&udev->dev);
+}
+
 static inline struct usb_device *__intf_to_usbdev(struct usb_interface *intf)
 {
 	return to_usb_device(intf->dev.parent);

-- 
2.56.0

