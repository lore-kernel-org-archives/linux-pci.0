Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15260381AE5;
	Thu, 13 Aug 2026 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603907; cv=none; b=P+JRMjzehZHs8Ioi8dIuJUUZMXCa5PCrnTz6Kfbf7ZayrI3OqicAfQpYym1zc21h2LWCh7r6YYi7LLfRkyBu/FKdBnVH2DmQQrc2FBnNm/WAP0OQbBeGWKH8AwHmYm0NjaLZ5EGaoQ4mtroxTzLv6Hbv/gzYy7vF+POJfP5WZ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603907; c=relaxed/simple;
	bh=gzfMLkPgbJdzIpsG8VDwd7qkaFNAysB6ikulMxufisw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PnE4YMUBPW42j3TNhqMcXNpzKIxj2NwmzFpdM1GS6mkh2uP8kxFEGDNLkoT75dUVNxQ2xE8GlNfszbQUavS+rrQwBgG7ViV9hBxjLf9IHanEE7Lvnlw5WZwMgBM0YxLkXEnTDg85Min/55MS+Iw12frtPs4MQ+20PdOuNCvwdUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMcHBEh5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMcHBEh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D771F000E9;
	Thu, 13 Aug 2026 06:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603905;
	bh=Spd8VBELnEnq1/BO8p4EY6HT8GuV5jD7Jem86/9cOBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UMcHBEh5a9io2uhct1+GDLU8OnCVD+wLAglPq8YnJyHxN768omi3zsKXqGF6zrNHI
	 qbrZMcPwBb3Clb0gqEtcBLWoPUaW+06momaZxM8Vr0Dpf8+iY4JQxBODvnAOBekZ9T
	 v9oP4BLXVi51Yczu4f9QLbUZe273Si02ncMBREj9iJGeg+IUkNGho68Fmgo9bXCvbH
	 iERosdff8+eIQQitSoCIr89rCEFENXTmn8n6B1Qr+m79OZAaVdE/q7/6EwS9SrdVNQ
	 eOi3Fptd8hAsefnaQ5IX57BR1KNl3i3b2YLVod0BKRm3C7u7/nRH3oUYto3eUBNZZx
	 mxjuyck5o1kSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/10] dmaengine: Allow drivers to assign static
 channel IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260813063757.3131865-2-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 06:51:45 +0000
Message-Id: <20260813065145.74D771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory and ID leak in the error rollback path of dma_async_device_=
register() when a subset of channels fail to register.
- [High] Directly calling kfree() on a device struct after device_register(=
) fails, leading to kobject resource leaks and potential use-after-free.
- [High] dma_channel_rebalance() is called without holding dma_list_mutex w=
hen dynamically registering or unregistering channels.
- [Medium] device->chancnt is incremented without synchronization, leading =
to data races during dynamic channel registration.
--

--- Patch [1]: [PATCH v7 01/10] dmaengine: Allow drivers to assign static c=
hannel IDs ---
commit d88a921ed93cbdf57ab5a802c1f278694ad4200a
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: Allow drivers to assign static channel IDs

The dmaengine core assigns channel IDs in registration order. If a driver s=
kips
a hardware channel, chan_id can differ from the hardware numbering and a cl=
ient
cannot reliably correlate a requested channel with hardware resources. Let a
driver request an exact channel ID before device registration.

Link: https://lore.kernel.org/r/lm7tadnxsyrypu4mypptlkx5qkytex4qxsijdr5ydud=
2n3anvf@yakjfjg5ng4u/

> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 6ffd8bd82154a..cc64a4679e6fa 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1078,6 +1078,7 @@ static int __dma_async_device_channel_register(stru=
ct dma_device *device,
>  					       struct dma_chan *chan,
>  					       const char *name)
>  {
> +	unsigned int id;
>  	int rc;
> =20
>  	chan->local =3D alloc_percpu(typeof(*chan->local));

[ ... ]

> -	/*
> -	 * When the chan_id is a negative value, we are dynamically adding
> -	 * the channel. Otherwise we are static enumerating.
> -	 */
> -	chan->chan_id =3D ida_alloc(&device->chan_ida, GFP_KERNEL);
> +	if (chan->chan_id & DMA_CHAN_ID_STATIC) {
> +		id =3D chan->chan_id & ~DMA_CHAN_ID_STATIC;
> +		chan->chan_id =3D ida_alloc_range(&device->chan_ida, id, id,
> +						GFP_KERNEL);
> +	} else {
> +		chan->chan_id =3D ida_alloc(&device->chan_ida, GFP_KERNEL);
> +	}
>  	if (chan->chan_id < 0) {
>  		pr_err("%s: unable to alloc ida for chan: %d\n",
>  		       __func__, chan->chan_id);

[Severity: High]
This is a pre-existing issue, but does the error rollback path in
dma_async_device_register() leak IDs?

drivers/dma/dmaengine.c:dma_async_device_register() {
...
	err_out:
		/* if we never registered a channel just release the idr */
		if (!device->chancnt) {
			ida_free(&dma_ida, device->dev_id);
			return rc;
		}

		list_for_each_entry(chan, &device->channels, device_node) {
			if (chan->local =3D=3D NULL)
				continue;
			mutex_lock(&dma_list_mutex);
			chan->dev->chan =3D NULL;
			mutex_unlock(&dma_list_mutex);
			device_unregister(&chan->dev->device);
			free_percpu(chan->local);
		}
		return rc;
}

If channel registration fails and one or more channels were already success=
fully
registered (device->chancnt > 0), it skips ida_free(&dma_ida, device->dev_i=
d).

Additionally, the rollback loop unregisters the previously successful chann=
els
but appears to miss calling ida_free(&device->chan_ida, chan->chan_id), whi=
ch
could permanently leak the channel IDs and their associated memory.


[Severity: High]
This is a pre-existing issue, but is it safe to use kfree() after
device_register() fails?

drivers/dma/dmaengine.c:__dma_async_device_channel_register() {
...
	rc =3D device_register(&chan->dev->device);
	if (rc)
		goto err_out_ida;
...
 err_out_ida:
	ida_free(&device->chan_ida, chan->chan_id);
 err_free_dev:
	kfree(chan->dev);
 err_free_local:
	free_percpu(chan->local);
...
}

If device_register(&chan->dev->device) fails, the error handler directly ca=
lls
kfree(chan->dev).

Once device_initialize() has been called (internally by device_register()),
shouldn't put_device() be used to clean up the kobject state and avoid leak=
ing
the device name string?


[Severity: High]
This is a pre-existing issue, but are these list operations safe from data
races?

drivers/dma/dmaengine.c:dma_async_device_channel_register() {
...
	dma_channel_rebalance();
...
}

drivers/dma/dmaengine.c:dma_async_device_channel_unregister() {
...
	dma_channel_rebalance();
...
}

When dynamically registering or unregistering channels, dma_channel_rebalan=
ce()
is called without acquiring dma_list_mutex.

Since dma_channel_rebalance() locklessly iterates over the global
dma_device_list, could this cause list corruption if another device is
concurrently registered or unregistered?


[Severity: Medium]
This is a pre-existing issue, but does device->chancnt need synchronization
here?

drivers/dma/dmaengine.c:__dma_async_device_channel_register() {
...
	chan->client_count =3D 0;
	device->chancnt++;
...
}

The increment device->chancnt++ is performed without holding dma_list_mutex=
 or
any other lock.

If multiple channels are dynamically registered concurrently on the same de=
vice,
could updates to this counter be lost?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813063757.3131=
865-1-den@valinux.co.jp?part=3D1
