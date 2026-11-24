Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513487;
	b=Bxk1xd/o2g7Ex6GeVF3fWAfZvTO/F8gDREePbQhiu+54KR9L5UF9J8xEQyxCclLGSYWc
	 DUY9BuTBVqFuFP1TGafF3g7v+2YX6elzISBsDx0bya2yBff554sWo66Ysej4pl0dZF2F0
	 eKaMr357JlhUFcvpT60Yqhf6/rCXjetqlGZcr27PRy/eV9cAcWUpjqrOSxVOpDTAFcqLU
	 DKcN4sn0jds+KbUHS1N+KMED7QgIlzP9wsobwkkEiwlYFozZyRKr2hAfMVaqC8EwmfMso
	 IBw32ayrMjrRIbBsvuLhOhdjCqLwYPGG6A3Ly8YJo2dAmuvP9mtUcMZL0Hv8gk4RzPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513487;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=0+4AWW7/TXSgEhNOA2QaReK/4uj61CDyaZD6wgpgIZo=;
	b=3d7D+wPpFAU8Ms3f+r4rlsfoK4T12bFRw4AGoU1V6VqNP963djYEDVsCbZINXmMKF93Q
	 d5RwmM704YKSgsI8u3xNKAHXsou+/OJNO+sUhw0I7IdQaQaINtKxkrJeJtX3EGjbYk+p5
	 JyzbboNCx5R3v+6ZtmV64Xl8IboDxwM6zcWlCWhXzbMAzg7FXyeuczUJG9C8rbzi6BsXN
	 c1GsYjHNsrTwpwig45TKk68blXKTHOnKuViak0OgTt46Fix7VHKDwIkKyrNGoHr2DU/xy
	 hidQW4J6ICokyn7FlHWAhRpmmYPyhdyypqQAIvh/PIh8hBCtPRbxUOVJk5GRmSwo4IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xd6zu49z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10004606A69C;
	Tue, 24 Nov 2026 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xd6zu49z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A496B1F000D4;
	Tue, 24 Nov 2026 09:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513486;
	bh=0+4AWW7/TXSgEhNOA2QaReK/4uj61CDyaZD6wgpgIZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xd6zu49znoRKxUHkX/K1izlVhJGOPUgGvWfSdP5GeeLjrYlimQFjjPSt74c3Ry494
	 C9bfl3RzbmUIj5Y1GfnQtVoAQH+yzPg+YvvvOfWJqEZiOhzdFEltiaWBpgK8n5jIHU
	 XiEnoz4iY5Wwf2vnRr2GBRyNcedHf4b3o6Pj9YOImMqpySTrQ0Y6cQ1TAbduCCrSk/
	 STx0J29vh/PZH8mO4aAZIC2cMhGT15vgJjPyg5H8GYMkh2FjpYIUH9G/dzfOb8m4ts
	 a2vQgYkSW/BGZxN1IvFQSQQSaHMqMzH42LuR8rZwLGzQvqbO8CKHpamChs/W8C6VcQ
	 BT3OKuoefxjRA==
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
Subject: [PATCH v4 08/33] USB: Reject claims after interface registration failure
Date: Tue, 24 Nov 2026 11:43:39 +0200
Message-ID: <20261124-device-trust-core-v4-8-037eb0d17b1f@nvidia.com>
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

After device_add() fails, the interface remains in the active
configuration, so usbfs can still claim it. Configuration removal skips
unregistered interfaces and never calls the claimant's disconnect
callback.

A driver can claim an interface before USB core registers it. If
registration fails, reject further claims because USB core will not retry
registration of that object. Changing the device configuration creates
new interface objects.

Fixes: 86d30741e480 ("[PATCH] USB: Usbcore: Don't try to delete unregistered interfaces")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/usb/core/driver.c  |  2 +-
 drivers/usb/core/message.c | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index d902708416d06..a50403820285a 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -561,7 +561,7 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 
 	device_lock(dev);
 
-	if (!iface->authorized ||
+	if (!iface->authorized || iface->unregistering ||
 	    (dev->of_node && !of_device_is_available(dev->of_node))) {
 		retval = -ENODEV;
 		goto unlock;
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index a738d03c23eac..a645858b25d96 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1468,8 +1468,13 @@ void usb_disable_device(struct usb_device *dev, int skip_ep0)
 		 * bandwidth_mutex, we have to mark all the interfaces
 		 * before unregistering any of them.
 		 */
-		for (i = 0; i < dev->actconfig->desc.bNumInterfaces; i++)
-			dev->actconfig->interface[i]->unregistering = 1;
+		for (i = 0; i < dev->actconfig->desc.bNumInterfaces; i++) {
+			struct usb_interface *intf = dev->actconfig->interface[i];
+
+			device_lock(&intf->dev);
+			intf->unregistering = 1;
+			device_unlock(&intf->dev);
+		}
 
 		for (i = 0; i < dev->actconfig->desc.bNumInterfaces; i++) {
 			struct usb_interface	*interface;
@@ -2279,6 +2284,9 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 		device_enable_async_suspend(&intf->dev);
 		ret = device_add(&intf->dev);
 		if (ret != 0) {
+			device_lock(&intf->dev);
+			intf->unregistering = 1;
+			device_unlock(&intf->dev);
 			dev_err(&dev->dev, "device_add(%s) --> %d\n",
 				dev_name(&intf->dev), ret);
 			continue;

-- 
2.56.1

