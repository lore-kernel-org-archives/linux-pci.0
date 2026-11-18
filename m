Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030082;
	b=vg9jpTUuGLP9BFou0Dni1r7OETSzUak/4tmUQbdyRHHbXrLqgD1Sulc85oJQXECGcjWU
	 l1ppExuM6uNKKvkuH8AUM3mjj9btA3nmfRKkhCtPWKpELOTJKAEmPfomE1sP5EX5CHWwi
	 UiiPGjv73VQJ1dV6IPLDTfRVs73qNHHOHl/ifc5WoJ3PxwXFhD+jaUlr2EIqB4tXWrBqN
	 IctNdZe3xN2Tytei1SYq9E7pWeDLnG8L+0cVgZIkGJbVncBhQ5Z3I3Fwf04cOOsyl7tO1
	 6/qvpXxFYJJAGtjw6g6NNPmaK9mk80zXsEIWs8IWYC++mEuOnis1fKl/dvZCSGhGlRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030082;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=YIoF29/HLGxivKo9y9Umvo7WdoqaNvqRS3anqksW2+E=;
	b=zotAHFrzw+FPfxQFGbfzyZHPaXJVIVLpLPN1TkdXHf4CsuAt2ije5m9FeTasOea6TpXm
	 yQGtTjkh/tKZGlJHmoS3AnLWaCmpPPLdVesZspynOzDhdg7QxjXCfu0vuHKsTofeWpYMD
	 pGiSCjuC49IRhPwbToxPbotgD8FWC+3zaGzJuvVEXv5SdT558I9+qCjtOHJMHHFjeHDmy
	 Ykv/yfIguuhyll0XHln1NVJItQMXflC5ANwa+TCPoyrwXDLfLQLEFPK815uNAYHb08mwC
	 gkS5F5IPtD33+Zr0COHareh/Y//LApXMTa8xPE49/kMRMm0k7SiKllmoBDfAKUR4i+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRZV72CP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CEC606A7E4;
	Wed, 18 Nov 2026 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRZV72CP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEA81F000CD;
	Wed, 18 Nov 2026 19:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030081;
	bh=YIoF29/HLGxivKo9y9Umvo7WdoqaNvqRS3anqksW2+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GRZV72CPjqMFDz8QVvFaDzm4LVKAGO1cB/qlcrZnlS+aSNN6dyhiAHzc7/Iuazi1G
	 E0+HoqJ35Lv7sBXo/FIcUJd2exYCi2hqwuURJZBJBZldug/vwUmFY3kO+fAcQ4wg+q
	 /j0H4tydBClBdMwpvshpct6bF3mbB2fVgJbBRIXWSFAEL1kw+U1Fjoohcmu1dgOk0w
	 mk5tarzoqyQbkocZUsOikIW25i//qizQMtr19cD/8MJiauMsTWUJQFr9y7yKWVNyiz
	 t259FRj7GvUVWH/K2dML1UyuCkdGAgufckIztJb7hXSUUALe+sxnopyvIi1cbG5YQr
	 jJhaay2TAN8kg==
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
Subject: [PATCH v3 12/31] PNP: Attach card devices through the driver core
Date: Wed, 18 Nov 2026 21:26:42 +0200
Message-ID: <20261118-device-trust-core-v3-12-d655875c4bfb@nvidia.com>
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

pnp_request_card_device() calls the PnP bus probe directly, bypassing
the driver core's supplier checks and power management setup. If
device_bind_driver() then fails to create the sysfs links, the device
remains attached and may stay active, but the caller receives NULL and
cannot release it.

Use device_driver_attach() for synchronous probing with the driver
core's setup and error handling. Preserve the card link until binding
completes, so probe cleanup and CONFIG_DEBUG_TEST_DRIVER_REMOVE cannot
clear or free a link still owned by the enclosing card probe.

Fixes: bfc7ee207078 ("[PATCH] PNP: handle sysfs errors")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pnp/card.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
index df5e3d3cbf6c0..9aaaa03d5ffa9 100644
--- a/drivers/pnp/card.c
+++ b/drivers/pnp/card.c
@@ -52,13 +52,17 @@ static const struct pnp_card_device_id *match_card(struct pnp_card_driver *drv,
 
 static void card_remove(struct pnp_dev *dev)
 {
-	dev->card_link = NULL;
+	if (device_is_bound(&dev->dev))
+		dev->card_link = NULL;
 }
 
 static void card_remove_first(struct pnp_dev *dev)
 {
 	struct pnp_card_driver *drv = to_pnp_card_driver(dev->driver);
 
+	/* The card probe still owns its link until this device is bound. */
+	if (!device_is_bound(&dev->dev))
+		return;
 	if (!dev->card || !drv)
 		return;
 	if (drv->remove)
@@ -331,16 +335,12 @@ struct pnp_dev *pnp_request_card_device(struct pnp_card_link *clink,
 
 found:
 	dev->card_link = clink;
-	dev->dev.driver = &drv->link.driver;
-	if (pnp_bus_type.probe(&dev->dev))
-		goto err_out;
-	if (device_bind_driver(&dev->dev))
+	if (device_driver_attach(&drv->link.driver, &dev->dev))
 		goto err_out;
 
 	return dev;
 
 err_out:
-	dev->dev.driver = NULL;
 	dev->card_link = NULL;
 	return NULL;
 }

-- 
2.56.1

