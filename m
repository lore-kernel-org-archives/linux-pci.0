Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:50345 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbeECHSa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 May 2018 03:18:30 -0400
Subject: Re: [PATCH v2 07/10] PCI: Convert of_pci_get_host_bridge_resources()
 users to devm variant
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <ed3e6df4feca5febefa14716d62aaddd5b4a39d1.1525067324.git.jan.kiszka@siemens.com>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <dbfa80fb-5fe8-3ccd-6886-4604ef9e058b@mentor.com>
Date: Thu, 3 May 2018 10:18:24 +0300
MIME-Version: 1.0
In-Reply-To: <ed3e6df4feca5febefa14716d62aaddd5b4a39d1.1525067324.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jan,

On 04/30/2018 08:48 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Straightforward for all of them, no more leaks afterwards.
> 
> CC: Jingoo Han <jingoohan1@gmail.com>
> CC: Joao Pinto <Joao.Pinto@synopsys.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Acked-by: Jingoo Han <jingoo1han@gmail.com>

[snip]

> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 6ab28f29ac6a..6eb36c924983 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -1067,12 +1067,11 @@ static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
>  {
>  	int err;
>  	struct device *dev = pci->dev;
> -	struct device_node *np = dev->of_node;
>  	resource_size_t iobase;
>  	struct resource_entry *win, *tmp;
>  
> -	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources,
> -					       &iobase);
> +	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> +						    &pci->resources, &iobase);
>  	if (err)
>  		return err;
>  

this one snippet is obsoleted by https://patchwork.ozlabs.org/patch/904326/

If 08/10 remains a deprecation, then it is sufficient to exclude the R-Car change,
otherwise I hope maintainers can deal with the proper ordering.

For PCI OF change:

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index f16b343d3b85..5a88d46a41b7 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -645,12 +645,12 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
>  				    struct resource **bus_range)
>  {
>  	int err, res_valid = 0;
> -	struct device_node *np = dev->of_node;
>  	resource_size_t iobase;
>  	struct resource_entry *win, *tmp;
>  
>  	INIT_LIST_HEAD(resources);
> -	err = of_pci_get_host_bridge_resources(np, 0, 0xff, resources, &iobase);
> +	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, resources,
> +						    &iobase);
>  	if (err)
>  		return err;
>  
> 

Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Tested-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir
