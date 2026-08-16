Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD364B0481;
	Sun, 16 Aug 2026 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786883924; cv=none; b=NgLgLmi/XYeK328+oCoVDEcaTabpLgItHiHpxmMd/eS0sIABXhXUyBaXgxvPBrOitaoO11uyJQ1jD/cXWkq1jX3BiidQTdO32dMyY3x0weRfRePMVmSvlaaCAmmB8CDylK/3iRSuq3zAKgMNZyNnz+odDPIav63jC63Yom3Q3mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786883924; c=relaxed/simple;
	bh=RWk2GeNE7atZjl4VCPlsVQZdG0bM7WCxeyjXR16RrQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ubzs1HIJpDhJxJJWf5bzkCdkwHftigAe6u99To0u+KibI3+xmC9OdCxynmHaxyetae5diiTvkEnuAbZ+zNgbxG4BhO2Orp+evBR5cbDldyuTBaK9JpO9RrlH+zPl6fQaUMNr8ht3OgpTywaGK+ws4XHc/gEvQiXEGEq3UUpHHSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkGkpCtn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkGkpCtn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3978C1F000E9;
	Sun, 16 Aug 2026 12:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786883923;
	bh=BEXDKxRiJVbRe0VhxuQsZIqCpnqErdTAPkVtzRcPSgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WkGkpCtnavbDYGvrFcajTODTzCpscEyvy6eYvEiv0xIsJ/u696FtecBPXYp80T2EJ
	 3fayIRAmRdRW6vK811j7k+EgzticVK7w75OOSkiJlLLDP57BIBuMtZdaL7eWF6nH4g
	 fCAOgapbL7ko4Ffw7M0jZQPLal1Yzyz1f6JR0Zz4NPcCWCVLmb+6rYCKthrJrDGZeC
	 1y4Y8y9arzEBt2e2QwVraBv/DdI8pSmd6Bsf+GB+QvbQBSwFHoVAX+AIzokFHKwfn+
	 FG8XR2LdygPpbatERR/12a9CUE3gJUhB347+nHVnVlAG3pXMk3wv511QsCMgxkySV2
	 I7Mp9mprT7TUA==
Date: Sun, 16 Aug 2026 15:38:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	"Natu, Mahesh" <mahesh.natu@intel.com>
Subject: Re: [PATCH RFC 4/7] PCI/P2PDMA: Prefer providers with better HMAT
 performance
Message-ID: <20260816123836.GC66924@unreal>
References: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com>
 <20260812-hmat-p2p-v1-4-75ac41380585@nvidia.com>
 <5e7eb09b-a47b-4cb5-8629-0ca5fa39f1f9@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e7eb09b-a47b-4cb5-8629-0ca5fa39f1f9@deltatee.com>

On Thu, Aug 13, 2026 at 09:50:07PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2026-08-12 1:47 p.m., Leon Romanovsky wrote:
> > @@ -820,21 +844,29 @@ static unsigned long map_types_idx(struct pci_dev *client)
> >   * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE. Otherwise, return
> >   * PCI_P2PDMA_MAP_BUS_ADDR.
> >   *
> > - * Any two devices that have a data path that goes through the host bridge
> > - * will consult a whitelist. If the host bridge is in the whitelist, return
> > - * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE with the distance set to the number of
> > - * ports per above. If the device is not in the whitelist, return
> > - * PCI_P2PDMA_MAP_NOT_SUPPORTED.
> > + * Any two devices that have a data path through a host bridge require
> > + * platform support from the CPU, the host bridge whitelist, or a reachable
> > + * ordered HMAT path. Return PCI_P2PDMA_MAP_NOT_SUPPORTED when none of those
> > + * sources permits the path.
> >   */
> >  VISIBLE_IF_KUNIT enum pci_p2pdma_map_type
> >  calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
> >  		int *dist, bool verbose)
> > +{
> > +	return __calc_map_type_and_dist(provider, client, dist, verbose, NULL);
> > +}
> 
> This patch is a bit hard to follow compared to the earlier ones in this
> series.
> 
> Why do we need to have a different variant of the function that excludes
> coord and is exported only for KUNIT? Why can't we just export the
> original function as is instead of creating the double underscore
> variant? Personally, I've been trying to avoid creating double
> underscore functions and naming functions more appropriately. But this
> one seems weird to me.

We can, and will. I just wanted to minimize the amount of churn
during the RFC stage of this work.

> 
> Seems like some of these details would be better split into another
> patch justifying them as this change seems more like prep changes for
> the KUNIT work that follows instead of what the patch is meant to do:
> enabling the HMAT stuff.

Will do

> 
> 
> > @@ -941,12 +976,22 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
> >  	}
> >  
> >  map_through_host_bridge:
> > -	if (!cpu_supports_p2pdma() &&
> > -	    !host_bridge_hmat_p2p(provider, client) &&
> > -	    !host_bridge_whitelist(provider, client, verbose)) {
> > -		if (verbose)
> > +	host_bridge_allowed = cpu_supports_p2pdma() ||
> > +			      host_bridge_whitelist(provider, client,
> > +						    false);
> > +	/*
> > +	 * The coordinates are only used to rank providers, which happens in
> > +	 * process context. Skip the firmware lookup on the mapping path once
> > +	 * the CPU or the whitelist has already permitted the path.
> > +	 */
> 
> This feels backwards to me. If ACPI is kind enough to include
> information on P2PDMA support then I feel like we should use it
> exclusively. Not prioritize the old janky whitelists.

Right now, there is no ACPI support, and I chose to prioritize
existing systems that already have some form of support over an ACPI
solution that does not yet exist.

But you are right: once the HMAT extension is ratified, we
need to use ACPI first.

> 
> --
> 
> In general this series looks really nice. And I'm so glad someone is
> finally adding this stuff to ACPI so that we can move away from the
> annoying white list.

Thanks a lot.

> 
> Thanks,
> 
> Logan
