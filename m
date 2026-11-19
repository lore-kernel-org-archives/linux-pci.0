Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116568;
	b=HaJH4pbuQJpYQU3NrHnQz5waR/0CaZmpYngD1J193fruYe2ZO8ZlRP3O2CWqzNVyhKEo
	 gjKkfjwu9hNOdY4E7lA/wIggpqiE6INvP28EJZ3vZY3KVYfu1YrWuar6h+PzTTSjdpKtM
	 2v7c+rYduZQyNpQF1LPaetQTIt7s7PbC4P0gojQriFkE51qCRF5X0Bv9COWpx9H6kfDcD
	 U7MmdTfAv/94X9kqzpFz0l+lcp6SmAFtx+X/souyFYeUI5Qu7hlhky7/tSKby1AQJARmr
	 sJ8fIQeBSUukJrVhX4SNS0MZnY7wMdWvMx0CNgXZqM3ziTyyJHgxX/qNCImFQupRtvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116568;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OgM+PEnCbO5Zw1W+/mO1GK38eonTVOG3vgB7OD9t3GE=;
	b=S3rXpX2lhkkZQMTz84DxoAQA/msRPb4SrDB4O8YL7aG0imhw0KpCZmnH24xWwd52t5KN
	 ikBExc1cEyAJ6LhssMkYW2L6lkpNVsLME7I8CA/P8cpcM9IuiKo1HdoLh8eS1kX6M/wUY
	 7SqIneAstZ7wX3UHf1s1bVi/Gg4C7GS+7mdKpcD3zaPfJDsG2136OAWdq8FRTxA7i4Bgk
	 PCwSMEFK4qixSgXc9HESE8aFqeh48vVYEGFVY2iR2ozVbE06InfYqectBRMen4FbwTC4K
	 elptqVZYONa/QU0T6PaG2TVHUE+Cf/7v1nxBdcWhXLmzhGkrzCTWqqoU36csyTi0IFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrV0eXRa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E0E60A2628;
	Thu, 19 Nov 2026 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrV0eXRa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D501E1F000C8;
	Thu, 19 Nov 2026 19:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116568;
	bh=OgM+PEnCbO5Zw1W+/mO1GK38eonTVOG3vgB7OD9t3GE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IrV0eXRaNjLHycAUzmvxmGp77JksAQrOXj+3XiwLfJyR7XRnoK8LwMAzI2OASugsr
	 IVz1xD4VKgREgMvpbHoIz79Qne8grLE20+7rckju4ez1j1HErNaOOy050YH1ug5/Zi
	 9fghxGK16+i1wId07253A1CGpGp9SRLevol6VJBkSKM93mWPkdyhJp1yI8/F/SX7dU
	 u2uA6hJYBuVXNqFbuvk28TMcdM+AQ24xmvg5sWbWxKxcnNPTeuWB1UJtqBgZyPluLc
	 VDU+MJTo+0w7dnMEScCNni+0YtHR/PmgdhryRmDpUkzW4x1nzG9ANWOIcvrV1iVhc4
	 nOPRIB4lafecA==
Message-ID: <sashiko-outbox-223895@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/31] USB: Pin modules for unregistered interface
 claims
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118-device-trust-core-v3-9-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-9-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:27 +0000
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
- [Medium] usb: core: premature claim_owner release in
  usb_set_configuration()
--

commit afd725f56c3717b2e1f97538c7c8fdee117c4deb
Author: Leon Romanovsky <leon@kernel.org>

USB: Pin modules for unregistered interface claims

This commit pins the owning driver module in struct usb_interface.claim_own=
er
when an interface is claimed before registration, and releases that referen=
ce
upon interface registration or claim teardown.

> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index 0a6fdf2e88f4e..b7bd9226d2627 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
[ ... ]
> @@ -619,6 +634,7 @@ static void usb_unbind_claim(struct usb_interface *if=
ace)
>  	usb_unbind_interface(dev);
>  	dev_set_drvdata(dev, NULL);
>  	dev->driver =3D NULL;
> +	usb_put_claim_owner(iface);
>  }
> =20
>  /**
> @@ -653,6 +669,7 @@ void usb_driver_release_interface(struct usb_driver *=
driver,
>  	if (device_is_bound(dev)) {
>  		device_unlock(dev);
>  		device_release_driver(dev);
> +		usb_put_claim_owner(iface);
>  		return;
>  	}
> =20
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index e56079398d26e..306978caaf1ef 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
[ ... ]
> @@ -2269,6 +2270,7 @@ int usb_set_configuration(struct usb_device *dev, i=
nt configuration)
>  	 */
>  	for (i =3D 0; i < nintf; ++i) {
>  		struct usb_interface *intf =3D cp->interface[i];
> +		struct module *claim_owner;
> =20
>  		if (intf->dev.of_node &&
>  		    !of_device_is_available(intf->dev.of_node)) {
> @@ -2282,12 +2284,16 @@ int usb_set_configuration(struct usb_device *dev,=
 int configuration)
>  			dev_name(&intf->dev), configuration,
>  			intf->cur_altsetting->desc.bInterfaceNumber);
>  		device_enable_async_suspend(&intf->dev);
> +		device_lock(&intf->dev);
> +		claim_owner =3D xchg(&intf->claim_owner, NULL);
> +		device_unlock(&intf->dev);
>  		ret =3D device_add(&intf->dev);
>  		if (ret) {
>  			device_lock(&intf->dev);
>  			intf->unregistering =3D 1;
>  			device_unlock(&intf->dev);
>  		}
> +		module_put(claim_owner);
>  		if (ret !=3D 0) {
>  			dev_err(&dev->dev, "device_add(%s) --> %d\n",
>  				dev_name(&intf->dev), ret);

[Severity: Medium]
Does clearing intf->claim_owner before device_add() and calling
module_put(claim_owner) unconditionally drop the module reference too early
when device_add() leaves a pre-claimed interface unbound in the driver core
(!device_is_bound(&intf->dev))?

Commit "USB: Unwind interface claims after registration or binding failure"
later in the series handles the cases where device_add() fails or
__device_attach_locked() clears intf->dev.driver on binding failure, but if
USB bus autoprobing (/sys/bus/usb/drivers_autoprobe) is disabled between
usb_driver_claim_interface() and device_initial_probe() inside device_add(),
device_add() returns 0 while intf->dev.driver remains set and
device_is_bound(&intf->dev) remains false.

Because usb_set_configuration() has already dropped claim_owner (making
usb_put_claim_owner() in usb_unbind_claim() and the device_is_bound() branch
of usb_driver_release_interface() a no-op after device_add()), releasing the
registered-but-unbound claimed interface via usb_driver_release_interface()
-> usb_unbind_claim() runs without a claim_owner reference. Once the driver=
's
disconnect() callback detaches the control interface from klist_devices, a
concurrent delete_module() can see an empty klist_devices and free the modu=
le
while disconnect() is still executing (or leave a dangling intf->dev.driver
pointer for drivers such as snd-usb-audio that do not release claimed sibli=
ng
interfaces from disconnect()).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D9
