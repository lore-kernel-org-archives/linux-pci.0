Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428907;
	b=Cliha68fj6QJotxsCtLsan+bjhQ2Bja75zntWtlVg1PtjkGrdStBpZKypIaZ/LfE32kq
	 i7BPMKnjTDfqNgEBfMTrkjNSkGSnWEIgSL6sHSqoV5qPs1fT8QTZD1UbP/8Cl7678NN5T
	 oL7rGTRbhr/tubsAhR2++y0AKtJHFLXETGw0sbXYBT6RM9ofA9Cy0Czva15IVsJMbh2h4
	 d4gcWtiqm56X3VMLyFAT+EqLf/2il5LNtE+LmbLYsGSzgqEyN1e7w5tqIpisuAqUE5uEh
	 CWaD0SffKlSAKy9zMW5K21CgCVL10aTpoSIAQdPo+HRbf4OSO/QC0dWbnKq6VorkjyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428907;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=z6TkMoT9MxgbWnHBzyuTC8V77L9Vpuu7tz1FcGVO7Wg=;
	b=lqMgKBTQWZf5JceClyEFCJ9Rr+BaxQ7WqwFehQhmTXr14s0WkA6J0rnzMlkOMqWlEOT8
	 yyW715/T6ZpEicBOxLO1e6gvkPF0VOr8VGB+SM7BSoWyuDOIc3DBIlivb5rNGxiRqa9RJ
	 cHA2PBoKgOcmwFSzc0w3iTSb5JgYBiGMLcx3FiXazIicnE7MVn8A/Isw857FQo85Zx4uk
	 8wvhHPkDSDpXxkNmjutwsTOzT49tBijWa+di0+Qnze0oCFSQV0+hVxDayEfYr5mFIPHyr
	 ynqxlPpNhPI6qXUgAzKilo43yeBQscdic0oNPVxnm5gkPsQ5jOni5uN+eTFdYdT0Riw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlLWLyeN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2D606A321;
	Mon, 23 Nov 2026 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlLWLyeN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3EC1F000CA;
	Mon, 23 Nov 2026 10:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795428907;
	bh=z6TkMoT9MxgbWnHBzyuTC8V77L9Vpuu7tz1FcGVO7Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YlLWLyeNc6sEMupR6z34DHfmP0V2UC2pVDdt/I0dtI5bHeA/tp7o1uXSqJHLZxI0b
	 2sDToDo5rxBpaOV9HhzCuYX6O7j6jJa6dJm6CHA0wmA7ezUfs1uvVxiAaBvCxvm5NJ
	 SvwSP7TIU8zI/yXXWJv4MrOGOdp3fU9wDvJFmBqEVFfWHSfDnGXhI1LLx6LN2BRccN
	 N51BsiHoD+rDy+wvlSTSvoTT8AJacyNRt/0DXK/O3DT4WVHctZwS25hP3zXQ1Lvipx
	 WP095TAVzmROt3gkFFH1tOZGj8J+JLrZHvJ/Tx9RQSBp+0bZi+43ldi/rQ/99JGQeG
	 NCVmIQ8/lQU5A==
Date: Mon, 23 Nov 2026 12:15:01 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v3 15/31] driver core: Add a compatibility API for manual
 driver attachment
Message-ID: <20261123101501.GM14811@unreal>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-15-d655875c4bfb@nvidia.com>
 <sashiko-outbox-223901@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-223901@kernel.org>

On Thu, Nov 19, 2026 at 07:29:34PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] driver core: dev->p dereferenced before dev_ready_to_probe()
>   check
> --
> 
> commit 25b9e856ab045cdfdef1969512d8e94dbd1559f4
> Author: Leon Romanovsky <leon@kernel.org>
> 
> driver core: Add a compatibility API for manual driver attachment
> 
> This commit adds device_driver_attach_unrestricted() and a per-device
> driver_lock mutex to serialize manual driver attachment, probing, removal,
> and deletion without requiring callers to hold the device mutex.
> 
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 52123251965de..6ac1486b9fbb5 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> [ ... ]
> > @@ -545,16 +560,85 @@ int device_bind_driver(struct device *dev)
> >  {
> >  	int ret;
> >  
> > -	ret = driver_sysfs_add(dev);
> > -	if (!ret) {
> > -		device_links_force_bind(dev);
> > -		driver_bound(dev);
> > +	mutex_lock(&dev->p->driver_lock);
> > +	ret = __device_bind_driver(dev);
> > +	mutex_unlock(&dev->p->driver_lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(device_bind_driver);
> > +
> [ ... ]
> > +int device_driver_attach_unrestricted(const struct device_driver *drv,
> > +				      struct device *dev)
> > +{
> > +	int ret;
> > +
> > +	if (!device_is_registered(dev))
> > +		return -ENODEV;
> > +	if (!mutex_trylock(&dev->p->driver_lock))
> > +		return -EBUSY;
> > +	if (dev->p->dead) {
> > +		ret = -ENODEV;
> > +		goto unlock;
> > +	}
> > +	if (!dev_ready_to_probe(dev)) {
> > +		ret = -EAGAIN;
> > +		goto unlock;
> > +	}
> 
> [Severity: Medium]
> Can device_driver_attach_unrestricted() and device_bind_driver() hit a
> use-after-free or NULL pointer dereference on dev->p when device_add()
> fails?

The thing that it is pre-existing as well __driver_probe_device() has
the same order.

Thanks

> 
> In device_add(), kobject_add() sets dev->kobj.state_in_sysfs before the
> remaining fallible registration steps run, while dev_set_ready_to_probe()
> is only called after all of those steps succeed.  If any step in between
> fails, device_add() unwinds through name_error and frees dev->p without
> taking dev->p->driver_lock:
> 
> CPU0                                  CPU1
> device_add(dev)
>   kobject_add(&dev->kobj, ...)
>   ...
>                                       device_driver_attach_unrestricted()
>                                         device_is_registered(dev) -> true
>   dpm_sysfs_add(dev) -> fails
>   ...
>   kobject_del(&dev->kobj)
>   kfree(dev->p)
>   dev->p = NULL
>                                         mutex_trylock(&dev->p->driver_lock)
>                                           <-- use-after-free / NULL deref
> 
> Unlike waiting_for_supplier_show() in this commit, which checks
> dev_ready_to_probe(dev) (stored in dev->flags) before reading
> dev->p->dead, device_driver_attach_unrestricted() touches
> dev->p->driver_lock and dev->p->dead before checking
> dev_ready_to_probe(dev).  device_bind_driver() similarly locks
> dev->p->driver_lock without checking dev->p or dev_ready_to_probe(dev).
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com?part=15
> 
