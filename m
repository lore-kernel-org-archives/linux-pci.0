Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34698 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750941AbeCPSBu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Mar 2018 14:01:50 -0400
Date: Fri, 16 Mar 2018 18:02:20 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: kishon@ti.com, Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>, John Keeping <john@metanate.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Niklas Cassel <niklass@axis.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] PCI: endpoint: BAR width should not depend on
 sizeof dma_addr_t
Message-ID: <20180316180220.GA13505@red-moon>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
 <20180308133331.19464-2-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180308133331.19464-2-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 08, 2018 at 02:33:26PM +0100, Niklas Cassel wrote:
> If a BAR supports 64-bit width or not depends on the hardware,
> and should thus not depend on sizeof(dma_addr_t).
> 
> Since this driver is generic, default to always using BAR width
> of 32-bits. 64-bit BARs can easily be tested by replacing
> PCI_BASE_ADDRESS_MEM_TYPE_32 with PCI_BASE_ADDRESS_MEM_TYPE_64
> in bar_flags.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
> Note to Lorenzo/Bjorn:
> It is not trivial to convert the bar_size + bar_flags +
> struct pci_epf->bar member array to an array of struct resources,
> since we need to be able to store the addresses returned
> by dma_alloc_coherent(), which is of type dma_addr_t.
> struct resource uses resource_size_t, which is defined as phys_addr_t.
> E.g. ARTPEC-7 uses 64-bit dma_addr_t, but only 32-bit phys_addr_t.
> 
>  drivers/pci/endpoint/functions/pci-epf-test.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 800da09d9005..7c70433b11a7 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -71,6 +71,14 @@ struct pci_epf_test_data {
>  };
>  
>  static int bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
> +static int bar_flags[] = {
> +	PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32,
> +	PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32,
> +	PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32,
> +	PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32,
> +	PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32,
> +	PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32
> +};

Niklas,

I think you are almost there, I have one question though to address
that can even simplify the patchset.

If, according to your own commit logs (and my reading of the code), the
Cadence driver makes a decision on the BAR size just by checking the
corresponding region size (I would be happy to hear the reason
underpinning that choice, BTW), why can't we do the same for DWC (ie to
let the DWC driver decides whether a BAR should be 64 or 32 bits ?)

This would mean that in this patch we would not bother about the BAR
32/64 size flag at all.

Thoughts ?

Lorenzo

>  
>  static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  {
> @@ -358,7 +366,6 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  
>  static int pci_epf_test_set_bar(struct pci_epf *epf)
>  {
> -	int flags;
>  	int bar;
>  	int ret;
>  	struct pci_epf_bar *epf_bar;
> @@ -367,15 +374,11 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  
> -	flags = PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32;
> -	if (sizeof(dma_addr_t) == 0x8)
> -		flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> -
>  	for (bar = BAR_0; bar <= BAR_5; bar++) {
>  		epf_bar = &epf->bar[bar];
>  		ret = pci_epc_set_bar(epc, epf->func_no, bar,
>  				      epf_bar->phys_addr,
> -				      epf_bar->size, flags);
> +				      epf_bar->size, bar_flags[bar]);
>  		if (ret) {
>  			pci_epf_free_space(epf, epf_test->reg[bar], bar);
>  			dev_err(dev, "failed to set BAR%d\n", bar);
> -- 
> 2.14.2
> 
