Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296123;
	b=OVVMBuT9nTs51M7VSKLilvWr9p7gq9F/dUSNfx0DZ2kZM433uSVUhMz64X2ghgXpl8WS
	 z8C4Vj4iB2qzmGelmC9i+lqqppirTP78rla68nzvGOC1YgAvCy6Xo2iWtH7elESBsOYqC
	 f1gXLQNU7FUniJXF4NqwJ2oSYA+jEcGjvO0VwmMevGvaAjjpUgf/Gqk1wBDwJJh3t7xUa
	 7KY0f8iotuDMcbRUzBiJdH94i7Vgwf8a86ao7WtOE1R0rwnp+jB6Q15vueQ8A+pBNq+1P
	 EmM8sQHNWlN6E4ci87PMzVGIrxicyQDCryvwPrfr5KIphD0rTPMlqfyXGHS9wscLPCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296123;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bAwo+lvZNbmWLTJmqaboGR6hyWG2JKJdmmTG6q3wgsM=;
	b=KBizbrWgjjL3kZYeSL1YmpE2Hfxby/Azgma5+MXZ6+4alzbc/4yUe7FH0lS/0zWUgqu7
	 xQ5YscFzC5LykNxHh3VDr7XRc5TxH0oTjuGwhGDewcBRzqGWwdZs4P0bOIVwlkRt8oYSl
	 HPprUeCseFNR8vusHkln+ERJ03Ib9mThKSWK9Flzn8KzOkg0sGtM7Hdy69/ukKvf56fQs
	 I6j7cxt/8jCYzf584EFHVrylOl4Wo4bozyV7F64NmBIQlXi54TkdoanFLGVzagO9IDAkR
	 fAkZb4X1jaGvhPRCI1wwa1i/BetI99YmaVqsAfCyxHIfeQWbDD3O+b57cnTJ0DN0+xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LA6PySbd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701C360A3831;
	Tue, 10 Nov 2026 07:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LA6PySbd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07A81F008A2;
	Tue, 10 Nov 2026 07:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296123;
	bh=bAwo+lvZNbmWLTJmqaboGR6hyWG2JKJdmmTG6q3wgsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LA6PySbdQRAI7K4UcGa3MiuC1PE3gawGJASmTyfx4wJD7f85SJYvcg6dr1gw+O9ry
	 FkgI7M+VwRNWa9Y/xTOeM4pzGAJ/fgD7K8NTYuMsrgjIjJ5u4cY6eZRkuV0VCbmKwN
	 F0EcCTd6+VE5xzFEqgpCZr/w+WhdjEBOdr6w3MJ1jZO5tQuTPIlzhiReuV1gro5po0
	 Ak4dEv3+yJUnt8ZORpN2Rnc8EZpcr6Tm0ideusUFa/YwDj6O+yg36lXcWLsP51pntK
	 nL18nTXuKM+Aihz0WFyKMxs1Un2yYIQzOxKBaB7jXelFrCuJ2+cKwVAuBQsrlquQeE
	 Iu9847ZXleeVQ==
Message-ID: <sashiko-outbox-206514@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/19] driver core: Accept device trust policy by
 driver name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109-device-trust-core-v2-14-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-14-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:22 +0000
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
- [High] usb: core: usb_driver_claim_interface() ignores
  device_trust.driver=3D
--

commit 411f8a29f95104232dcf95e09cd04a0c125becd0
Author: Leon Romanovsky <leon@kernel.org>

driver core: Accept device trust policy by driver name

This commit adds the device_trust.driver=3D kernel command-line parameter to
configure initial device trust policies by bus and driver name, and checks
trust policy when claiming unregistered USB interfaces.

> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index ee36eae34bdcc..04b77691fbd7d 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -563,6 +563,10 @@ int usb_driver_claim_interface(struct usb_driver *dr=
iver,
>  	if (!iface->authorized)
>  		return -ENODEV;
> =20
> +	if (!device_is_registered(dev) &&
> +	    dev->trust_policy =3D=3D DEVICE_TRUST_POLICY_DISABLED)
> +		return -EPERM;
> +
>  	dev->driver =3D &driver->driver;
>  	usb_set_intfdata(iface, data);
>  	iface->needs_binding =3D 0;

[Severity: High]
Does usb_driver_claim_interface() ignore device_trust.driver=3D rules when
checking an unregistered sibling interface?

In usb_set_configuration(), device_trust_init() sets each interface's
dev->trust_policy from device_trust.default=3D and device_trust=3D before t=
he
device_add() loop, whereas device_trust.driver=3D is only evaluated in
__device_trust_prepare() during registration.

With device_trust.default=3Ddisabled and device_trust.driver=3Dusb:<drv>=3D=
full,
probing interface 0 succeeds, but claiming an unregistered sibling from
probe() still sees DEVICE_TRUST_POLICY_DISABLED and fails with -EPERM.

Conversely, if device_trust.driver=3Dusb:<drv>=3Ddisabled is set and interf=
ace
0 is allowed by a device_trust=3D entry, usb_driver_claim_interface() does
not reject the unregistered sibling claim with -EPERM.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D14
