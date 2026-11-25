Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600003;
	b=4kB5ChJkgXCyk4ianpBcVZfIktUyGlv5LHjZ7iDJu2x/5L6S0pr2twFv4q1OFWxUvTm7
	 kK83ZmGRJrD8UxZY78FXaKcItXFVNzVmBbVqYYQYf5eaL93NIs5e7aLgLyNfi8Ye6GShQ
	 +ZVk9q6OD1nwWoTmMNLWE7Gna6M2u7UR3cwJALXnstS2b/Uzu/smKNqsfwYD6QQgux6W2
	 Whc7DzmFLGJZdC+H8rsbbg0GiUd5ViDv0ieUTVEkfEDQe5bhqlUl50dI4tL3VyX4ot1aj
	 mI/RcPYhoXDm0K16gTrzC9LzyteuHxR3vb2UgJ6SgCmMJDD1aSp3I35ZloT3iFwlRvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600003;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A/HYs9qmkoLxn9WF0VxRASDX9C3y7gHzK+NdjwM56D0=;
	b=kX3tHkMbk1/7IM0O4YRV6cfMaGbWmq17T8/9tQvmbTR/8Y/dcLjbcj92aoxtlvAMzN9S
	 X4OY3TIJYnV21O2wQMAf5i7CYVB/XLrzhyIRdkxYGb0qHmwFvikPzLfpUXQcqX24omTx8
	 MyBwGKczkwTMyQ72MpPZhRa+TnLbUOQOu6gNc2Xv4zPJUV2Z6phzzbIa+WrQeatJwv3+j
	 YJkrlmIX7NswavTC4FoBZ2gXkUlM/5n0ikbDR3L1qwobrOD88OMZAJNmdcj3JbbJbinUQ
	 XmomFHiQHd2wJY2HKy3TCYPG70nApnm6ccy/kAwrmppC7pfxolaq51JOS5P73gnsHQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDMQmQjj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44B606A331;
	Wed, 25 Nov 2026 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDMQmQjj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6971F000D0;
	Wed, 25 Nov 2026 09:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795600003;
	bh=A/HYs9qmkoLxn9WF0VxRASDX9C3y7gHzK+NdjwM56D0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hDMQmQjjCHdZafFawZ0dC1u7SVThldiMBNWqD4gq3grda8mlX4ZGVciOZhPhOiI2O
	 slCixTEIFdPVOwK3BUIf78pGBd/MIDWZnCZ3948Dca+UZQ6+SWD5BDY1IUYES/b+x9
	 tcq/0eo+HR9ucmGSB+P2ui5zWQKAq94qjTGOTX9Y6S1Qi2UHy4jrvZX+XAwJHrzeYU
	 IaY7x4S3UBc7V8czj0kSV2fBZkkhY2/M4QtOsi1eYPZUkp3zfMk42rsXTadGVoIFEY
	 xGbnLOFBqEdAYzSoEFAkrej7F9JTx9gpuP26dN6xTzyerxPAUQ+5GiITspqiKTm0kF
	 eYvzAaZZYO/Qg==
Message-ID: <sashiko-outbox-233053@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/33] driver core: Add a compatibility API for
 manual driver attachment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261124-device-trust-core-v4-16-037eb0d17b1f@nvidia.com>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-16-037eb0d17b1f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:46:42 +0000
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

commit 5a1e46424b0dbbd5e29618593c53f6f0928c9f00
Author: Leon Romanovsky <leon@kernel.org>

driver core: Add a compatibility API for manual driver attachment

This commit adds device_driver_attach_unrestricted() and a per-device
driver_lock mutex to serialize manual driver binding with normal probing,
removal, and device deletion.

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 52123251965de..6ac1486b9fbb5 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c

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
Can this dereference dev->p after or while device_add() frees it on an
error path?

In device_add(), kobject_add() sets dev->kobj.state_in_sysfs =3D 1, so
device_is_registered(dev) becomes true before several fallible steps
(such as bus_add_device() and dpm_sysfs_add()) run.
dev_set_ready_to_probe(dev) is only called after all fallible steps have
succeeded; if an earlier step fails, device_add() frees dev->p and clears
it to NULL without holding device_lock(dev) or driver_lock:

CPU0                              CPU1
device_add(dev)
  kobject_add(&dev->kobj, ...)
    state_in_sysfs =3D 1
                                  device_driver_attach_unrestricted()
                                    if (!device_is_registered(dev))
  bus_add_device(dev) -> fails
  ...
  kfree(dev->p);
  dev->p =3D NULL;
                                    mutex_trylock(&dev->p->driver_lock)
                                      <-- use-after-free / NULL deref

Unlike waiting_for_supplier_show() in this patch, which checks
dev_ready_to_probe(dev) before touching dev->p->dead, this function
dereferences dev->p->driver_lock and dev->p->dead before checking
dev_ready_to_probe(dev).  Similarly, device_release_driver_internal()
checks !dev->p without holding a lock before __device_driver_lock()
acquires dev->p->driver_lock, and __device_attach() locks
dev->p->driver_lock without checking dev_ready_to_probe(dev) or dev->p.

Checking dev_ready_to_probe(dev) before accessing dev->p ensures
device_add() can no longer fail and free dev->p.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-device-tru=
st-core-v4-0-037eb0d17b1f@nvidia.com?part=3D16
