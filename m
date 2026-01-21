Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B7D33E372;
	Wed, 21 Jan 2026 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769038811; cv=none; b=TTs8Y+ht2pK1xtEN9pVK54hnhMZ9xVew/IAUj2A48/l4EwHVApCeUBVaHzdIhzuwbAwCWv5jtansosbbb/b75XGdFOrZZ1ZDaEUwpITE83mqtlsdsJKRTZCT+kriVRvr3R2BnPPnoa2mdJoZ/w06bK035/ROB+JbqUPAa/2IJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769038811; c=relaxed/simple;
	bh=gQh6gpxVannkjECmoCgbQdX8xQ7iUcZw3F5m/PfebIM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=anRP2MR1K0q/pc4YsFAJJL9Qkn0DZRXMZ7BfEYErM/pdmaQfB4COFVMWVAEtP10lwWVnuR3bMPiRKqYy1NGWky/ZICGPzBMuEpKnAvspZD95p58zCO/BoxDw6SOpFCMTrUVkreFkauLlOyld5E8r1DuV/wTc1I7f02So2YCrHG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQgBH2k1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQgBH2k1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F22FC4CEF1;
	Wed, 21 Jan 2026 23:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769038810;
	bh=gQh6gpxVannkjECmoCgbQdX8xQ7iUcZw3F5m/PfebIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RQgBH2k1U0UcHMSzn5EnaPerQcXnO/4t15qxcqqreXWyD14N5LIfcyfiJu40n1mMS
	 6aKDYvy3WXBTkOuV1am69OaLdGqEb9mgSIT2rGW3s6Y0aaWSqBXMSnM6TUW4o8sBxc
	 PIrqsE95wqXWnkE5eUdjwGG/qZHIL4hvYiagD4U3G/lHzlZfklRoYGcnP7mEMJPG8A
	 8qQud8Ts0YPtRhFXbMt0XYqvhBnkg3PQLxdw7xZtnzYlBuaWq1O3CmtatF4DOMuHuN
	 irR3jGvb3oO4ww3vccKCtqqOjKjlZLmBKMCDVK7UZHaefMcMXMaD278dxrCePj34Us
	 LmG/XYFLz68Ig==
Date: Wed, 21 Jan 2026 17:40:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"Creeley, Brett" <bcreeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Han Gao <gaohan@iscas.ac.cn>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-riscv@lists.infradead.org, sophgo@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH v2 1/4] PCI/MSI: Conservatively generalize no_64bit_msi
 into msi_addr_mask
Message-ID: <20260121234009.GA1222599@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-pci-msi-addr-mask-v2-1-f42593168989@iscas.ac.cn>

[+cc Thomas]

On Wed, Jan 21, 2026 at 11:49:37AM +0800, Vivian Wang wrote:
> Some PCI devices have PCI_MSI_FLAGS_64BIT in the MSI capability, but
> implement less than 64 address bits. This breaks on platforms where such
> a device is assigned an MSI address higher than what's reachable.
> 
> Currently, we deal with this with a single no_64bit_msi flag, and
> (notably on powerpc) forces 32-bit MSI address for these devices.
> However, on some platforms the MSI doorbell address is above 32-bit but
> within device ability.
> 
> As a first step to enabling MSI on those combinations of devices and
> platforms, conservatively generalize the single-bit flag no_64bit_msi
> into msi_addr_mask. (The name msi_addr_mask is chosen to avoid confusion
> with msi_mask.)
> 
> The translation is essentially:
> 
> - no_64bit_msi = 1    ->    msi_addr_mask = DMA_BIT_MASK(32)
> - no_64bit_msi = 0    ->    msi_addr_mask = DMA_BIT_MASK(64)
> - if (no_64bit_msi)   ->    if (msi_addr_mask < DMA_BIT_MASK(64))
> 
> Since no values other than DMA_BIT_MASK(32) and DMA_BIT_MASK(64) is
> used, no functional change is intended. Future patches that make use of
> intermediate values of msi_addr_mask will follow, allowing devices that
> cannot use full 64-bit addresses for MSI to work on platforms with MSI
> doorbell above 32-bit address space.
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> 
> ---
> 
> v2: Minor rewording. No code changes.
> 
> checkpatch complains about the comment include/linux/pci.h, which I have
> formatted similarly with other comments in the vicinity.
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c           | 2 +-
>  arch/powerpc/platforms/pseries/msi.c                | 4 ++--
>  drivers/gpu/drm/radeon/radeon_irq_kms.c             | 2 +-
>  drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 2 +-
>  drivers/pci/msi/msi.c                               | 2 +-
>  drivers/pci/msi/pcidev_msi.c                        | 2 +-
>  drivers/pci/probe.c                                 | 7 +++++++
>  include/linux/pci.h                                 | 8 +++++++-
>  sound/hda/controllers/intel.c                       | 2 +-
>  9 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index b0c1d9d16fb5..1c78fdfb7b03 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1666,7 +1666,7 @@ static int __pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
>  		return -ENXIO;
>  
>  	/* Force 32-bit MSI on some broken devices */
> -	if (dev->no_64bit_msi)
> +	if (dev->msi_addr_mask < DMA_BIT_MASK(64))
>  		is_64 = 0;
>  
>  	/* Assign XIVE to PE */
> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> index a82aaa786e9e..7473c7ca1db0 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -383,7 +383,7 @@ static int rtas_prepare_msi_irqs(struct pci_dev *pdev, int nvec_in, int type,
>  	 */
>  again:
>  	if (type == PCI_CAP_ID_MSI) {
> -		if (pdev->no_64bit_msi) {
> +		if (pdev->msi_addr_mask < DMA_BIT_MASK(64)) {
>  			rc = rtas_change_msi(pdn, RTAS_CHANGE_32MSI_FN, nvec);
>  			if (rc < 0) {
>  				/*
> @@ -409,7 +409,7 @@ static int rtas_prepare_msi_irqs(struct pci_dev *pdev, int nvec_in, int type,
>  		if (use_32bit_msi_hack && rc > 0)
>  			rtas_hack_32bit_msi_gen2(pdev);
>  	} else {
> -		if (pdev->no_64bit_msi)
> +		if (pdev->msi_addr_mask < DMA_BIT_MASK(64))
>  			rc = rtas_change_msi(pdn, RTAS_CHANGE_32MSIX_FN, nvec);
>  		else
>  			rc = rtas_change_msi(pdn, RTAS_CHANGE_MSIX_FN, nvec);
> diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon/radeon_irq_kms.c
> index 9961251b44ba..d550554a6f3f 100644
> --- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
> @@ -252,7 +252,7 @@ static bool radeon_msi_ok(struct radeon_device *rdev)
>  	 */
>  	if (rdev->family < CHIP_BONAIRE) {
>  		dev_info(rdev->dev, "radeon: MSI limited to 32-bit\n");
> -		rdev->pdev->no_64bit_msi = 1;
> +		rdev->pdev->msi_addr_mask = DMA_BIT_MASK(32);
>  	}
>  
>  	/* force MSI on */
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> index 70d86c5f52fb..0671deae9a28 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> @@ -331,7 +331,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  #ifdef CONFIG_PPC64
>  	/* Ensure MSI/MSI-X interrupts lie within addressable physical memory */
> -	pdev->no_64bit_msi = 1;
> +	pdev->msi_addr_mask = DMA_BIT_MASK(32);
>  #endif
>  
>  	err = ionic_setup_one(ionic);
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 34d664139f48..48f5f03d1479 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -322,7 +322,7 @@ static int msi_verify_entries(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
>  
> -	if (!dev->no_64bit_msi)
> +	if (dev->msi_addr_mask == DMA_BIT_MASK(64))
>  		return 0;
>  
>  	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
> diff --git a/drivers/pci/msi/pcidev_msi.c b/drivers/pci/msi/pcidev_msi.c
> index 5520aff53b56..0b0346813092 100644
> --- a/drivers/pci/msi/pcidev_msi.c
> +++ b/drivers/pci/msi/pcidev_msi.c
> @@ -24,7 +24,7 @@ void pci_msi_init(struct pci_dev *dev)
>  	}
>  
>  	if (!(ctrl & PCI_MSI_FLAGS_64BIT))
> -		dev->no_64bit_msi = 1;
> +		dev->msi_addr_mask = DMA_BIT_MASK(32);
>  }
>  
>  void pci_msix_init(struct pci_dev *dev)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 41183aed8f5d..a2bff57176a3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2047,6 +2047,13 @@ int pci_setup_device(struct pci_dev *dev)
>  	 */
>  	dev->dma_mask = 0xffffffff;
>  
> +	/*
> +	 * Assume 64-bit addresses for MSI initially. Will be changed to 32-bit
> +	 * if MSI (rather than MSI-X) capability does not have
> +	 * PCI_MSI_FLAGS_64BIT. Can also be overridden by driver.
> +	 */
> +	dev->msi_addr_mask = DMA_BIT_MASK(64);
> +
>  	dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
>  		     dev->bus->number, PCI_SLOT(dev->devfn),
>  		     PCI_FUNC(dev->devfn));
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 864775651c6f..0fe32fef0331 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -377,6 +377,13 @@ struct pci_dev {
>  					   0xffffffff.  You only need to change
>  					   this if your device has broken DMA
>  					   or supports 64-bit transfers.  */
> +	u64		msi_addr_mask;	/* Mask of the bits of bus address for
> +					   MSI that this device implements.
> +					   Normally set based on device
> +					   capabilities. You only need to
> +					   change this if your device claims
> +					   to support 64-bit MSI but implements
> +					   fewer than 64 address bits. */
>  
>  	struct device_dma_parameters dma_parms;
>  
> @@ -441,7 +448,6 @@ struct pci_dev {
>  
>  	unsigned int	is_busmaster:1;		/* Is busmaster */
>  	unsigned int	no_msi:1;		/* May not use MSI */
> -	unsigned int	no_64bit_msi:1;		/* May only use 32-bit MSIs */
>  	unsigned int	block_cfg_access:1;	/* Config space access blocked */
>  	unsigned int	broken_parity_status:1;	/* Generates false positive parity */
>  	unsigned int	irq_reroute_variant:2;	/* Needs IRQ rerouting variant */
> diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
> index 1e8e3d61291a..c9542ebdf7e2 100644
> --- a/sound/hda/controllers/intel.c
> +++ b/sound/hda/controllers/intel.c
> @@ -1905,7 +1905,7 @@ static int azx_first_init(struct azx *chip)
>  
>  	if (chip->msi && chip->driver_caps & AZX_DCAPS_NO_MSI64) {
>  		dev_dbg(card->dev, "Disabling 64bit MSI\n");
> -		pci->no_64bit_msi = true;
> +		pci->msi_addr_mask = DMA_BIT_MASK(32);
>  	}
>  
>  	pci_set_master(pci);
> 
> -- 
> 2.52.0
> 
