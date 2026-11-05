Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899480;
	b=0rJmwFo3jBi58uuCD7S3X+dGEn4FpQN5btoeciN0rt3OAwFtl2Ec5ixEnTPF3hK+WiXk
	 EMau8BIKmgs71R/0jZKtzw8WXTnoCmRc3Fm7rkc1MJEozZEIsmPL9GfeU8btQQ2FcgSKf
	 V2EXbRpzJVjaYeQO41OVI1yX5fCOafwGvX/UXneQX4QSW4Z1b8PEYfqUQo1Jq0BOnDHd3
	 PWfuj4EBTeA3ZYgp3zfdDjWJEv+dmMqfAWHdA6gCJSRaTwrKPPyNy04oAOo9jPYIKF8QI
	 kzK0hyus/6tGbUPhSnwn8zTpkoq8yjqIhS2rZB/9oRujD9w/B++1ae6TOe5CHfCxT4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+Sc9yPGaNTmoDAc39XzEsbXpXvtl7Fk3dFBI/g/ZPmw=;
	b=X6nN6WP6tZ5q7lerTxRtXafR5IQWQ3VLhCfGTSM8+O94pkKbhOlCS/aLnTfMM8RHdigM
	 Cu948UUOXIGCN/ZscU9CgP+/PUgnuD/IwKpW0rOoMoNjKXvKdYepl2wH+huBIbNB3+STJ
	 cWtSxMJ/gTwl5Zra4ChuZrBhznV8358VK7H9+ku/QjHzy36XBoJ9u23PwyXZc4FqjSN5/
	 azZg2AkR6oKiTufoUDRC2cx7w646aJ8V2FZutc5j9lIMGsZchKoSMVoF/zLWU6UtLWtY3
	 fJ7LDI8rmeVwN9SVP6TJDNTuedxIRAzgTfm896QH5xuSqI3KJ08EIGxaPldzh3Hdlbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=OXXcUxth;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C93D606EE82
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 17:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C93D606EE82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=OXXcUxth
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53c4b82919fso26190021cf.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 09:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1793899478; x=1794504278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Sc9yPGaNTmoDAc39XzEsbXpXvtl7Fk3dFBI/g/ZPmw=;
        b=OXXcUxthtyymPU3fwfbcr40/daOdZ4UuV0IOhK3r7k3BfuoZd0x2qWahN2YNfUretu
         Tvwnl0KFWoKOeZb7Eb3uBsqzIqq8J25exR7V5CgkLuEPZfnZT4ED35Z0b9rlaw575Jgj
         FQy6EYxV5onXU0wpKN8YyESt8CkDTpTTkNBn9V25Xj56jakQJCIeQ+jbdgqM3xEfnuQB
         l6A1FG/uOsFRxdidxCtIsyNflhv6dRW8a6chHrMU0u2dgaNP3KFe01+lBZywKoRsUbeP
         mAwXyFk8XjT9tW3AtUvUEUaho7CfMrUWwbB5j2cn7aptAgB87xrCSo1TqcjbSZYZh8xc
         JpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793899478; x=1794504278;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Sc9yPGaNTmoDAc39XzEsbXpXvtl7Fk3dFBI/g/ZPmw=;
        b=FwQhLc/nx1KtJm5jk3fpNhzO6lkcyWvOvq5cPOKPDzFv95gnqR1/jn2eAr51SBb+ZS
         Qg+sYHQqRCiN0tRxVicA2yTUVRAAKlGR5smnMiSlhXyCtiSR5O63zqu66zAsURzxbaxv
         3Fw+LWaVJy0gUaG1wtfvwyVOhJmdhIR9oDuDtVyWbkw0yJQFieQDFQFWBeLHsqI0moQh
         JlSiULDyBiKf0BE+d4Zdzl6Tvoh331DjdyvcLgypn3g/wqRv2/y0cKHms2Y1X4p4sFCv
         d8C+4BJkN8gK5PwPmmHCtVl9JWL8o/Ek7aTB/5YejYJE59ENMS9EREpAkqls6GlVyYrP
         Htuw==
X-Forwarded-Encrypted: i=1; AKwUvBxjE72qKsb6U0MeQorAx5M492g62D3O8Tg9AjxcEVZ145nIgh9bEKqWoq7af9chmwZRJJpQ68Qdzgw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vHce/T+CwdXaemmhzGxVivD9MEjVrMahF58Pu2QVne4xSZI9E
	AfYeZJOSS2puK43iuqeRoC15suY0rIjrgOZuqY3P1cjgTuuQMC/LKwAB77pUmsaCPg==
X-Gm-Gg: AYBFou00LPCjg1UevTGvwtf9um1SHwBrMa9Rd7zpQLR4sdM6ykzbOaBbWmBOo5oKOQa
	TAqxfYoeZqfr0xvxN4xbMxPdBw1rS7r+0qV4xPMNyBwPP6bhYuRNCf4+kerI9k0A44rX9+4tshK
	DdoZfq7oR71XFdbhNAOFf7FoFcq5+D30xAcGkQv95DlaNQmbUr1engvYM86cpPs0TpFbld1lllD
	hZ3sVNerF2qeTtSC/TqaOdr4IQAH8672mfxoVU3z4gk0eG+7JuMjh72EkP23imYuCkrbzrKUtzF
	d/eDiArm91iVO2qwYNVFBrdlpWfskjhJD/1XG3dUtzQe4gPe8FHPpQG3FIeeFn8Yy4YaiMbRL35
	uBA7IApBFQEDGIq1Kc4bbK9zu/QgjaJwGnkpJdv86x0d7oEU0IMoRkplgVIM0UvgvUbmwJXi3hx
	UCeqcx+aBcWjOyE/DEyCCeTWMNxa6ZKvgCEV56j3waTNFu+7P7YJT5cXmvUHqtRUAiiBQUGCrR1
	wlIGg2AnmrEpiCV9zxeGKiGwBSYmXl/fKCqbPHxxk2PMvBeLHFXkIsk7CMKGeq3apwvXfp8P0o1
	ooyC1CiaqvvCdLJM0HoyYOtVIb3J
X-Received: by 2002:a05:622a:2515:b0:536:52ae:d92c with SMTP id d75a77b69052e-542b6e55bebmr328898701cf.35.1793899478212;
        Thu, 05 Nov 2026 09:24:38 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10a6ca24sm57130131cf.14.2026.11.05.09.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:24:37 -0800 (PST)
Date: Thu, 5 Nov 2026 12:24:33 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-input@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 05/17] USB: Lock registered interfaces during manual
 driver binding
Message-ID: <bb83fe3c-cebb-4bc8-bfc9-24df1cf72b0b@rowland.harvard.edu>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-5-1e536825b4eb@nvidia.com>
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
In-Reply-To: <20261105-device-trust-core-v1-5-1e536825b4eb@nvidia.com>

On Thu, Nov 05, 2026 at 01:42:18PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Interface claims hold the USB device lock, but device_bind_driver()
> requires the target interface lock. Without it, trust-policy writes can
> race admission.

This says nothing about usb_driver_release_refused_claim() and the code 
related to it.  It is an incomplete description of the patch.

Note that nothing prevents drivers from using an interface they claim 
before that interface is registered.  For your scheme to work properly, 
you should make sure the claim is authorized when 
usb_driver_claim_interface() is called, not when the interface is 
registered.

Alan Stern

> +/*
> + * The driver core refused to bind an interface that a sibling claimed before
> + * it was registered, and dropped the claim. Let the claimant release the
> + * interface instead of operating it with a bound interface but no driver.
> + */
> +void usb_driver_release_refused_claim(struct usb_interface *iface,
> +				      struct device_driver *claimant)
> +{
> +	struct device *dev = &iface->dev;
> +
> +	device_lock(dev);
> +	if (!dev->driver && iface->condition == USB_INTERFACE_BOUND) {
> +		dev->driver = claimant;
> +		usb_unbind_interface(dev);
> +		dev_set_drvdata(dev, NULL);
> +		dev->driver = NULL;
> +	}
> +	device_unlock(dev);
> +}
> +
>  /* returns 0 if no match, 1 if match */
>  int usb_match_device(struct usb_device *dev, const struct usb_device_id *id)
>  {
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index a738d03c23eac..d35a7710c8ef4 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -2264,6 +2264,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>  	 */
>  	for (i = 0; i < nintf; ++i) {
>  		struct usb_interface *intf = cp->interface[i];
> +		struct device_driver *claimant;
>  
>  		if (intf->dev.of_node &&
>  		    !of_device_is_available(intf->dev.of_node)) {
> @@ -2277,7 +2278,14 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>  			dev_name(&intf->dev), configuration,
>  			intf->cur_altsetting->desc.bInterfaceNumber);
>  		device_enable_async_suspend(&intf->dev);
> +		claimant = intf->dev.driver;
> +		if (claimant && !try_module_get(claimant->owner))
> +			claimant = NULL;
>  		ret = device_add(&intf->dev);
> +		if (!ret && claimant && !intf->dev.driver)
> +			usb_driver_release_refused_claim(intf, claimant);
> +		if (claimant)
> +			module_put(claimant->owner);
>  		if (ret != 0) {
>  			dev_err(&dev->dev, "device_add(%s) --> %d\n",
>  				dev_name(&intf->dev), ret);
> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
> index a9b37aeb515be..293340a48b6c5 100644
> --- a/drivers/usb/core/usb.h
> +++ b/drivers/usb/core/usb.h
> @@ -49,6 +49,8 @@ extern int usb_set_isoch_delay(struct usb_device *dev);
>  extern int usb_get_bos_descriptor(struct usb_device *dev);
>  extern void usb_release_bos_descriptor(struct usb_device *dev);
>  extern int usb_set_configuration(struct usb_device *dev, int configuration);
> +void usb_driver_release_refused_claim(struct usb_interface *iface,
> +				      struct device_driver *claimant);
>  extern int usb_choose_configuration(struct usb_device *udev);
>  extern int usb_generic_driver_probe(struct usb_device *udev);
>  extern void usb_generic_driver_disconnect(struct usb_device *udev);
> 
> -- 
> 2.56.0
