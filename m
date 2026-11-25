Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600008;
	b=YgT3q3/sAmr/l6Bic5YY67uDzsmq1fpkGt4+LHBhDPRCS5NXKFOAJtcsf5spzyNHs8Yn
	 MF9oF3hqoI1xNJj8lPRWsApq2XX+6I/9LvsBz4ZmlrDEcxtG2aU62Tte1hHcsdRT9E3Wu
	 02C+ADCTG5nEttCWGfW4xFQrhz8ot2Lm1gOiymuKr4p2YsZWUMxk6DDH8s15YAasCtLoF
	 aNcsW4i/TkXXJUnapQZ/rnh0oOEw9Ie2hT+H0dn0rzb8f7Ba/hKWGuVvkg0wGKlFou+TA
	 FAtZwH0ycI477p8XFaIp8XuiRnIbLtcWlIfU9OhzlcInR6WW58vBAFeMZAVtiiucn0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600008;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oFeLu7EEDvClRzVwizYa0Eo4zJlKAa12pT6RWv0WOrw=;
	b=bDZTOMEDoQA8506YoxnY5Wvz4D0TDB2V+Umu+Ps/eJSG5mKmYiiYK66xgnA/w7pIB5J+
	 PPQq9CqkgQLQxRjTyScSt9u8/fqFPC4IkLx0CHxTIdzkYT9IG6wUPmj1l2EwPzTfSvITa
	 lK6b63vWzJhgwyM7tyFPbXkj/Gu/4vgTjQ/z1tGNUl/3tXv0/uEVJgrXSNrAAc+UwWQUG
	 j1ABwroLDD65mTLzacBlSocCpf66XBCrRpL/Vbu88dt1TTYAZInUFYBlSUb+mrkKVdYZ1
	 /udqJ6htdn7dropBBLRSCUEoyREFPa+lqZsahT1UPdcIxmWEMuoooD2N3BgVikW/R1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1lfBPOO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9B606A327;
	Wed, 25 Nov 2026 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1lfBPOO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5741F000C6;
	Wed, 25 Nov 2026 09:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795600008;
	bh=oFeLu7EEDvClRzVwizYa0Eo4zJlKAa12pT6RWv0WOrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S1lfBPOOKBCeBvYW5N8RAlkDblE9Oba9fA2LSs0wOJfphi48iiQNHyviYw8BmmBG0
	 sFK8NZScAss4nmXwEH3YQUx1q+tPJGH9Waig+ofXg6S9sj4zy6GvNbrDapK196ZMpx
	 Ab2gPWu/DlDh2sdw/nsq/HTMzNJCKKwuJiDau0q9WDiBLnQOYNuvvgU7NpV8T0HcsG
	 C7omolF55+acX7PAR3S1QuyqrCeRr5tZGSlZBczPLAK1QD0axSjudmNoBKNwdFr6e+
	 FswjaFyWWXFiOcTP4t1JPaOrGUcrKoA2/3w8+89BEM6tTqE+OnUgy4VZoVQCbBjkLL
	 9v7o3/r6ImyYg==
Message-ID: <sashiko-outbox-233070@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 33/33] USB: Authorize devices through device trust
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261124-device-trust-core-v4-33-037eb0d17b1f@nvidia.com>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-33-037eb0d17b1f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:46:47 +0000
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
- [Low] usb: stale config_error in usb_authorize_device() when no config
  is chosen
--

commit e933bc32d14e8dc32abb1afc1a81475eeaa3569d
Author: Leon Romanovsky <leon@kernel.org>

USB: Authorize devices through device trust

This commit integrates USB device authorization with the device trust
framework so that device driver admission precedes configuration when
device trust is enabled, and tracks configuration errors under the device
lock to allow retries.

> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 372bd6368cc94..c94539b0c697c 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c

[ ... ]

> @@ -2787,17 +2788,41 @@ int usb_deauthorize_device(struct usb_device *usb=
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

[Severity: Low]
Should the non-attach path in usb_authorize_device() also clear
usb_dev->config_error =3D 0 before calling usb_choose_configuration()?

Unlike the attach branch, the non-attach path only updates
usb_dev->config_error when usb_choose_configuration() returns c >=3D 0 and
usb_set_configuration() runs.  If a previous configuration attempt failed
(leaving usb_dev->config_error non-zero and usb_dev->actconfig NULL) and
usb_choose_configuration() returns -1 because no suitable configuration
exists, the stale error remains set and subsequent writes of 1 to the
authorized attribute will bypass the early return and repeatedly re-run
autoresume and configuration selection instead of returning as a no-op.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-device-tru=
st-core-v4-0-037eb0d17b1f@nvidia.com?part=3D33
