Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51583 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932827AbbLGQBG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Dec 2015 11:01:06 -0500
Date: Mon, 7 Dec 2015 10:00:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: Resizeable PCI BAR support
Message-ID: <20151207160054.GF7994@localhost>
References: <5662C61F.50303@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <5662C61F.50303@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Dec 05, 2015 at 12:10:23PM +0100, Christian König wrote:
> Hi Bjorn,
> 
> reading up on the mailing list this is probably not the first time
> this topic comes up, but this time it is not just for FPGAs but for
> really end user hardware.
> 
> Alex and I are the maintainers of the Radeon and Amdgpu kernel
> drivers for the AMD graphics hardware.  Now the newest hardware
> generation of those devices started to support resizeable PCI BARs
> as specified here https://pcisig.com/sites/default/files/specification_documents/ECN_Resizable-BAR_24Apr2008.pdf.
> 
> That feature is rather important for graphics hardware, because the
> PCI BARs are usually limited to 256MB while on modern cards you can
> easily find 4GB or more VRAM. The end result is that only a fraction
> of that VRAM is CPU accessible, causing a whole bunch of workarounds
> in the driver stack for that hardware.
> 
> We of course want to avoid that hassle and so I've attached two
> patches created to test the functionality. The first one is just
> infrastructure for handling the extension and the second is a hack
> to resize all BARs to their maximum before probing them by the PCI
> subsystem.
> 
> That resizing works astonishing fine, the only problem is that on
> practical no system I've tested this feature actually works. The
> reason is that the PCI root bridge doesn't get enough address space
> assigned by the BIOS for this and the PCI subsystem in the kernel
> isn't able to reprogram it.
> 
> Any clever idea how to get this working without waiting for system
> BIOS providers to pick up that extension? Would adding support for
> reprogramming the root bridges be possible?

Many host bridges support programmable windows in the hardware, so in
principle we could reprogram them at run-time.  But the CPU side of
the bridge is out of the PCI domain, so there's no single way to do it
-- it's all implementation-specific.  ACPI has some pieces that would
make it more generic (_PRS tells us whether the bridge supports
reprogramming, the Linux resource map tells us what address space is
available, _SRS lets us actually reprogram the bridge), but I don't
know whether any BIOSes actually support _PRS and _SRS on host
bridges.  I don't know of any OS support that would use it.

Bottom line, I don't have any clever ideas for how to do this.

> From ea99917e1760b2a1ecd6d353d7a8a060ea24dd03 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
> Date: Wed, 25 Nov 2015 12:46:29 +0100
> Subject: [PATCH 1/2] PCI: add resizeable BAR infrastructure
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Just the defines and helper functions to read the possible sizes of a BAR and
> update it's size.
> 
> See https://pcisig.com/sites/default/files/specification_documents/ECN_Resizable-BAR_24Apr2008.pdf.
> 
> Signed-off-by: Christian K??nig <christian.koenig@amd.com>
> ---
>  drivers/pci/pci.c             | 78 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h           |  2 ++
>  include/uapi/linux/pci_regs.h |  7 ++++
>  3 files changed, 87 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6a9a111..862247f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2453,6 +2453,84 @@ bool pci_acs_path_enabled(struct pci_dev *start,
>  }
>  
>  /**
> + * pci_rbar_get_sizes - get possible sizes for BAR
> + * @dev: PCI device
> + * @bar: BAR to query
> + *
> + * Get the possible sizes of a resizeable BAR as bitmask defined in the spec
> + * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizeable.
> + */
> +u32 pci_rbar_get_sizes(struct pci_dev *pdev, int bar)
> +{
> +	int pos, nbars;
> +	u32 ctrl, cap;
> +	int i;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
> +	if (!pos)
> +		return 0x0;
> +
> +	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
> +
> +	for (i = 0; i < nbars; ++i, pos += 8) {
> +		int bar_idx;
> +
> +		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +		bar_idx = (ctrl & PCI_REBAR_CTRL_BAR_IDX_MASK) >>
> +				PCI_REBAR_CTRL_BAR_IDX_SHIFT;
> +		if (bar_idx != bar)
> +			continue;
> +
> +		pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
> +		return (cap & PCI_REBAR_CTRL_SIZES_MASK) >>
> +			PCI_REBAR_CTRL_SIZES_SHIFT;
> +	}
> +
> +	return 0x0;
> +}
> +
> +/**
> + * pci_rbar_set_size - set a new size for a BAR
> + * @dev: PCI device
> + * @bar: BAR to set size to
> + * @size: new size as defined in the spec.
> + *
> + * Set the new size of a BAR as defined in the spec (0=1MB, 19=512GB).
> + * Returns true if resizing was successful, false otherwise.
> + */
> +bool pci_rbar_set_size(struct pci_dev *pdev, int bar, int size)
> +{
> +	int pos, nbars;
> +	u32 ctrl;
> +	int i;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
> +	if (!pos)
> +		return false;
> +
> +	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
> +
> +	for (i = 0; i < nbars; ++i, pos += 8) {
> +		int bar_idx;
> +
> +		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +		bar_idx = (ctrl & PCI_REBAR_CTRL_BAR_IDX_MASK) >>
> +				PCI_REBAR_CTRL_BAR_IDX_SHIFT;
> +		if (bar_idx != bar)
> +			continue;
> +
> +		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE_MASK;
> +		ctrl |= size << PCI_REBAR_CTRL_BAR_SIZE_SHIFT;
> +		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
>   * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
>   * @dev: the PCI device
>   * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTC, 4=INTD)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e90eb22..fafb974 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1801,6 +1801,8 @@ void pci_request_acs(void);
>  bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
>  bool pci_acs_path_enabled(struct pci_dev *start,
>  			  struct pci_dev *end, u16 acs_flags);
> +u32 pci_rbar_get_sizes(struct pci_dev *pdev, int bar);
> +bool pci_rbar_set_size(struct pci_dev *pdev, int bar, int size);
>  
>  #define PCI_VPD_LRDT			0x80	/* Large Resource Data Type */
>  #define PCI_VPD_LRDT_ID(x)		((x) | PCI_VPD_LRDT)
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 413417f..b746cbb 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -886,9 +886,16 @@
>  #define PCI_SATA_SIZEOF_LONG	16
>  
>  /* Resizable BARs */
> +#define PCI_REBAR_CAP		4	/* capability register */
> +#define  PCI_REBAR_CTRL_SIZES_MASK	(0xFFFFF << 4)	/* mask for sizes */
> +#define  PCI_REBAR_CTRL_SIZES_SHIFT	4	/* shift for sizes */
>  #define PCI_REBAR_CTRL		8	/* control register */
> +#define  PCI_REBAR_CTRL_BAR_IDX_MASK	(7 << 0)	/* mask for bar index */
> +#define  PCI_REBAR_CTRL_BAR_IDX_SHIFT	0	/* shift for bar index */
>  #define  PCI_REBAR_CTRL_NBAR_MASK	(7 << 5)	/* mask for # bars */
>  #define  PCI_REBAR_CTRL_NBAR_SHIFT	5	/* shift for # bars */
> +#define  PCI_REBAR_CTRL_BAR_SIZE_MASK	(0x1F << 8)	/* mask for bar size */
> +#define  PCI_REBAR_CTRL_BAR_SIZE_SHIFT	8	/* shift for bar size */
>  
>  /* Dynamic Power Allocation */
>  #define PCI_DPA_CAP		4	/* capability register */
> -- 
> 2.5.0
> 

> From b7201b6af1b3f5452549351b018a27806ee5a723 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
> Date: Wed, 25 Nov 2015 12:51:24 +0100
> Subject: [PATCH 2/2] PCI: WIP hack to resize all BARs to their maximum
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Signed-off-by: Christian K??nig <christian.koenig@amd.com>
> ---
>  drivers/pci/probe.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8361d27..1d8fc20 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -318,6 +318,17 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  
>  	for (pos = 0; pos < howmany; pos++) {
>  		struct resource *res = &dev->resource[pos];
> +		u32 sizes = pci_rbar_get_sizes(dev, pos);
> +
> +		if (sizes) {
> +			/* Just resize to the maximum for now */
> +			int size = fls(sizes) - 1;
> +
> +			if (pci_rbar_set_size(dev, pos, size))
> +				dev_info(&dev->dev, "Resized BAR %d to %dMB\n",
> +					 pos, 1 << size);
> +		}
> +
>  		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
>  		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
>  	}
> -- 
> 2.5.0
> 

