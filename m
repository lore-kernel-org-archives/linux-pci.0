Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795419671;
	b=JqRWTznEHqQ4eN1mHF8BWJXi+KXBCIyOrjV79Q540VUC59R5sxs3uTPr6HgOESnOZlgF
	 cQLfwAKVcllqCqJJEnL/KPnn/jsG7+VfaICLVh4/jvUsa1sYc+gTLvalvOJ3SuHZFJ0lI
	 GrdR9FvZuAiyAWd3Qn7HjkM4kV+LuZ9n2dP2JWygEnUv7ZYHEyGt3SgEeL5e4+QiE9B4E
	 XUaRT/TPo5kqZkwFtw7CPT+n05SnRT1pJgW9W5SYi6aIYuc/2LgX4aZMsk+YFDLZYbIn/
	 1f9SstPC/zGK3sEsCcRFTpiuAvjxphvzWeQ1DGdpcQH7c3mPSSii3LZNurr2k0jkVDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795419671;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=l/Pc2DCUBFyAS6tazwdq2rsCOqbWYdzdUOXxolyW3Sg=;
	b=0mzVz6vGU3Srj/Sn1qvQsYOckCdHLQiHpEsx/QCB7db3KuL3B1ySgQR4LfFVrTB2vqoe
	 g/QIXQxcjObJA8l4DfNHR4o5ussOWrFw/1UI8y2rllc4TLI391/S35zSJa5qYk4IsbTfG
	 We9wXEpJ60qnUjDJEQG8WIXZ40ASDoWN9RUF3XskAaRVFTIvtT+wKZ5lxYw/zm5Pi64BY
	 p+FbGH6l9Jh8o6/DOc6m/bY/GykBqMQZmH+2FaBBnblWQhUOEsHpeKUOnE8EthMJsExwY
	 C363Rf8aLWtDgZX70Z/EUGvm4HqzIKyYw+rQn1H9vBLOBte6W1ojPDaaqoNf69Eodzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8vX8WCH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA04D606A31A;
	Mon, 23 Nov 2026 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8vX8WCH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B241F000C0;
	Mon, 23 Nov 2026 07:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795419671;
	bh=l/Pc2DCUBFyAS6tazwdq2rsCOqbWYdzdUOXxolyW3Sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z8vX8WCHlaqlsh+8ELEhbThFKWLc9wm9zz52RUYCQ9QEMaBW7ZSNNmBpKXZFR8gUm
	 j2VWKcsvpEqnj6Fwj+yz/LLmfCevthUS8E06zcb1dHm2iPqQqS4Zvn/+cIjPG4zU3v
	 S9ucD4a6TM5TVQKFQ4fKC8Y2O2AEOUgGnwlGKGoHJ7vpD1QOU8A+D/hdMqBJoHB/m+
	 V6qf38AYpbcn04RKcXEcOXW9w4D8fnTNbjvX+dQ26Yhu8UWFspm2Hru6/QYy2Mg2Vs
	 H0of26p9CrxAH7qzsAlnanMpiTKaPDjQyE9JKpwi01gXZlVXvhY/xK20HFZaj5ULo9
	 XO1eCi7V1XN8g==
Date: Mon, 23 Nov 2026 09:41:05 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v3 06/31] USB: Release interface claims according to
 binding state
Message-ID: <20261123074105.GI14811@unreal>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-6-d655875c4bfb@nvidia.com>
 <sashiko-outbox-223892@kernel.org>
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
In-Reply-To: <sashiko-outbox-223892@kernel.org>

On Thu, Nov 19, 2026 at 07:29:25PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] usb: core: pre-claimed interface with autoprobe off crashes
>   on core unbind
> - [Medium] usb: core: NULL dereference in usb_driver_release_interface()
>   when driver is NULL
> --
> 
> commit 03347cb54cf6030265378e68aba157a23982255b
> Author: Leon Romanovsky <leon@kernel.org>
> 
> USB: Release interface claims according to binding state
> 
> This commit updates usb_driver_release_interface() to check
> device_is_bound() instead of device_is_registered() before releasing an
> interface through the driver core, and holds the device lock while
> checking and unbinding unclaimed interfaces.
> 
> > diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> > index 735ae3310b45d..926f63cd2c834 100644
> > --- a/drivers/usb/core/driver.c
> > +++ b/drivers/usb/core/driver.c
> > @@ -612,6 +612,15 @@ int usb_driver_claim_interface(struct usb_driver *driver,
> >  }
> >  EXPORT_SYMBOL_GPL(usb_driver_claim_interface);
> >  
> > +static void usb_unbind_claim(struct usb_interface *iface)
> > +{
> > +	struct device *dev = &iface->dev;
> > +
> > +	usb_unbind_interface(dev);
> > +	dev_set_drvdata(dev, NULL);
> > +	dev->driver = NULL;
> > +}
> > +
> >  /**
> >   * usb_driver_release_interface - unbind a driver from an interface
> >   * @driver: the driver to be unbound
> > @@ -631,27 +640,25 @@ void usb_driver_release_interface(struct usb_driver *driver,
> >  {
> >  	struct device *dev = &iface->dev;
> >  
> > -	/* this should never happen, don't release something that's not ours */
> > -	if (!dev->driver || dev->driver != &driver->driver)
> > -		return;
> > -
> > -	/* don't release from within disconnect() */
> > +	/* Avoid recursive locking from disconnect(). */
> >  	if (iface->condition != USB_INTERFACE_BOUND)
> >  		return;
> > +
> > +	device_lock(dev);
> > +	if (dev->driver != &driver->driver ||
> > +	    iface->condition != USB_INTERFACE_BOUND)
> > +		goto unlock;
> 
> [Severity: Medium]
> Can dropping the !dev->driver check cause a NULL pointer dereference in
> usb_unbind_interface()?
> 
> When intf->dev.driver is NULL, usb_forced_unbind_intf() passes driver =
> to_usb_driver(NULL), whose &driver->driver member address evaluates back
> to NULL, making dev->driver != &driver->driver false.  If an interface is
> claimed before registration and registered while drivers_autoprobe is
> disabled, device_add() succeeds with iface->condition ==
> USB_INTERFACE_BOUND and device_is_bound(dev) == false (so the unwind in a
> later commit "USB: Unwind interface claims after registration or binding
> failure" does not run); if a subsequent __device_attach() fails in
> device_bind_driver(), it clears dev->driver to NULL while leaving
> iface->condition as USB_INTERFACE_BOUND.  Calling
> usb_deauthorize_interface() -> usb_forced_unbind_intf() on that interface
> then passes the guard and dereferences to_usb_driver(NULL) in
> usb_unbind_claim() -> usb_unbind_interface().

This path is already unreachable in the current code, and patch 11 removes that
state entirely.

> 
> >  	iface->condition = USB_INTERFACE_UNBINDING;
> >  
> > -	/* Release via the driver core only if the interface
> > -	 * has already been registered
> > -	 */
> > -	if (device_is_registered(dev)) {
> > -		device_release_driver(dev);
> > -	} else {
> > -		device_lock(dev);
> > -		usb_unbind_interface(dev);
> > -		dev_set_drvdata(dev, NULL);
> > -		dev->driver = NULL;
> > +	if (device_is_bound(dev)) {
> >  		device_unlock(dev);
> > +		device_release_driver(dev);
> > +		return;
> >  	}
> > +
> > +	usb_unbind_claim(iface);
> > +unlock:
> > +	device_unlock(dev);
> >  }
> >  EXPORT_SYMBOL_GPL(usb_driver_release_interface);
> 
> [Severity: Medium]
> What happens if a pre-claimed sibling interface registered with
> drivers_autoprobe disabled is detached through the driver core rather
> than usb_driver_release_interface()?

This is a pre-existing issue, I didn't modify btusb_disconnect(). It
appears that the "if (intf == data->intf) ..." checks can never be true
for ISO in any leaf.

Thanks
