Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425756;
	b=mV0zUD+IW1odUyDHqx4KNeJayr5h0sHCX9BW1c9VRCyE2eHKbn4WCbd4bLiT3DGOb972
	 0xqbatX2VB5+sKoL9w4xSnJ/AeEqY62A8nQth0QLNBOJZu44EkKueuJ5xOIzEmw2OQaZZ
	 yKbaTZ7kA1UYJMyMnRWDKdUEOxpVo+37u+UEKCco0GSGrCf/RQw8Um8KHRfpPEfioCqZf
	 LvaiA/t+wp2ztMVsK/xuXCMdCeBn8nLG4QWV83YS+vcvxLTbsGjS2KARN7Hcj5M853CCW
	 SuAALhohXBZuFoCxzzjzZ9yR/WtnCyWQphOwOKP2IbMqAkPhAOg1NnfIenWCxfsTBvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425756;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=+YqP0VPIZaqejn7zGmUTDDm9+wSwQPjiEk9xfXfIWnE=;
	b=HVuYhuJCwfCVK0Mg5STYlYDKHOa3UZzhxMnHa3XU+89Qot5fvDMaw+EB7WwLZ2MIJuqn
	 s5evdo6qFql6eA/Mp2gzkhujvOYzcM0ayDgfBrcaa35RxZja8PqNsFxVLy4qEe1Ygrfrp
	 ddkupb2YLMmm8wEzNOxxXKdYGwHyTAax1tHvTwuFtdtsoOLnrtbX3hBWqlCg+hPUOMNbj
	 GoIZ5R6u0qwuT3wTTtZXsAQ5jP10Qzx0z3pN3GXvpKWL87hjy/H1b1F9jVdaaFsLU9/ND
	 w5SM07KIZKLkARUa/YZszVf4C+6izODFDafF9TP4IU5pZlKZMyT8/EvSYWkRGy6h6OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N8/2hWLQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83015606A31F;
	Mon, 23 Nov 2026 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8/2hWLQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139A21F000C0;
	Mon, 23 Nov 2026 09:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795425755;
	bh=+YqP0VPIZaqejn7zGmUTDDm9+wSwQPjiEk9xfXfIWnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N8/2hWLQXF3Tz0DxjD59Gbri4SwGVHJ216vpug58t4irfv8+mrjF5xzBNq+C35x+P
	 bODMqKM7CBfY9UJOKzGBGmAhn1s5xCmQ5Eh/JIAfExZ9H2K6PHWKSi+ZqodV1LQHzY
	 3Uuj2D5YhvXpIKwr7penjZBqZ0d/cwmauzmVO1uk11l9A1yrwJ7+/WeNOCKUgkailw
	 oNzhbBUQ46R9F+okFKligmxxuA9VJxKDAIJlV87PgplVO1G2gzg2/SxD+AQHTrR5SS
	 /KkKsLiaRB3l5QgW2b60BRw1cQNavX2io3nFPrd+eULRwrxTzEwCKYNkZ88pkd2JJQ
	 mTBV+JgiNTRfw==
Date: Mon, 23 Nov 2026 11:22:31 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v3 11/31] USB: Unwind interface claims after registration
 or binding failure
Message-ID: <20261123092231.GL14811@unreal>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-11-d655875c4bfb@nvidia.com>
 <sashiko-outbox-223897@kernel.org>
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
In-Reply-To: <sashiko-outbox-223897@kernel.org>

On Thu, Nov 19, 2026 at 07:29:29PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] USB: unbound claim missed in usb_set_configuration() when
>   autoprobe is off
> - [Medium] usb: core: failed interface claim unwind skips altsetting 0
>   reset
> --
> 
> commit 5e9d278c3fe83635c408aabb0f7fdb4a22c1316b
> Author: Leon Romanovsky <leon@kernel.org>
> 
> USB: Unwind interface claims after registration or binding failure
> 
> This commit unwinds pre-claimed USB interfaces when device_add() fails or
> driver binding does not complete during usb_set_configuration(), and releases
> remaining unregistered interface claims in usb_disable_device().
> 
> > diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> > index 306978caaf1ef..b2e5ed35a4a59 100644
> > --- a/drivers/usb/core/message.c
> > +++ b/drivers/usb/core/message.c
> 
> [ ... ]
> 
> > @@ -2270,6 +2292,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
> >  	 */
> >  	for (i = 0; i < nintf; ++i) {
> >  		struct usb_interface *intf = cp->interface[i];
> > +		struct device_driver *claimant;
> >  		struct module *claim_owner;
> >  
> >  		if (intf->dev.of_node &&
> > @@ -2285,6 +2308,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
> >  			intf->cur_altsetting->desc.bInterfaceNumber);
> >  		device_enable_async_suspend(&intf->dev);
> >  		device_lock(&intf->dev);
> > +		claimant = intf->dev.driver;
> >  		claim_owner = xchg(&intf->claim_owner, NULL);
> >  		device_unlock(&intf->dev);
> >  		ret = device_add(&intf->dev);
> > @@ -2293,7 +2317,22 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
> >  			intf->unregistering = 1;
> >  			device_unlock(&intf->dev);
> >  		}
> 
> [Severity: Medium]
> Does setting intf->unregistering = 1 before calling
> usb_driver_release_refused_claim() prevent usb_unbind_interface() from
> resetting the interface back to altsetting 0?
> 
> When a driver such as cdc_ncm claims a sibling data interface and switches it
> to a non-zero alternate setting during probe(), a later device_add() failure
> on that sibling sets intf->unregistering = 1 before
> usb_driver_release_refused_claim() runs usb_unbind_interface().  Inside
> usb_unbind_interface(), driver->disconnect() releases the control interface
> and usb_set_interface() is called to restore altsetting 0, but
> usb_set_interface() rejects the request with -ENODEV because
> iface->unregistering is already set.  Since disconnect() released the sibling
> claim, usb_has_claimant() returns false and the device stays configured with
> the failed interface and its HCD bandwidth stuck on the non-zero altsetting.

This is worth fixing, but the race is difficult to trigger, it requires
device_add() for a sibling device to fail at just the right time.

> 
> > -		module_put(claim_owner);
> > +		if (claimant && (ret || !intf->dev.driver) &&
> > +		    usb_driver_release_refused_claim(intf, claimant)) {
> > +			bool unconfigure = usb_has_claimant(dev, claimant);
> > +
> > +			get_device(&intf->dev);
> > +			if (unconfigure)
> > +				usb_set_configuration(dev, -1);
> > +			module_put(claim_owner);
> > +			put_device(&intf->dev);
> > +			if (unconfigure) {
> > +				usb_autosuspend_device(dev);
> > +				return ret ? ret : -ENODEV;
> > +			}
> > +		} else {
> > +			module_put(claim_owner);
> > +		}
> 
> [Severity: Medium]
> Can checking (ret || !intf->dev.driver) without device_lock(&intf->dev) miss
> an unbound claim when drivers_autoprobe is disabled?

This is same pre-existing issue as in patch 6.

> 
> If an unregistered sibling interface was claimed during an earlier probe() and
> bus autoprobing is disabled before device_add() runs device_initial_probe(),
> __device_attach() is skipped:
> 
> drivers/base/dd.c:device_initial_probe() {
> 	if (sp->drivers_autoprobe) {
> 		ret = __device_attach(dev, true);
> 		if (ret == 2)
> 			__device_attach(dev, false);
> 	}
> }
> 
> device_add() then returns 0 with intf->dev.driver still pointing to claimant
> while device_is_bound(&intf->dev) is false.  Because (ret ||
> !intf->dev.driver) is false, usb_set_configuration() skips
> usb_driver_release_refused_claim() and drops claim_owner in the else branch.
> When usb_disable_device() later runs, device_is_registered(&interface->dev) is
> true, so device_del() is called before usb_release_unregistered_interface()
> and __device_release_driver() calls klist_remove(&dev->p->knode_driver) on an
> unattached klist_node, causing a NULL pointer dereference in klist_put().
> 
> Checking !device_is_bound(&intf->dev) under device_lock(&intf->dev) inside
> usb_driver_release_refused_claim() instead of the unlocked !intf->dev.driver
> check would catch this case.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com?part=11
> 
