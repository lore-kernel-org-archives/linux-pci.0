Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030073;
	b=n4kRFpu4JhZIwmVARxXXuqnFnwWSGa290AuEjQMF9ykZvZkvG19WODTgQVqT1OSqYXqj
	 eTkQNpCag+IMtfLXRND5R+eV7bGjy6aZh2DOyh8KxGTT4oLguLlyI+P6PRgAEQ2iPbDQr
	 hIiaedMWWZKf+pld15bMfBaPXZUgxHCSa4+gmYXs5jiEc914WUxyv7SP06VjKaCcQedgC
	 WMgQYpTBlz3ys3MI4QZ38lntn5V2k22A95PWdXzQmpYMNiRmfnYycCFp7xTjE7/f7on1/
	 ghs5mQebQWnTGzrzVrIZuMtbRuhA2CYEKLjz2XEN00i7K64nZLGSosiIJDb3dPw11OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030073;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=1YKQWQ2OAQkN5+uMRlTvEbCZ/XYCSadXwwlj5aVnGJM=;
	b=UM6tG35/juQUyl56wxZIwtvgk/PvA9UG4JDq0cn/ujlGHPcRbceqCSz5xLXjIKCm0QYR
	 wax01jQzQsP/wIR6LP4pgsLb+tzsAAdLnVjVB0Hcl4MTPUeMJYsyGXDWxWUYqWts+OiBA
	 HyLB9GY7BiZkise1q2XnOI3HOmmdY7W4rY+eUra+qoLbdJbPRPU2P7FPYLxCw7ZlyLh79
	 yQjw5h5pej/yDlAmvS6CjpwAUq4caH6Qq9fpa7edQaJNcD3nabmMIJMvqIwjr991/F4rd
	 QDUt9pKBKUf6qxQaMce8sUFNQZMogX8I/h7gEEpBdgHlGKMNanWmaOHU5J930J0RXSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=COJ6XROP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3D606B13D;
	Wed, 18 Nov 2026 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=COJ6XROP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D02A1F000C4;
	Wed, 18 Nov 2026 19:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030073;
	bh=1YKQWQ2OAQkN5+uMRlTvEbCZ/XYCSadXwwlj5aVnGJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=COJ6XROPRzNSDpwLm1+FfRrVjQRtO5VUwdyrSqsYkR81hJUgYGWz04paI5orjifAU
	 vX0CoNx4GD4CgsQf2IOdrl9sl06osATaomzVffn5cOzn4nDutX1XtpfxpzaAVJxnDR
	 BhN+ELlZX1yqbGUQx1O2DIirXGdAbHIj7pyajF3whrk4e/C4WdUv3BMQCySaZU7ihl
	 PBKGlK4O1LEqAaXLpI5fcFOvKuObTEe5RFKzdGVN92bmMvcqtjfKfcSoeZh7WfNO2U
	 iOfjYqD1tnAX7kdzFKpit/LGYnrZixBAMzE7UefpuJYw+IEpAPQ9xgBz3QV86fSirZ
	 FBj9C35R6L11A==
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
Subject: [PATCH v3 10/31] USB: Add helpers to release unpublished interface claims
Date: Wed, 18 Nov 2026 21:26:40 +0200
Message-ID: <20261118-device-trust-core-v3-10-d655875c4bfb@nvidia.com>
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

An early USB claim can require disconnect even though driver core never
bound the interface. Binding failure may also have cleared the claimant
pointer.

Add release helpers so registration rollback and configuration removal
can unwind these claims through USB.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/usb/core/driver.c | 26 ++++++++++++++++++++++++++
 drivers/usb/core/usb.h    |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index b7bd9226d2627..3beed56fabf3d 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -637,6 +637,14 @@ static void usb_unbind_claim(struct usb_interface *iface)
 	usb_put_claim_owner(iface);
 }
 
+void usb_release_unregistered_interface(struct usb_interface *iface)
+{
+	device_lock(&iface->dev);
+	if (iface->condition == USB_INTERFACE_BOUND)
+		usb_unbind_claim(iface);
+	device_unlock(&iface->dev);
+}
+
 /**
  * usb_driver_release_interface - unbind a driver from an interface
  * @driver: the driver to be unbound
@@ -679,6 +687,24 @@ void usb_driver_release_interface(struct usb_driver *driver,
 }
 EXPORT_SYMBOL_GPL(usb_driver_release_interface);
 
+bool usb_driver_release_refused_claim(struct usb_interface *iface,
+				      struct device_driver *claimant)
+{
+	struct device *dev = &iface->dev;
+
+	device_lock(dev);
+	if (iface->condition != USB_INTERFACE_BOUND) {
+		device_unlock(dev);
+		return false;
+	}
+	dev->driver = claimant;
+	usb_unbind_interface(dev);
+	dev_set_drvdata(dev, NULL);
+	dev->driver = NULL;
+	device_unlock(dev);
+	return true;
+}
+
 /* returns 0 if no match, 1 if match */
 int usb_match_device(struct usb_device *dev, const struct usb_device_id *id)
 {
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index dfa48f43046d4..1b2de58fd6cef 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -50,6 +50,9 @@ extern int usb_get_bos_descriptor(struct usb_device *dev);
 extern void usb_release_bos_descriptor(struct usb_device *dev);
 extern int usb_set_configuration(struct usb_device *dev, int configuration);
 void usb_put_claim_owner(struct usb_interface *intf);
+void usb_release_unregistered_interface(struct usb_interface *iface);
+bool usb_driver_release_refused_claim(struct usb_interface *iface,
+				      struct device_driver *claimant);
 extern int usb_choose_configuration(struct usb_device *udev);
 extern int usb_generic_driver_probe(struct usb_device *udev);
 extern void usb_generic_driver_disconnect(struct usb_device *udev);

-- 
2.56.1

