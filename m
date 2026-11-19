Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116566;
	b=TwW2iLJlLry6ohwhJkl3EDu5sGoPfOhprKSaqA7b+0OI4hd5Qnd/I7mKZtrvmAn7/ALd
	 FSjpgiG6mDq4J22WUgMVuN0f28JF6WyXuSOXFDc6VXT512F8roqEhpASmmo73onpYyqjT
	 pHBfCzbokO0mM3/QHW+39fzm7e+0uk4QY1qrhUhzIQci48ihmwV/gCwDwcqh8SLTjYZ3R
	 drDUM9RzcFLS6kDND7+r/CqEd1DJkVaL2NiZXL0EsRDcMGgRN+UC/1OighSiC5QBcYm+f
	 cx2s1w7j8bGnn7OWv/3+mRxrbFvhhuWSzUDxIFpSmWED514gMPfnUW8GQyI11oQq2YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116566;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bSFIjcou7q/5pluyfRNFytgr8faDH7vbFq3ncru7Ndk=;
	b=W86hTjEXBBRyGSY2rk/mNVLo5GDncogO9M2umGzafNxQ/lj6dPTOXqLIvMDR6kqRidDn
	 LrySQIBxE2NddqCaqNVdVuO39DHolZO180zFnXC9nPpAFMS8oNfAxnjxVwqw++Pik9q7I
	 7bPWQajdwteRXjIyW93SW+zrd4qRHnQObVeD9NaJNzO5HgqCkJLOyV7IHGck59a/JLO/x
	 V9erdXU2SHjCtoEoOykmAXxZSAdHxhF989gIfMPDl0l8oaasljUJSiS6/d1XdXHi9K8EJ
	 +lP4EBkXySn5m/JHb1Rk7G9XEmpjeIJ4N3vyX3TXZLkKybDPJTcyS0FsOkGqlxiDx1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXkq2E+Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B31606A334;
	Thu, 19 Nov 2026 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXkq2E+Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682C71F000C5;
	Thu, 19 Nov 2026 19:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116565;
	bh=bSFIjcou7q/5pluyfRNFytgr8faDH7vbFq3ncru7Ndk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YXkq2E+YcJWSSARzeI9915RltHnRALKDiCObhu+j7gXZqroLXQVfIBr8nS7+jUmsR
	 XvTMXqGO1XyajFleZiBRt7jrukHm4fOqG2wqpc7d9m7diF/cmSSbGrOlEyPSGsc4Dg
	 R8q+IoiHbKcKCLrT15DyPA0LRbJ1+F0HIDgAhn+xrVo+E7Xw+yn8qzmcCRbeHcRoTr
	 zJFHkzcQNi2/K5SwDbY5OpsDjG2LHickIUN1nc4g6dHZus0TnVDHVNIsPDSYyRo7MF
	 0kFGzzFzSRj0k6wxRf3mdmsnibNV0K2+GBLGsaBPrFYZmmGw2OhU4l0is0Z8/TIm1Z
	 25BMT4hPUMW2A==
Message-ID: <sashiko-outbox-223892@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/31] USB: Release interface claims according to
 binding state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118-device-trust-core-v3-6-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-6-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] usb: core: pre-claimed interface with autoprobe off crashes
  on core unbind
- [Medium] usb: core: NULL dereference in usb_driver_release_interface()
  when driver is NULL
--

commit 03347cb54cf6030265378e68aba157a23982255b
Author: Leon Romanovsky <leon@kernel.org>

USB: Release interface claims according to binding state

This commit updates usb_driver_release_interface() to check
device_is_bound() instead of device_is_registered() before releasing an
interface through the driver core, and holds the device lock while
checking and unbinding unclaimed interfaces.

> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index 735ae3310b45d..926f63cd2c834 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -612,6 +612,15 @@ int usb_driver_claim_interface(struct usb_driver *dr=
iver,
>  }
>  EXPORT_SYMBOL_GPL(usb_driver_claim_interface);
> =20
> +static void usb_unbind_claim(struct usb_interface *iface)
> +{
> +	struct device *dev =3D &iface->dev;
> +
> +	usb_unbind_interface(dev);
> +	dev_set_drvdata(dev, NULL);
> +	dev->driver =3D NULL;
> +}
> +
>  /**
>   * usb_driver_release_interface - unbind a driver from an interface
>   * @driver: the driver to be unbound
> @@ -631,27 +640,25 @@ void usb_driver_release_interface(struct usb_driver=
 *driver,
>  {
>  	struct device *dev =3D &iface->dev;
> =20
> -	/* this should never happen, don't release something that's not ours */
> -	if (!dev->driver || dev->driver !=3D &driver->driver)
> -		return;
> -
> -	/* don't release from within disconnect() */
> +	/* Avoid recursive locking from disconnect(). */
>  	if (iface->condition !=3D USB_INTERFACE_BOUND)
>  		return;
> +
> +	device_lock(dev);
> +	if (dev->driver !=3D &driver->driver ||
> +	    iface->condition !=3D USB_INTERFACE_BOUND)
> +		goto unlock;

[Severity: Medium]
Can dropping the !dev->driver check cause a NULL pointer dereference in
usb_unbind_interface()?

When intf->dev.driver is NULL, usb_forced_unbind_intf() passes driver =3D
to_usb_driver(NULL), whose &driver->driver member address evaluates back
to NULL, making dev->driver !=3D &driver->driver false.  If an interface is
claimed before registration and registered while drivers_autoprobe is
disabled, device_add() succeeds with iface->condition =3D=3D
USB_INTERFACE_BOUND and device_is_bound(dev) =3D=3D false (so the unwind in=
 a
later commit "USB: Unwind interface claims after registration or binding
failure" does not run); if a subsequent __device_attach() fails in
device_bind_driver(), it clears dev->driver to NULL while leaving
iface->condition as USB_INTERFACE_BOUND.  Calling
usb_deauthorize_interface() -> usb_forced_unbind_intf() on that interface
then passes the guard and dereferences to_usb_driver(NULL) in
usb_unbind_claim() -> usb_unbind_interface().

>  	iface->condition =3D USB_INTERFACE_UNBINDING;
> =20
> -	/* Release via the driver core only if the interface
> -	 * has already been registered
> -	 */
> -	if (device_is_registered(dev)) {
> -		device_release_driver(dev);
> -	} else {
> -		device_lock(dev);
> -		usb_unbind_interface(dev);
> -		dev_set_drvdata(dev, NULL);
> -		dev->driver =3D NULL;
> +	if (device_is_bound(dev)) {
>  		device_unlock(dev);
> +		device_release_driver(dev);
> +		return;
>  	}
> +
> +	usb_unbind_claim(iface);
> +unlock:
> +	device_unlock(dev);
>  }
>  EXPORT_SYMBOL_GPL(usb_driver_release_interface);

[Severity: Medium]
What happens if a pre-claimed sibling interface registered with
drivers_autoprobe disabled is detached through the driver core rather
than usb_driver_release_interface()?

When device_add() registers a pre-claimed interface while
sp->drivers_autoprobe is 0, device_initial_probe() skips
__device_attach(), leaving the interface registered on the bus with
dev->driver set and dev->p->knode_driver unattached (which the later
commit "USB: Unwind interface claims after registration or binding
failure" does not unwind because device_add() returns 0 and dev->driver
is non-NULL).  If that sibling interface is then unbound directly via
sysfs unbind_store() -> device_driver_detach() ->
__device_release_driver(), or removed by usb_disable_device() ->
device_del() for drivers such as snd-usb-audio that do not call
usb_driver_release_interface() in disconnect(), __device_release_driver()
sees dev->driver !=3D NULL and calls klist_remove(&dev->p->knode_driver) on
the unattached node, causing a NULL pointer dereference.  For drivers
that do not call usb_driver_release_interface() on disconnect,
driver_unregister() -> driver_detach() also misses the interface because
it is not on drv->p->klist_devices, leaving dev->driver as a dangling
pointer after module unload.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D6
