Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513516;
	b=Qdu2NRF7UW5CAg4hsXrRx64PraF9NA8OugNorDpHvWEBa1Z7MND9ES5QHLMXz0ahCTSN
	 PBorQONew3ERr8vXKhJpWJ5SOLY2WBaYdSj6ihLZoc/hRvSKkYpewFWZN89H1EmQ+lrLQ
	 Ex+uKlqwV98OjsdL2douqPVZ8MStDQM9WfgRGIbHQ+hQLFF2ncqNbtHWQMC8q+1XaRPXT
	 U6ePkgGLbiYhCXMYafsvXSLTAOl4igKF+JeJZ9lVKg+ylnH94NkuEXAciWnHp3Yr9M0f7
	 PFbj7wrOG1k212FyPeC2rPHK++pb7hd47BhtQzaCrlkP/pezoxRqR4yxBeoSG+3XgtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513516;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=HhsYqTWaEbeiBD28eWBoEDfW+Typf3OqOXLWU9ZeNH0=;
	b=axVx3wqSdPw8BtOgWAeUL2XERFaN2tEOVFjVKGhYiyHcfFQTAq5o4CZ6evdlhm8jY5FQ
	 hMxcUhx8VJNfjr+zP+yWtng/xsdUdXHQq8djCKDNET+Hr1axVrGcqSdzfSL8fpgm+CjIk
	 IsxwrknzjpdMdkIuJw1rqu5z0+V5cYWRyw5nJrnMck1WRhkS0eGeXSPZ3nopnYkOReNRr
	 ixV2ASMkuRHLxxhNWq1CSyqZQ033boA1DI8HuI/IEgnyGp5YkVYBDpzxk0NvTuJCUuBU6
	 1DxdWEVXBDcWSKmEICw/pNew6Q2U7hT/Lh+68eyTjVojaEGMKEfLeofqkm0oQYTTm7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtWOUXhZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EB060A3808;
	Tue, 24 Nov 2026 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtWOUXhZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AF31F0089E;
	Tue, 24 Nov 2026 09:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513515;
	bh=HhsYqTWaEbeiBD28eWBoEDfW+Typf3OqOXLWU9ZeNH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RtWOUXhZlH7YuIcxtLWLmuu1kVpxbxuPYh3EY7KEuw9f9bPzjHvg+pv2/+f4AhuQN
	 UCUIjUo8SKpuwmLiGjzOc5e2GrmBaIG9jq/+TOJhhNO+XbNPZjIfJkUKLJg/EluCrQ
	 JOXwogrIU73Z4TQ1qgqfJJldEcs82f7tNBoUt57VXA5oCW7UiifRRYtJwyhIXmjd2R
	 iwR4jl0bzmDEuL2rnyMRkuupy7e+TzQUU/qVB2Q9vqsc/vukIykJoRPNbcF0Opl4gl
	 JuxgBY4PUlnF7Hh04IEyDv5D/bSqFLhA/B/wYkRzia0h4cFW7+lFTy85cGbM4xf0Ll
	 PqBJtjBmyJ7RQ==
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
Subject: [PATCH v4 10/33] USB: Pin modules for unregistered interface claims
Date: Tue, 24 Nov 2026 11:43:41 +0200
Message-ID: <20261124-device-trust-core-v4-10-037eb0d17b1f@nvidia.com>
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
index a50403820285a..a03ea60edc501 100644
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
index a645858b25d96..cfb4cbdbe76fa 100644
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
@@ -2282,7 +2284,11 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 			dev_name(&intf->dev), configuration,
 			intf->cur_altsetting->desc.bInterfaceNumber);
 		device_enable_async_suspend(&intf->dev);
+		device_lock(&intf->dev);
+		claim_owner = xchg(&intf->claim_owner, NULL);
+		device_unlock(&intf->dev);
 		ret = device_add(&intf->dev);
+		module_put(claim_owner);
 		if (ret != 0) {
 			device_lock(&intf->dev);
 			intf->unregistering = 1;
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

