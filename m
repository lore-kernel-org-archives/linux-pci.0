Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030058;
	b=Zrae8y1FoQWI3EYl4l236hH4wJxR6CX9YyUUcObpneVVTPmbUhjmZTI3epGFYyMGVmZT
	 WTXIEufSlxwNKgzwXQ2G6ywlr21ZV0wKsCNygmxc774dEFUBF3yIW4ymK/PGwKiEsbcmC
	 bTbGI81HcQ98UceqQ+KyixONbYLQfCtlxMueeAe84Lw7ReM/ey3qByGsu0yEfowx/ErNj
	 UQn0m49NycWZcbfiBaTc6UcMfp24oNlF7PI5DhPndyhHmIQWNzvMapXzN0isMyf14L7Fd
	 F8E17zxwAbLIzaUSOwXHqXgwVqB3nJVNkJNWW+O0AGz8dIs2nAWjXkrqtysSF2YSGRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030058;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=HQBoEMtna5bK8TwEvMmKwBNLX3MjDbXuh/TDouN79oI=;
	b=D/s90WOg6Q2/M6ekUHVBfZqUldCLzlAaQUCa+XGPDlyMRrY98NksytMPEMru71Hfo2T8
	 1cyuZ44Q3aIHOI2xzYTUaCUwWagRNH2C49FN7u8EZKKlQR6xd4aGrUEXM5HGn5HA0a7HH
	 8HVVOKg05A/jSQG6k/yl0VwqmP5XXhO/f6P+KvnzrVNn0yBOywzplq58eNOrGLm+HP1Ou
	 4QZJQlXu63w81AoPNJVm7hJTKUS6a3Vj3/09cVnYdFEZ9r9AeeUOK//UkSzhUIncFEchl
	 gfvyyYo+LNLoh0lKJOwh2TkhhCSNnqiTmEKzCZxf2fpDSL/VSB4o8GqBstgfST95Tpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fq2AsTJC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41784606A339;
	Wed, 18 Nov 2026 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fq2AsTJC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AB51F000C4;
	Wed, 18 Nov 2026 19:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030057;
	bh=HQBoEMtna5bK8TwEvMmKwBNLX3MjDbXuh/TDouN79oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fq2AsTJCuzGycTLVvdmXO4cnqSQCQck5Td1qAIjGtYH78QyJf8OZBZis6H/WcXsHw
	 DjCcN8GQMdvB+rOBoJ2akTIcTRg8jhxu8mrcnI1uJ5t02wruZ031PmZxdujuFl++NP
	 Q3vKB3JLPv03tSi2DmkyZDpVuLzoynYkPDAlDm9bCtWnMLOL8dHe/fFRxyodGSv1jE
	 wSPcWpQxAuOJSOpkls02K8zr/BqVzSXCKN935BDEn0H49Cz/a6YMwWRx91Rcin1JPG
	 ZJNRBptleE24QqD0Fvxwr3wPPC8M/iQNBguRDsmmceq940JeWAorY+oiwMUHcyyyzm
	 ZncnHk0e6DV6Q==
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
Subject: [PATCH v3 06/31] USB: Release interface claims according to binding state
Date: Wed, 18 Nov 2026 21:26:36 +0200
Message-ID: <20261118-device-trust-core-v3-6-d655875c4bfb@nvidia.com>
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

A driver such as CDC-ACM can claim a sibling interface before it is
registered. Disabling USB bus autoprobing between the claim and
registration leaves dev->driver set without adding the interface to the
driver's bound-device list.

Releasing that interface through driver core then attempts to remove an
unattached list node, causing a NULL pointer dereference.

Fixes: b8c5cec23d5c ("Driver core: udev triggered device-<>driver binding")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/usb/core/driver.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 735ae3310b45d..926f63cd2c834 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -612,6 +612,15 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 }
 EXPORT_SYMBOL_GPL(usb_driver_claim_interface);
 
+static void usb_unbind_claim(struct usb_interface *iface)
+{
+	struct device *dev = &iface->dev;
+
+	usb_unbind_interface(dev);
+	dev_set_drvdata(dev, NULL);
+	dev->driver = NULL;
+}
+
 /**
  * usb_driver_release_interface - unbind a driver from an interface
  * @driver: the driver to be unbound
@@ -631,27 +640,25 @@ void usb_driver_release_interface(struct usb_driver *driver,
 {
 	struct device *dev = &iface->dev;
 
-	/* this should never happen, don't release something that's not ours */
-	if (!dev->driver || dev->driver != &driver->driver)
-		return;
-
-	/* don't release from within disconnect() */
+	/* Avoid recursive locking from disconnect(). */
 	if (iface->condition != USB_INTERFACE_BOUND)
 		return;
+
+	device_lock(dev);
+	if (dev->driver != &driver->driver ||
+	    iface->condition != USB_INTERFACE_BOUND)
+		goto unlock;
 	iface->condition = USB_INTERFACE_UNBINDING;
 
-	/* Release via the driver core only if the interface
-	 * has already been registered
-	 */
-	if (device_is_registered(dev)) {
-		device_release_driver(dev);
-	} else {
-		device_lock(dev);
-		usb_unbind_interface(dev);
-		dev_set_drvdata(dev, NULL);
-		dev->driver = NULL;
+	if (device_is_bound(dev)) {
 		device_unlock(dev);
+		device_release_driver(dev);
+		return;
 	}
+
+	usb_unbind_claim(iface);
+unlock:
+	device_unlock(dev);
 }
 EXPORT_SYMBOL_GPL(usb_driver_release_interface);
 

-- 
2.56.1

