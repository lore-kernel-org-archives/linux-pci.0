Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320644;
	b=JpBp2YRmBgjWaDertyziLrDebF+rDmxI3hM7jplCj7vylBHA1FvAVzIGl/CAQ+EjIl71
	 +cnb8hJfscoGwYY0M/w7S9b9K24XvIf3qa0y98dwZryfWquR1/K86Y8E2bxUn8xCIJW/D
	 +s012KY2rapJANO/47PVThVeRXKHeSuATkcdx3D0KEG51KkhSYE24xAPdEi9EvbGPvWmR
	 8xRrt7fcsNtqAf089GmzEtMOk9Wl5fmDl+q0oMAonqaGg29pHy0Ei4KigTqcRqc7w1n68
	 S09gyBdiXio7S3yqYn+qBjhbq+g8VMOswl4Of/Ft30U0lBfWuvzHTa1P2HoqF0WzzjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320644;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LCluFXtvQpbxx25JetrKLg476Z535ceslprNTtU1UtI=;
	b=ELd/5NRptWbNsG157paqi7OIPZMU/9gA171XTOuTJ2g2GOZFubpNdrggmrnNXeDltWFs
	 2z35zLtBgyGcwDrCS+3y1cZOrK3XkB7j7UjOcYe1H9dV+f7DBVomBPLQZUgM3kMeYgvRH
	 Aq6DtPQDRE4K7pLlUJMgXg/CrxsJLMMSHMdAZpve+wAkl6NO6XDR3/uOSgTWh9nq50Z25
	 +v72gNWMLKa71NogpPT54TE8danAcaaPrrXRGnko4wEq/DvYmRbkpZ98Ti5+zuBh0BxG2
	 2OSGCwytyaQDPHv9V8zAZRXCA2LiIcX0cmS1GaU4JxAc06JeDGhoVPZrmxIxvjyjiEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FNj3tAT7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5A606A331;
	Tue, 10 Nov 2026 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FNj3tAT7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BD91F008A1;
	Tue, 10 Nov 2026 14:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320643;
	bh=LCluFXtvQpbxx25JetrKLg476Z535ceslprNTtU1UtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FNj3tAT7RXG+sVTdwakh9nstbaDnlsF9UZoXmr7vzTkiQUnpklettVj/dGjrnpVdW
	 aOjWMvLnR55G9T6FpXZqdAj1xlSzepO4aaeltyHBb0rVoTxNFptriWA4or3sfWBfPa
	 iHqg9mMdXni08o9Oz7zCnika3I7UWKi59gwCZZexnQtCZ9kvbqdQd/38zqCyF87JXD
	 /QsDtLn3vMHI8XBG7IvlMdogqgyrMZEUC5Se8w2Az7ZZqCxme9wRzAZgcwYnc85PJH
	 RDSTzWgdprMqKFgaMXrKf8dK6v+7vCsNISdgtmuWHwtEEzS8tqV24bg1bxr97O0psT
	 7Gq/AIFJVJIZQ==
Date: Tue, 10 Nov 2026 16:23:59 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v2 04/19] USB: Release interface claims refused during
 registration
Message-ID: <20261110142359.GI8635@unreal>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-4-3b12d9a9f861@nvidia.com>
 <sashiko-outbox-206504@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-206504@kernel.org>

On Tue, Nov 10, 2026 at 07:35:14AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] usb: core: unreleased interface claim when device_add() fails
>   or skips probe
> - [Medium] usb: core: skipped claim release when try_module_get() fails
>   in usb_set_configuration()
> --
> 
> commit fe8ed7c8ae2a463fe7346f0944a52ef057b538c6
> Author: Leon Romanovsky <leon@kernel.org>
> 
> USB: Release interface claims refused during registration
> 
> This commit tracks pre-registration interface claims across device_add() in
> usb_set_configuration() and invokes usb_driver_release_refused_claim() to
> unbind the interface if the driver core drops the claim during registration.
> 
> > diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> > index a738d03c23eac..d35a7710c8ef4 100644
> > --- a/drivers/usb/core/message.c
> > +++ b/drivers/usb/core/message.c
> > @@ -2264,6 +2264,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
> >  	 */
> >  	for (i = 0; i < nintf; ++i) {
> >  		struct usb_interface *intf = cp->interface[i];
> > +		struct device_driver *claimant;
> >  
> >  		if (intf->dev.of_node &&
> >  		    !of_device_is_available(intf->dev.of_node)) {
> > @@ -2277,7 +2278,14 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
> >  			dev_name(&intf->dev), configuration,
> >  			intf->cur_altsetting->desc.bInterfaceNumber);
> >  		device_enable_async_suspend(&intf->dev);
> > +		claimant = intf->dev.driver;
> > +		if (claimant && !try_module_get(claimant->owner))
> > +			claimant = NULL;
> 
> [Severity: Medium]
> Does clearing claimant to NULL when try_module_get() fails skip releasing
> the refused claim if the claimant module is concurrently unloading?
> 
> Binding a USB driver to an interface does not take a module reference on
> claimant->owner.  If delete_module() races with usb_set_configuration(),
> try_stop_module() sets MODULE_STATE_GOING (causing try_module_get() to fail)
> before mod->exit() -> usb_deregister() -> driver_detach() blocks on
> device_lock(&dev->dev) while detaching the already-bound sibling interface.
> 
> If device_add() then fails to bind intf and clears intf->dev.driver to NULL,
> usb_driver_release_refused_claim() is skipped because claimant is NULL, and
> the sibling's later usb_driver_release_interface() call returns early because
> intf->dev.driver is already NULL.  That leaves intf registered with
> intf->condition == USB_INTERFACE_BOUND and intf->dev.driver == NULL, which
> causes a NULL pointer dereference in usb_suspend_interface().

I have no idea if this flow is possible, but the fix to satisfy AI
review is relatively simple, so let's do it.

> 
> >  		ret = device_add(&intf->dev);
> > +		if (!ret && claimant && !intf->dev.driver)
> > +			usb_driver_release_refused_claim(intf, claimant);
> 
> [Severity: Medium]
> Can a pre-claimed interface also be left in USB_INTERFACE_BOUND state without
> a bound driver when device_add() returns an error or skips probing?

Yes, like before this change.

Thanks
