Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030069;
	b=VEWjNHXN13sEPB1HnOH3luPrGebWsyWKoI4cvEyR60Qp/VWaBffQSyjqAuD7VZV/pMHH
	 xBxBTvwDHBC0ymhFUF/Tm/qm1xJgneRXe7a86Des1vNsIy8woNuGSqBSCDbRe8/2YSR1n
	 UHoX1J2y15icRdMOleLSg0agYk4whGKUi+uwiDkawQoqW/M2mmeNEeLWedisqTDFJOpa1
	 mesYt7SxBWbO9XtAEXo/XD/RpHcJmDN8Oh053/tSHjtUJaSRAWdArueSShQERMgEXq1TE
	 66prpqXxg7eEvei3Bwc/JSIeqkRNzucYb3yVM9kyUEpt+ewCnhMj1CY3HFrJVrO5YcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030069;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=7Nm2liFGcG+effGustAj08mOurK+X/T+WDxoq66PTm0=;
	b=i2skhwyZs31m8RkoMltXyJSZP49yxEaM36CvPdzfwA/N0CJoZC92OSrc/+/NZ/+o+ie3
	 iQeOvtl4Zl+oOEGrd/U0Tjnqe3LMrn7rFXYwHL0LL3jWiAIyjZ9eTaEVulSeQbb1Ap4Nf
	 /xamjpd7Q4ter1C1KGQIfN0rmVTq6WGl7aFEWNA0M3JuZ0zJCcWc7UXRLKhiPWMVdnEM7
	 TCniwzZVOmt63e50mTVEwFkSd+TyyDO7nJXqW9k+eFhzhx4Kt71d/5YyKR8LhScAT5zu3
	 Pom/PNwizQ8BsOsh11cleLa0Ckw00RzSMhABykrzTDiUOtC4rf3rIoB+9+Y++P2uw+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHpXA2R8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA904606B103;
	Wed, 18 Nov 2026 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHpXA2R8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60751F000C5;
	Wed, 18 Nov 2026 19:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030069;
	bh=7Nm2liFGcG+effGustAj08mOurK+X/T+WDxoq66PTm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KHpXA2R8TBQNr30w80R/HDxmN+lUrMiSRW0F17cyGDnmmZ5ezDbebLJyPPTEzKXYW
	 SLqhmjhvd0arHmpCLByGvBH8njmV9Hp9SeUHt1VGQP68m8E/soD/y8rJ8UgJjyCu7C
	 bgowuEbNk34Ot24OZbA2J560j0gQ/gqraggVrtOJOG/SPYO1AUgP1DoN/VDpB+q7pF
	 2VFz2ElFKk/RLs9sxHw/bi+ftNKnVZ4zhcTZmcNSsa7axaRfTrvIzZoSO4Yh6h1Tf0
	 lCW6wGguB/EZ9sdlHCXOMFzHQT9D2xEXIwKxmUR0mAa18tF0307WpTnfigIaRyioO+
	 llAnHZI4nTHkA==
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
Subject: [PATCH v3 09/31] USB: Pin modules for unregistered interface claims
Date: Wed, 18 Nov 2026 21:26:39 +0200
Message-ID: <20261118-device-trust-core-v3-9-d655875c4bfb@nvidia.com>
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

A successful CDC-ACM control probe can claim its data interface before
registration. If data registration fails, cleanup can race with module
unload when no tty is open:

Thread A (cleanup)                            Thread B (unload)

usb_driver_release_refused_claim(data)
 usb_unbind_interface(data)
  acm_disconnect(data)
   usb_driver_release_interface(control)
    device_release_driver(control)
     device_release_driver_internal()
      __device_release_driver()
       klist_remove() [last bound interface]
                                              delete_module()
                                               acm_exit()
                                                usb_deregister()
                                                 driver_unregister()
                                                  bus_remove_driver()
                                                   driver_detach()
                                                    [empty list]
                                               free_module()
   [resumes in freed acm_disconnect()]
   tty_port_put()

The empty list lets unload skip the USB device lock and free the module
before the callback returns. Hold a module reference through registration
or cleanup, preparing for the cleanup added next.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/usb/core/driver.c  | 17 +++++++++++++++++
 drivers/usb/core/message.c |  6 ++++++
 drivers/usb/core/usb.h     |  1 +
 include/linux/usb.h        |  2 ++
 4 files changed, 26 insertions(+)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 0a6fdf2e88f4e..b7bd9226d2627 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -529,6 +529,13 @@ static void usb_shutdown_interface(struct device *dev)
 		driver->shutdown(intf);
 }
 
+void usb_put_claim_owner(struct usb_interface *intf)
+{
+	struct module *owner = xchg(&intf->claim_owner, NULL);
+
+	module_put(owner);
+}
+
 /**
  * usb_driver_claim_interface - bind a driver to an interface
  * @driver: the driver to be bound
@@ -567,6 +574,14 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 		goto unlock;
 	}
 
+	if (!device_is_registered(dev)) {
+		if (!try_module_get(driver->driver.owner)) {
+			retval = -ENODEV;
+			goto unlock;
+		}
+		iface->claim_owner = driver->driver.owner;
+	}
+
 	dev->driver = &driver->driver;
 	usb_set_intfdata(iface, data);
 	iface->needs_binding = 0;
@@ -619,6 +634,7 @@ static void usb_unbind_claim(struct usb_interface *iface)
 	usb_unbind_interface(dev);
 	dev_set_drvdata(dev, NULL);
 	dev->driver = NULL;
+	usb_put_claim_owner(iface);
 }
 
 /**
@@ -653,6 +669,7 @@ void usb_driver_release_interface(struct usb_driver *driver,
 	if (device_is_bound(dev)) {
 		device_unlock(dev);
 		device_release_driver(dev);
+		usb_put_claim_owner(iface);
 		return;
 	}
 
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index e56079398d26e..306978caaf1ef 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1845,6 +1845,7 @@ static void usb_release_interface(struct device *dev)
 	struct usb_interface_cache *intfc =
 			altsetting_to_usb_interface_cache(intf->altsetting);
 
+	usb_put_claim_owner(intf);
 	kref_put(&intfc->ref, usb_release_interface_cache);
 	usb_put_dev(interface_to_usbdev(intf));
 	of_node_put(dev->of_node);
@@ -2269,6 +2270,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 	 */
 	for (i = 0; i < nintf; ++i) {
 		struct usb_interface *intf = cp->interface[i];
+		struct module *claim_owner;
 
 		if (intf->dev.of_node &&
 		    !of_device_is_available(intf->dev.of_node)) {
@@ -2282,12 +2284,16 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 			dev_name(&intf->dev), configuration,
 			intf->cur_altsetting->desc.bInterfaceNumber);
 		device_enable_async_suspend(&intf->dev);
+		device_lock(&intf->dev);
+		claim_owner = xchg(&intf->claim_owner, NULL);
+		device_unlock(&intf->dev);
 		ret = device_add(&intf->dev);
 		if (ret) {
 			device_lock(&intf->dev);
 			intf->unregistering = 1;
 			device_unlock(&intf->dev);
 		}
+		module_put(claim_owner);
 		if (ret != 0) {
 			dev_err(&dev->dev, "device_add(%s) --> %d\n",
 				dev_name(&intf->dev), ret);
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index a9b37aeb515be..dfa48f43046d4 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -49,6 +49,7 @@ extern int usb_set_isoch_delay(struct usb_device *dev);
 extern int usb_get_bos_descriptor(struct usb_device *dev);
 extern void usb_release_bos_descriptor(struct usb_device *dev);
 extern int usb_set_configuration(struct usb_device *dev, int configuration);
+void usb_put_claim_owner(struct usb_interface *intf);
 extern int usb_choose_configuration(struct usb_device *udev);
 extern int usb_generic_driver_probe(struct usb_device *udev);
 extern void usb_generic_driver_disconnect(struct usb_device *udev);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 825f03b290670..a5e706f67f33a 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -213,6 +213,7 @@ enum usb_wireless_status {
  * @dev: driver model's view of this device
  * @usb_dev: if an interface is bound to the USB major, this will point
  *	to the sysfs representation for that device.
+ * @claim_owner: Module reference for an unpublished claim.
  * @reset_ws: Used for scheduling resets from atomic context.
  * @resetting_device: USB core reset the device, so use alt setting 0 as
  *	current; needs bandwidth alloc after reset.
@@ -271,6 +272,7 @@ struct usb_interface {
 
 	struct device dev;		/* interface specific device info */
 	struct device *usb_dev;
+	struct module *claim_owner;
 	struct work_struct reset_ws;	/* for resets in atomic context */
 };
 

-- 
2.56.1

