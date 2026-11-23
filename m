Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423711;
	b=K2ShcKP8q8smgBM3l19VZ2S6rHNb60/LLQalXlwqjBO0HgiqA/uSDYIQsoXACLON6D9I
	 nbPbk13/l/K68dwRt+P2uZByp1xLaXZ6YcysSmakdcmdXtmCaTxS9Cd9Le/qnJz+/20aE
	 1AiHZMp6JfzTgRJQBPKxcrfwSicV9rz9AM6Mtg7/rf4LlrEV+UzMUyeRVG4jQ0RzRR3uP
	 lDe4FMS/nizMvx5EKjAjmMyRKSNcv2niF+8ARyCqeKfyL1UrvZCNa45yGQFO72IsK6ip6
	 wW7Bt9KQK+rZL8IKQVG68Or5felf4s8mFv76U+CVajIWRITI36voNTlvmXObBH9g3UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423711;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nwKJl00tpwdLLtoEZ27UPU0xq2dCJMGiy6FAFfkNDtk=;
	b=HSK0AOq3pSTvrRchOmhfYhTICWCHry2XCcgg+F1YU5YTgEKpc8nwRTNQ1DGmWSgTUoPQ
	 nnQ80vpmHFzqGU+ydBB7D9A2N+TuGtVwKYYRIrLS8nN9ionZHXqCFB37QqwaPc/dbKPa0
	 V2iystWCo5xQWDIgGdUHwkXfNfvhjqbGCJNuLIJ5SPU4zE0bIQfKcij0EE8vU5hkvrST9
	 OgpOilLgkiAcQr1BVwjfzvsXBrNVTEldxjQtNBzI4NgdtA6rBvxrec71VzZGVOtNltkCR
	 Bnn1PLcRWIvhHgd8Tt7Pm64hFsMHbPXtsKgbMzs7QMJDutdAeLy54DhljVtuJ5R/paQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z/hgRgEi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3575606A31E;
	Mon, 23 Nov 2026 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z/hgRgEi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2851F000D0;
	Mon, 23 Nov 2026 08:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795423711;
	bh=nwKJl00tpwdLLtoEZ27UPU0xq2dCJMGiy6FAFfkNDtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z/hgRgEiZXH+GOjsznrUlAcd6Pq3ZE9bvNHbRTtnKCtfArV9H03FPjlty2mJMcajD
	 lZ+Kh/YIrpgPzhxkovGb5ALDef929PqUA0FN9yYlFoQfsfx6MpH2vb3Hra94LSuKDv
	 Oc7d0+Bnj+FAKnSpmr+qeMZdWy/kcR7iG0Amyecekdaz8Z9EaVwaZzUrT1BZprNH0N
	 JsxCafbmVxsZHsoqGJgpF4SnBvEWVd8bg+GKEBXl8NkH0vXo+ty6xBn3Z8/m30TTnh
	 vC1NTr9+Q7HLpP63seG2GKsN0DbomgBATQ6/MmmhVSOBDlyD+BaB9/pGvJhZOvQRLj
	 5/x8iK+NXxdlQ==
Date: Mon, 23 Nov 2026 10:48:26 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v3 09/31] USB: Pin modules for unregistered interface
 claims
Message-ID: <20261123084826.GJ14811@unreal>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-9-d655875c4bfb@nvidia.com>
 <sashiko-outbox-223895@kernel.org>
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
In-Reply-To: <sashiko-outbox-223895@kernel.org>

On Thu, Nov 19, 2026 at 07:29:27PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] usb: core: premature claim_owner release in
>   usb_set_configuration()
> --
> 
> commit afd725f56c3717b2e1f97538c7c8fdee117c4deb
> Author: Leon Romanovsky <leon@kernel.org>
> 
> USB: Pin modules for unregistered interface claims
> 
> This commit pins the owning driver module in struct usb_interface.claim_owner
> when an interface is claimed before registration, and releases that reference
> upon interface registration or claim teardown.
> 
> > diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> > index 0a6fdf2e88f4e..b7bd9226d2627 100644
> > --- a/drivers/usb/core/driver.c
> > +++ b/drivers/usb/core/driver.c
> [ ... ]
> > @@ -619,6 +634,7 @@ static void usb_unbind_claim(struct usb_interface *iface)
> >  	usb_unbind_interface(dev);
> >  	dev_set_drvdata(dev, NULL);
> >  	dev->driver = NULL;
> > +	usb_put_claim_owner(iface);
> >  }
> >  
> >  /**
> > @@ -653,6 +669,7 @@ void usb_driver_release_interface(struct usb_driver *driver,
> >  	if (device_is_bound(dev)) {
> >  		device_unlock(dev);
> >  		device_release_driver(dev);
> > +		usb_put_claim_owner(iface);
> >  		return;
> >  	}
> >  
> > diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> > index e56079398d26e..306978caaf1ef 100644
> > --- a/drivers/usb/core/message.c
> > +++ b/drivers/usb/core/message.c
> [ ... ]
> > @@ -2269,6 +2270,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
> >  	 */
> >  	for (i = 0; i < nintf; ++i) {
> >  		struct usb_interface *intf = cp->interface[i];
> > +		struct module *claim_owner;
> >  
> >  		if (intf->dev.of_node &&
> >  		    !of_device_is_available(intf->dev.of_node)) {
> > @@ -2282,12 +2284,16 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
> >  			dev_name(&intf->dev), configuration,
> >  			intf->cur_altsetting->desc.bInterfaceNumber);
> >  		device_enable_async_suspend(&intf->dev);
> > +		device_lock(&intf->dev);
> > +		claim_owner = xchg(&intf->claim_owner, NULL);
> > +		device_unlock(&intf->dev);
> >  		ret = device_add(&intf->dev);
> >  		if (ret) {
> >  			device_lock(&intf->dev);
> >  			intf->unregistering = 1;
> >  			device_unlock(&intf->dev);
> >  		}
> > +		module_put(claim_owner);
> >  		if (ret != 0) {
> >  			dev_err(&dev->dev, "device_add(%s) --> %d\n",
> >  				dev_name(&intf->dev), ret);
> 
> [Severity: Medium]
> Does clearing intf->claim_owner before device_add() and calling
> module_put(claim_owner) unconditionally drop the module reference too early
> when device_add() leaves a pre-claimed interface unbound in the driver core
> (!device_is_bound(&intf->dev))?

Yes, the complaint is valid. Triggering this race requires root
privileges, but that's fine. Let's fix it.

Thanks
