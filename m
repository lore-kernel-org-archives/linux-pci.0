Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116575;
	b=Z39XSEbXEpyoQXEbZxOLCA0kg0lpdoobbmUitB/LTzrdWhTAHHzU+sMcRe9fGF8tfA9R
	 pWPufA3dfqa/3F3UTmRzsMklRAblsMrZ7+XBkC7OmVPWsqB6D6fxcHMR1DgR/NHzQHOED
	 umZuG9AWSpLgORy1vaN4rgXHXHX7QyCFwQ3q5drwCFoXnNECrE4qphBCAdhOaclzqOegg
	 x5dPE122qszSTTn/AHgarLCI6fR67uxLSi12BbjUbWjpcsIuDyECBM3D8u1L8dBEhlBTk
	 qsiPD309YlrSI4hCdFA8dG4z2pjuqNpBGJJT5MQV6tyWzGDfiF4inOK6/4xS02oTrrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116575;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OqvWvWSEWOMAPcWD1E1yQ4+agcuuth8y8Vk9KOcS+2A=;
	b=0SeswfS7JCrUkGORoNJXTFz+HzYqN47axbGzMwrlY8e+foiSGu4/f+KS/iuNdXA3fEd2
	 Ev7ms8+Yl4ysCNC1U+rVEyu+NnkHGpgmfDBo46A2ih8kN8b50HxJTlIe8MocFjZiU+zy5
	 uVXOGSd1pWvsar5xgSZW8bUnROtFd+n5921V57kvNj1ZxjXp9ArFLp6OE+kPYfdtuWvSv
	 N2hyaWh0horuoeJyFlkBOTwerQciHRKAnxDGwa3WOL+bxi5w3PrMLGtXNPHvteM8xeIe8
	 52oAX+C9znBjJLFwGs0i+UuHoq9MxrDRdtImVCXn0a/v/vFbyTCsKccE1wM21M3ywZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ja/9MZey";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE42606A337;
	Thu, 19 Nov 2026 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ja/9MZey
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCCA1F000C8;
	Thu, 19 Nov 2026 19:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116575;
	bh=OqvWvWSEWOMAPcWD1E1yQ4+agcuuth8y8Vk9KOcS+2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ja/9MZeycAsVNq703u3OfdACFlM7zE5N4LmYsA4qEp8JXoEoZNpvZfnqPE9nVFc0f
	 h92yL3q+Z6hdu1HjgD6LTTCz9kDaTbhAWIseYlch7Kh6wG6XQZ86SDNhTbUW2mXIyZ
	 OIUDZyy3buDT+uB1U/LkBu31xkJVEdX3xHHchu9lRKvyIdo7B5z7Z2Msbi+jCewnKR
	 mrExvh3r2KuaHTnImlv9JOyzuG/Vp6cmWjjKI7VdK5bqcCAjVRUFA00GIHJ6PEwg2c
	 o80UCH+o00i7p+NYVvTNis7+zqn0reLlQc3bt/0IiHw3GM2BjWMsPlA0w6m0bxeBKj
	 CoqU6CGETRmOQ==
Message-ID: <sashiko-outbox-223901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/31] driver core: Add a compatibility API for
 manual driver attachment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118-device-trust-core-v3-15-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-15-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:34 +0000
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
- [Medium] driver core: dev->p dereferenced before dev_ready_to_probe()
  check
--

commit 25b9e856ab045cdfdef1969512d8e94dbd1559f4
Author: Leon Romanovsky <leon@kernel.org>

driver core: Add a compatibility API for manual driver attachment

This commit adds device_driver_attach_unrestricted() and a per-device
driver_lock mutex to serialize manual driver attachment, probing, removal,
and deletion without requiring callers to hold the device mutex.

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 52123251965de..6ac1486b9fbb5 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
[ ... ]
> @@ -545,16 +560,85 @@ int device_bind_driver(struct device *dev)
>  {
>  	int ret;
> =20
> -	ret =3D driver_sysfs_add(dev);
> -	if (!ret) {
> -		device_links_force_bind(dev);
> -		driver_bound(dev);
> +	mutex_lock(&dev->p->driver_lock);
> +	ret =3D __device_bind_driver(dev);
> +	mutex_unlock(&dev->p->driver_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(device_bind_driver);
> +
[ ... ]
> +int device_driver_attach_unrestricted(const struct device_driver *drv,
> +				      struct device *dev)
> +{
> +	int ret;
> +
> +	if (!device_is_registered(dev))
> +		return -ENODEV;
> +	if (!mutex_trylock(&dev->p->driver_lock))
> +		return -EBUSY;
> +	if (dev->p->dead) {
> +		ret =3D -ENODEV;
> +		goto unlock;
> +	}
> +	if (!dev_ready_to_probe(dev)) {
> +		ret =3D -EAGAIN;
> +		goto unlock;
> +	}

[Severity: Medium]
Can device_driver_attach_unrestricted() and device_bind_driver() hit a
use-after-free or NULL pointer dereference on dev->p when device_add()
fails?

In device_add(), kobject_add() sets dev->kobj.state_in_sysfs before the
remaining fallible registration steps run, while dev_set_ready_to_probe()
is only called after all of those steps succeed.  If any step in between
fails, device_add() unwinds through name_error and frees dev->p without
taking dev->p->driver_lock:

CPU0                                  CPU1
device_add(dev)
  kobject_add(&dev->kobj, ...)
  ...
                                      device_driver_attach_unrestricted()
                                        device_is_registered(dev) -> true
  dpm_sysfs_add(dev) -> fails
  ...
  kobject_del(&dev->kobj)
  kfree(dev->p)
  dev->p =3D NULL
                                        mutex_trylock(&dev->p->driver_lock)
                                          <-- use-after-free / NULL deref

Unlike waiting_for_supplier_show() in this commit, which checks
dev_ready_to_probe(dev) (stored in dev->flags) before reading
dev->p->dead, device_driver_attach_unrestricted() touches
dev->p->driver_lock and dev->p->dead before checking
dev_ready_to_probe(dev).  device_bind_driver() similarly locks
dev->p->driver_lock without checking dev->p or dev_ready_to_probe(dev).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D15
