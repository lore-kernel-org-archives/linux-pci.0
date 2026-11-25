Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632040;
	b=LwpGPl/y6PGAwjw0aC8zcHLZ9IlfOJ6AJo0uPavIluIBtYNdOXn6/Y6Xx4ZvPBA1AJPh
	 a33mDjShqJKVP63R5I8793r4rhdqXn5dQ4XwZPFE1dvAj9QBxhXwl7WtD2s18UOogzhpf
	 wV3yXNFEw/+MMCw1WC9bJCKxfclxVim1JZEs0Z3sn09DFcI0yGF3uIY0d/kb2/yqM6wck
	 MBvg8sdOULH+QsPgmmE0GFWDU6X21sZK+mSHLM+2DKWJYMcyHTaI9gcgADpm/7mB7K98d
	 gy90SkLdYaBgyZSuio2DTzNH6fQUZLgQ3TKrpD2MYmXmPolKoa/Vz2udfBta/rzROYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632040;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7IHoz1/bmsEMIR5P9or+ua9IgZfeMFUbK4lqK460csE=;
	b=Ngsy0oyXcQuDIAKlX3KTNcOTnTmSaJthqku9T10D7UQKXSE4ZmAh+yPGcYtcy8KeKcxV
	 RJOXtqKEynAugmHREcFPhqwHsuvkp6OZhotovYWmN5yrPJV7LBkmhsoeAarg86d03Gfty
	 47ueFw//MZ2J53npINcOEbl1ZM2N2JRHjIisizeIo/a+po1ZtTTHvS0YdoTRtATEbLV3b
	 74jOXDDwo7ZlFhoP9TDWt5U+ZLUDpRA1bpGCp1fTSS8VFBVa/DOqH1EtLbwFjP3WBfUXB
	 DOvbayBN3GP4OGxeumhcqfIWIkAyhClCCVW5u1XCuIGBDuOqZWtFh0KA8wbZ1P/90Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmfjGvBv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9109E606A323;
	Wed, 25 Nov 2026 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmfjGvBv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B4D1F000C6;
	Wed, 25 Nov 2026 18:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795632040;
	bh=7IHoz1/bmsEMIR5P9or+ua9IgZfeMFUbK4lqK460csE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AmfjGvBvWcjUwW/+u/OElnW3hw6vxCp2K/w6CAClGSK9O++yh5ITnpNSG4+cjnm1s
	 l7LJqOOyLVbCln8MHC5NKTrjsFxZp4QitqkHaY59n9o81f/A//CJ8O3Z0ctgFg7Ais
	 3mDLguAVj6amXLxA+ZZPWGEINUY0il8uiV1ElnnqIeGX4T/4+lqa2OibtzlUKCHXLn
	 e+7zGQZvcUqHMRVUuMt24reNlqMqBVtoAp7iYKGjnQeNNvAWB+4CRWQ1V/xu2IBJff
	 8pHnMpyMlfNN3lZiCtIkB6gL8Le1+d7XqTSl3CE//EmDdZ9TuNA+dsgvXFjVQjZUFq
	 CSsICb+kObTng==
Date: Wed, 25 Nov 2026 20:40:36 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v4 33/33] USB: Authorize devices through device trust
Message-ID: <20261125184036.GD774860@unreal>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-33-037eb0d17b1f@nvidia.com>
 <sashiko-outbox-233070@kernel.org>
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
In-Reply-To: <sashiko-outbox-233070@kernel.org>

On Wed, Nov 25, 2026 at 09:46:47AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] usb: stale config_error in usb_authorize_device() when no config
>   is chosen
> --
> 
> commit e933bc32d14e8dc32abb1afc1a81475eeaa3569d
> Author: Leon Romanovsky <leon@kernel.org>
> 
> USB: Authorize devices through device trust
> 
> This commit integrates USB device authorization with the device trust
> framework so that device driver admission precedes configuration when
> device trust is enabled, and tracks configuration errors under the device
> lock to allow retries.
> 
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 372bd6368cc94..c94539b0c697c 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> 
> [ ... ]
> 
> > @@ -2787,17 +2788,41 @@ int usb_deauthorize_device(struct usb_device *usb_dev)
> >  
> >  int usb_authorize_device(struct usb_device *usb_dev)
> >  {
> > +	bool attach;
> >  	int result = 0, c;
> >  
> >  	usb_lock_device(usb_dev);
> > -	if (usb_dev->authorized == 1)
> > -		goto out_authorized;
> > +	if (device_policy_is_blocked(&usb_dev->dev)) {
> > +		result = device_trust_set_policy_locked(&usb_dev->dev,
> > +							DEVICE_TRUST_POLICY_UNRESTRICTED);
> > +		if (result)
> > +			goto out_unlock;
> > +	}
> > +
> > +	attach = device_trust_enabled() && !usb_dev->dev.driver;
> > +	if (!attach && usb_dev->authorized == 1 &&
> > +	    (!device_trust_enabled() || !usb_dev->config_error ||
> > +	     usb_dev->actconfig))
> > +		goto out_unlock;
> >  
> >  	result = usb_autoresume_device(usb_dev);
> >  	if (result < 0) {
> >  		dev_err(&usb_dev->dev,
> >  			"can't autoresume for authorization: %d\n", result);
> > -		goto error_autoresume;
> > +		goto out_unlock;
> > +	}
> > +
> > +	if (attach) {
> > +		usb_dev->authorized = 1;
> > +		usb_dev->config_error = 0;
> > +		result = device_attach_locked(&usb_dev->dev);
> > +		if (result <= 0) {
> > +			if (result >= 0)
> > +				result = -ENODEV;
> > +		} else {
> > +			result = usb_dev->config_error;
> > +		}
> > +		goto out_autosuspend;
> > +	}
> >  
> >  	usb_dev->authorized = 1;
> 
> [Severity: Low]
> Should the non-attach path in usb_authorize_device() also clear
> usb_dev->config_error = 0 before calling usb_choose_configuration()?

It is not necessary. I don't see a correctness failure in the reported sequence.

Thanks
