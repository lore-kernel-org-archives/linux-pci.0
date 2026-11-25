Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616088;
	b=KpNA7Y7bSiRUZyBfnbbjkGFzuB9XHRprcpqwZwq9shjYN1Cbr+ZgfN0SsDB7O+YhrNHk
	 kc9a2ogjB3GyzbvI0yIHMbk8mzybx62Ho1Sa7qzfUZFt8MwbQ+Fq0N1xaQryNnuuH8WCM
	 o1+bl4iG5/4sixqEXP8wyDpc/glhHHJ2+nL9tZK91NOqP/GtblcKXhCwKxOngjmp+VrG4
	 w3NKhC5qLpGM190PUu6L5GmphwP3J0msx2c1f4P/45a5crDAJIScAJpklXVT6vaqrn4wv
	 PSe3SUPL6dXhSmBTFbpABZr2C1V9IDVLdy6okf0rWDPhw8cpMMS1VvdSZcRvDvmqKNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616088;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Kv+akDX9Fsnwxn65LfxO/JR/K22GBsqiPUJfMBr0TqE=;
	b=Ja6woCd3zL5rphMXwB1Wftw2yTENdkp4pi1VsDpQT7rHLa7zRy8Y3Mw7fdWyR8vJUNKC
	 5reUJyO4JwwvYS+TC91Qg/OY7EWR07GlNFZbtBLui0hd/lMriojFgQl09rQqXGwdNw5zG
	 Hf3CsPOl98YYnN/2pY5uwxAvoaeadEF6B3RJZVFGZKQ1ILSy8kxAlOtTvmPGIaAWA8Q9C
	 ffYtiHEccJEjQV9PBd1HJj0liITXY16aHdCwf+JVwRDX522W80nzG2KLJn3pBNvSDZ4GR
	 h1Vu+DfhRTIYjP8P3FO1go3GTiZu0Fmi1PGHdOQmCkimKoBij+t7hjv8Am+JOWYxzcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E7Os5AEC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B161F606A31E;
	Wed, 25 Nov 2026 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E7Os5AEC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD1A1F000C6;
	Wed, 25 Nov 2026 14:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616087;
	bh=Kv+akDX9Fsnwxn65LfxO/JR/K22GBsqiPUJfMBr0TqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E7Os5AECGG/U0qU64nJiAP8nVuovNGts1h0W5oAZsSju8o/FVsoNHT93syGMV6/Kq
	 ZnFp4nYV37o1wK0h7iJwjcIPuN91C5XWMvgYWdgVfYGCamanAslUxELbgz7a/KpUSW
	 CxmW4Q8UAAHeFiyL+iNDKb36RZ0LC0MySIgcqBoy17BB/rUvvFemVYfiGTq7dZohUw
	 1DveJxOL9WtgvVvqWng7Zhv9FSaD0zgSqK3CYuxyYDV+n+t5VbGrd99biDrPEuzOk0
	 fmR01BrSuVLVqgwj5VHLUpjw6/MvRuFxXiqUpN/ifzSmKaWNApEYmw6irp7/YtSjcC
	 6sBxr9Y7w0+xQ==
Date: Wed, 25 Nov 2026 16:14:42 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v4 06/33] USB: Reject usbfs connect requests for
 unregistered interfaces
Message-ID: <20261125141442.GD14811@unreal>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-6-037eb0d17b1f@nvidia.com>
 <sashiko-outbox-233043@kernel.org>
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
In-Reply-To: <sashiko-outbox-233043@kernel.org>

On Wed, Nov 25, 2026 at 09:46:41AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] usb: core: devio: incorrect Fixes trailer in commit message
> --
> 
> commit ef85167342ae0257c27f5a71e468b1906042fdf9
> Author: Leon Romanovsky <leon@kernel.org>
> 
> > USB: Reject usbfs connect requests for unregistered interfaces
> >
> > USB core does not register DT-disabled interfaces, and an interface whose
> > registration failed stays in the active configuration. USBDEVFS_CONNECT
> > still asks driver core to attach a driver to such an interface:
> >
> > proc_ioctl()
> >   device_attach()
> >     __device_attach()
> >
> > The interface has no driver-core private data, so the request
> > dereferences a NULL pointer.
> >
> > Return -ENODEV for an unregistered interface. An interface claimed by a
> > sibling driver keeps reporting -EBUSY.
> >
> > Fixes: ef0ff68351be ("driver core: Probe devices asynchronously instead of the driver")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> [Severity: Low]
> Is the Fixes tag accurate?
> 
> Commit ef0ff68351be ("driver core: Probe devices asynchronously instead of
> the driver") only changed bus_add_driver() and __driver_attach(), which
> iterate over already-registered devices on bus->p->klist_devices.  At that
> point, __device_attach() on an unregistered device with dev->driver == NULL
> did not dereference dev->p and instead reached driver_probe_device(), which
> returned -ENODEV on !device_is_registered(dev).
> 
> The unconditional dev->p->dead dereference at the top of __device_attach()
> was added later by commit 654888327e9f ("driver core: Avoid binding drivers
> to dead devices"), while skipping registration for DT-disabled USB
> interfaces was introduced by commit 01fdf179f4b0 ("usb: core: skip
> interfaces disabled in devicetree").

I don't mind, whatever Sashiko says.

Thanks

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com?part=6
> 
