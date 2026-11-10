Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296115;
	b=A+8OxOF8S/g6LEPv0VW7IDKKrOgicp5M7nFgprZ18CM0Hn2gEjNKDl9rXNSK9bFnRDVh
	 pIJF66XHsSBSn1xJKn2uQ+AbBsgvgrNhMc3wwjfmYV8llThsypqzSgU5aZq8DCEAPj6O4
	 3/kVzErHLFbH7WgJL8DLy9b6TRdNtDP67cLQdPCru46VhVBf7p+cjJF2QWy8NCbMfjYIM
	 7F+04mrDFz+0HstsZIr9e0EWDnwwY2v44g6KqXcQrRZPmfS3zFGzjCGLRlQVnnu5ihLyK
	 Fg+IVDNBBH7RvNvFS50k5KTbnh972LBuAU0RB+kO2M/2wkstJhbIQ6G4Sakk9P3Ps/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296115;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L4wZJyQPyTVS35HwhEdrXS1F0O3J/fvnZmTfPrPMDiA=;
	b=BK6IWYv0jumIwATQY6ovWET8HKRMLLqP6VTLJXvOIfHWgaWkDevpX8IMKisJsjzwhQ2H
	 5idP8W0Kw34FWDsioPxv74g+w+pFB3e35dfbyj+v+4V/cinFlyuUfrd5XVdH5/tRMMMVp
	 qQGOxSV3LvO4HpnarFbpB68C4mHoU5pWEit1DSLefZWJRO/LxqqF2efpKWX71v6T33w0S
	 Es9t7SBEi9SjfxA3MbGWiCg3liIaaZtDNRdov/vjxqYo5pQXst8Cdl9f0PUIKvUwr5Vcp
	 s+JwroRpXTh93IoLfTGi/O7ZzLXjVMeyoMjhZpXngy/7ZW6NdyLmAHHsAJHnfZFdw2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m8/wkRMj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73460A2608;
	Tue, 10 Nov 2026 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8/wkRMj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72521F008A1;
	Tue, 10 Nov 2026 07:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296115;
	bh=L4wZJyQPyTVS35HwhEdrXS1F0O3J/fvnZmTfPrPMDiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m8/wkRMjP+lVKbJIRKhqEXCvZeAGeyera2YGXhwcKeD4e9/Y8ZwHmrlUE31V/YA/9
	 ilkjbJHC8kmLm6bWWzPtXVys6Zm+cJZfKm8G2S9AmhlSUkmqt7j29Gu6v8EYin1lLu
	 SH4uYGrjnc6gKRnVvdDKJfcef9p2KBlMEhT+mGHNzygswxq8ryzORjELCCHN+OFp+L
	 bvnSmlblp0pzAJTj+YxXhNfn/oWAptico9ZbBnO4iYYKsBTBcC6M5OLKq3OtB3u6Yd
	 1oFD037mKasMptcuny3n0Kj4pr1loMj6x3UBqDDOwilaE9QLuDTI03V5DncmldxHwd
	 h4fkcItkx4OwQ==
Message-ID: <sashiko-outbox-206504@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/19] USB: Release interface claims refused during
 registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109-device-trust-core-v2-4-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-4-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:14 +0000
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
- [Medium] usb: core: unreleased interface claim when device_add() fails
  or skips probe
- [Medium] usb: core: skipped claim release when try_module_get() fails
  in usb_set_configuration()
--

commit fe8ed7c8ae2a463fe7346f0944a52ef057b538c6
Author: Leon Romanovsky <leon@kernel.org>

USB: Release interface claims refused during registration

This commit tracks pre-registration interface claims across device_add() in
usb_set_configuration() and invokes usb_driver_release_refused_claim() to
unbind the interface if the driver core drops the claim during registration.

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

[Severity: Medium]
Does clearing claimant to NULL when try_module_get() fails skip releasing
the refused claim if the claimant module is concurrently unloading?

Binding a USB driver to an interface does not take a module reference on
claimant->owner.  If delete_module() races with usb_set_configuration(),
try_stop_module() sets MODULE_STATE_GOING (causing try_module_get() to fail)
before mod->exit() -> usb_deregister() -> driver_detach() blocks on
device_lock(&dev->dev) while detaching the already-bound sibling interface.

If device_add() then fails to bind intf and clears intf->dev.driver to NULL,
usb_driver_release_refused_claim() is skipped because claimant is NULL, and
the sibling's later usb_driver_release_interface() call returns early becau=
se
intf->dev.driver is already NULL.  That leaves intf registered with
intf->condition =3D=3D USB_INTERFACE_BOUND and intf->dev.driver =3D=3D NULL=
, which
causes a NULL pointer dereference in usb_suspend_interface().

>  		ret =3D device_add(&intf->dev);
> +		if (!ret && claimant && !intf->dev.driver)
> +			usb_driver_release_refused_claim(intf, claimant);

[Severity: Medium]
Can a pre-claimed interface also be left in USB_INTERFACE_BOUND state witho=
ut
a bound driver when device_add() returns an error or skips probing?

If dpm_sysfs_add() fails in device_add(), its DPMError path calls
device_set_driver(dev, NULL) and returns a non-zero ret:

drivers/base/core.c:device_add() {
    ...
 DPMError:
	device_set_driver(dev, NULL);
	bus_remove_device(dev);
    ...
}

Because usb_set_configuration() logs the device_add() error and continues,
skipping usb_driver_release_refused_claim() when ret !=3D 0 leaves intf in
dev->actconfig->interface[i] with intf->condition =3D=3D USB_INTERFACE_BOUN=
D and
intf->dev.driver =3D=3D NULL, which crashes in usb_suspend_interface() and
prevents usb_driver_release_interface() from cleaning it up.  If device_add=
()
fails before DPMError, intf remains unregistered in USB_INTERFACE_BOUND
state, so usb_disable_device() also skips unbinding it on teardown.

Similarly, if bus autoprobe is disabled when device_initial_probe() runs,
device_add() returns 0 without calling device_bind_driver() or clearing
intf->dev.driver, leaving intf->dev.driver set while !device_is_bound(&intf=
->dev).
Checking !device_is_bound(&intf->dev) instead of !ret && !intf->dev.driver
would cover all of these cases.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D4
