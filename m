Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:32470 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758133Ab2JYHar (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Oct 2012 03:30:47 -0400
Message-ID: <5088EA6D.2070509@huawei.com>
Date: Thu, 25 Oct 2012 15:29:49 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Jon Mason <jdmason@kudzu.us>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/3] PCI: correct static code analysis tool issue
References: <1350020155-3782-1-git-send-email-jdmason@kudzu.us> <1350020155-3782-2-git-send-email-jdmason@kudzu.us>
In-Reply-To: <1350020155-3782-2-git-send-email-jdmason@kudzu.us>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012/10/12 13:35, Jon Mason wrote:
> Coverity noticed that pcie_bus_configure_settings() can call
> pcie_bus_configure_set() when "smpss" is uninitialized.  The smpss is
> used to make the bus and all child devices have a uniform value.
> Setting the smpss is moot for PCIE_BUS_PERFORMANCE, since it will be
> determined dynamically based on the max size of the parent device and
> the child device.  To avoid the erroneous detection of this issue, set
> the smpss to 0.  Also, add a case statement to make clearer the possible
> use cases and add a nice comment describing what is being done in the
> PCIE_BUS_PERFORMANCE case.
> 
> Signed-off-by: Jon Mason <jdmason@kudzu.us>
> ---
>  drivers/pci/probe.c |   25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9f8a6b7..6b672c1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1570,21 +1570,36 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
>  	if (!pci_is_pcie(bus->self))
>  		return;
>  
> -	if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
> -		return;
> -
> +	switch (pcie_bus_config) {
> +	/* The smpss is used to make the bus and all child devices have
> +	 * a uniform value.  Setting the smpss is moot for
> +	 * "Performance", since it will be determined dynamically based
> +	 * on the max size of the parent device and the child device.
> +	 * However, not setting the smpss can result in static code
> +	 * analysis tools erroniously reporting an issue.  To avoid
> +	 * this, set the smpss to 0.
> +	 */
> +	case PCIE_BUS_PERFORMANCE:
>  	/* FIXME - Peer to peer DMA is possible, though the endpoint would need
>  	 * to be aware to the MPS of the destination.  To work around this,
>  	 * simply force the MPS of the entire system to the smallest possible.
>  	 */
> -	if (pcie_bus_config == PCIE_BUS_PEER2PEER)
> +	case PCIE_BUS_PEER2PEER:
>  		smpss = 0;
> +		break;
>  
> -	if (pcie_bus_config == PCIE_BUS_SAFE) {
> +	case PCIE_BUS_SAFE:
>  		smpss = mpss;
>  
>  		pcie_find_smpss(bus->self, &smpss);
>  		pci_walk_bus(bus, pcie_find_smpss, &smpss);
> +		break;
> +
> +	case PCIE_BUS_TUNE_OFF:
> +	default:
> +		return;
> +	}
> +
>  	}

Remove bracket }

>  
>  	pcie_bus_configure_set(bus->self, &smpss);
> 


-- 
Thanks!
Yijing

