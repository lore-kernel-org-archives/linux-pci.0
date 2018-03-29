Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:42610 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeC2Jfc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Mar 2018 05:35:32 -0400
Subject: Re: [PATCH v5 01/12] PCI: endpoint: BAR width should not depend on
 sizeof dma_addr_t
To: Niklas Cassel <niklas.cassel@axis.com>,
        <cyrille.pitchen@free-electrons.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Niklas Cassel <niklass@axis.com>,
        John Keeping <john@metanate.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-2-niklas.cassel@axis.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <01244df4-165b-77bb-e542-26e33dc0d348@ti.com>
Date: Thu, 29 Mar 2018 15:05:03 +0530
MIME-Version: 1.0
In-Reply-To: <20180328115018.31921-2-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 28 March 2018 05:20 PM, Niklas Cassel wrote:
> If a BAR supports 64-bit width or not depends on the hardware,
> and should thus not depend on sizeof(dma_addr_t).
> 
> If a certain hardware doesn't support 64-bit BARs, its
> epc->ops->set_bar() implementation should return -EINVAL
> when PCI_BASE_ADDRESS_MEM_TYPE_64 is set.
> 
> We can't change pci_epc_set_bar() to only set
> PCI_BASE_ADDRESS_MEM_TYPE_64 based on size, since if the user,
> for some reason, wants to configure a BAR with a 64-bit width,
> even though the BAR size is less than 4 GB, he should be able
> to do that.
> 
> However, since pci-epf-test is simply a test and not an API,
> we can set PCI_BASE_ADDRESS_MEM_TYPE_64 in pci-epf-test itself
> only based on size.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 64d8a17f8094..f6c0c59b1bc8 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -70,7 +70,7 @@ struct pci_epf_test_data {
>  	bool		linkup_notifier;
>  };
>  
> -static int bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
> +static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
>  
>  static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  {
> @@ -367,12 +367,14 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  
> -	flags = PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32;
> -	if (sizeof(dma_addr_t) == 0x8)
> -		flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> -
>  	for (bar = BAR_0; bar <= BAR_5; bar++) {
>  		epf_bar = &epf->bar[bar];
> +
> +		flags = PCI_BASE_ADDRESS_SPACE_MEMORY;
> +		flags |= upper_32_bits(epf_bar->size) ?
> +			PCI_BASE_ADDRESS_MEM_TYPE_64 :
> +			PCI_BASE_ADDRESS_MEM_TYPE_32;
> +
>  		ret = pci_epc_set_bar(epc, epf->func_no, bar,
>  				      epf_bar->phys_addr,
>  				      epf_bar->size, flags);
> 
