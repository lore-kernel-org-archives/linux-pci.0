Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752157AbeB1OVx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Feb 2018 09:21:53 -0500
Date: Wed, 28 Feb 2018 14:21:48 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: kishon@ti.com, Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Niklas Cassel <niklass@axis.com>,
        John Keeping <john@metanate.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: endpoint: Handle 64-bit BARs properly
Message-ID: <20180228142148.GD21854@e107981-ln.cambridge.arm.com>
References: <20180227115908.14593-1-niklas.cassel@axis.com>
 <20180227115908.14593-2-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180227115908.14593-2-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 27, 2018 at 12:59:05PM +0100, Niklas Cassel wrote:
> A 64-bit BAR uses the succeeding BAR for the upper bits, therefore
> we cannot call pci_epc_set_bar() on a BAR that follows a 64-bit BAR.
> 
> If pci_epc_set_bar() is called with flag PCI_BASE_ADDRESS_MEM_TYPE_64,

PCI_BASE_ADDRESS_MEM_TYPE_64 is detected through a sizeof(dma_addr_t).

I thought we decided to describe the BARs not as dma_addr_t + size but
as resources, which would allow you to have flags describing their
actual size.

Current code has a fixed BAR size defined by the dma_addr_t type size
and I do not think that's what we really want.

How is (in HW I mean) actually the BAR size configured in a given EPF ?

Thanks,
Lorenzo

> it has to be up to the controller driver to write both BAR[x] and BAR[x+1]
> (and BAR_mask[x] and BAR_mask[x+1]).
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 64d8a17f8094..ecbf6a7750dc 100644
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
> -- 
> 2.14.2
> 
