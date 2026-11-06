Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965422;
	b=1HFj5x+TlFx+EdVfffazGFD7Zm4XKoaRYVqYQGXL2BMCJw9RBUWBR4+Uwo+2ysqPOpPL
	 2oCbwRhxRuG5qSmQ9eNPOWzcAUWywLBwgn1tPK6fxgpMtiRWU3uYcPAV77KusYy2oU+T9
	 Astr61zT6xpjWWwPSa+T4V4EYfZfT2CX+QVtMryWjCDx6rVoj84bJ89sdd+6vq1HdJFTX
	 jM0AsNdsPQ3+qFwjczIBCxj1QSb6RPj1P8eYXphmt4MsuTU6SpeslfbK4k2xrbbnIaE5K
	 LFdt4uBkysPfPNaQu9wy7IzthfysTfgaeYf+eukvlaC9txbwARZ8jNhGRVhoZjfvRiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965422;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AvkeeGcDpLrFgc1vdUUjvfYaU6P4zvT3uKo4WSR7PqY=;
	b=iICF2DtfPYTkM9BMO+Owkxgfdi0YsTj/edTD6NoK+O6SXwgd8G0KhlMeXJCcYXEYjRZv
	 JfkrkHTLX57TGkrAGJbL9pS1L4h307G5tpTf3/YIHzXGS4TRPOSx0kR2ntKvXHRAY0rkY
	 CGMkNCEuVi0YbWOVn51qKl+mPL7mqpw6T06f2/APvDKww68/Dz3CeZJMTb66CCubtFaMm
	 kx4Xn1EQc5Ms8o3psgMen22rnd7FY6v1G2IpWenBR3X4ESJwJo5q4UR1ZlTW7vRstcGxu
	 5PfmfORlDlUqGnmBxtUM+Xa4OlcqpA1uQt+WNxEer6vdwPAzILTQeec04Q+1qs/wvAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtUZE9g0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C37606D80C;
	Fri,  6 Nov 2026 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtUZE9g0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEE21F008A1;
	Fri,  6 Nov 2026 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965421;
	bh=AvkeeGcDpLrFgc1vdUUjvfYaU6P4zvT3uKo4WSR7PqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HtUZE9g0GLLiD1HSxtYAAuUZ8ZgJdRqL0Ni2vSelZGABLRPnJh6D6F6EosITQMcSw
	 1ebPr2u4ffBWVlXo4Z/ok6VgrrD1EXL2RX04RWAol7Oe40u6zXTm9ZqVoB7XSPxdQ+
	 hDOVaQu2ivKSnvA2HniHKPYvkXsQ7SACevQoqDfweSAKWU+qj2YNpeTZ3dq0ty665J
	 BkfLVqdMqFugCCUpDnvXXdoivvmprgBj/OWCqMpfa1bKnOFK5VfdpnOFG5b0BmwHxh
	 PRBeYEmgz15y0U7sjCMdiWrZmM3venkS0+qSfy4lAnQkpFh4MoUhXljfVCZOXHh6qQ
	 4ud66pdfOT3rw==
Message-ID: <sashiko-outbox-201338@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/17] USB: Lock registered interfaces during manual
 driver binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261105-device-trust-core-v1-5-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-5-1e536825b4eb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:43:40 +0000
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
- [High] USB: unlocked dev->driver and state updates in
  usb_driver_claim_interface()
- [High] usb: core: unreleased pre-claim in usb_set_configuration() when
  unbound
- [High] usb: core: skipped refused-claim cleanup in
  usb_set_configuration()
- [High] usb: incomplete unbind of multi-interface drivers in
  usb_driver_release_refused_claim()
--

commit f8b8b26e3d94c65587df2d54f58d12342c54f09a
Author: Leon Romanovsky <leon@kernel.org>

USB: Lock registered interfaces during manual driver binding

This commit acquires the target USB interface device lock around
device_bind_driver() in usb_driver_claim_interface(), updates
btusb_mtk_claim_iso_intf() to acquire the USB device lock instead of the
interface lock, and adds usb_driver_release_refused_claim() to clean up
pre-claimed interfaces when binding is refused during usb_set_configuration=
().

> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index d3a61ebc6afb0..262502642ca98 100644
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
When usb_driver_claim_interface() is called on an already-registered
interface, the caller holds the parent USB device lock (udev->dev.mutex)
rather than the target interface lock (dev->mutex). Here device_lock(dev)
only wraps device_bind_driver(dev), while dev->driver, driver_data,
iface->needs_binding, and iface->condition are still written before
device_lock(dev) is acquired and rolled back after device_unlock(dev) is
released:

drivers/usb/core/driver.c:usb_driver_claim_interface() {
	...
	dev->driver =3D &driver->driver;
	usb_set_intfdata(iface, data);
	iface->needs_binding =3D 0;

	iface->condition =3D USB_INTERFACE_BOUND;
	...
	if (device_is_registered(dev)) {
		device_lock(dev);
		retval =3D device_bind_driver(dev);
		device_unlock(dev);
	}

	if (retval) {
		dev->driver =3D NULL;
		usb_set_intfdata(iface, NULL);
		iface->needs_remote_wakeup =3D 0;
		iface->condition =3D USB_INTERFACE_UNBOUND;
	...
}

Because several driver-core and USB sysfs paths synchronize access to a
registered interface using only device_lock(dev) without holding the parent
USB device lock, can those unlocked state mutations still race?

For example, if device_bind_driver(dev) fails and drops device_unlock(dev),
drivers/usb/core/sysfs.c:supports_autosuspend_show() can acquire
device_lock_interruptible(dev) before dev->driver is cleared:

drivers/usb/core/sysfs.c:supports_autosuspend_show() {
	s =3D device_lock_interruptible(dev);
	if (s < 0)
		return -EINTR;
	/* Devices will be autosuspended even when an interface isn't claimed */
	s =3D (!dev->driver || to_usb_driver(dev->driver)->supports_autosuspend);
	device_unlock(dev);
}

If supports_autosuspend_show() sees dev->driver !=3D NULL in the first check
while usb_driver_claim_interface() concurrently writes dev->driver =3D NULL,
to_usb_driver(dev->driver)->supports_autosuspend will dereference NULL.

Similarly, under only device_lock(dev), device_trust_set_policy() in
drivers/base/trust.c can observe the transient non-NULL dev->driver before
device_bind_driver() or before the error rollback and fail with -EBUSY,
drivers/base/dd.c:__driver_attach() can observe the transient dev->driver a=
nd
skip probing, and drivers/usb/core/message.c:usb_authorize_interface() can
write intf->authorized concurrently with the unlocked writes to
iface->needs_binding and iface->needs_remote_wakeup in the same bitfield
word.

Should device_lock(dev) be held across the entire state transition and error
rollback in usb_driver_claim_interface()?

> @@ -649,6 +652,26 @@ void usb_driver_release_interface(struct usb_driver =
*driver,
>  }
>  EXPORT_SYMBOL_GPL(usb_driver_release_interface);
> =20
> +/*
> + * The driver core refused to bind an interface that a sibling claimed b=
efore
> + * it was registered, and dropped the claim. Let the claimant release the
> + * interface instead of operating it with a bound interface but no drive=
r.
> + */
> +void usb_driver_release_refused_claim(struct usb_interface *iface,
> +				      struct device_driver *claimant)
> +{
> +	struct device *dev =3D &iface->dev;
> +
> +	device_lock(dev);
> +	if (!dev->driver && iface->condition =3D=3D USB_INTERFACE_BOUND) {
> +		dev->driver =3D claimant;
> +		usb_unbind_interface(dev);
> +		dev_set_drvdata(dev, NULL);
> +		dev->driver =3D NULL;
> +	}
> +	device_unlock(dev);
> +}

[Severity: High]
When a driver probes interface 0 during usb_set_configuration() and claims =
an
unregistered secondary interface via usb_driver_claim_interface(), calling
usb_unbind_interface() only on the refused secondary interface here invokes
driver->disconnect(iface) on that secondary interface and then re-enables i=
ts
endpoints via usb_enable_interface(udev, intf, false).

However, many multi-interface USB drivers treat disconnect() on a secondary
interface as a no-op and only tear down state when disconnect() is called on
the primary control interface. For example, in sound/usb/card.c:

sound/usb/card.c:usb_audio_disconnect() {
	struct snd_usb_audio *chip =3D usb_get_intfdata(intf);
	struct snd_card *card;

	if (chip =3D=3D USB_AUDIO_IFACE_UNUSED)
		return;
	...
}

And in drivers/media/usb/uvc/uvc_driver.c:

drivers/media/usb/uvc/uvc_driver.c:uvc_disconnect() {
	struct uvc_device *dev =3D usb_get_intfdata(intf);

	usb_set_intfdata(intf, NULL);

	if (intf->cur_altsetting->desc.bInterfaceSubClass =3D=3D
	    UVC_SC_VIDEOSTREAMING)
		return;
	...
}

Drivers such as ims_pcu_disconnect(), ati_remote2_disconnect(),
line6_disconnect(), and uea_disconnect() similarly return early when
disconnect() is called on a secondary interface.

If device_bind_driver() refuses the secondary interface during device_add(),
won't unbinding only iface leave the claimant bound to the primary interface
and actively using the unbound secondary interface (whose endpoints were ju=
st
re-enabled by usb_unbind_interface() and whose dev->driver is now NULL)?

> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index a738d03c23eac..d35a7710c8ef4 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -2264,6 +2264,7 @@ int usb_set_configuration(struct usb_device *dev, i=
nt configuration)
>  	 */
>  	for (i =3D 0; i < nintf; ++i) {
>  		struct usb_interface *intf =3D cp->interface[i];
> +		struct device_driver *claimant;
> =20
>  		if (intf->dev.of_node &&
>  		    !of_device_is_available(intf->dev.of_node)) {
> @@ -2277,7 +2278,14 @@ int usb_set_configuration(struct usb_device *dev, =
int configuration)
>  			dev_name(&intf->dev), configuration,
>  			intf->cur_altsetting->desc.bInterfaceNumber);
>  		device_enable_async_suspend(&intf->dev);
> +		claimant =3D intf->dev.driver;
> +		if (claimant && !try_module_get(claimant->owner))
> +			claimant =3D NULL;
>  		ret =3D device_add(&intf->dev);
> +		if (!ret && claimant && !intf->dev.driver)
> +			usb_driver_release_refused_claim(intf, claimant);
> +		if (claimant)
> +			module_put(claimant->owner);

[Severity: High]
What happens if a pre-claimed interface is passed to device_add(&intf->dev),
but device_bind_driver(&intf->dev) never completes for reasons other than
__device_attach() clearing intf->dev.driver on a0 return?

First, if /sys/bus/usb/drivers_autoprobe is set to 0 before
bus_probe_device() -> device_initial_probe() runs inside device_add(),
device_initial_probe() skips __device_attach(). In that case, device_add()
returns 0 with intf->dev.driver still set to claimant, even though
device_bind_driver() and driver_bound() were never called
(!device_is_bound(&intf->dev)). Because intf->dev.driver is non-NULL,
usb_driver_release_refused_claim() is not called, the claimant continues
operating the interface without going through device_bind_driver() admissio=
n,
and later unbinding the interface via usb_driver_release_interface() or
device_del() -> __device_release_driver() calls
klist_remove(&dev->p->knode_driver) on an unattached knode, dereferencing
NULL in klist_put().

Second, if device_add(&intf->dev) fails with a negative ret (for example, at
DPMError in drivers/base/core.c:device_add(), which calls
device_set_driver(dev, NULL), or earlier before DPMError), the !ret check
skips usb_driver_release_refused_claim(). That leaves cp->interface[i] in
dev->actconfig with intf->condition =3D=3D USB_INTERFACE_BOUND and
intf->dev.driver =3D=3D NULL (or an unbound driver), so usb_autosuspend_dev=
ice()
at the end of usb_set_configuration() -> usb_suspend_both() ->
usb_suspend_interface() sees intf->condition !=3D USB_INTERFACE_UNBOUND and
dereferences NULL at to_usb_driver(intf->dev.driver)->suspend:

drivers/usb/core/driver.c:usb_suspend_interface() {
	if (udev->state =3D=3D USB_STATE_NOTATTACHED ||
			intf->condition =3D=3D USB_INTERFACE_UNBOUND)
		goto done;
	driver =3D to_usb_driver(intf->dev.driver);

	/* at this time we know the driver supports suspend */
	status =3D driver->suspend(intf, msg);
}

Should usb_set_configuration() and usb_driver_release_refused_claim() check
whether the pre-claimed interface actually finished binding via
!device_is_bound(&intf->dev) regardless of whether ret is non-zero or
intf->dev.driver is still set?

[Severity: High]
In addition, is it safe to set claimant =3D NULL when
try_module_get(claimant->owner) returns false here?

The driver core does not hold a module reference on drv->owner when an
earlier sibling interface probes a modular USB driver during
usb_set_configuration(). If a concurrent rmmod (delete_module) begins on
claimant->owner while usb_set_configuration() holds device_lock(&dev->dev),
try_stop_module() transitions the module to MODULE_STATE_GOING and the
module's exit path blocks in usb_deregister() -> driver_unregister() ->
driver_detach() waiting to acquire the parent USB device lock
device_lock(&dev->dev).

Because MODULE_STATE_GOING is already set, try_module_get(claimant->owner)
returns false and sets claimant =3D NULL even though claimant cannot disapp=
ear
while device_lock(&dev->dev) is held. If device_add(&intf->dev) then fails =
to
bind the pre-claimed interface and clears intf->dev.driver =3D NULL,
usb_driver_release_refused_claim() is skipped because claimant is NULL.

Neither driver_detach() (since intf was never added to
claimant->p->klist_devices) nor a subsequent usb_driver_release_interface()
call from the sibling interface's disconnect callback (which returns early
when !dev->driver) will reset intf->condition, leaving intf->condition =3D=
=3D
USB_INTERFACE_BOUND with intf->dev.driver =3D=3D NULL and causing
usb_suspend_interface() to dereference a NULL driver pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D5
