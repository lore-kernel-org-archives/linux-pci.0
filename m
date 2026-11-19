Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116590;
	b=Nhw9AhFoTfx85iGWT1LnYIiLrlQHH/54XEnYjKnfgahKZ3qYuVmgIgOTN6LmkgnUmjY8
	 gf0YvTBu2FytRt+dHKYPz5ilwB6dKBHWl71srhQe0FpjxwcbefDxtLpnN3zUrcI9Afi0P
	 wnr3lyX+q0RUDyldY7DgJZ1rOOjw7xb9rwZnLvpBWBpVpME4o0RLBB70DUCTx6JE7a9d7
	 AmmEFtcb0SsHg/SyFTFt2vIvFyVerJWb4rjFMpUB+bUdyIQBTiBTUpg+1pengfv8Lr2R4
	 7m8s5zU3LYiFSG1lqI0mhZyXPX4loHlKgOOcTO7DbKtRymVzpJBFDQE41OnO3WS8CYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116590;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6rDuPvMNMonUi4Jk3oCiITM0hmxt7+saHsno2Ls24CY=;
	b=txN0UPwfX1m+bv/gBP37NFX1/oMUboYy5N+d/vN2XOg4jQSiqVm6/5vGCVVIdhwI3HT8
	 rb6MTpBzIXQBonzpR6ScB/JJs9WQ9Ao2cRM9cJiPtV+H1Sl/sX5Zv9fPysY/8gdRxOCrM
	 bNly6YalT9f3TKZq0sRyqI0NqEJYF1bXqXWMEJqX8+ssdKxOKEVIBrwBPbDoGqkdB5FZb
	 iQ1JHUmfnQ2ihTg78qgO0Ay8AgvuiBrPg1FcK+N/fgzDJh/MEBYdlTvcxXnZ+8IGkbESx
	 M0wrcAek7G4axl/4ucqmagSXo7aRR9+rMUP/qDXl9nJQTZfdIUt5sj2s/Lz8sIrHU+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5fNTviH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B960A6F62;
	Thu, 19 Nov 2026 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5fNTviH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2041F000C8;
	Thu, 19 Nov 2026 19:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116590;
	bh=6rDuPvMNMonUi4Jk3oCiITM0hmxt7+saHsno2Ls24CY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X5fNTviH53Q8V/0scmmvgQODjeE3pITD3OsrHFQJETF+4LvLnMGhCz33MYaHB/6pu
	 gdxdlnsDPxMulv1WUOooa/aqGIY001Gbm4cXL+V2kVXA138swhCFczq3Ml9yhra66O
	 smVXeTEPoFoVkXwXNMgedOzvA2aWxa1DoNwAtdDLpDfMbHs3KZoaE29Sz0HaW6qKMh
	 XV+CoHXm1jE7/DobTyAOUjLDXLmcF02z4im5EKBLV482RunRvJNqpO9bQsAbt3xIZd
	 oFGeww7T14lkjIUXk1T87FK5rMndZ9C1ZL3TOkdAOc69DvH9tMBtXl5cUrpIyw9Tjn
	 QTK+t/ie4EseQ==
Message-ID: <sashiko-outbox-223917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 31/31] USB: Authorize devices through device trust
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118-device-trust-core-v3-31-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-31-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:49 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] usb: core: missing usb_notify_remove_device() when
  disconnecting unbound device
- [Low] usb: stale config_error in usb_authorize_device() when no config
  is chosen
- [Low] usb: core: missing device_trust_init() before
  trace_usb_alloc_dev()
--

commit 6534edcb6b352edce6df3458c65d3d073e695248
Author: Leon Romanovsky <leon@kernel.org>

USB: Authorize devices through device trust

This commit integrates USB device authorization with the generic device
trust policy framework, deferring driver binding and configuration for
unauthorized devices until their trust policy is updated and keeping
authorization and configuration result tracking under the device lock.

> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 199d3f535a891..62eedae9d0077 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c

[ ... ]

> @@ -2784,17 +2785,41 @@ int usb_deauthorize_device(struct usb_device *usb=
_dev)
> =20
>  int usb_authorize_device(struct usb_device *usb_dev)
>  {
> +	bool attach;
>  	int result =3D 0, c;
> =20
>  	usb_lock_device(usb_dev);
> -	if (usb_dev->authorized =3D=3D 1)
> -		goto out_authorized;
> +	if (device_policy_is_blocked(&usb_dev->dev)) {
> +		result =3D device_trust_set_policy_locked(&usb_dev->dev,
> +							DEVICE_TRUST_POLICY_UNRESTRICTED);
> +		if (result)
> +			goto out_unlock;
> +	}
> +
> +	attach =3D device_trust_enabled() && !usb_dev->dev.driver;
> +	if (!attach && usb_dev->authorized =3D=3D 1 &&
> +	    (!device_trust_enabled() || !usb_dev->config_error ||
> +	     usb_dev->actconfig))
> +		goto out_unlock;
> =20
>  	result =3D usb_autoresume_device(usb_dev);
>  	if (result < 0) {
>  		dev_err(&usb_dev->dev,
>  			"can't autoresume for authorization: %d\n", result);
> -		goto error_autoresume;
> +		goto out_unlock;
> +	}
> +
> +	if (attach) {
> +		usb_dev->authorized =3D 1;
> +		usb_dev->config_error =3D 0;
> +		result =3D device_attach_locked(&usb_dev->dev);
> +		if (result <=3D 0) {
> +			if (result >=3D 0)
> +				result =3D -ENODEV;
> +		} else {
> +			result =3D usb_dev->config_error;
> +		}
> +		goto out_autosuspend;
> +	}
> =20
>  	usb_dev->authorized =3D 1;
>  	/* Choose and set the configuration.  This registers the interfaces
>  	 * with the driver core and lets interface drivers bind to them.
>  	 */
>  	c =3D usb_choose_configuration(usb_dev);
>  	if (c >=3D 0) {
>  		result =3D usb_set_configuration(usb_dev, c);

[Severity: Low]
Should the non-attach path also clear usb_dev->config_error =3D 0 before
calling usb_choose_configuration()?

If a prior configuration attempt failed (leaving usb_dev->config_error
non-zero and usb_dev->actconfig NULL) and usb_choose_configuration()
returns -1, usb_set_configuration() is not called and config_error stays
non-zero.  Subsequent calls to usb_authorize_device() on the already
authorized device will then bypass the early return and repeatedly
autoresume the device and re-run configuration selection.

> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 2559a180fdeec..ed71f1155e2ed 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -748,6 +748,11 @@ struct usb_device *usb_alloc_dev(struct usb_device *=
parent,
>  #endif
> =20
>  	dev->authorized =3D usb_dev_authorized(dev, usb_hcd);
> +	if (device_trust_enabled()) {
> +		if (!dev->authorized)
> +			dev->dev.trust_policy =3D DEVICE_TRUST_POLICY_BLOCKED;
> +		dev->authorized =3D 1;
> +	}
>  	trace_usb_alloc_dev(dev);
>  	return dev;
>  }

[Severity: High]
Does leaving a trust-blocked USB device unbound skip
usb_notify_remove_device() if the device is disconnected before being
authorized?

With DEVICE_TRUST_POLICY_BLOCKED, device_add() in usb_new_device()
creates the /dev/bus/usb/BBB/DDD node, but device_trust_prepare()
rejects binding usb_generic_driver, leaving udev->dev.driver NULL.
Userspace can still open the usbfs node via usbdev_open(), which adds a
struct usb_dev_state entry to udev->filelist.  If the device is then
unplugged before authorization, device_del() in usb_disconnect() does
not run usb_generic_driver_disconnect(), which is the only caller of
usb_notify_remove_device():

drivers/usb/core/generic.c:usb_generic_driver_disconnect() {
	usb_notify_remove_device(udev);
	usb_release_bos_descriptor(udev);
}

As a result, usbdev_remove() never runs, udev->filelist is not drained,
disconnect signals are not delivered, and tasks waiting in poll(),
USBDEVFS_REAPURB, or USBDEVFS_WAIT_FOR_RESUME hang indefinitely.

[Severity: Low]
Does trace_usb_alloc_dev() record usb_device_authorized() before
device_trust_init() has applied any boot trust rules?

device_trust_init(&udev->dev) is not called until device_add() in
usb_new_device(), so trace_usb_alloc_dev() and the early
trace_usb_set_device_state() events during enumeration evaluate
dev->dev.trust_policy before device_trust.default=3D or device_trust=3D boot
policies take effect.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D31
