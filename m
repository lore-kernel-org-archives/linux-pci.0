Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2308F245020;
	Mon, 27 Jul 2026 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193663; cv=none; b=TSXAugk65+/TvQv3nI4wyjcBFgJaPAjKNE729Kel4wTfSen9tMO3/9W9eAS5ytFVqCfKP+93cUE5ImSgXf6tP2vhhSg+fEY5/x691B3gA3Z0RpR+LkJhpMZympjzi5CGBFYCmcf4WnBBMPHyvdPtzKBPly6muhtlzvUsmkdHfZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193663; c=relaxed/simple;
	bh=L0VAKJUeApHNjCL3YQhJGCEAPSjqOJhLvr5ddPbXjtw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A9JzUEzuOnFfCQ40CJjmMqTl3HJwYluzug4GSpUEL899iV+uLXViqGUV99l/2lb8uA5xNV4TXxkleJapuXGzDm8todfP1WVe3n8R7Q+ZzQUApl00Xu8sHsbP+mKNzzf7th7456WoQPgqMMUp5WYXbC1E2x6AbbKPpRGwGNReTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Coo62tiQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Coo62tiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFBC1F000E9;
	Mon, 27 Jul 2026 23:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785193661;
	bh=cO4H7SyXSWmzmogiLuNgyZmjdPhXBVrqySf37gDJpto=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Coo62tiQSLxOgaR7E2ulvwDVRvU7+la4nlWtaK9yFuompvjuKQFQB69D297yCiQQP
	 0HempbVTUtNTmH75yoMWOjNmH1+NS/8xr9RqwwN3f7sHhU1MKikde/8HV53MswvEly
	 lYWZ+4kC4dg7uiJZPXaCTCHXNl+zggFmWhS8GKIoEFsgtHgzRafJ665TrYgp61ty9U
	 VfY9XfPPVqptR22QibTbmAN4DP8RfYo7g5yVu7kup3xq/DoLjswMA3QOCrjPxgwqLT
	 YUv+1/HNQGHbwmRgzadmr5ol3ZhHxukLy2P2+dJ57hW7De2u72BapdsmDPgV7j8mJR
	 kUMNfVLw8mkNw==
Date: Mon, 27 Jul 2026 18:07:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable
 on preserved bridges
Message-ID: <20260727230740.GA1273350@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710212616.1351130-10-dmatlack@google.com>

On Fri, Jul 10, 2026 at 09:26:12PM +0000, David Matlack wrote:
> Inherit the ARI Forwarding Enable on preserved bridges and update
> pci_dev->ari_enabled accordingly during a Live Update. This ensures that
> the preserved devices on the bridge's secondary bus can be identified
> with the same expanded 8-bit function number after a Live Update.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c | 18 ++++++++++++++++++
>  drivers/pci/liveupdate.h |  6 ++++++
>  drivers/pci/pci.c        |  8 +++++++-
>  3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index a95bfe5eff77..74a11e520f0d 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -128,6 +128,10 @@
>   *    way after Live Update and ensures that IOMMU groups do not change. Note
>   *    that a device will use its inherited ACS flags for the lifetime of its
>   *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
> + *
> + *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
> + *    preserved devices to ensure that all preserved devices on the bridge's
> + *    secondary bus are addressable after the Live Update.
>   */
>  
>  #define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
> @@ -816,6 +820,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +int pci_liveupdate_configure_ari(struct pci_dev *dev)
> +{
> +	u16 val;
> +
> +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> +
> +	if (!dev->liveupdate.incoming)
> +		return -EINVAL;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
> +	dev->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);
> +	return 0;
> +}

I'm guessing we're going to see a lot of this pattern, so it will
eventually become familiar, but it's not familiar yet ;)  This doesn't
"configure" anything (I do understand that avoiding configuration in
the new kernel is really the main point of liveupdate).

Maybe a comment is the solution.  Or maybe a rename to
"pci_liveupdate_ari_preserved" or something?  That would have to
reverse the sense of return values, but I think something like this in
the callers would read better:

  if (pci_liveupdate_ari_preserved(dev))
    return;

or maybe:

  if (pci_liveupdate_preserve_ari(dev))
    return;

>  /**
>   * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
>   * @dev: The PCI device to check
> diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
> index 4e8a01bcb4bb..6f21ec50927b 100644
> --- a/drivers/pci/liveupdate.h
> +++ b/drivers/pci/liveupdate.h
> @@ -18,6 +18,7 @@ bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
>  void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass);
>  void pci_liveupdate_init_acs(struct pci_dev *dev);
>  int pci_liveupdate_enable_acs(struct pci_dev *dev);
> +int pci_liveupdate_configure_ari(struct pci_dev *dev);
>  #else
>  static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
>  {
> @@ -46,6 +47,11 @@ static inline int pci_liveupdate_enable_acs(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> +
> +static inline int pci_liveupdate_configure_ari(struct pci_dev *dev)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  #endif /* DRIVERS_PCI_LIVEUPDATE_H */
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 739ecaab2e76..e0c133b66a35 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3528,7 +3528,7 @@ void pci_configure_ari(struct pci_dev *dev)
>  	u32 cap;
>  	struct pci_dev *bridge;
>  
> -	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
> +	if (!pci_is_pcie(dev) || dev->devfn)
>  		return;
>  
>  	bridge = dev->bus->self;
> @@ -3539,6 +3539,12 @@ void pci_configure_ari(struct pci_dev *dev)
>  	if (!(cap & PCI_EXP_DEVCAP2_ARI))
>  		return;
>  
> +	if (!pci_liveupdate_configure_ari(bridge))
> +		return;
> +
> +	if (pcie_ari_disabled)
> +		return;
> +
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
>  		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
>  					 PCI_EXP_DEVCTL2_ARI);
> -- 
> 2.55.0.795.g602f6c329a-goog
> 
