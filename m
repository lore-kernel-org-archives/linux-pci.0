Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296119;
	b=GVske9RqLtQv7kyW9SFsHu3cGNm/7tZmCqGjxF4VQahgZhtMDDJn9NFMGYDLpN0mgsl3
	 P90XwnlIaEpGdZZGeSQ770t7d4dXnoRE97sl6Y9zD9FDhn6/3ImLBZdSMcp8lGeoXvyfz
	 P6P0z3r5WaUmR/cPPR+eHukWLTjvxWvUBdkDmQtxSEuDMsRgMgnkNKYwZPl5SF8IOVVoL
	 cgaffE0GmOIO2pGKLZEbfoU2ygmzEvFkjpyEVaP6Hj8HeWGySFhq7cBWWjMuF9Ly4Fb+j
	 vSK2aifl75t1dzNHRTmhCjHZDlL6P3bhzU1Iy9WXuSwrygfspLjO5zuRCBSj+OydHbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296119;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uoRWm8g+4dcdBOd1TXXWNxw9k/l1MQxwf8spyBkp6TE=;
	b=5B/jobjkR83aSmunnVhrOTOxK7de92ngblslljUaICPAzjVlkaqwgd3j5Laa/N6LehXD
	 4DGfRZcUt5EukShKbdynE03C/seW62NssG47X/Ge1qkVahHZiK7UD9rptRnxMqFZz913U
	 ynHC37Z+/2LtTWuKDS7qEaDU+fLmAFANUJqArlU6lxPmUpfmMSnBfEliOj970sCoY3Vti
	 lXtpkLFbHa9+X3K21tPQ4RcAiNvd9XU0kN5SZOzrQ2tpDfVHAlB6g8H2a8jAOuwlHoR6G
	 2wzhMjRUewDklOEe9klsQavbJtG4Bg2Jl5FcAJeSETTLQbNmUWmCMG3bhn7uo36QL3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IoS6GPvY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1F760A262C;
	Tue, 10 Nov 2026 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IoS6GPvY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66E61F008A1;
	Tue, 10 Nov 2026 07:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296119;
	bh=uoRWm8g+4dcdBOd1TXXWNxw9k/l1MQxwf8spyBkp6TE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IoS6GPvYr1wP53TYNA0xlqjwWphlyCY90QioconVqIfLj5U2EEcs+oT3lK9EvmVNn
	 udnB2VvTe8hlyiEJpQaX8f9DasXquDaN1BKlIAt+OpXDPLzF7ac8aCqaipFNVaT4vA
	 dIjkS1bboNa0gf9Bja35FFM6S2RWF2K6ygDxWL8Xgo5T0URQ+ABO9imQl8kcPf1+zY
	 sZyoiNfp81vlqYN1TBtir6QCN7ll/Jrt1qTu2t9JvyKbCIz0Zld9Xh1PYCIRD9DoNX
	 RrTfEAZCsA4fXnSB00iGbX85ZgqVnvStCeYDlK91o8Vb2QaEeURZnYe49m/cO2Qlxf
	 WiVDAjZwdFjYA==
Message-ID: <sashiko-outbox-206509@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/19] Input: serio - use the compatibility driver
 attachment API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109-device-trust-core-v2-9-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-9-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:18 +0000
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
- [High] Input: serio: serio_bind_driver() fails with -EPERM under
  default boot policy
--

commit 3fd95316c0bff9166a7d599c0aa06fa861dbf4de
Author: Leon Romanovsky <leon@kernel.org>

Input: serio - use the compatibility driver attachment API

This commit replaces the manual driver connect and bind sequence in
serio_bind_driver() with device_driver_attach_full().

> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> index 54dd26249b027..b54072769ab68 100644
> --- a/drivers/input/serio/serio.c
> +++ b/drivers/input/serio/serio.c
> @@ -81,28 +81,10 @@ static int serio_match_port(const struct serio_device=
_id *ids, struct serio *ser
> =20
>  static int serio_bind_driver(struct serio *serio, struct serio_driver *d=
rv)
>  {
> -	int error;
> -
> -	if (serio_match_port(drv->id_table, serio)) {
> -
> -		serio->dev.driver =3D &drv->driver;
> -		if (serio_connect_driver(serio, drv)) {
> -			serio->dev.driver =3D NULL;
> -			return -ENODEV;
> -		}
> +	if (!serio_match_port(drv->id_table, serio))
> +		return 0;
> =20
> -		error =3D device_bind_driver(&serio->dev);
> -		if (error) {
> -			dev_warn(&serio->dev,
> -				 "device_bind_driver() failed for %s (%s) and %s, error: %d\n",
> -				 serio->phys, serio->name,
> -				 drv->description, error);
> -			serio_disconnect_driver(serio);
> -			serio->dev.driver =3D NULL;
> -			return error;
> -		}
> -	}
> -	return 0;
> +	return device_driver_attach_full(&drv->driver, &serio->dev);
>  }

[Severity: High]
As reported by Dmitry Torokhov on v1 [1], serio_bind_driver() is only
called for explicit user-initiated binding via the drvctl sysfs attribute,
and it was requested that this patch be dropped from the series.

In addition, does switching serio_bind_driver() to
device_driver_attach_full() break manual binding via drvctl on default
boots?  Later in this series (commit "driver core: Introduce a generic
device trust level" and commit "driver core: Accept device trust policy on
the kernel command line"), device_driver_attach_full() calls
device_trust_prepare_full(), which returns -EPERM unless
device_trust.default=3Dfull was passed on the kernel command line.  When
userspace writes a driver name such as serio_raw to drvctl, drvctl_store()
disconnects the existing driver via serio_disconnect_port() and then
serio_bind_driver() fails with -EPERM, leaving the port unbound.

[1] https://lore.kernel.org/r/auy2plYVi723Qt42@google.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D9
