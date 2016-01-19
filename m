Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44074 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757456AbcASJWH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jan 2016 04:22:07 -0500
From: "Lawrynowicz, Jacek" <jacek.lawrynowicz@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"jroedel@suse.de" <jroedel@suse.de>
Subject: RE: [PATCH] pci: Add support for multiple DMA aliases
Date: Tue, 19 Jan 2016 09:21:59 +0000
Message-ID: <36D38C1F74839847A52A484C31F3E51A6212318F@irsmsx105.ger.corp.intel.com>
References: <1453118346-76897-1-git-send-email-jacek.lawrynowicz@intel.com>
 <1453133267-79756-1-git-send-email-jacek.lawrynowicz@intel.com>
 <20160119033315.GA6510@localhost>
In-Reply-To: <20160119033315.GA6510@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Tuesday, January 19, 2016 4:33 AM
> To: Lawrynowicz, Jacek <jacek.lawrynowicz@intel.com>
> Cc: linux-pci@vger.kernel.org; bhelgaas@google.com;
> dwmw2@infradead.org; jroedel@suse.de
> Subject: Re: [PATCH] pci: Add support for multiple DMA aliases
> 
> On Mon, Jan 18, 2016 at 05:07:47PM +0100, Jacek Lawrynowicz wrote:
> > This patch solves IOMMU support issues with PCIe non-transparent
> > bridges that use Requester ID look-up tables (LUT), e.g. PEX8733.
> > Before exiting the bridge, packet's RID is rewritten according to LUT
> > programmed by a driver. Modified packets are then passed to a
> > destination bus and processed upstream. The problem is that such
> > packets seem to come from non-existent nodes that are hidden behind
> > NTB and are not discoverable by a destination node, so IOMMU discards
> > them. Adding DMA alias for a given LUT entry allows IOMMU to create a
> > proper mapping that enables inter-node communication.
> >
> > The current DMA alias implementation supports only single alias, so
> > it's not possible to connect more than two nodes when IOMMU is
> > enabled. This implementation enables all possible aliases on a given
> > bus (256) that are stored in a bitset. Alias devfn is directly
> > translated to a bit number. The bitset is not allocated for devices
> > that have no need for DMA aliases.
> >
> > More details can be found in following article:
> >
> http://www.plxtech.com/files/pdf/technical/expresslane/RTC_Enabling%20
> > MulitHostSystemDesigns.pdf
> >
> > Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
> > Acked-by: David Woodhouse <David.Woodhouse@intel.com>
> > Acked-by: Joerg Roedel <jroedel@suse.de>
> 
> I applied this to pci/iommu and intend to merge it for v4.5.
> 
> I made the following change because the kcalloc() failure warning in your
> patch looks wrong:
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index b0d6a0a..29cfe1a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4577,13 +4577,15 @@ int pci_set_vga_state(struct pci_dev *dev, bool
> decode,
>   */
>  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)  {
> -	if (!dev->dma_alias_mask) {
> +	if (!dev->dma_alias_mask)
>  		dev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
>  					      sizeof(long), GFP_KERNEL);
> -		dev_warn(&dev->dev, "Unable to allocate DMA alias
> mask.\n");
> +	if (!dev->dma_alias_mask) {
> +		dev_warn(&dev->dev, "Unable to allocate DMA alias
> mask\n");
> +		return;
>  	}
> -	if (dev->dma_alias_mask)
> -		set_bit(devfn, dev->dma_alias_mask);
> +
> +	set_bit(devfn, dev->dma_alias_mask);
>  }
>  EXPORT_SYMBOL_GPL(pci_add_dma_alias);

Yes, you're right. Thanks.

--
Jacek Lawrynowicz
Intel Technology Poland sp. z o.o.
KRS 101882 - ul. Slowackiego 173, 80-298 Gdansk



