Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030078;
	b=tCLDYYrC6gbIvMsybsDQrQZONgU++BFzm2vPAYQtcJ3e/h5wCiYD9tkQDdfft4SqN2La
	 qelWx8vmkGEXY58yt3vpLM4VkdKVePOrI6EoUSBhlP7ZX3uv4Crc4/QxJ8QLUh63RAvQ+
	 wUNaUUy+VxU84DfnTw2MiirCQeUwjbcCmMeK6012w+vdmzD10scYYyrsdAJ9jzN5JPk5h
	 9Mmit8z6a1hD6FxsQ4gJqf5nN+PxWq/tG8uefI3YVJGwHTUeJizHs4CmRLpru8o6M29Vh
	 lYKxbO3F87sCC2ddqnnE72b48JSRBr3T2dHNzIWERkfkXLCQmz0d8AUiHf9uDKL4z5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030078;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=anRl7XzxmWAd4I65xBnGqpxFVe3h8V+5KB72VF6S6NQ=;
	b=eDMeOB2p6by1ukgaurpwRK/RYiymCOwTPNTNhIRjtUGnHcP217oTe5AhEGjsbHntCsjJ
	 h09WSnVUdYkyhER5pw8mG9ae8V2EiCcFg5Sed2hlssT6iNg0VC+dsb4r37ulxFgjGKH1r
	 EtcRy36F2rVRdeDja1f1OVocbHO1dlp7c0VxsuroPIfvVYLzUbRlkkDjhtSQF0qBtDcu4
	 1PcFqfNaD6HEkkoxmObGWi7tMWk3xXUFHfdaO3tT74xC9krDyWiVodhZsZP3BW1bShwwv
	 viICwoBAvdQBCddKheph0rDuSAB5Uh/tBWOpr55c/RCaw+vjYQS/tGdZfqp81/dJSVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e/eyfjil";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07F1606BB7F;
	Wed, 18 Nov 2026 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e/eyfjil
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B6A1F000CA;
	Wed, 18 Nov 2026 19:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030077;
	bh=anRl7XzxmWAd4I65xBnGqpxFVe3h8V+5KB72VF6S6NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e/eyfjilUUstnvPzcYoDzASy0RPKzQsGaViyRBBOGePQ+Iuxs73dYZ5tDM+NmiNtK
	 +/D+Z8ufPIGyqcHz+FnMlOvbzd/o6X14iLkhfhKwjsiOHhyHSDODYnduZEEmfPcI96
	 NsryVnKHLf9WzxdC2LVJbYlyPFn/LBpgN/sFRUi2B6UQDrfPabGCNNMLZUxsIklzAS
	 ibHYfRAGALN/EGQE+GoL/8gisbKLvL4EfyuNGCYrGfmDWdoad95d4hNQlEhMv9HT1e
	 xDEdmeO9RBo741cwzNyjqtZLFbiep8sCpCsvD+Ezq8rvTR8nTQP1f/L4HNYV0f0JRA
	 24/Ma14tSgc/Q==
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
Subject: [PATCH v3 11/31] USB: Unwind interface claims after registration or binding failure
Date: Wed, 18 Nov 2026 21:26:41 +0200
Message-ID: <20261118-device-trust-core-v3-11-d655875c4bfb@nvidia.com>
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

A successful USB-audio control probe can claim unregistered playback and
capture interfaces. If playback registration fails, releasing its claim
alone leaves the card active, its disconnect callback returns immediately.

usb_set_configuration()
  device_add(control)
    usb_audio_probe()
      snd_usb_create_streams()
        snd_usb_create_stream(playback)
          usb_driver_claim_interface(playback)
        snd_usb_create_stream(capture)
          usb_driver_claim_interface(capture)
  device_add(playback) [fails]

Configuration removal skips unregistered claims and binding failure can
also clear dev->driver without disconnecting the claimant.

Release the failed claim, remove the configuration if sibling claims
remain, and disconnect unpublished claims before freeing interfaces or
dropping the module reference.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 86d30741e480f ("[PATCH] USB: Usbcore: Don't try to delete unregistered interfaces")
Fixes: c6a46696f97ff ("driver core: don't fail attaching the device if it cannot be bound")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/usb/core/driver.c  |  3 ++-
 drivers/usb/core/message.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 3beed56fabf3d..e2a120c64f6e1 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -488,7 +488,8 @@ static int usb_unbind_interface(struct device *dev)
 		/* Already in altsetting 0 so skip Set-Interface.
 		 * Just re-enable it without affecting the endpoint toggles.
 		 */
-		usb_enable_interface(udev, intf, false);
+		if (!intf->unregistering)
+			usb_enable_interface(udev, intf, false);
 	} else if (!error && !intf->dev.power.is_prepared) {
 		r = usb_set_interface(udev, intf->altsetting[0].
 				desc.bInterfaceNumber, 0);
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 306978caaf1ef..b2e5ed35a4a59 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1489,6 +1489,9 @@ void usb_disable_device(struct usb_device *dev, int skip_ep0)
 			device_del(&interface->dev);
 		}
 
+		for (i = 0; i < dev->actconfig->desc.bNumInterfaces; i++)
+			usb_release_unregistered_interface(dev->actconfig->interface[i]);
+
 		/* Now that the interfaces are unbound, nobody should
 		 * try to access them.
 		 */
@@ -2020,6 +2023,25 @@ int usb_set_wireless_status(struct usb_interface *iface,
 }
 EXPORT_SYMBOL_GPL(usb_set_wireless_status);
 
+static bool usb_has_claimant(struct usb_device *dev,
+			     const struct device_driver *claimant)
+{
+	struct usb_host_config *config = dev->actconfig;
+	int i;
+
+	for (i = 0; i < config->desc.bNumInterfaces; i++) {
+		struct device *intf = &config->interface[i]->dev;
+		bool claimed;
+
+		device_lock(intf);
+		claimed = intf->driver == claimant;
+		device_unlock(intf);
+		if (claimed)
+			return true;
+	}
+	return false;
+}
+
 /*
  * usb_set_configuration - Makes a particular device setting be current
  * @dev: the device whose configuration is being updated
@@ -2270,6 +2292,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 	 */
 	for (i = 0; i < nintf; ++i) {
 		struct usb_interface *intf = cp->interface[i];
+		struct device_driver *claimant;
 		struct module *claim_owner;
 
 		if (intf->dev.of_node &&
@@ -2285,6 +2308,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 			intf->cur_altsetting->desc.bInterfaceNumber);
 		device_enable_async_suspend(&intf->dev);
 		device_lock(&intf->dev);
+		claimant = intf->dev.driver;
 		claim_owner = xchg(&intf->claim_owner, NULL);
 		device_unlock(&intf->dev);
 		ret = device_add(&intf->dev);
@@ -2293,7 +2317,22 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 			intf->unregistering = 1;
 			device_unlock(&intf->dev);
 		}
-		module_put(claim_owner);
+		if (claimant && (ret || !intf->dev.driver) &&
+		    usb_driver_release_refused_claim(intf, claimant)) {
+			bool unconfigure = usb_has_claimant(dev, claimant);
+
+			get_device(&intf->dev);
+			if (unconfigure)
+				usb_set_configuration(dev, -1);
+			module_put(claim_owner);
+			put_device(&intf->dev);
+			if (unconfigure) {
+				usb_autosuspend_device(dev);
+				return ret ? ret : -ENODEV;
+			}
+		} else {
+			module_put(claim_owner);
+		}
 		if (ret != 0) {
 			dev_err(&dev->dev, "device_add(%s) --> %d\n",
 				dev_name(&intf->dev), ret);

-- 
2.56.1

