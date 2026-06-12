Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2608836B043;
	Fri, 12 Jun 2026 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274854; cv=none; b=XVdt+Pqni6M12cR3u+yq7JprvUymr3F8DT+MTIlYvGXBaWfB5Tml/aU1JcLP6FJIgI8CTeUojrAaPDncBV5XfuIvQXf3kVm1QrDzVjOxSCMu3ODs0sRI10QrDvKBZ6ufVq9Xm0SJZ9bZeYyzvSOX81Uv4B6M4xDkoG1TYfW+tgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274854; c=relaxed/simple;
	bh=aHUf9LsHkAOmKKvt5xIWnEh6hJFIUIWdZL87ZmNpS/o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=njRISEnhQgmqzMk4ZW5Xr6tlrsphszndBAB2h29grXbNOPa5/pta5oa9yYjrDpg6r1vipkmcFlJwZzAPuQDUNBxuhwa9Jrywaz99cSeWJxLf7flvjobcrss1ipumVW2N5F01HDjE0PBtYReOKLtZ3G06nf8RF1Wsgpt+zvCAnvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH+XYW0A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH+XYW0A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C723B1F000E9;
	Fri, 12 Jun 2026 14:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781274853;
	bh=lc+n3N5IJriWVMd7FzDigrJ711iw7yLvZP8Yuk8T0DE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=RH+XYW0AbuapYvGWWJrawpvvFJWEPyrbttlOG9Bqwes+rl7OmXD6Cu3cbw8tANEvV
	 f02AdkrDHgu9szeNMBxQgGe/3ICets8eaXRmyKmkrKgkN2pgDf+gv2dCc9pVU8MWdK
	 HDD+/BmV74UyPNYpF00cuVxkyt1okU6DHw2gIHiAOgynX0pomQZ6SbQj3BH81oGO3X
	 fPz/G8VbGZdiKNWzC7n/i+uVGcA4CNiNKvNivJtKbYDnv91H6+FZEaP3u5W5tkIjDA
	 tDZhzQ16IdFil2AnMU98I59VP4Z2WUCxdeCS+rF01yN0MQaXXuijUvVJXZT/Xz44eP
	 GwMgDxNJ76w0g==
Date: Fri, 12 Jun 2026 09:34:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v8 1/4] PCI/ATS: Ensure pci_ats_supported() is PF-aware
 for VFs
Message-ID: <20260612143411.GA599201@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604182116.3179005-2-praan@google.com>

On Thu, Jun 04, 2026 at 06:21:13PM +0000, Pranjal Shrivastava wrote:
> Update pci_ats_supported() to additionally check the associated PF's
> status when called on a VF. This ensures that PF-level quirks and
> untrusted status are correctly propagated to VFs, providing a robust
> support check that aligns with the kernel's PF-centric ATS configuration
> model and is immune to the timing of VF-specific fixups.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

This series looks like material for the IOMMU tree?  Let me know if
you prefer merging these via PCI.

> ---
>  drivers/pci/ats.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 96efa00d9743..679a3c3c1d54 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -40,10 +40,13 @@ void pci_ats_init(struct pci_dev *dev)
>   */
>  bool pci_ats_supported(struct pci_dev *dev)
>  {
> -	if (!dev->ats_cap)
> +	if (!dev->ats_cap || dev->untrusted)
>  		return false;
>  
> -	return (dev->untrusted == 0);
> +	if (dev->is_virtfn)
> +		return pci_ats_supported(pci_physfn(dev));
> +
> +	return true;
>  }
>  EXPORT_SYMBOL_GPL(pci_ats_supported);
>  
> -- 
> 2.54.0.1032.g2f8565e1d1-goog
> 
