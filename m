Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296115;
	b=X6pZvGYEiY8ETfMMEP7kSquUpEgSw6Wzj4if9lTLoT9n+7M0/7V/2DgtI97S/QllfNmf
	 hytiNMxABhb+GfdHA5AKkvwBKWkSy7f8jpB+2Ap8ON8QQsUbDg1vrN3kWOlnerdXvDplF
	 MvLWrItzEGn1tFA+ZT7jQEjEmjBEv/lUQho9kGr6LiejWSSN6BemuKtracDpHfJop2dd6
	 TgTQWHHxUQNtVnkYHqRvxotznbVlZU72Gg52/YnvtXiNVLEJpPMkXorzVrdxh7aqe2dez
	 PXYyJ6xuuGZQvXsZonOnTCBx7V6q30PLn80OjKzvihtsxfdD0d0ryGRgN6oQ/gUuFfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296115;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=weUd2KkK+Td2wOHM6SUBvzIuwXjKcDMMXmQN7dO05+8=;
	b=0M9XTedzN2zQ+R8T4De19mhCBnmzmVaFvghy7BXSnixwQOK8cmm5U+UwZ+rTP3MtnSbX
	 dPtF/H8lx/cYjVADjQR5ICuEjonh34PAFuAbjcodRBHxcJi3lY1v5N4T36ygEIk7ubi72
	 7hndM/x3LlWNggPZmgZ+FSSCNvWk/6b/Ef8aOhpQATsMCWBAHg8w8cKAp/RNuis3qn4vW
	 r+RbBsULCeJOkv2NMnFrYHadeoKKYZxVnjewKGSY1dWdpf/MBbRkHqoJtKa9pW7j06N5A
	 yP6nrG6CH3Nk/jKBBQqQkxBZ8t34MrAmXwCN/EIpwkCNQyGlzrOCf2iD+iii3tC/6aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rm6h1j0q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C477260A2601;
	Tue, 10 Nov 2026 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rm6h1j0q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BB71F008A2;
	Tue, 10 Nov 2026 07:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296114;
	bh=weUd2KkK+Td2wOHM6SUBvzIuwXjKcDMMXmQN7dO05+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rm6h1j0qYePgp6t4TbvQng9CM5UmW7/ujSZFHgUIF2JIUEV4PgE272SCZmuJ5G015
	 Pgz/NmyzccX2Oi5Mqo0fXNWsyI4sI8QUWFx+fFnYrvU3bD8yWwqweE7vMD56jF3QrF
	 H5Y/agnCrpc2CJupo5QWhtmwYBhh6L4zBijBHOiKeyhsopWmR/vmLr4lay7aSo+YQf
	 ynEZvjAaK1lLPZeIfRMC5lAoCqEB8SN8lIYU10XOK1JCYe9uhIxQiIB8cbugDfaz57
	 7EPnl2Ez8eudjZaFuj3uHdqkHiLGgLXff+3/8ZV0MgvGNYPYrxbNxoa6O/eRE7nvIz
	 EZtGd3U7xQ6Lw==
Message-ID: <sashiko-outbox-206503@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/19] USB: Lock registered interfaces during manual
 driver binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109-device-trust-core-v2-3-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-3-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:13 +0000
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
- [High] usb: core: unlocked dev->driver updates in
  usb_driver_claim_interface()
--

commit aa47d25b59fe6dc15ab05e899c754ff4b6a72894
Author: Leon Romanovsky <leon@kernel.org>

USB: Lock registered interfaces during manual driver binding

This commit locks registered USB interfaces around device_bind_driver() in
usb_driver_claim_interface() and updates btusb_mtk_claim_iso_intf() to acqu=
ire
the USB device lock instead of the target interface lock.

> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index d3a61ebc6afb0..ad5d9d5fc7598 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -584,8 +584,11 @@ int usb_driver_claim_interface(struct usb_driver *dr=
iver,
>  	/* if interface was already added, bind now; else let
>  	 * the future device_add() bind it, bypassing probe()
>  	 */
> -	if (device_is_registered(dev))
> +	if (device_is_registered(dev)) {
> +		device_lock(dev);
>  		retval =3D device_bind_driver(dev);
> +		device_unlock(dev);
> +	}
> =20
>  	if (retval) {
>  		dev->driver =3D NULL;

[Severity: High]
Does taking device_lock(dev) only around device_bind_driver() leave
dev->driver and the interface binding state unprotected on a registered
interface?

Callers of usb_driver_claim_interface() hold the parent USB device lock, not
the target interface lock.  When device_is_registered(dev) is true,
usb_driver_claim_interface() checks dev->driver and iface->authorized and
writes dev->driver, intfdata, iface->needs_binding, and iface->condition
before acquiring device_lock(dev), and rolls them back after releasing
device_unlock(dev) if device_bind_driver() fails.

Readers that synchronize using only the interface lock, such as
supports_autosuspend_show(), can race with the unlocked rollback and
dereference a NULL dev->driver:

drivers/usb/core/sysfs.c:supports_autosuspend_show() {
	s =3D device_lock_interruptible(dev);
	if (s < 0)
		return -EINTR;
	/* Devices will be autosuspended even when an interface isn't claimed */
	s =3D (!dev->driver || to_usb_driver(dev->driver)->supports_autosuspend);
	device_unlock(dev);
}

CPU0                                  CPU1
usb_driver_claim_interface()
  dev->driver =3D &driver->driver
  device_lock(dev)
  device_bind_driver(dev) -> fails
  device_unlock(dev)
                                      supports_autosuspend_show()
                                        device_lock_interruptible(dev)
                                        !dev->driver (false)
  dev->driver =3D NULL
                                        to_usb_driver(dev->driver)
                                          ->supports_autosuspend
                                          <-- NULL pointer dereference

Setting dev->driver outside device_lock(dev) also allows
device_trust_set_policy() and usb_authorize_interface() to observe a
transient non-NULL dev->driver before admission completes or after it fails,
races with __driver_attach() checking !dev->driver under device_lock(dev),
and modifies struct usb_interface bitfields (needs_binding,
needs_remote_wakeup) without serializing against iface->authorized updates.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D3
