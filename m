Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965420;
	b=suM3J8lmT6YjeHTxH28oj15gVmdvFIvv+SGKiupA0V/NN0An62YNZhIVJnmYvkLdfPHB
	 +hVoURNBkDa1UPlITQ+zExy3dhXIX7lfJgKDMvgw/QR+67UzPbKMNLB9gvXYT6fZyfHri
	 jB8b0d8a+iuXyVmj7mRL/6mYCK3qib6oVET5K0ifKXDrQ+tE9nIiwtK7memfNYB8nq37f
	 l2YmXVXspTqtQNVxohbYbZEPp5LChq+Demf5lErggyO68ol4JavekrVrQe7oa9D8GQFjb
	 ghAAW3qBzlPgYh5Gnv0qbEnzATS9xH8DffsebXVIsgh537AHc+FOh5qxQZsjX5zkJKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965420;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZKH8wWMW7zIzX4zFr56DLMh6DAtpnwAJ45KtfWhxc8o=;
	b=A8m0+gKr0rcYQzfOdvbFyEbN/4p5mDsEHkS6gBVz+Om3ng7zgJ3uliBat1RYQipHvNKR
	 Mw7QhmhOFDblLsShM2OhgTGAc9VTwn8lVYi8Dmn1Kn6qRN+Wbngr9+ls464uKGdBVbYpu
	 o6HZbdYo7mWA0U0tt43JEqpkJq48WJH7KlkHNHqqCYzcgj/POPw/pIIFmseU2NP1Jzwdp
	 4i6Ie9stRpQmujAV3B8SQapEw2SmWk6mZFi406JnMnk5URsgm6ptmkAg2EQ+tgMHXb1Px
	 q/lE8rzz7UVVoCxGhu6QyO7WM+yNnbEInQT1xQB7vCm9dbBS5VK06AZ3aPH5muLFCXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TRfK4RKe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A432606C7EF;
	Fri,  6 Nov 2026 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TRfK4RKe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13511F008A1;
	Fri,  6 Nov 2026 11:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965420;
	bh=ZKH8wWMW7zIzX4zFr56DLMh6DAtpnwAJ45KtfWhxc8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TRfK4RKent/43BxbnG/cEaCZzxA6sEUQjK/xaAWesCWAWrjkr/JdTT0ZN/t8Ubfbg
	 a+mxV37rhwaOZTzW+3fZ8js0Upu4Zjrz6LhHosMPYEyN8Quvemv9Y9UDuTGqMMjY5y
	 U8UecOWO8wughqCyUK0Prbu5LSyLjiencqOwVpirJnZu1iYIyTxIrx1DE3FQ8yoTYO
	 2TtSCZhWm3XOF9JKxNsvcXwPkZpFxH30/HXm7YLrBY6zNDol8ZIEgzOJdsMcWKxKcU
	 Wyv+Npeqwk6GFxxhLmJ31HvxtT5mra2zFvsQt4pljawXPT6D03jFYI0FtKLPqzQTbD
	 aWlkPfpe3kTBQ==
Message-ID: <sashiko-outbox-201336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/17] net: phy: Attach generic PHY drivers through the
 driver core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261105-device-trust-core-v1-3-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-3-1e536825b4eb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:43:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] net: phy: -EBUSY conflation and phydev->irq race in
  phy_attach_direct()
- [High] net: phy: unlocked d->driver check in phy_attach_direct()
  bypasses trylock
- [High] net: phy: pinctrl_bind_pins() fails with -EINVAL on fixed-link
  PHYs
- [Medium] net: phy: phy_attach_direct() leaks -EPROBE_DEFER to
  non-probe callers
--

commit 041c1bf498be3c0bd71084280b91acccb80528b3
Author: Leon Romanovsky <leon@kernel.org>

net: phy: Attach generic PHY drivers through the driver core

This commit introduces device_driver_try_attach() in the driver core and
updates phy_attach_direct() to attach the generic PHY fallback drivers
through the driver core rather than calling probe() and device_bind_driver()
directly.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 5d4508bcfbe99..8cc0de755bd08 100644
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

[Severity: High]
Does checking d->driver without holding device_lock(d) or checking
device_is_bound(d) bypass device_driver_try_attach() when a specific PHY
driver is concurrently probing?

In drivers/base/dd.c, really_probe() sets dev->driver at the very start of
probing via device_set_driver(), before running pinctrl_bind_pins(),
driver_sysfs_add(), and call_driver_probe() -> phy_probe():

drivers/base/dd.c:really_probe() {
    re_probe:
        device_set_driver(dev, drv);

        /* If using pinctrl, bind pins now before probing */
        ret =3D pinctrl_bind_pins(dev);
        ...
        ret =3D call_driver_probe(dev, drv);
}

Because d->driver is already non-NULL throughout the entire execution of
really_probe() and phy_probe() (including when phy_probe() ->
phy_setup_ports() -> phy_sfp_add_upstream() -> sfp_bus_add_upstream()
blocks waiting for RTNL with device_lock(d) held), a concurrent call to
phy_attach_direct() under RTNL sees drv !=3D NULL, sets bind_genphy to fals=
e,
and skips device_driver_try_attach() altogether.

When that happens, phy_attach_direct() races with the in-progress probe (or
an in-progress unbind in __device_release_driver()):

1. If the concurrent thread is in really_probe() after device_set_driver()
   but before phy_probe() assigns phydev->drv =3D phydrv, or in
   __device_release_driver() after phy_remove() clears phydev->drv =3D NULL
   before device_unbind_cleanup() clears d->driver, phy_attach_direct()
   passes a NULL phydev->drv to phy_drv_supports_irq(phydev->drv) and
   dereferences NULL.

2. If phy_probe() is blocked waiting for RTNL in sfp_bus_add_upstream(),
   phy_attach_direct() runs phy_init_hw() and phy_resume() on a half-probed
   PHY before phy_probe() has finished setting up SFP ports,
   phy_advertise_supported(), EEE, pause bits, LEDs, or phydev->state =3D
   PHY_READY. Once RTNL is released, phy_probe() overwrites
   phydev->advertising and resets phydev->state to PHY_READY.

3. If the concurrent really_probe() or phy_probe() later fails, it asserts
   hardware reset via phy_device_reset(phydev, 1) and runs
   device_unbind_cleanup() -> devres_release_all(), freeing devm-allocated
   phydev->priv while the net_device remains attached to phydev.

Conversely, if d->driver is NULL when read into drv, and a concurrent
specific-driver probe finishes and releases device_lock(d) before
device_driver_try_attach(drv, d) runs, __driver_probe_device() sees
dev->driver !=3D NULL and returns -EBUSY, causing phy_attach_direct() to fa=
il
with -EPROBE_DEFER instead of using the newly bound specific driver.

> =20
> -	drv_owner =3D d->driver->owner;
> +	drv_owner =3D drv->owner;
>  	if (!try_module_get(drv_owner)) {
>  		phydev_err(phydev, "failed to get the device driver module\n");
>  		err =3D -EIO;
> @@ -1956,11 +1958,20 @@ int phy_attach_direct(struct net_device *dev, str=
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
> +		/*
> +		 * RTNL is held, and a concurrent bind of a specific driver may
> +		 * wait for it with the device lock held. Never wait for that
> +		 * lock, and let the caller retry.
> +		 */
> +		err =3D device_driver_try_attach(drv, d);

[Severity: High]
What happens on Device Tree platforms with fixed-link PHYs when
device_driver_try_attach() routes generic PHY attachment through
really_probe() -> pinctrl_bind_pins()?

When a MAC driver registers a fixed-link PHY via
of_phy_register_fixed_link(np) or of_phy_get_and_connect(),
fixed_phy_register() in drivers/net/phy/fixed_phy.c assigns the MAC
controller's DT node to phy->mdio.dev.of_node without setting
dev_set_of_node_reused(&phy->mdio.dev):

drivers/net/phy/fixed_phy.c:fixed_phy_register() {
    of_node_get(np);
    phy->mdio.dev.of_node =3D np;
    phy->is_pseudo_fixed_link =3D true;
}

Because a fixed PHY has phy_id =3D=3D 0, it does not match any driver during
phy_device_register() and always attaches to genphy_driver in
phy_attach_direct(). Previously, phy_attach_direct() called
d->driver->probe(d) and device_bind_driver(d), bypassing really_probe() and
pinctrl_bind_pins().

With device_driver_try_attach() calling __driver_probe_device() ->
really_probe() -> pinctrl_bind_pins(d), dev_of_node_reused(d) is false in
drivers/base/pinctrl.c:pinctrl_bind_pins(), so pinctrl attempts to claim the
MAC's pinctrl-0 pins a second time under the fixed PHY device. When the MAC
device has already claimed its pins, pin_request() in
drivers/pinctrl/pinmux.c rejects the duplicate mux claim with -EINVAL, which
pinctrl_bind_pins() propagates, causing phy_attach_direct() to fail with
-EINVAL on fixed-link interfaces whose MAC node defines pinctrl-0.

> +		if (err =3D=3D -EBUSY) {
> +			/* Another bind owns the PHY, so nothing was probed here. */
> +			irq =3D phydev->irq;
> +			err =3D -EPROBE_DEFER;
> +		} else if (err =3D=3D -EAGAIN) {
> +			err =3D -EPROBE_DEFER;
> +		}
>  		if (err)
>  			goto error_module_put;
>  	}

[Severity: Medium]
Can returning -EPROBE_DEFER from phy_attach_direct() leak to userspace or
cause permanent probe failures for callers that do not handle deferral?

Most Ethernet drivers that call phy_attach_direct() with RTNL held (via
phylink_of_phy_connect(), phylink_fwnode_phy_connect(),
phylink_connect_phy(), phy_connect(), or phy_connect_direct()) do so from
their net_device_ops->ndo_open() callback during __dev_open() (triggered by
SIOCSIFFLAGS or RTM_NEWLINK), rather than from a driver-core probe callback.
__dev_open() does not retry on -EPROBE_DEFER; it aborts opening the interfa=
ce
and returns -EPROBE_DEFER (-517) directly to userspace.

Additionally, drivers that attach PHYs during .probe() via of_phy_connect()
in drivers/net/mdio/of_mdio.c only receive NULL when phy_connect_direct()
returns an error, losing the -EPROBE_DEFER errno. And because
__device_driver_attach() calls __driver_probe_device() instead of
driver_probe_device(), a supplier deferral (-EPROBE_DEFER converted to
-EAGAIN) does not add &phydev->mdio.dev to deferred_probe_pending_list.

> @@ -2071,8 +2082,6 @@ int phy_attach_direct(struct net_device *dev, struc=
t phy_device *phydev,
>  	module_put(phydev->drv_owner);
>  	phydev->drv_owner =3D NULL;
>  	phydev->irq =3D irq;

[Severity: High]
Could conflating all -EBUSY returns from device_driver_try_attach() with
lock contention corrupt phydev->irq in phy_attach_direct()?

In drivers/base/dd.c, __device_driver_attach() can return -EBUSY in four
different cases, not only when __device_driver_trylock() fails before
probing (which also makes the kernel-doc comment on
device_driver_try_attach() inaccurate):

1. __device_driver_trylock() fails because device_lock(dev) or
   device_lock(dev->parent) is contended.
2. __driver_probe_device() returns -EBUSY because dev->driver is already
   set.
3. really_probe() fails with -EBUSY when !list_empty(&dev->devres_head).
4. call_driver_probe() -> phy_probe() fails with -EBUSY (for example,
   phy_setup_ports() -> of_phy_ports() -> phy_add_port() returning -EBUSY,
   or an MDIO read in genphy_read_abilities(),
   genphy_c45_pma_read_abilities(), or genphy_c45_read_eee_adv() returning
   -EBUSY), because really_probe() negates negative probe errors to +EBUSY
   and __device_driver_attach() negates ret > 0 back to -EBUSY:

drivers/base/dd.c:__device_driver_attach() {
    ret =3D __driver_probe_device(drv, dev);
    __device_driver_unlock(dev, dev->parent);

    /* also return probe errors as normal negative errnos */
    if (ret > 0)
        ret =3D -ret;
}

When phy_probe() runs for genphy_driver or genphy_c45_driver and then fails
with -EBUSY, phy_probe() has already overwritten phydev->irq with PHY_POLL:

drivers/net/phy/phy_device.c:phy_probe() {
    if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
        phydev->irq =3D PHY_POLL;
}

In phy_attach_direct(), the err =3D=3D -EBUSY branch assumes nothing was pr=
obed,
reads irq =3D phydev->irq (which is now PHY_POLL), converts the error to
-EPROBE_DEFER, and writes phydev->irq =3D irq (PHY_POLL) at error_module_pu=
t,
permanently losing the PHY's original hardware interrupt number.

Conversely, when device_driver_try_attach() returns -EBUSY because another
thread holds device_lock(d) inside phy_probe(), phy_attach_direct() reads
irq =3D phydev->irq and writes phydev->irq =3D irq at error_module_put with=
out
holding device_lock(d). If irq =3D phydev->irq is read before the concurrent
phy_probe() sets phydev->irq =3D PHY_POLL, and phydev->irq =3D irq is writt=
en at
error_module_put after phy_probe() sets PHY_POLL, phy_attach_direct()
overwrites the concurrent driver's PHY_POLL setting with the stale IRQ
number. Similarly, if device_driver_try_attach() fails with -EAGAIN before
phy_probe() runs, error_module_put writes phydev->irq =3D irq after
__device_driver_unlock() has already released device_lock(d).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D3
