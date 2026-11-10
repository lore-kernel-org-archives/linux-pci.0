Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296120;
	b=EK9YOIcOjanYP8Om6OSYBebciOgUS9gsGrRte+6PWbkJ2Cr0FPtyUbDRgv+riE3yzv1z
	 EGVjLB7j+76Hgg4qumeWzK8PRkyqUt9Wuff5zjMzOQRwzHleJsi/grqtm9E7neIN95Emp
	 nXuiX/7NJoBZTBlAqdgeoqM1iYSl4sKTKZlfARGzwh0x1MRm+guFS5hAZ7R03cLPodISt
	 nfCMU4XhgGHOldX7zHsVIqOaD1P6T3B9uyKctwU/OX/SvxzOmnpCQej/hQ8luDO7ovPeO
	 v9vIk5S3O5DrVq0KMqKQ1KdXa8zEaHhsAhNXhEQdrgx1liYhKtVFBSLvkFXrbIqPs0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296120;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XzYQ2P2qESFquLsq+VAwcCYsFqoXagWZzEGdZMaZt+Y=;
	b=Dopur9KCixPD07Ypimxm8ycSRRSva3YlUz8i5dQOw32fI3UCuWzp/QC0G68F5WsNJY2F
	 xUBQLPU8lHzMewFu6ODTLft8ZUqT8qC8ri6MuhHZ88L6BBl57ADGoqKF81FPeqFg+gL5X
	 SXc1y4LgtdPjWqrX8OTibeKZ16vW7CLrqqDGQPAReNqJrB01ArDnDIqrUf9pYVgmCXgTj
	 O9/V4DEuX4XmZkxlEqTlR7lT0bcxSgkxjd+bXg8bo/z/NnC1HT3JgXCJlVUzphxugtAox
	 3eZLIYzSYIPeaeo65YNFv3WTsEjQi/KjKMbrJrqmrF0Kc+1j1oQvC2r8ArzigC8JCow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abk7kMV0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4888F60A3803;
	Tue, 10 Nov 2026 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abk7kMV0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9646A1F0089F;
	Tue, 10 Nov 2026 07:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296119;
	bh=XzYQ2P2qESFquLsq+VAwcCYsFqoXagWZzEGdZMaZt+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=abk7kMV0D0wtpjoM7OSKUrLf555j1qiZh/TAqEqq01hG498b6UOcedjLXkeRw1CYp
	 5V76V0Lx3aiGNQFMWRwUybWZHdm/Hq4Z3c5dm3k2PZVHWYY91DfBA4zF2wxDqteEkc
	 YTlxMjByoPwwNMoTWUX30sXUuVpsydiIWXbpJjuBI69L1FcGTBEmiM6kBN2SStQ7YB
	 +3kKhKSgVMNkICM2N+YYc9yjhvRPiqwDkNGzUUBfHL0LZLOzpR6JhupoYwht2dkySH
	 1OCCH4i2lzoVyaPPO9qlsMQ2uLkts4MrnDLzbDsZh5es5T+BHo6toOV0BLUDvv2MpY
	 AdgIaL1DpvAbQ==
Message-ID: <sashiko-outbox-206510@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/19] net: phy: Use the compatibility driver
 attachment API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109-device-trust-core-v2-10-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-10-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:19 +0000
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
- [Medium] net: phy: loss of phydev->irq in phy_attach_direct() on
  -EBUSY probe failure
--

commit 89d719155ade2a67c02be5cec992ec1828452066
Author: Leon Romanovsky <leon@kernel.org>

net: phy: Use the compatibility driver attachment API

This commit switches generic PHY driver attachment in phy_attach_direct()
to device_driver_attach_full() and updates phy_probe() and phy_remove() to
manage phydev->is_genphy_driven.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 5d4508bcfbe99..5f0ca981644ec 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1912,7 +1912,9 @@ int phy_attach_direct(struct net_device *dev, struc=
t phy_device *phydev,
>  	struct device *d =3D &phydev->mdio.dev;
>  	struct module *ndev_owner =3D NULL;
>  	struct module *drv_owner;
> +	struct device_driver *drv;
>  	int irq =3D phydev->irq;
> +	bool bind_genphy;
>  	int err;
> =20
>  	/* For Ethernet device drivers that register their own MDIO bus, we
> @@ -1939,16 +1941,16 @@ int phy_attach_direct(struct net_device *dev, str=
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
> @@ -1956,11 +1958,10 @@ int phy_attach_direct(struct net_device *dev, str=
uct phy_device *phydev,
>  	}
>  	phydev->drv_owner =3D drv_owner;
> =20
> -	if (phydev->is_genphy_driven) {
> -		err =3D d->driver->probe(d);
> -		if (err >=3D 0)
> -			err =3D device_bind_driver(d);
> -
> +	if (bind_genphy) {
> +		err =3D device_driver_attach_full(drv, d);
> +		if (err =3D=3D -EBUSY)
> +			irq =3D phydev->irq;
>  		if (err)
>  			goto error_module_put;
>  	}

[Severity: Medium]
Can this overwrite the saved irq with PHY_POLL when phy_probe() fails with
-EBUSY?

At the start of phy_probe(), !phy_drv_supports_irq(phydrv) sets phydev->irq
to PHY_POLL for the generic PHY drivers.  If a later step in phy_probe()
returns -EBUSY (for example via phy_setup_ports() -> of_phy_ports() ->
phy_add_port(), or an MDIO bus read returning -EBUSY),
device_driver_attach_full() propagates -EBUSY after unbinding the driver.
Overwriting irq =3D phydev->irq on -EBUSY then causes the error_module_put
path to write PHY_POLL back to phydev->irq instead of restoring the
original interrupt number, leaving the PHY in polling mode on subsequent
attachments.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D10
