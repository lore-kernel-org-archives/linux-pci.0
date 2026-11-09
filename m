Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209652;
	b=ueRJ3rd8jdospcvnu3pvWUcmbE7L6IMIyOvYsSQnFyjXy7uMcvtyvDBIb+luJDPpgEkI
	 VLy/vaqKDNtoxIglpj9oh8z4Xvnc3C4/JKAkA/MP97CqMUvJcaebqI1Eit8tEXajM/w99
	 reFO1/Rly7H+MqGV8ZGjiTJWIjBKTjJUP27q+7FFUjJfW+t5V1XfkstwWEQxjlJJymoHJ
	 URCSSB48SncW90hXM1ViCdorzH2nPJV9l9Gi2b4ehHsIGpGS+BJFazKnKieoT0HDZn2DI
	 kcRMtx4GfpwXjuY848+m+wyoOzT6oyH5NB7bOLJCKLptGKzGZSlY6LV7igTG+xHZCrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209652;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=5KpZyXTyDaeCpFL09xfcSddfcVQz8Z2BLa6aTzaRrnw=;
	b=kIrpUDg7h4QzTP+CD/Lnd48zHcPGiFoqWCqL5t+ztsfJ6Y1KCPhZBgZWcE5QNouGiTVx
	 YmKkGkqxtkLpog7RUX3zYCyEDD6nCmBiuBcaGaKmzFiqIi8ZyNeFG90EiGsY4D5q5q+Yw
	 5jt12kvfHl8KRJNRGWdE1cxiF9QaGWZB9egZG5jXSUSMSK8dxx7a3Zzf8ps/KpYZW1pGj
	 mlv4YeD3A1tKClMeNv+n9zg5T6J5DxdPAnLmElEZyYo+qvTxfr4d3WeYlV1t34Gu7SjxJ
	 nSLUzxSU00zRpbt1jafZMkwZ+KXyBo9+rfjB+geKyE9bzBmy3B8/gPOAjFT4nz9yVWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwKBHRrg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDA1606D827;
	Mon,  9 Nov 2026 07:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwKBHRrg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410D21F0089F;
	Mon,  9 Nov 2026 07:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209652;
	bh=5KpZyXTyDaeCpFL09xfcSddfcVQz8Z2BLa6aTzaRrnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lwKBHRrgtLlHdfSIgSshSm3e0EGD/FzxILn/oHZ/MBhIlxI92zK1vyP/KinI0O+dq
	 N1lkFUZ1d1LxsJFXpKksY6sxA+asTaTHkZoul7zy9272bic517JX89oNFsIZ1y5Xpo
	 lpJVehQ2mPpV8DtjN9VWns0x+h74ukvpSJnGqPF3qV7WMyHiEty6/9IUL4NqOH9sbO
	 N4Xg0BfHVzBLU8JKOsEAtqqFC/KoByvzJTCTdkwPkrln1oXePe+/4LOBk5b6PTvakB
	 qGWrjTRcTvelnyEbe0ToJwLbaTKoeQR0FT/RT6LxYj1L0gDGKgW+DHEKRPmlndd15f
	 1L7qwcpsIsz/A==
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
Subject: [PATCH v2 04/19] USB: Release interface claims refused during registration
Date: Mon,  9 Nov 2026 09:33:34 +0200
Message-ID: <20261109-device-trust-core-v2-4-3b12d9a9f861@nvidia.com>
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

An interface can be claimed by a sibling's probe before registration.
If its later binding fails, driver core clears the driver pointer while
USB retains the bound state and claimant data. Device registration still
succeeds, leaving the claimant unaware that its binding was refused.

Remember the claimant across device_add() and invoke USB unbinding when
driver core drops the claim. Hold the claimant's module while running its
disconnect callback, and clear the retained interface state.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/usb/core/driver.c  | 18 ++++++++++++++++++
 drivers/usb/core/message.c |  8 ++++++++
 drivers/usb/core/usb.h     |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index ad5d9d5fc7598..ee36eae34bdcc 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -652,6 +652,24 @@ void usb_driver_release_interface(struct usb_driver *driver,
 }
 EXPORT_SYMBOL_GPL(usb_driver_release_interface);
 
+/*
+ * The driver core refused to bind an interface that a sibling claimed before
+ * it was registered, and dropped the claim. Let the claimant release the
+ * interface instead of operating it with a bound interface but no driver.
+ */
+void usb_driver_release_refused_claim(struct usb_interface *iface,
+				      struct device_driver *claimant)
+{
+	struct device *dev = &iface->dev;
+
+	device_lock(dev);
+	dev->driver = claimant;
+	usb_unbind_interface(dev);
+	dev_set_drvdata(dev, NULL);
+	dev->driver = NULL;
+	device_unlock(dev);
+}
+
 /* returns 0 if no match, 1 if match */
 int usb_match_device(struct usb_device *dev, const struct usb_device_id *id)
 {
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index a738d03c23eac..d35a7710c8ef4 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -2264,6 +2264,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 	 */
 	for (i = 0; i < nintf; ++i) {
 		struct usb_interface *intf = cp->interface[i];
+		struct device_driver *claimant;
 
 		if (intf->dev.of_node &&
 		    !of_device_is_available(intf->dev.of_node)) {
@@ -2277,7 +2278,14 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 			dev_name(&intf->dev), configuration,
 			intf->cur_altsetting->desc.bInterfaceNumber);
 		device_enable_async_suspend(&intf->dev);
+		claimant = intf->dev.driver;
+		if (claimant && !try_module_get(claimant->owner))
+			claimant = NULL;
 		ret = device_add(&intf->dev);
+		if (!ret && claimant && !intf->dev.driver)
+			usb_driver_release_refused_claim(intf, claimant);
+		if (claimant)
+			module_put(claimant->owner);
 		if (ret != 0) {
 			dev_err(&dev->dev, "device_add(%s) --> %d\n",
 				dev_name(&intf->dev), ret);
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index a9b37aeb515be..293340a48b6c5 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -49,6 +49,8 @@ extern int usb_set_isoch_delay(struct usb_device *dev);
 extern int usb_get_bos_descriptor(struct usb_device *dev);
 extern void usb_release_bos_descriptor(struct usb_device *dev);
 extern int usb_set_configuration(struct usb_device *dev, int configuration);
+void usb_driver_release_refused_claim(struct usb_interface *iface,
+				      struct device_driver *claimant);
 extern int usb_choose_configuration(struct usb_device *udev);
 extern int usb_generic_driver_probe(struct usb_device *udev);
 extern void usb_generic_driver_disconnect(struct usb_device *udev);

-- 
2.56.0

