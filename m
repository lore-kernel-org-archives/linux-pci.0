Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030045;
	b=IghP9Wgb8VUwDPSzJG6MgeBL8FmJzGepVJa+c1cs/xlI7dojjaLQH1dz4m4fkL/F8vDG
	 GEbNcI1bT+510/BXKhp7PV18w0fHXv6geK9DZGW2G0y6n0gYTKF2B1IqmtaOHFr6xG9+w
	 z7/R0VVWnNrOY/iVRlp0eoci5TUkbbt/UMeIDD4fofadIClsnSRwfgZt9GB8fVbId3IeR
	 cwsTu2G/IbhhEbFgq8GZ1RSbRkmiW3V49RTzd021zv6aknwKjzqgqKZuvpouUdosJaTFF
	 edmIOghGxeGGbAODRiFjVAVcFvJbf89YAbJ26gZvN0RjudPqkz7x32fgC0sgZBnKpIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030045;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=pmqSzlC17POH37JTU3MdGVt/pD+9YvkJtbsZUBZyg3A=;
	b=kEdlAtKTfmteDzOmvPZipR45swk434o8jTKaEizmOYjZN4/+s2E1WNNFYhJF73/vB6wD
	 egbsd1vi1pn1hTGD33RtFJ3clsOSbb++PCGILn7Vb3s92OUMo6C4/dlySu0TBheiz0npP
	 R11ZehcNvqUSjSil9tP+kkzAb2W6A3L+CuZFDTNdb7t1DlJb0PC9aA6yPVwXhS5/bKPg3
	 CPAi1DAOH0Ac1obt//azbGUkEoymHfieVENziNBdpHlGe8OytYV0dBSzLvfc96WvQc47H
	 8vQY/vlLlGjEXE8KzmeX+BdGu9HDp6xJ67ti7wnHyRG/fmZiXfcGmXbDb+R3tPt9vlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XicwAWHd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD09960A2606;
	Wed, 18 Nov 2026 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XicwAWHd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3363F1F000CF;
	Wed, 18 Nov 2026 19:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030045;
	bh=pmqSzlC17POH37JTU3MdGVt/pD+9YvkJtbsZUBZyg3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XicwAWHdytxAaeHfNJ6XxFwtg24F7hIFx3HJbaRTYOcHYpVnw8m/Qzf9ViBGb2EWx
	 TWStNFxX+LeAv0n5e4G5Mg0p+iYmIzV9vZKeqgvkZvg9Dhl0d+kNwKw44mMAD2lcer
	 WvojnDisK44wkD4y9eOU73VFcl51rD/7LpcDtmmybdm6lxWbbQxamwYgvkshQMzAz9
	 5tcMwlv7GOc1REDXQUopa3yZTVr68o5evqR1MkFIXerJ0dwaP7Vg2c3AvCKvle+M/X
	 yC4VE3ajz9pw9Ds7I3+09yawipuP8MoeygJTPEAN/zd4iKOidRXxU0T296+av9Fxld
	 lgvXP+aOVa3lg==
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
Subject: [PATCH v3 03/31] USB: Lock interfaces during manual driver binding
Date: Wed, 18 Nov 2026 21:26:33 +0200
Message-ID: <20261118-device-trust-core-v3-3-d655875c4bfb@nvidia.com>
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

Driver core requires the claimed interface's device lock during binding.
The parent USB device lock alone does not satisfy this requirement.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/bluetooth/btusb_main.c |  2 --
 drivers/usb/core/driver.c      | 15 ++++++++++-----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 8307fd819cc2e..f7f312af35c81 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -3024,10 +3024,8 @@ static int btusb_mtk_claim_iso_intf(struct btusb_data *data)
 	if (err)
 		goto err_put_interface;
 
-	device_lock(&btmtk_data->isopkt_intf->dev);
 	err = usb_driver_claim_interface(&btusb_driver,
 					 btmtk_data->isopkt_intf, data);
-	device_unlock(&btmtk_data->isopkt_intf->dev);
 	if (err)
 		goto err_unlock;
 
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index d3a61ebc6afb0..e1de348cc0cac 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -540,9 +540,8 @@ static void usb_shutdown_interface(struct device *dev)
  * No device driver should directly modify internal usb_interface or
  * usb_device structure members.
  *
- * Callers must own the device lock, so driver probe() entries don't need
- * extra locking, but other call contexts may need to explicitly claim that
- * lock.
+ * Callers must hold the parent USB device lock, but not the claimed
+ * interface's device lock.
  *
  * Return: 0 on success.
  */
@@ -559,9 +558,13 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 	if (dev->driver)
 		return -EBUSY;
 
+	device_lock(dev);
+
 	/* reject claim if interface is not authorized */
-	if (!iface->authorized)
-		return -ENODEV;
+	if (!iface->authorized) {
+		retval = -ENODEV;
+		goto unlock;
+	}
 
 	dev->driver = &driver->driver;
 	usb_set_intfdata(iface, data);
@@ -602,6 +605,8 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 		pm_runtime_set_suspended(dev);
 	}
 
+unlock:
+	device_unlock(dev);
 	return retval;
 }
 EXPORT_SYMBOL_GPL(usb_driver_claim_interface);

-- 
2.56.1

