Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2A3A4505;
	Thu, 17 Sep 2026 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789674430; cv=none; b=L7MDdOHUF8sj/iMf3+0e6vLLf8GGolOOyIZ9VxeywpJOWPRgTj5qNrnUou4XkMq4TYUJNgJF2OpBTYhUMkEXa1cn4Lbm35Okjr31D79S+QejejoZHuT14osP003StzykNGdcUSgkpIq06/3Af3jP9BP/Owhf+ZZF6HZjU6Pt6Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789674430; c=relaxed/simple;
	bh=dUUo335Ajl+0VlABfhi9E5I4j2kVX2QAdrgctqfQZZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=S0nrkjCuyOuOsWDCWTCmog3yjGkrKSK5L6koM9e+9XlaMwrC70tIcuY/S86FqSq58L+LBYwQxOCezxoFhWg/2qMTb1Qli91Y4TlKdkwVoXV5WAoCFXhdX2sINPgUPBOmuf78gZKN9m+s3vfBPfoEhaNmaySAO1+3NtNipoRhMTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITACFmTu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITACFmTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96EC1F000FF;
	Thu, 17 Sep 2026 19:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789674429;
	bh=FIVFF1Gz0qTcL6D0qsjU7Wz5A7oH5Uxjc4mt3x0Rb8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ITACFmTuRMNQBN70r1LnmUlyRzCHXOzNKwQta9Q3q8IXvtIZGGZC0HnDjiuVGz78R
	 EI93ZUJBBCPLeovbDy0Ya2s+Jizc+FiJeJ9wBZfFKMjqoaH52DlK4Xoo4X2+aED1PO
	 11Tu3BmmyNrTrknb2wJyGvUs8xJD893qs2vSLN/6pGC4pfbcMZAsUQQ6hTvbLLsDxB
	 A1Un69fr/uNRVwYmEKSRf/2s2tCjcBCliZfkAx5MkL96mrCZXc6aA42BYjNJjlyYri
	 wmyHxC0nRKKJiVpWROfJSOnMgC3KzaifYv19mCGGyI3yp1TqpS9tRfTJ6cXz8tNlc5
	 QykvFjSC7e2Uw==
Date: Thu, 17 Sep 2026 14:47:07 -0500
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
Subject: Re: [PATCH v8 09/12] PCI: liveupdate: Adopt ARI Forwarding Enable on
 preserved bridges
Message-ID: <20260917194707.GA1047156@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-10-dmatlack@google.com>

On Tue, Jul 28, 2026 at 10:10:03PM +0000, David Matlack wrote:
> Adopt the ARI Forwarding Enable bit on preserved bridges and update
> pci_dev->ari_enabled accordingly during a Live Update. This ensures that
> the preserved devices on the bridge's secondary bus can be identified
> with the same expanded 8-bit function number after a Live Update.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/liveupdate.c | 30 ++++++++++++++++++++++++++++++
>  drivers/pci/liveupdate.h |  6 ++++++
>  drivers/pci/pci.c        |  8 +++++++-
>  3 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index fb602dd3933e..744513ee11ed 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -128,6 +128,10 @@
>   *    way after Live Update and ensures that IOMMU groups do not change. Note
>   *    that a device will use its adopted ACS controls for the lifetime of its
>   *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
> + *
> + *  * The PCI core adopts ARI Forwarding Enable on all bridges with downstream
> + *    preserved devices to ensure that all preserved devices on the bridge's
> + *    secondary bus are addressable after the Live Update.
>   */
>  
>  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> @@ -833,6 +837,32 @@ int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +/**
> + * pci_liveupdate_adopt_ari() - Adopt ARI configuration
> + * @dev: The PCI device to adopt ARI configuration for
> + *
> + * For devices preserved across a Live Update, read the ARI state from
> + * hardware and adopt it. This ensures the device continues to use the ARI
> + * configuration established by the previous kernel.
> + *
> + * Return: 0 on success, or -EINVAL if the device was not preserved.
> + */
> +int pci_liveupdate_adopt_ari(struct pci_dev *dev)
> +{
> +	u16 val;
> +
> +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> +
> +	if (!dev->liveupdate.incoming)
> +		return -EINVAL;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
> +
> +	/* Safe to modify dev->ari_enabled bitfield during enumeration. */
> +	dev->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);
> +	return 0;
> +}
> +
>  /**
>   * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
>   * @dev: The PCI device to check
> diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
> index ac5b8bf2edf5..ccc23031e99d 100644
> --- a/drivers/pci/liveupdate.h
> +++ b/drivers/pci/liveupdate.h
> @@ -18,6 +18,7 @@ bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus,
>  void pci_liveupdate_scan_bridge_end(struct pci_dev *dev);
>  void pci_liveupdate_cache_adopted_acs_controls(struct pci_dev *dev);
>  int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev);
> +int pci_liveupdate_adopt_ari(struct pci_dev *dev);
>  #else
>  static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
>  {
> @@ -45,6 +46,11 @@ static inline int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev
>  {
>  	return -EINVAL;
>  }
> +
> +static inline int pci_liveupdate_adopt_ari(struct pci_dev *dev)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  #endif /* DRIVERS_PCI_LIVEUPDATE_H */
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 22001bdf4c97..6922f361a89e 100644
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
> +	if (!pci_liveupdate_adopt_ari(bridge))
> +		return;
> +
> +	if (pcie_ari_disabled)
> +		return;
> +
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
>  		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
>  					 PCI_EXP_DEVCTL2_ARI);
> -- 
> 2.55.0.487.gaf234c4eb3-goog
> 
