Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030110;
	b=TMmRj07yjUqLUUYVzoLQUPiFzaS8qscqF9BjR29VdWESjlENhDZdGw7YRCfYIz8kCDjF
	 cov8l68R941hoJuyKIfUsG+X12SeLQYYkDBQwPI94IIXyEAaSE7TO8g2X0NXTUURBbuIi
	 RLGmDYBL1czG2Fy/wirx7QN1QHH7MzILGS3AAYQkps7+OetsajlUO9sGcTlq8JRLSQhih
	 1Q3IaFt3a15DFsg3Bg+GHsY2G3vp+5r//1qAm6qIh3Iy8VdK6oB7hf7J/7/FxuDRMHqGE
	 Cg0a5gnrMw/5VZckuY8oAR35f7FpKMwfk5dLNyA2y4zGFPt2gh6otiBTBucoXrlKlPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030110;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=XQYDdAkVR7IUALr9I7d52ZHJP7tMO6LB2W6b4WjMN48=;
	b=Kw0TsvSo/YN9tJ8lULZPz8e7Syxob+4RsAPar5l53Pbq2zRIw/sTmoXEpdQIzzcTY1pj
	 RqbVxXev039RTtW/LrG9qgLlZLSb5QtnxgMsryAwPdU6+PabNRZomBFcLRan6P2CRVSmJ
	 DktdFKDWePwFscNUKFGXKVEapXAE1kUWdt4Ij8mkHCH6xZ8r900y0vZloYdH41rXhBrfl
	 qGkan8Jd+4cX+2gZlnrUPoSMB7jYEeYmG+ouTe9jy3SHCO9IEh9TWmkFecqFDPD0cFait
	 JU3scxh217eHJA9Bi1yOtToZUKLmkhZwtGDE7rIRHPS+i+29/WRfIQWo/gpFf/4iNFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+F9NrM4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C337606A7D8;
	Wed, 18 Nov 2026 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+F9NrM4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0BA1F000C4;
	Wed, 18 Nov 2026 19:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030110;
	bh=XQYDdAkVR7IUALr9I7d52ZHJP7tMO6LB2W6b4WjMN48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F+F9NrM4hHz9iyzQTtn/F3OM0J9Ad9oH3h/VEfjxH9zjQ+Ain9SvKqxO7Hvd4OZEV
	 TTbERPwr7JbOgG0vS409CBC+98fpQ+EoLa2MG2p5FhSdzr2+e3TZvHexHANm9RKRYi
	 aKMbA3iKLmVTO+2cjO3RyIvj6QyBEPQBUmSxe56FhlawKnLlW1urQT9AJylIQC43y1
	 6oMHsgP9cwWXkG7YfY/HRP0pks3epCdtizwZSBQaxYJKgGL46zUM/Z5cLhtbHMn+Pc
	 NE3DSX2zsEF7FdLx5Jd3cBif+rtcDpxVSuH3624/enZqDyw/oRBVxFGKUIV4snMD9G
	 w/x9lwI4bXfGA==
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
Subject: [PATCH v3 18/31] net: phy: Use the compatibility driver attachment API
Date: Wed, 18 Nov 2026 21:26:48 +0200
Message-ID: <20261118-device-trust-core-v3-18-d655875c4bfb@nvidia.com>
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

The generic PHY fallback probes directly before publishing its binding.
Device trust admission needs to precede that probe without changing the
caller's serialization, so use device_driver_attach_unrestricted()
to serialize the generic attachment.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/phy/phy_device.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 5d4508bcfbe99..4f20b451e270d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1857,7 +1857,6 @@ static void phy_detach_internal(struct phy_device *phydev, bool notify_bus)
 		/* The release below lets phy_probe() write this field. */
 		phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];
 		device_release_driver(&phydev->mdio.dev);
-		phydev->is_genphy_driven = 0;
 	}
 
 	/* Assert the reset signal */
@@ -1912,6 +1911,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	struct device *d = &phydev->mdio.dev;
 	struct module *ndev_owner = NULL;
 	struct module *drv_owner;
+	struct device_driver *drv;
+	bool bind_genphy;
 	int irq = phydev->irq;
 	int err;
 
@@ -1939,16 +1940,16 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	/* Assume that if there is no driver, that it doesn't
 	 * exist, and we should use the genphy driver.
 	 */
-	if (!d->driver) {
+	drv = d->driver;
+	bind_genphy = !drv;
+	if (bind_genphy) {
 		if (phydev->is_c45)
-			d->driver = &genphy_c45_driver.mdiodrv.driver;
+			drv = &genphy_c45_driver.mdiodrv.driver;
 		else
-			d->driver = &genphy_driver.mdiodrv.driver;
-
-		phydev->is_genphy_driven = 1;
+			drv = &genphy_driver.mdiodrv.driver;
 	}
 
-	drv_owner = d->driver->owner;
+	drv_owner = drv->owner;
 	if (!try_module_get(drv_owner)) {
 		phydev_err(phydev, "failed to get the device driver module\n");
 		err = -EIO;
@@ -1956,11 +1957,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	}
 	phydev->drv_owner = drv_owner;
 
-	if (phydev->is_genphy_driven) {
-		err = d->driver->probe(d);
-		if (err >= 0)
-			err = device_bind_driver(d);
-
+	if (bind_genphy) {
+		err = device_driver_attach_unrestricted(drv, d);
 		if (err)
 			goto error_module_put;
 	}
@@ -2071,8 +2069,6 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	module_put(phydev->drv_owner);
 	phydev->drv_owner = NULL;
 	phydev->irq = irq;
-	phydev->is_genphy_driven = 0;
-	d->driver = NULL;
 error_put_device:
 	put_device(d);
 	if (ndev_owner != bus->owner)
@@ -3813,6 +3809,8 @@ static int phy_probe(struct device *dev)
 	int err = 0;
 
 	phydev->drv = phydrv;
+	phydev->is_genphy_driven = phydrv == &genphy_driver ||
+				 phydrv == &genphy_c45_driver;
 
 	/* Disable the interrupt if the PHY doesn't support it
 	 * but the interrupt is still a valid one
@@ -3949,6 +3947,7 @@ static int phy_probe(struct device *dev)
 out_reset:
 	/* Re-assert the reset signal on error */
 	phy_device_reset(phydev, 1);
+	phydev->is_genphy_driven = 0;
 
 	return err;
 }
@@ -3977,6 +3976,7 @@ static int phy_remove(struct device *dev)
 	phy_device_reset(phydev, 1);
 
 	phydev->drv = NULL;
+	phydev->is_genphy_driven = 0;
 
 	return 0;
 }

-- 
2.56.1

