Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:53817 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeC2JvU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Mar 2018 05:51:20 -0400
Subject: Re: [PATCH v5 08/12] PCI: endpoint: Handle 64-bit BARs properly
To: Niklas Cassel <niklas.cassel@axis.com>,
        <cyrille.pitchen@free-electrons.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>, John Keeping <john@metanate.com>,
        Niklas Cassel <niklass@axis.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-9-niklas.cassel@axis.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <390035dc-7e33-184f-a2eb-909c09e2c455@ti.com>
Date: Thu, 29 Mar 2018 15:20:51 +0530
MIME-Version: 1.0
In-Reply-To: <20180328115018.31921-9-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 28 March 2018 05:20 PM, Niklas Cassel wrote:
> If a 64-bit BAR was set-up, we need to skip a BAR,
> since a 64-bit BAR consists of a BAR pair.
> 
> We need to check what BAR width the epc->ops->set_bar() specific
> implementation actually did set-up, since some drivers, like the
> Cadence EP controller, sometimes sets up a 64-bit BAR, even though
> a 32-bit BAR was requested.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 91274779e59f..d46e3ebabb8e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -380,6 +380,13 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>  			if (bar == test_reg_bar)
>  				return ret;
>  		}
> +		/*
> +		 * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
> +		 * if the specific implementation required a 64-bit BAR,
> +		 * even if we only requested a 32-bit BAR.
> +		 */
> +		if (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
> +			bar++;
>  	}
>  
>  	return 0;
> 
