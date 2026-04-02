Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB16F25D527
	for <linux-pci@vger.kernel.org>; Thu,  2 Apr 2026 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775169941; cv=none; b=N21tz1pfz9TWNI24Osjvjb7guqgvOqr0zEGG23EvOnpAWi+Bmft2MysnR7yrVVmbbInqT0QBQuTQ7AZ1L/lroX/d+4rn4WsFO/y3xgzUYaY5LWj0+uAi4c8XGOnao8aYJy6z0sGA+p98VGqeBWIRQ4rEVHbq7o/CpbSI8ms2fks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775169941; c=relaxed/simple;
	bh=nYxqavELlS7nJJvNXCYtnFhZA/55JDcSnMxAa5fW5aM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GAW1ATmzDiHU1hMX2aJs1PNpVlf11ajeB9mI17Pg5Ie7VJGxYV6hQ4UgrxYHyAqw6CBZQjm4aIPlanrht56QLHX7IyKF7GDEtwd62DbM2DIbL1lyQlUE83aYhyX1qH867xcZ4GfISYcLjMxYXofYVufDzF1ayk08F31iv4IM1aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuVfCWTp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuVfCWTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CABC116C6;
	Thu,  2 Apr 2026 22:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775169941;
	bh=nYxqavELlS7nJJvNXCYtnFhZA/55JDcSnMxAa5fW5aM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FuVfCWTpa8ehGJ58KMfjUDsJD6rWNCrp5yKyfOHoDHry5ruB1ypnt0F57I2uBTdmJ
	 CWNIq+YKG5c9m6FoiT4/4Epf3tA3LrRTzAN3RrNuEhwtkQEvaeWRlsScfZKRzBnu6y
	 rl89AbiczPkiLvG5nBosPAwbmzm2DNvWGRRf7bgDxZJJ4vXB8DQtbTo4zimz9hHN1p
	 Hxv3n3lYpZmjOBd8fmIG6p4uxGVYDRT9UUEIh6oYtJPr4h4jryhBbobz+7ym9Aas9x
	 qZIzncPRTG78cr1c2UIRW8Ldz1yssJPs4gaSGve3KMlIyf+pYAJZGvEv4PZI15Uz3f
	 Pc1XOIVNFwHVg==
Date: Thu, 2 Apr 2026 17:45:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhu Lingshan <lingshan.zhu@amd.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Skip devices with RRS Vendor ID(0x0001) on root bus
Message-ID: <20260402224540.GA303659@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327073659.6160-1-lingshan.zhu@amd.com>

On Fri, Mar 27, 2026 at 03:36:59PM +0800, Zhu Lingshan wrote:
> PCIe Request Retry Status (RRS) is a link-layer mechanism where a
> downstream device responds with RRS to indicate it is not ready.
> 
> With RRS Software Visibility enabled, the Root Port translates
> RRS into Vendor ID 0x0001 (reserved by PCI SIG) for the driver.
> 
> Devices on the root bus, for example the root port itself,
> have no upstream PCIe link and can never legitimately return RRS.
> 
> This patch skips any devices with RRS Vendor ID 0x0001
> on the root bus instead of entering the RRS retry loop.

What problem does this solve?  Did you see a device that claimed a
0x0001 Vendor ID?

How does this work for devices on s390 and virtualized guest
topologies where a device may be on the root bus seen by the guest
kernel, but still have an upstream link to a Root Port not visible to
that kernel?

The device may respond with RRS completions, but I don't know how that
would be handled.

> @@ -2578,8 +2578,27 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  	    *l == 0x0000ffff || *l == 0xffff0000)
>  		return false;
>  
> -	if (pci_bus_rrs_vendor_id(*l))
> +	if (pci_bus_rrs_vendor_id(*l)) {
> +		/*
> +		 * RRS (Request Retry Status) is a PCIe link-layer mechanism
> +		 * where a downstream device sends a RRS completion status, and the
> +		 * Root Port (with RRS Software Visibility enabled) translates
> +		 * it to Vendor ID 0x0001 for the driver, indicating the
> +		 * device is not ready.
> +		 *
> +		 * Therefore, RRS is a root port feature, and devices on the root bus,
> +		 * for example the root port itself have no upstream PCIe link,
> +		 * so they can never legitimately return RRS.

Please wrap comments to fit in 80 columns like the rest of the file.

> +		 */
> +		if (pci_is_root_bus(bus)) {
> +			pr_err("pci %04x:%02x:%02x.%d: invalid Vendor ID %04x (RRS, reserved by PCI SIG) on root bus, buggy device\n",
> +				pci_domain_nr(bus), bus->number,
> +				PCI_SLOT(devfn), PCI_FUNC(devfn),
> +				*l & 0xffff);
> +			return false;
> +		}
>  		return pci_bus_wait_rrs(bus, devfn, l, timeout);
> +	}
>  
>  	return true;
>  }
> -- 
> 2.53.0
> 
