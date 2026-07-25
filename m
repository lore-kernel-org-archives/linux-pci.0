Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE5170836;
	Sat, 25 Jul 2026 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785007194; cv=none; b=LuTy9IaR5jZH0QT7MDJzcBrHJCo0ig6TCcjK9sCWX1/yXOEAis0+Mrgu5eW1s2Re/yOfJlw9mULdF49urmqAPlPZfXUOfZJEPRi9Dw0lelE3y16SYMQvPpv1iIiXA8a+Nw8g/l9dyVsdxTp4ZOmK0G8SWy5kfOgLKafzgaw627E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785007194; c=relaxed/simple;
	bh=+GpekuUidsYb+dft8TmcichhXZ1gMHF1qjHs+Oxuaqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwMn7gO+kjTnlrcLOi/nYtvri5h7PMjyCBWfyAW0o02FinUi0YoF3/ynxzhJTj8hJpoHOe9A1ZmqGIRx0z0mjwfJikw5tGV1w8dB3xs9mgcelgwBvUXAE/MLc1+o1S6MKsSHNm6v3oqF72Ybvf1rhuajvE9qNHWp6dcQFgQI8bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJNLhppo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJNLhppo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F4D1F000E9;
	Sat, 25 Jul 2026 19:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785007193;
	bh=yalvd/zA75YsG+jLZ6NQZeA/Ox8j0UuPf0c5Lh2eGnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fJNLhppogLIkfJP2+3AngJ0RH4zvrNnoefYuKmBeplrnJ5XwLnSRLw1Aq2Kp5BvUF
	 L5FlwgzS7y4kczO6eVuXMptgkRg74bYvoJH4NpOQdSiyRm4t7ErV0CrvlgT5GuzJZ8
	 v3EmMJmF3NTB38C0Jcq63+4UgklYqhvDDkcK2Tp14FcCP8LMngQ10/mifZTjZYukPb
	 7v8WamlmyTYcCVpHYLRJqV4+iZ9oVw7/kSKEn4haaL5Vb2eW+/RutPMRtXwN8WElRY
	 XAe1FtQBmUMS/tyv3PHnktGAGMUZpI937whhOOvLuVuA20dTw6qFxisWXWe1pojfmt
	 Qf+4bN3NWF7fw==
Date: Sun, 26 Jul 2026 04:19:51 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Rihyeon Kim <rihyeon8648@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, tarunsahu@google.com, 
	djeffery@redhat.com
Subject: Re: [PATCH] PCI: Handle dev_set_name() failure in pci_setup_device()
Message-ID: <20260725180429.GA349362@rocinante>
References: <20260725104747.226575-1-rihyeon8648@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260725104747.226575-1-rihyeon8648@gmail.com>

Hello,

[...]
> Propagate the error instead.  pci_setup_device() already returns int and
> both callers, pci_scan_device() and pci_iov_scan_device(), release the
> device on failure, so no caller changes are needed.  Release the OF node
> first, matching the existing error path for an unknown header type.

The kernel-doc for pci_setup_device() will probably need to be updated to
reflect changes in what the function returns on failure, since now you have
the -EIO and also -ENOMEM, potentially.

> Fixes: eebfcfb52ce7 ("PCI: handle pci_name() being const")

Probably:

  Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")

The commit you have references a state of the code, a much older code base,
where the implementation was fundamentally different, per:

  va_start(vargs, fmt);
  vsnprintf(dev->bus_id, sizeof(dev->bus_id), fmt, vargs);
  va_end(vargs);
  return 0;

The kvasprintf(), the kobject_set_name_vargs() uses internally, has been
replaced with kvasprintf_const() since commit f773f32d71a4 ("lib/kobject.c:
use kvasprintf_const for formatting ->name"), so the commit log is not
strictly correct.

[...]
> Two things I noticed while working on this and deliberately left alone,
> since they look like separate changes:
> 
> - pci_scan_device() releases the pci_dev with kfree() rather than
>   put_device(), so on the existing "unknown header type" -EIO path the
>   name allocated by dev_set_name() is leaked.  That was reported in 2022
>   [1] but never applied.

The fix there is valid and would be nice to also pick it up.  Might use
a little...

  dev->dev.kobj.name = NULL;

After the kfree_const().

Feel free to pick it up, and include here as a second patch, so a small
series.  Don't forget to credit Yang Yingliang, if you do decide to
follow-up.

> - pci_device_add() ignores device_add() failure entirely; the WARN_ON() is
>   all there is and the half-added device stays on bus->devices.  I built a
>   kernel with [2] applied (it stops device_add() from freeing dev->p) and
>   the NULL dereference above does go away, but the WARNING and the stale
>   bus->devices entry remain.  Happy to follow up on that separately if you
>   think it is worth doing.

This one I am not sure.  The NULL-assignment move looks awkward there.

[...]
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dd0abbc63e18..474c6cb327be 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2052,9 +2052,13 @@ int pci_setup_device(struct pci_dev *dev)
>  	 */
>  	dev->msi_addr_mask = DMA_BIT_MASK(64);
>  
> -	dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
> -		     dev->bus->number, PCI_SLOT(dev->devfn),
> -		     PCI_FUNC(dev->devfn));
> +	err = dev_set_name(&dev->dev, "%04x:%02x:%02x.%d",
> +			   pci_domain_nr(dev->bus), dev->bus->number,
> +			   PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
> +	if (err) {
> +		pci_release_of_node(dev);
> +		return err;
> +	}
>  
>  	class = pci_class(dev);

Looks good!

  Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Thank you for the fix!

	Krzysztof
