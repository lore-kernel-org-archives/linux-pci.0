Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513589;
	b=nSOqaGURR1MB9jP0UEdZwDIVP/S6PJSFwFTl6mF4AP4FsPCYOfPvTgZxOwUjMqJFTuzy
	 Wo8bnMWLrz8Xs2aFNaY5rbhEvepBegbE+eB9RlAUxOIbhNCAcfMaKS9iVZupib9KxHco2
	 X9+OtMuJBEGLkDzYRMmXvbGAyJbbJVy1a+Fk4DNQYHdib8DqnTsFTCVc5Q4SVgKP5nhAe
	 hsaDwsbdfdYC+nVcMGiZzOshCz9HKnDCUd3OuTHsBL+XfshLin3qSZ4NB8On1ht0Usid1
	 UeDzxJmte8rXM5sNw692lErHFcvWg70L+p0b+zSkzdAhGjKeZRRe7ZHLngAseQKvumA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513589;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=oOv+gVtKhIeMKpTI0yWQno/GsqkqC/UC3tuwmycezAs=;
	b=oBi0ndywb01HWC7xc62Vq8m7HODN+jHzYgx2g4ltZWBR9ehk9ctH3zZ4FtKplCIpTqSQ
	 Fa28oEHq2C2n5n7KLNtOVYvv9a8NFCKjnF4jmIi/5kmXvlb0cbzAPyQpLeXyaweMuGPq/
	 klW6JoDIQ26uxBv9fOtST5Wv5OwhM73jBpNl3FNPXUwZcwkyZmgFAuiyofgO6Jf18VBAx
	 wfURAZgEbvQQb5j2/Mc7A+YITiN+MGao5sDhSjwQ4YvmQ3gV1Ki9SZkMGUmlIpYZ62l48
	 vbIX2MmHEzB9Enm8PEKxhFlhW4wVPdPiHeOkHXXxPYM2jEvDqfENjtYg82yspQLN78A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMjRkV1O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13DC606A6BD;
	Tue, 24 Nov 2026 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMjRkV1O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F991F000CA;
	Tue, 24 Nov 2026 09:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513589;
	bh=oOv+gVtKhIeMKpTI0yWQno/GsqkqC/UC3tuwmycezAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FMjRkV1OQ81KV/qMDFbJOvzmHTPA+xevogjyMDoDXRccaDOk/hablPLSBW9R1CFNj
	 LO7SIaOigTXu6q69CexyJSeLklD58/r/UWwTz7mCaSyA50tzP86IZ6RUqAuL4TPdPI
	 KKWtxVIyNw4uPUOjDOmiWulF10HzOj2D9alhvsG95/oXwZs0sU15vCFBKa7Gao/54+
	 7v1+LzO8pXu/PiAk7Qnu3dY5KSY+Pt/V04k0UMqODSOtKm8Uu45CNdC5gSARpbNvMA
	 OU/gWjj4KWQk34WaFuTf7Po62wM/2MGj8f9Qr3xXfwXjvD9hCfOJMCTsq5KauaJbFa
	 j31B9r1oan2TA==
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
Subject: [PATCH v4 32/33] USB: Authorize interfaces through device trust
Date: Tue, 24 Nov 2026 11:44:03 +0200
Message-ID: <20261124-device-trust-core-v4-32-037eb0d17b1f@nvidia.com>
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

An interface denied by USB defaults must remain blocked until its trust
policy permits binding. Keeping an independent denial flag would prevent
generic trust authorization from making that interface usable.

Represent the initial denial as blocked policy when trust is enabled, and
let interface authorization request unrestricted operation. Preserve
explicit USB deauthorization and report rejected policy changes to
userspace. Interface policies remain independent of the device policy.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/ABI/testing/sysfs-bus-usb |  5 +++++
 Documentation/usb/authorization.rst     | 11 +++++++++++
 drivers/usb/core/driver.c               |  2 +-
 drivers/usb/core/message.c              | 23 ++++++++++++++++++-----
 drivers/usb/core/sysfs.c                |  7 +++++--
 drivers/usb/core/usb.h                  |  2 +-
 include/linux/usb.h                     |  9 +++++++--
 7 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 5213117fd957e..62e326710ef5f 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -12,6 +12,11 @@ Description:
 
 		A deauthorized interface cannot be probed or claimed.
 
+		With device trust enabled at boot, an interface that is not
+		authorized by default starts with the "blocked" trust policy
+		(see sysfs-devices-trust). Writing 1 then requests the "unrestricted"
+		policy. Deauthorizing does not change the committed trust level.
+
 What:		/sys/bus/usb/devices/usbX/interface_authorized_default
 Date:		August 2015
 Description:
diff --git a/Documentation/usb/authorization.rst b/Documentation/usb/authorization.rst
index 150a14970e951..cc419a11ffc43 100644
--- a/Documentation/usb/authorization.rst
+++ b/Documentation/usb/authorization.rst
@@ -120,6 +120,13 @@ Deny interfaces per default::
 Per default the interface_authorized_default bit is 1.
 So all interfaces would authorized per default.
 
+With device trust enabled, an interface that is not authorized by default
+starts with the "blocked" trust policy, and writing 1 to its "authorized"
+attribute requests the "unrestricted" policy. Device and interface trust policies
+are independent: selecting "adversarial" for a USB device does not select it
+for its interfaces. Set interface policies separately before their drivers
+bind, using boot rules when necessary.
+
 Note:
   If a deauthorized interface will be authorized so the driver probing must
   be triggered manually by writing INTERFACE to /sys/bus/usb/drivers_probe
@@ -127,3 +134,7 @@ Note:
 For drivers that need multiple interfaces all needed interfaces should be
 authorized first. After that the drivers should be probed.
 This avoids side effects.
+
+Driver boot rules apply when an interface is claimed, including before
+registration. An interface deauthorized through sysfs must still be
+authorized before it can be claimed.
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 1d488111a70fb..80f4d2644023b 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -338,7 +338,7 @@ static int usb_probe_interface(struct device *dev)
 	if (udev->authorized == 0) {
 		dev_info(&intf->dev, "Device is not authorized for usage\n");
 		return error;
-	} else if (intf->authorized == 0) {
+	} else if (!usb_interface_authorized(intf)) {
 		dev_info(&intf->dev, "Interface %d is not authorized for usage\n",
 				intf->altsetting->desc.bInterfaceNumber);
 		return error;
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 32014605b6db6..534f8e645a856 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1881,16 +1881,24 @@ void usb_deauthorize_interface(struct usb_interface *intf)
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
+	int ret = 0;
 
-	if (!intf->authorized) {
-		device_lock(dev);
-		intf->authorized = 1; /* authorize interface */
-		device_unlock(dev);
+	device_lock(dev);
+	if (device_policy_is_blocked(dev)) {
+		ret = device_trust_set_policy_locked(dev, DEVICE_TRUST_POLICY_UNRESTRICTED);
+		if (ret)
+			goto out_unlock;
 	}
+	intf->authorized = 1;
+out_unlock:
+	device_unlock(dev);
+	return ret;
 }
 
 static int usb_if_uevent(const struct device *dev, struct kobj_uevent_env *env)
@@ -2213,6 +2221,11 @@ static int usb_set_configuration_internal(struct usb_device *dev, int configurat
 		intf->altsetting = intfc->altsetting;
 		intf->num_altsetting = intfc->num_altsetting;
 		intf->authorized = !!HCD_INTF_AUTHORIZED(hcd);
+		if (device_trust_enabled()) {
+			if (!intf->authorized)
+				intf->dev.trust_policy = DEVICE_TRUST_POLICY_BLOCKED;
+			intf->authorized = 1;
+		}
 		kref_get(&intfc->ref);
 
 		alt = usb_altnum_to_altsetting(intf, 0);
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index d22dc78457d79..b8974e9db3a22 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
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
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index cbee731837471..6f65d6cd5d117 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -34,7 +34,7 @@ extern void usb_disable_device(struct usb_device *dev, int skip_ep0);
 extern int usb_deauthorize_device(struct usb_device *);
 extern int usb_authorize_device(struct usb_device *);
 extern void usb_deauthorize_interface(struct usb_interface *);
-extern void usb_authorize_interface(struct usb_interface *);
+extern int usb_authorize_interface(struct usb_interface *);
 extern void usb_detect_quirks(struct usb_device *udev);
 extern void usb_detect_interface_quirks(struct usb_device *udev);
 extern void usb_release_quirk_list(void);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index d372712eba34c..9399c816b367d 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -204,8 +204,8 @@ enum usb_wireless_status {
  *	has been deferred.
  * @needs_binding: flag set when the driver should be re-probed or unbound
  *	following a reset or suspend operation it doesn't support.
- * @authorized: This allows to (de)authorize individual interfaces instead
- *	a whole device in contrast to the device authorization.
+ * @authorized: USB authorization flag; trust policy may also restrict use,
+ *	see usb_interface_authorized().
  * @wireless_status: if the USB device uses a receiver/emitter combo, whether
  *	the emitter is connected.
  * @wireless_status_work: Used for scheduling wireless status changes
@@ -278,6 +278,11 @@ struct usb_interface {
 
 #define to_usb_interface(__dev)	container_of_const(__dev, struct usb_interface, dev)
 
+static inline bool usb_interface_authorized(const struct usb_interface *intf)
+{
+	return intf->authorized && !device_policy_is_blocked(&intf->dev);
+}
+
 static inline void *usb_get_intfdata(struct usb_interface *intf)
 {
 	return dev_get_drvdata(&intf->dev);

-- 
2.56.1

