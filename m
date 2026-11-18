Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030062;
	b=2EzEC2SvpZPiKLEmkq6N+3Ub2wdlOOuQK1tdCpYE+xUxpaB1cBcZSQQr8AvVXxPBjUZy
	 Rul3uNC7Rww+PvuUbbCKzhDeHL9mQFPVUB8iNBpZOzAvJTn+Fu4oia+1qgMEqDQ34BHOw
	 FoKEdRubsPsTOyKv6Z3abdwCJJsN9OjYpFTg59phtvfiskuGyyeoKO1NKyFhpZwk9fI9p
	 trlboUC/iUTnNSQEcydnVnnaR8nl5YvZxJUW7sufjSuOgPMcfu/wQzSZ6+AeLm+Fjv763
	 NlfxyTnGHktfF4+nNCxtg2oThWD2hohy/Wlfy+kCpYZZ3GHYCYzsB1sHRZ6TYTHSN/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030062;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=tIkIa9xWsGpipUak11v/cJ0X9CImINsTJeRFQi63NF0=;
	b=0xBNgVHkkwLLzrlYaep3iMUDervmCpsIjeZCUDNIToyPhc+Dgu2xWxZkuDJhgs43MrN3
	 t8mm/X8ZPzLIbIxkWS38yU+1Wp99eIwd9G7hGQSGKT0hxFQJJiJyQmVfnzXesi5G2GQp7
	 BqshrtZ6osEAlr5048rcvPR9UeB+snjld8iqKmKsqKCWk49WZhmHssTo5174pivut/rHb
	 x8uhhpufcezuR75pFTyKt0844a07vYtkpGQSDnfdfImGskfWJWvl6mX8oRfwUuzWbGVFM
	 C8kStw5Aoa6Gnq2RA4aV1Tjb8AHsvnrE8SHfNXPuW7bm6aSSNKt1kIKstHBVXmBiBdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VG88znX5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F4B60A6F6E;
	Wed, 18 Nov 2026 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VG88znX5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E209B1F000CA;
	Wed, 18 Nov 2026 19:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030061;
	bh=tIkIa9xWsGpipUak11v/cJ0X9CImINsTJeRFQi63NF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VG88znX5pFawkJSAyapyFZsuga4KtFPIUUOEh1BSrA2aCI7XmTozzLCKkOcvVB+Xn
	 lJCdTnr/UQD/DajyfgnXleNWKgcBxNM6CeHKnx7jDVPNgLWln+CmAcdGysoCUYm20B
	 WHE3rxRMrHJ293qYp8/yLi6hBaq+MJMHh962b2LBNnlc9CVA+93dQx3erLL+tmYniH
	 Ustpq/1wvW/LqSq3l3a7GVviQPDdGML/v86356ZO20vYo4kzwLKu3+uo66ejlKEvu9
	 H59iiXEikoL+iVWmvvA8Roc07kaF0rtGAUt5SqdZr4oynVbuMC+p6+sGxw0qouB7hI
	 npI5Sbp5u5bhg==
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
Subject: [PATCH v3 07/31] USB: Reject claims after interface registration failure
Date: Wed, 18 Nov 2026 21:26:37 +0200
Message-ID: <20261118-device-trust-core-v3-7-d655875c4bfb@nvidia.com>
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
 drivers/usb/core/message.c | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 926f63cd2c834..0a6fdf2e88f4e 100644
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
index a738d03c23eac..e56079398d26e 100644
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
@@ -2278,6 +2283,11 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 			intf->cur_altsetting->desc.bInterfaceNumber);
 		device_enable_async_suspend(&intf->dev);
 		ret = device_add(&intf->dev);
+		if (ret) {
+			device_lock(&intf->dev);
+			intf->unregistering = 1;
+			device_unlock(&intf->dev);
+		}
 		if (ret != 0) {
 			dev_err(&dev->dev, "device_add(%s) --> %d\n",
 				dev_name(&intf->dev), ret);

-- 
2.56.1

