Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600004;
	b=U5S3yHGbC+hiIX24j1ySqASfpDQ5R/9iqAg3yf+W2zbYIWj9J73t9rDm6I7qwCtf31x8
	 uqfKai6VGzSM06ETMf53Nq2xGYefW4aCpoTs4+YGgCE80oBVaOywDSIrm8emal5G7dSyE
	 J6w6L7AtZCqvjLw52ewUstZeDYJVz4d4gULBzl8vpp7UNcvzEi31gkyrxBLgFhW7iMlbI
	 Kev1D4UEPZSTJGTbPfn9tcRvw8i2p4RySedUH2dU15aGVUMHGbsVKJ1RVxKpxqrmSkFrU
	 90+/6KxhqYK0uX8xSADeqjYSlvbEuOdlj0qpHAbJF8ytrVXh+QXwq/OZlPn+E1tIXlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600004;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fmhwXq/f9JXdRGSNdyaOu0CVw2W4HpLV/7LXpNbJfGI=;
	b=soYgDUIfMmANzOJxZRq/E6VVjbBwfrJkJ054RaAP9T0zmoUihpjD4RPRNl9a872Eu5vY
	 JlS6KlXyWJbbdDe4BiLhUg8QwTCcvs7EmBcXB+HizEi7ciWEyV7/uy40oXbXSZth9os67
	 xiMQq+DyKW1l1dAhHpLXVf5HISZI8ASh8qWsRVUfyAzrnMuKe1V2CoHXrYcwsAPs0hDGU
	 yCCqoJ8DBD9f4PQU3M1N2ImoNjVLksrqPlQ6W6/VTCiXTuEheViz4nncH/8QX3WyegLgF
	 F6IHbjwX4tWj88HTb6S+F0KKKWjHIIbOcXWR3hevv/dEsJMRqjHEF4o1IOcu8TJe6CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfCNwtkI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A863606A323;
	Wed, 25 Nov 2026 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfCNwtkI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00191F000D0;
	Wed, 25 Nov 2026 09:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795600004;
	bh=fmhwXq/f9JXdRGSNdyaOu0CVw2W4HpLV/7LXpNbJfGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VfCNwtkIBneaCqK6xvyhxC0zm7HiySbIlZeIVfAg7dul0DDqMmneIvifka/IGyRnU
	 PE6ica0DftYcWRTFjuiIy4e6GYd6Nw4ZnlB7grgIFH+HQomGGOZfNbzRfl41EuSt28
	 3OaS/g/iJZxPAk0seLv8Rx4T0BPIFYHtfDI4QLZuTdeKkToEKhGCsTw/maXpqlrBgX
	 hdEoOXBsx3/YOQRP2ELljFO1Nni692kLsT7ErUjil1it415KIX1/Jx5KjA+dzIUTxl
	 Onc7+6UtjCWmBCKscVygGjyAJwAofoojUUu/czxDC4rO4U0TdGIBiLhVoplHZXg1mr
	 K+PcXJORWNnKA==
Message-ID: <sashiko-outbox-233056@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/33] net: phy: Use the compatibility driver
 attachment API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261124-device-trust-core-v4-19-037eb0d17b1f@nvidia.com>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-19-037eb0d17b1f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:46:43 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] net: phy: unsynchronized phydev->irq write on error in
  phy_attach_direct()
--

commit 165c70c3ab9d6261f753f16524c858fcd9ab84df
Author: Leon Romanovsky <leon@kernel.org>

net: phy: Use the compatibility driver attachment API

This commit switches the generic PHY fallback attachment in
phy_attach_direct() to use device_driver_attach_unrestricted() and moves
is_genphy_driven management into phy_probe() and phy_remove().

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 5d4508bcfbe99..4f20b451e270d 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
[ ... ]
> @@ -1912,6 +1911,8 @@ int phy_attach_direct(struct net_device *dev, struc=
t phy_device *phydev,
>  	struct device *d =3D &phydev->mdio.dev;
>  	struct module *ndev_owner =3D NULL;
>  	struct module *drv_owner;
> +	struct device_driver *drv;
> +	bool bind_genphy;
>  	int irq =3D phydev->irq;
>  	int err;
> =20
> @@ -1939,16 +1940,16 @@ int phy_attach_direct(struct net_device *dev, str=
uct phy_device *phydev,
>  	/* Assume that if there is no driver, that it doesn't
>  	 * exist, and we should use the genphy driver.
>  	 */
> -	if (!d->driver) {
> +	drv =3D d->driver;
> +	bind_genphy =3D !drv;
> +	if (bind_genphy) {
>  		if (phydev->is_c45)
> -			d->driver =3D &genphy_c45_driver.mdiodrv.driver;
> +			drv =3D &genphy_c45_driver.mdiodrv.driver;
>  		else
> -			d->driver =3D &genphy_driver.mdiodrv.driver;
> -
> -		phydev->is_genphy_driven =3D 1;
> +			drv =3D &genphy_driver.mdiodrv.driver;
>  	}
> =20
> -	drv_owner =3D d->driver->owner;
> +	drv_owner =3D drv->owner;
>  	if (!try_module_get(drv_owner)) {
>  		phydev_err(phydev, "failed to get the device driver module\n");
>  		err =3D -EIO;
> @@ -1956,11 +1957,8 @@ int phy_attach_direct(struct net_device *dev, stru=
ct phy_device *phydev,
>  	}
>  	phydev->drv_owner =3D drv_owner;
> =20
> -	if (phydev->is_genphy_driven) {
> -		err =3D d->driver->probe(d);
> -		if (err >=3D 0)
> -			err =3D device_bind_driver(d);
> -
> +	if (bind_genphy) {
> +		err =3D device_driver_attach_unrestricted(drv, d);
>  		if (err)
>  			goto error_module_put;
>  	}
> @@ -2071,8 +2069,6 @@ int phy_attach_direct(struct net_device *dev, struc=
t phy_device *phydev,
>  	module_put(phydev->drv_owner);
>  	phydev->drv_owner =3D NULL;
>  	phydev->irq =3D irq;
> -	phydev->is_genphy_driven =3D 0;
> -	d->driver =3D NULL;
>  error_put_device:
>  	put_device(d);
>  	if (ndev_owner !=3D bus->owner)

[Severity: Medium]
Can error_module_put overwrite phydev->irq after a concurrent driver probe?

While d->driver and phydev->is_genphy_driven are now cleaned up under
d->p->driver_lock, error_module_put still unconditionally restores the
saved phydev->irq outside d->p->driver_lock when
device_driver_attach_unrestricted() fails:

CPU0                                     CPU1
phy_attach_direct()
  irq =3D phydev->irq;
  drv =3D d->driver; (NULL)
                                         driver_probe_device()
                                           mutex_lock(&d->p->driver_lock)
                                           ...
                                           phy_probe()
                                             phydev->irq =3D PHY_POLL;
  device_driver_attach_unrestricted()
    mutex_trylock(&d->p->driver_lock)
    -> returns -EBUSY
  goto error_module_put;
  phydev->irq =3D irq;  <-- clobbers PHY_POLL

If the bound PHY driver does not support interrupts and phy_probe() forced
phydev->irq to PHY_POLL, restoring the raw IRQ number leaves the bound
driver with an unsupported interrupt configuration.  The same race exists
if genphy's phy_probe() fails inside device_driver_attach_unrestricted()
and another driver probes after d->p->driver_lock is released.

Restoring phydev->irq inside phy_probe()'s error path (while holding
d->p->driver_lock) instead of at error_module_put would avoid touching
phydev->irq when driver_lock is not held.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-device-tru=
st-core-v4-0-037eb0d17b1f@nvidia.com?part=3D19
