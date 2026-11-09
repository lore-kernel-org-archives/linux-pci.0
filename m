Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209673;
	b=wKnimjeQdz+IeCJcT9ZKIJi/8ekY509fW4G9phVhne9qhff5F3IfwYJMwd59TDyy9D7H
	 EwkYwX88iSQZoLvqiQcjuC5/JCdfTjGsoTto4Mh4+SqEtWgnAd3RdL8stSMRzlZvvP3vY
	 BffEYhI/sp+E0kUyc0qeCZICJ9hXChKrO5zoE4jbmdz/lQd22m8NQezk03G9wbzV3RRzm
	 kYzEBatHYu6poJ8iNr1pulW3Smvyl8E27aHw3bq/abSr+yh6N+m3m1yBWlXirVM54Z7xu
	 8j5F892zqGOgFRkv1RHUIKnHu6CEf6kpOdMoPmPXfO/AJqaOLCE8bldE/u9qXZ0lJzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209673;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=vG0WCZy3iE1+4XczqhoA7nnJoT9xeOvH5Oigf6iHqe8=;
	b=v81t+adMhO47hcQnwejvoV2ghx0cRRWwJurxUXyx0u75t5lOSA4eNxQxs7ouitdHfIke
	 CE59nUzmr8ZcAvvJG2s/mua1XEGdy9b5zw1gzLW9RHNaU903K+99rT4wKYBc+jzg0Sxt9
	 J8aEZ5jWfG1AUWdmKfuXUKCQMSbATtP6tc3ZVLiAe4mpx+NRfcvieFfWPGQGdw/VubDKE
	 f2UsnBDV7jI1vugb9365VGYThzBVEAnhag7gsoTeU6D1UVTEsii8q5ng7zOzDq6Z1Pz13
	 vGpxKP1XQST9vU8EkzMuykhrrGdi3ncc+0/6Z9EFPvLSAMnPfRYxaRengstIvWjUSCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6v5NU8e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089AD60A2634;
	Mon,  9 Nov 2026 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6v5NU8e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7311F0089F;
	Mon,  9 Nov 2026 07:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209672;
	bh=vG0WCZy3iE1+4XczqhoA7nnJoT9xeOvH5Oigf6iHqe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X6v5NU8e7hboZBFNVdkE+TCnE3/kJjqC+16mkWkg0Iz47daUPWcD+YSeDoAOenaXw
	 s+LmP7Owp9d/f/5//lNu99peSAtIOfWxtLtJyplCTYeOGfgOYmuBj2YDo5VSFtCBd6
	 5qwk4B0VmUNFI+FxJOz6c3l3X1s2/gMVumnA5Wj1ed1RHu0eWzZ4qP9Nlkex3I0OIQ
	 JFV5LzMnctyHjI6W2fXOCazR3j9DmULS4x3qHm4n6FJ3D71V0TBO9lGhyrmb3I900/
	 2K8qLMCG3124kkBYFbXRsJDA2VdfI8qfnRF8ny8gf0yF7axZiHABTSAxSWjlZqM8wm
	 mSFJF5wTe1Dlg==
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
Subject: [PATCH v2 10/19] net: phy: Use the compatibility driver attachment API
Date: Mon,  9 Nov 2026 09:33:40 +0200
Message-ID: <20261109-device-trust-core-v2-10-3b12d9a9f861@nvidia.com>
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

The generic PHY fallback probes directly before publishing its binding.
Device trust admission needs to precede that probe without changing the
caller's serialization.

Use device_driver_attach_full() and leave driver ownership cleanup to the
helper. Mark generic drivers during probe so failure and removal callbacks
observe the right state.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/phy/phy_device.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 5d4508bcfbe99..5f0ca981644ec 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1912,7 +1912,9 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	struct device *d = &phydev->mdio.dev;
 	struct module *ndev_owner = NULL;
 	struct module *drv_owner;
+	struct device_driver *drv;
 	int irq = phydev->irq;
+	bool bind_genphy;
 	int err;
 
 	/* For Ethernet device drivers that register their own MDIO bus, we
@@ -1939,16 +1941,16 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
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
@@ -1956,11 +1958,10 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	}
 	phydev->drv_owner = drv_owner;
 
-	if (phydev->is_genphy_driven) {
-		err = d->driver->probe(d);
-		if (err >= 0)
-			err = device_bind_driver(d);
-
+	if (bind_genphy) {
+		err = device_driver_attach_full(drv, d);
+		if (err == -EBUSY)
+			irq = phydev->irq;
 		if (err)
 			goto error_module_put;
 	}
@@ -2071,8 +2072,6 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	module_put(phydev->drv_owner);
 	phydev->drv_owner = NULL;
 	phydev->irq = irq;
-	phydev->is_genphy_driven = 0;
-	d->driver = NULL;
 error_put_device:
 	put_device(d);
 	if (ndev_owner != bus->owner)
@@ -3813,6 +3812,8 @@ static int phy_probe(struct device *dev)
 	int err = 0;
 
 	phydev->drv = phydrv;
+	phydev->is_genphy_driven = phydrv == &genphy_driver ||
+				 phydrv == &genphy_c45_driver;
 
 	/* Disable the interrupt if the PHY doesn't support it
 	 * but the interrupt is still a valid one
@@ -3949,6 +3950,7 @@ static int phy_probe(struct device *dev)
 out_reset:
 	/* Re-assert the reset signal on error */
 	phy_device_reset(phydev, 1);
+	phydev->is_genphy_driven = 0;
 
 	return err;
 }
@@ -3977,6 +3979,7 @@ static int phy_remove(struct device *dev)
 	phy_device_reset(phydev, 1);
 
 	phydev->drv = NULL;
+	phydev->is_genphy_driven = 0;
 
 	return 0;
 }

-- 
2.56.0

