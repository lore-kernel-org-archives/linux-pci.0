Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629892;
	b=zfGLYNljwv2TXDqT3lMS+T66IehUdex1YOWB7QJWkXsz07WHOg23/JOP3XYobg0aFIJ4
	 KzrvZw9zCTI4PwTegOkUt149kcjNpVAqMUlocdnGtP3+oTR/KPbSEH4A6RhgdSb1DtFsc
	 LCTFgCKtKfiT4eO+x2PYz76lHUqZqx9i8Dq/jwD0yE26W8thX2fpq5mM6+cx1Ybxjsb+q
	 T+ElLmBuYwQOqEAXG0pLmcgSiMA90tX6SzvWEbyy/OuSFgPylpTzjeirJnPxX68iwuB6G
	 RsbASMnri+IwuZJkh8ZsmUpAYK0C8DZFfCgkIlusRqBhcfb1rHyWrO996/BWtUT+aWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629892;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+FVqL9ntFrkIeDACgdbPrlQAjg1IHC9YGpnQbHm+hC0=;
	b=eEBryh4aoWRqXJzKIGFtKYYJc3ztzdYsMSrVo1+7E7XdPejKAd/rzJvPWqNmPA7xnbYs
	 26PJpQ2ya+XZoybD9TImqE8RDvTumY0iTybwqavfUXu1i9t4ZwQM/GhiQFT4sekmggp4B
	 Aptyz8aIRIgZ1UBAiNpedm6tNUTWXKjRSCi+hN0bVZBH2IcJuFNyjDB0xOCAYxihWPT3V
	 bVrY4O4z7q2dfFh6t2MzmPe6Wsc9YYKm3f171O+Y9XZFQDqxgXW0s6TQiqujZG/03fh6p
	 LtTHnap3wzatu849F8lqOF0cAs0Yl0bD26LcHYukYuYatDM+Wf1K2YuDKqVU6K7jWlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Mtx/B528";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89008606A31E;
	Wed, 25 Nov 2026 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mtx/B528
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9C41F000C6;
	Wed, 25 Nov 2026 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629892;
	bh=+FVqL9ntFrkIeDACgdbPrlQAjg1IHC9YGpnQbHm+hC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mtx/B5280bzuMoP3qJtbs2zGWXJHwkGtJ9Fb5L7cOb4oiEOvjVxiEROGKIX9GVhLF
	 5hNN5Gp4o2liNBhXPOZvPTXUlawIfk2daOweej/ChCSti0t+/MjEtGsC0r0FUOmmd3
	 m1RdnfbWGlqZWIktar5Uc+Mg83aWydWTp94rCKNaCXPXvCPMYnZ565w6e/klYS9oVx
	 vQPPe+hTP8RuBVDcT3kPV7i2N69BZyXK+OgdsEL7UtGJSIe9qkx8Xi06+pJ2RaAln8
	 otzGXANamfK4TUH5WS23meT3spAfKQmBfAcAH3NTCWy8bnLz9HfhVhE/+0q0PCZkCf
	 0dza9LlC10z1A==
Date: Wed, 25 Nov 2026 20:04:48 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v4 19/33] net: phy: Use the compatibility driver
 attachment API
Message-ID: <20261125180448.GF14811@unreal>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-19-037eb0d17b1f@nvidia.com>
 <sashiko-outbox-233056@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-233056@kernel.org>

On Wed, Nov 25, 2026 at 09:46:43AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] net: phy: unsynchronized phydev->irq write on error in
>   phy_attach_direct()
> --
> 
> commit 165c70c3ab9d6261f753f16524c858fcd9ab84df
> Author: Leon Romanovsky <leon@kernel.org>
> 
> net: phy: Use the compatibility driver attachment API
> 
> This commit switches the generic PHY fallback attachment in
> phy_attach_direct() to use device_driver_attach_unrestricted() and moves
> is_genphy_driven management into phy_probe() and phy_remove().
> 
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index 5d4508bcfbe99..4f20b451e270d 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> [ ... ]
> > @@ -1912,6 +1911,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
> >  	struct device *d = &phydev->mdio.dev;
> >  	struct module *ndev_owner = NULL;
> >  	struct module *drv_owner;
> > +	struct device_driver *drv;
> > +	bool bind_genphy;
> >  	int irq = phydev->irq;
> >  	int err;
> >  
> > @@ -1939,16 +1940,16 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
> >  	/* Assume that if there is no driver, that it doesn't
> >  	 * exist, and we should use the genphy driver.
> >  	 */
> > -	if (!d->driver) {
> > +	drv = d->driver;
> > +	bind_genphy = !drv;
> > +	if (bind_genphy) {
> >  		if (phydev->is_c45)
> > -			d->driver = &genphy_c45_driver.mdiodrv.driver;
> > +			drv = &genphy_c45_driver.mdiodrv.driver;
> >  		else
> > -			d->driver = &genphy_driver.mdiodrv.driver;
> > -
> > -		phydev->is_genphy_driven = 1;
> > +			drv = &genphy_driver.mdiodrv.driver;
> >  	}
> >  
> > -	drv_owner = d->driver->owner;
> > +	drv_owner = drv->owner;
> >  	if (!try_module_get(drv_owner)) {
> >  		phydev_err(phydev, "failed to get the device driver module\n");
> >  		err = -EIO;
> > @@ -1956,11 +1957,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
> >  	}
> >  	phydev->drv_owner = drv_owner;
> >  
> > -	if (phydev->is_genphy_driven) {
> > -		err = d->driver->probe(d);
> > -		if (err >= 0)
> > -			err = device_bind_driver(d);
> > -
> > +	if (bind_genphy) {
> > +		err = device_driver_attach_unrestricted(drv, d);
> >  		if (err)
> >  			goto error_module_put;
> >  	}
> > @@ -2071,8 +2069,6 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
> >  	module_put(phydev->drv_owner);
> >  	phydev->drv_owner = NULL;
> >  	phydev->irq = irq;
> > -	phydev->is_genphy_driven = 0;
> > -	d->driver = NULL;
> >  error_put_device:
> >  	put_device(d);
> >  	if (ndev_owner != bus->owner)
> 
> [Severity: Medium]
> Can error_module_put overwrite phydev->irq after a concurrent driver probe?

Andrew already explained it in v2 that it is not possible.

Thanks
