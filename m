Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320391;
	b=WRRcR9EbHIjn2Ye/NlbVjnoFgXSJGjaZ5EoGVQupZdMD+bair/JuIgV15Ls6V6QKTwZe
	 Y8KfZyH6A0rVJI4JNTVaaFfkVLskBirhrL6cRUU/rDITphfDO9MxMuVwJU2gfp7dDD42s
	 Wzlv5HxBGp2zXa5oXC+Tk19lZ6/MRYdXvxiB3S/aewbVT+8Yn+xgVnMBT2kR7bLLIP1Xd
	 3sym+5rO/zPUCxHJf5NvppHCOCU6T+gW8xT5MY1nDVy7fMFgt7lnCiaM3EcaXhjZ7eRx7
	 5T8QjRbL3ElKZDaivSfMCho4e1v0wmzgatZOP2DwxWiV2BP+YxNHLlUDVf9075DaVhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320391;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IBD63mXVAB9tRvzlY0mflXUJuM26Hy1nA4TKi2zhtyk=;
	b=ceUadKvSiW/Yxm5v75nJDeqHwqiR1SfkNmj9nT8o4IMmqSaZ5qDrBSegB2yiCobdvyxT
	 pyI52T78UkbqfgiEyZJHAjWSdlPIjR4+/T9voYuPtJS+qG0ZE/r0n4aVE0mJSGAyQSxoF
	 4gxJCfah/G5Z5LGjx0bedVhKuN1CxZ99f9lwfEgHCk5z0fKa1VETmpA/pCAbFyuNwavyC
	 m7qgMRAaG5linZLFF4CDVhHcxl+c/yKfkYfUtWx0MeVthscAH8Kx0sDALh2SWJbkRGlgn
	 NBfo7BQYCdcTBCNwlLA4iu3hf66hKxM2T5MksA1KlPOzIkPVxu53LWHuO3J3+kkXKBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ft9x1Fze;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F4606A332;
	Tue, 10 Nov 2026 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ft9x1Fze
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39A81F008A1;
	Tue, 10 Nov 2026 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320390;
	bh=IBD63mXVAB9tRvzlY0mflXUJuM26Hy1nA4TKi2zhtyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ft9x1FzedVvgFlwnml0bPMihpW39jjhhf3Gv5QQVN1aatjgBLDezeXW/K3xSRCR6g
	 uuQ8nbQy6DSu9Rsd3ugres2Gm7XewnYKEqy049a14Qd/7nApwDyk+luZ6M4+BgnITp
	 0heE4mEoTOnkPyEwzv811l5zRdaY8QiPyVqOlemmdtciLXs8wxyqMml6HYBekHFdEZ
	 QHSCObhQey3jdf42MP9JrK09iXL+HGMVSiDpxXnWzrW7neITSndhXrhz2pX5hykHBS
	 9btjBmuoOhC9etyEPxIXwEgKUF5QZ5rFo6OErbX+Gimp2E2CcOq8HrNY7R7aerjrCa
	 YQcmUVLI2wr9g==
Date: Tue, 10 Nov 2026 16:19:45 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v2 03/19] USB: Lock registered interfaces during manual
 driver binding
Message-ID: <20261110141945.GH8635@unreal>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-3-3b12d9a9f861@nvidia.com>
 <sashiko-outbox-206503@kernel.org>
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
In-Reply-To: <sashiko-outbox-206503@kernel.org>

On Tue, Nov 10, 2026 at 07:35:13AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] usb: core: unlocked dev->driver updates in
>   usb_driver_claim_interface()
> --
> 
> commit aa47d25b59fe6dc15ab05e899c754ff4b6a72894
> Author: Leon Romanovsky <leon@kernel.org>
> 
> USB: Lock registered interfaces during manual driver binding
> 
> This commit locks registered USB interfaces around device_bind_driver() in
> usb_driver_claim_interface() and updates btusb_mtk_claim_iso_intf() to acquire
> the USB device lock instead of the target interface lock.
> 
> > diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> > index d3a61ebc6afb0..ad5d9d5fc7598 100644
> > --- a/drivers/usb/core/driver.c
> > +++ b/drivers/usb/core/driver.c
> > @@ -584,8 +584,11 @@ int usb_driver_claim_interface(struct usb_driver *driver,
> >  	/* if interface was already added, bind now; else let
> >  	 * the future device_add() bind it, bypassing probe()
> >  	 */
> > -	if (device_is_registered(dev))
> > +	if (device_is_registered(dev)) {
> > +		device_lock(dev);
> >  		retval = device_bind_driver(dev);
> > +		device_unlock(dev);
> > +	}
> >  
> >  	if (retval) {
> >  		dev->driver = NULL;
> 
> [Severity: High]
> Does taking device_lock(dev) only around device_bind_driver() leave
> dev->driver and the interface binding state unprotected on a registered
> interface?

Yes, the thing is that behaviour existed before, but no problem, let's
try to fix it in separate patch.

Thanks
