Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513559;
	b=BQh6sH10T9yfYyGJVJ29jmHEYzBVlsOgzRcKPAFnh3jhbzLqxa1PSOGMkRnMWoWwd4av
	 BhPThkJj7zZcurilANF6rt6GQdiqKBdWyrw0ITMchQTn11BreisIwfBGBrE32/jjWp1lG
	 m8eNtWaAxcNPW5FGyQkcM5oY8bObgzYIL4SiMPWk/fO28bRtNPNC19GKHxDWWSPZQp9IA
	 +YUWY956PA0G1rILcrmShgnPOmWJ4OUbjvJXOzgYduYhW5CE+/HaX7naOpgxUc6IEFF/B
	 ilmcCXhdOw8/Ne9c80Muy7VcXS3xzxI7tBlGe6TRbTaeoOHKVTkefnQdADC8UpVXRcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513559;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=0ocO3hzxDXP5J+wMv8np8RM3eAnwMTJFFeAUpb5CWAI=;
	b=x0H7YX5e/0dzv8pRGx4dVHVaInTJyWVCoisQk+FFzFKVbvSpmUnu+7LIaDuX6VBNdGC8
	 ff/nRh5UbBs5vo6Vr413oX2j+kEM4YIMMkplYGEc1nBVcFcPAbszUxahZRVcV0Kd1ViY9
	 rcpXVS9NNOA3CzD8TIyutwfZzVJ0mshXFP9lgQ5ewXcf7tVdUCmdtT7OpOe7VGsnaiuz0
	 68s0Y74T0Bylud+v2lGZkx2HzIg0tQHkNyHQfpbyY5fxMcugDN+MAYBwH6SNgjaTTjGYI
	 owSyPQLw5+HZGoTqJ54aiK/KBc9R2WYylG72UUf8xcYLR+eKWiH2Hq/aL9dH0RBb/bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AtRBTbcF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F75606B033;
	Tue, 24 Nov 2026 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AtRBTbcF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F391F000D4;
	Tue, 24 Nov 2026 09:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513559;
	bh=0ocO3hzxDXP5J+wMv8np8RM3eAnwMTJFFeAUpb5CWAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AtRBTbcFtUyiPTchVF40SgM0rK31T4QwRREUs/Yc8+5PG+SU/7QMKuPH3fhhsLDjq
	 0KwoHAqW5wrwPaiMgSrMdD7uwRBlSWOXsCUUTkyrkyS6fQ58nZpB39E5RgeyIqVDjh
	 ProYd+7lblyTrOA7lkRJ2HvBvL9BoxWNcv/gCzVOfs5W0qvc8OgBwbGmCEQAg2S85m
	 p0F0pYMg44HEHOSEeJMvfw2da2/oCaRHp3ch6mz9LDsvXd7C/LL3dGdCw+ppeL4+eH
	 v1tV0f0XZB5j7ckmku60Rwj4AAlp88jH2WXsLgHGN2EVGA4KUGBbgFBER4EmZGFL6T
	 ctaAi8z6GXEww==
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
Subject: [PATCH v4 20/33] USB: Drain usbfs when a device is unregistered
Date: Tue, 24 Nov 2026 11:43:51 +0200
Message-ID: <20261124-device-trust-core-v4-20-037eb0d17b1f@nvidia.com>
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

Only the generic USB device driver tells usbfs that a device is gone.
A device without that driver bound, such as one unbound through sysfs,
is unplugged without any notification. usbdev_open() does not check for
a driver, so a process can open such a device and sleep in poll() on its
idle descriptor. The unplug never wakes it or sends its disconnect
signal.

Drain usbfs from usb_disconnect() before device_del(). The device is
already marked as not attached, so no new user can open it. The later
drain from the generic driver finds nothing left.

Fixes: 782da727b0d59 ("usbcore: make usb_generic a usb_device_driver")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/usb/core/devio.c | 4 ++--
 drivers/usb/core/hub.c   | 3 +++
 drivers/usb/core/usb.h   | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 1491ba015bcd8..a881f06361bfa 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -2862,7 +2862,7 @@ const struct file_operations usbdev_file_operations = {
 	.release =	  usbdev_release,
 };
 
-static void usbdev_remove(struct usb_device *udev)
+void usbfs_notify_remove(struct usb_device *udev)
 {
 	struct usb_dev_state *ps;
 
@@ -2889,7 +2889,7 @@ static int usbdev_notify(struct notifier_block *self,
 	case USB_DEVICE_ADD:
 		break;
 	case USB_DEVICE_REMOVE:
-		usbdev_remove(dev);
+		usbfs_notify_remove(dev);
 		break;
 	}
 	return NOTIFY_OK;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 199d3f535a891..372bd6368cc94 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2379,6 +2379,9 @@ void usb_disconnect(struct usb_device **pdev)
 	if (udev->usb4_link)
 		device_link_del(udev->usb4_link);
 
+	/* usbfs is otherwise notified only by a bound generic driver */
+	usbfs_notify_remove(udev);
+
 	/* Unregister the device.  The device driver is responsible
 	 * for de-configuring the device and invoking the remove-device
 	 * notifier chain (used by usbfs and possibly others).
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 1b2de58fd6cef..cbee731837471 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -195,6 +195,7 @@ extern const struct file_operations usbdev_file_operations;
 
 extern int usb_devio_init(void);
 extern void usb_devio_cleanup(void);
+void usbfs_notify_remove(struct usb_device *udev);
 
 /*
  * Firmware specific cookie identifying a port's location. '0' == no location

-- 
2.56.1

