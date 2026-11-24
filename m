Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513504;
	b=0RMDvmJJlQnvBZnwFDiAmnAoELHWpbAYPpAqtV0FWiny7fWE6PYNrtv8WjNeQu3gREQw
	 qOFCY7dHqiOiHg1ZWFvh7UCbXeqGKg5DE69QTpOvj/8vAn6yX9N2J6/NnDBC+XG3AWcAN
	 hVK1pGtVFix3b3Mt8ZYphbVrcNg05vzI0zpIKP+/NQwm+S58g0KSnLZqdZmlcHkw8WHdo
	 iHXQ7Glztnf9Xa/6CCUGmTk7MG4+n0XAlkhcTKpT97FQP3fHCG/8wDlj2CEmN0bFXxWn5
	 SGB0cTzfwIEAxFNbrucPfcv8Dbu0g9CHMmrHcORQA6ml55u+CsX/LX0eiHT6O5o2xcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513504;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=c2GmkRj6kP3mA9/dih2IWVlm65+EvEG4i+reuaRR1xg=;
	b=VCS8qhccbWgKrsAyOM8/t49IDFLxlLNVc0Gp6SGTkHjyhAcZ7kho4Cd1psWUZP76bZ7/
	 JdOWrxgmq2kbaXouzmGCBOZ3cIISA1f/oSp5cQN9fkv9wB7N12Afo15T6ZsE5pdZoNpvD
	 vrfGE+2v4RFN9kZEVzulWZyozJbThS7c6JlaOkoNlRnCwWVVv7HFLAWOVWCY5tUgdbWCb
	 tbuvnY3zZjJ+WkrQYnZRhsVwFHEns6TLELkuUUQMXu2nnbDcUWgJrHguH1yDMdbUYhzN7
	 GOAnmX2FqcNidygzrsABGfS4LQQ8pw0qoTktVMp4f+FIYIv9WkXFKLKga1dUW4pmJKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQTHe+7b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51CE60A260C;
	Tue, 24 Nov 2026 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQTHe+7b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E571F000C4;
	Tue, 24 Nov 2026 09:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513503;
	bh=c2GmkRj6kP3mA9/dih2IWVlm65+EvEG4i+reuaRR1xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AQTHe+7bxfErZlBsxE3vWuGPvd3h9E10qCG3iepRTZVBAg5Mq4+lV2EsjkowYljHG
	 GCfM70UUcVZGeVMMKwiUXevU3uSDBCZqPKifVIqB6e/eXtevDA5s8srfmtNSqAstxF
	 NbcpxKeWutJVHrvyAVOIxdYbm8270nHSKT4gW0aw0kX3Qp/OwYu9H33uB+DTcHqMD7
	 X4QpE7olsao6E1APui8iIuYGDq796R5FBW+pEqFosRQq30PFoqXQDsgMGxHyI20Ts5
	 t6EPagcza1X+1+5i2oT+Fe8j9viBoUoyaY5j/hZwRJVTXWFOwYjAAH3ARetDuEdFsn
	 h9oaYe7psS5Rw==
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
Subject: [PATCH v4 12/33] USB: Unwind interface claims after registration or binding failure
Date: Tue, 24 Nov 2026 11:43:43 +0200
Message-ID: <20261124-device-trust-core-v4-12-037eb0d17b1f@nvidia.com>
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

Configuration removal skips unregistered claims. Binding failure can
clear dev->driver without disconnecting the claimant, and disabled
autoprobe leaves the claim unbound.

Release every claim that driver core left unbound, remove the
configuration if sibling claims remain, and disconnect unpublished
claims before freeing interfaces or dropping the module reference. A
bound claim is on the driver's device list, so unload waits for its
disconnect.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 86d30741e480f ("[PATCH] USB: Usbcore: Don't try to delete unregistered interfaces")
Fixes: c6a46696f97ff ("driver core: don't fail attaching the device if it cannot be bound")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/usb/core/message.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index cfb4cbdbe76fa..e7a23e406f8a2 100644
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
@@ -2285,10 +2308,26 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 			intf->cur_altsetting->desc.bInterfaceNumber);
 		device_enable_async_suspend(&intf->dev);
 		device_lock(&intf->dev);
+		claimant = intf->dev.driver;
 		claim_owner = xchg(&intf->claim_owner, NULL);
 		device_unlock(&intf->dev);
 		ret = device_add(&intf->dev);
-		module_put(claim_owner);
+		if (claimant &&
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
 			device_lock(&intf->dev);
 			intf->unregistering = 1;

-- 
2.56.1

