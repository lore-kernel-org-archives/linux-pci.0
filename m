Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629823;
	b=C7fiuoMz7oxquCcdY3pWcflMgOPoz5kA5DZ8pNirh3GfPHmlfVnklwAq6CqZvFmEMoYg
	 O17I6VRUoptLT9PvKsBAOHudi9yDk+/J6N2q8AD+pJPa2PdOe9skHdbBYL5T8BXy20gpt
	 ZV9rIXRig91Oz5QNhDRZu5LY8YTOc6CKxTGskwpiT/xksQCYybR4uPTcZAyCah97q9cqX
	 V07muln6+BJKYdt+CI+z4qRGDYkKyWrmoqqzpOh1PQit1bKsZR0qzdvL518phS0Qn2RrL
	 kP2K8jSTPt1C6V8Kw26Zs9DjUV623agqfHDiqqfQh8Ruo2fOPVjXhm/L6xMTozP1mtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629823;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=hlpId+rVODIMOjXZ2atqTUbn29vNX4fN0j8YfFE6hoc=;
	b=g4fNntMFVm7PAp5hj3P24+6nrrz57f3+1FSFwmlKAFlRGRuoUWNwNrUkG/0nQOSQv95z
	 FU1nsxMH4RUrBVrS6m2wsG1IUYZIHo/dgURgumNkWd5YzjYX/yiK+R66Pgg5wz/SBi4dZ
	 VI5cuCgLS3v2AUgEtUb7wEp3NQ1rs7ijc5zcVOMMt2IuuSRqJ1OB2XQ6N+OewpOXeSuAp
	 XcGjfB0k6PQpNMycrI5n/7X+ohvRXfkHEOTUIUooWSN2i/xcm4aEHiOFfd5+qzAVA5dbP
	 gQoU/7qy56kUCxwouIRkFSRiTkGLEkAH0x5v7LK519Bh0by2tuv7JGKYm6Sn1vzsMpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQAvtQO1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9722A606A321;
	Wed, 25 Nov 2026 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQAvtQO1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFDC1F000E0;
	Wed, 25 Nov 2026 18:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629823;
	bh=hlpId+rVODIMOjXZ2atqTUbn29vNX4fN0j8YfFE6hoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZQAvtQO1hScRjsP+H3QUGmsCoWNNDzegkV8UWbr/wVV/cQ85viL2eNiI+0ntu0Jvt
	 lUNpkL75Lml/uKZYmGR3G9qY6Xh2JU6s3FL5rXOeDINCJqOJNA6n5904PLZhsRRPbi
	 z/N6e59Ll5NUmX5SXix4tCk5sbozjAUs55EhjlHHRugO2KyJnA441xaLYMQcxXwJAV
	 rIJ7yLQpWz3I3zi6k66GMq22JOr22qbRXjMhFoSyka5ovUmfdtXLa/nvpSYgt2xTuB
	 Q8CJ+4uriOsxb9a+oyg8EC59aUhFK0KKRJvCMM7C6Iu2EMMr2UdGHoXKYZMwEp5HGE
	 CELc9bPI9SIvA==
Date: Wed, 25 Nov 2026 20:03:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v4 16/33] driver core: Add a compatibility API for manual
 driver attachment
Message-ID: <20261125180338.GE14811@unreal>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-16-037eb0d17b1f@nvidia.com>
 <sashiko-outbox-233053@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-233053@kernel.org>

On Wed, Nov 25, 2026 at 09:46:42AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] driver core: dev->p dereferenced before dev_ready_to_probe()
>   check
> --
> 
> commit 5a1e46424b0dbbd5e29618593c53f6f0928c9f00
> Author: Leon Romanovsky <leon@kernel.org>
> 
> driver core: Add a compatibility API for manual driver attachment
> 
> This commit adds device_driver_attach_unrestricted() and a per-device
> driver_lock mutex to serialize manual driver binding with normal probing,
> removal, and device deletion.
> 
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 52123251965de..6ac1486b9fbb5 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> 
> [ ... ]
> 
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
> Can this dereference dev->p after or while device_add() frees it on an
> error path?

The same answer as for v3 still applies.
“The thing that it is pre-existing as well __driver_probe_device() has the same order.” 

Thanks
