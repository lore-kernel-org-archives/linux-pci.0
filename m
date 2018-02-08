Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:49866 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBHMrz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Feb 2018 07:47:55 -0500
Subject: Re: [PATCH v2 1/3] PCI: endpoint: Handle 64-bit BARs properly
To: Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Niklas Cassel <niklass@axis.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        John Keeping <john@metanate.com>
References: <20180208123346.20784-1-niklas.cassel@axis.com>
 <20180208123346.20784-2-niklas.cassel@axis.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <da5004d3-c3e8-d9fd-6698-3b12c3ab624a@ti.com>
Date: Thu, 8 Feb 2018 18:17:32 +0530
MIME-Version: 1.0
In-Reply-To: <20180208123346.20784-2-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Thursday 08 February 2018 06:03 PM, Niklas Cassel wrote:
> A 64-bit BAR uses the succeeding BAR for the upper bits, therefore
> we cannot call pci_epc_set_bar() on a BAR that follows a 64-bit BAR.
> 
> If pci_epc_set_bar() is called with flag PCI_BASE_ADDRESS_MEM_TYPE_64,

Not related to $patch. But I have a query on when PCI_BASE_ADDRESS_MEM_TYPE_64
should be set. Whether if the size is > 4G or if the address can be mapped
anywhere in the 64-bit PCIe address space or both?

Thanks
Kishon
> it has to be up to the controller driver to write both BAR[x] and BAR[x+1]
> (and BAR_mask[x] and BAR_mask[x+1]).
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 800da09d9005..eef85820f59e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -382,6 +382,8 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>  			if (bar == test_reg_bar)
>  				return ret;
>  		}
> +		if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
> +			bar++;
>  	}
>  
>  	return 0;
> 
