Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:54340 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeCUF3g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Mar 2018 01:29:36 -0400
Subject: Re: [PATCH v4 1/5] PCI: endpoint: BAR width should not depend on
 sizeof dma_addr_t
To: Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>, John Keeping <john@metanate.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Niklas Cassel <niklass@axis.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
 <20180308133331.19464-2-niklas.cassel@axis.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <825d8376-915c-ee4d-1a1e-d3430e5d0928@ti.com>
Date: Wed, 21 Mar 2018 10:59:11 +0530
MIME-Version: 1.0
In-Reply-To: <20180308133331.19464-2-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Thursday 08 March 2018 07:03 PM, Niklas Cassel wrote:
> If a BAR supports 64-bit width or not depends on the hardware,
> and should thus not depend on sizeof(dma_addr_t).
> 
> Since this driver is generic, default to always using BAR width
> of 32-bits. 64-bit BARs can easily be tested by replacing
> PCI_BASE_ADDRESS_MEM_TYPE_32 with PCI_BASE_ADDRESS_MEM_TYPE_64
> in bar_flags.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
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
> 
