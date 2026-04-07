Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C362F60CC;
	Tue,  7 Apr 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568433; cv=none; b=n64wZke4PM3kvBMvqyF+xQtwx6NFlQWP+YjL4pxFKPC5ikD575b74qzHCUx7xHInmlzVTYdcN10fQEKFjHPg4HYqSBVTVq6LYlApaouW84IjI4v2h1ApKwbbydLGPvv93hkUEJ1zTeuSAZc5juhgIHW4J9KKyJKTkzR5KccYhe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568433; c=relaxed/simple;
	bh=NbvYPznNh5YF7BLCPc0vkkphiqZCgi6sGlSzqTEKe4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByqzeXlOShuDm3SAt23FO807xZtYjoWXqA8C0sk72W+GXs8qf8l/QDi6D51xKnM37BIhcJyLMMa8Pl+QOrDK/AnkeJjbCjgCvyfsjJ8WxUrl3vSMwOUeRXuJhzhDENeGD/vIIpTalyGXhyPmDC7uFFx6ovbXlLgD0MRKOrcjnvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ch1UitFu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ch1UitFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B371EC19424;
	Tue,  7 Apr 2026 13:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568433;
	bh=NbvYPznNh5YF7BLCPc0vkkphiqZCgi6sGlSzqTEKe4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ch1UitFu4B4nmanDqFPopy62LPM5Pa7VCdL0eyDdf5CyqE/KW9DvFpWntJtqIdMcK
	 VA3pt1Hd+/ORLe3VqOo52fYtUYdhO1OVGn1d2rDmvdHLnbOMZEZLoTzlJlNfcMA2+A
	 tiGCzXFaXeMOJY+JiFf+cZLBxShZEPA1GrmBdxOMqI5hfOmchhwxzsUOf87hgWZlo6
	 3fsXhARMFVOONtS+hz54n1CFbZC9OD4BjLwcE2QdqxSPbSACZrZoI/LNaMMWmgd6RK
	 CQADol0qm36nT5JbY4vzh9DTz7tR5XNvqaUG5glthTYqXI7YyJAxHmuTCt826rbtYR
	 v9jLAXWxsKnsg==
Date: Tue, 7 Apr 2026 18:57:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	bhelgaas@google.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de, 
	imx@lists.linux.dev, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V11 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Message-ID: <lnzprzrdwra7pn7d6m3sbj5pvjy64blwpjl6i3lmlnfbyho63b@czpyhpgz5vum>
References: <20260407104154.2842132-1-sherry.sun@nxp.com>
 <20260407104154.2842132-3-sherry.sun@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407104154.2842132-3-sherry.sun@nxp.com>

On Tue, Apr 07, 2026 at 06:41:44PM +0800, Sherry Sun wrote:
> Introduce generic helper functions to parse Root Port device tree nodes
> and extract common properties like reset GPIOs. This allows multiple
> PCI host controller drivers to share the same parsing logic.
> 
> Define struct pci_host_port to hold common Root Port properties
> (currently only reset GPIO descriptor) and add
> pci_host_common_parse_ports() to parse Root Port nodes from device tree.
> 
> Also add the 'ports' list to struct pci_host_bridge for better maintain
> parsed Root Port information.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/pci/controller/pci-host-common.c | 77 ++++++++++++++++++++++++
>  drivers/pci/controller/pci-host-common.h | 16 +++++
>  drivers/pci/probe.c                      |  1 +
>  include/linux/pci.h                      |  1 +
>  4 files changed, 95 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index d6258c1cffe5..0fb6991dde7b 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> @@ -17,6 +18,82 @@
>  
>  #include "pci-host-common.h"
>  
> +/**
> + * pci_host_common_delete_ports - Cleanup function for port list
> + * @data: Pointer to the port list head
> + */
> +void pci_host_common_delete_ports(void *data)
> +{
> +	struct list_head *ports = data;
> +	struct pci_host_port *port, *tmp;
> +
> +	list_for_each_entry_safe(port, tmp, ports, list)
> +		list_del(&port->list);
> +}
> +EXPORT_SYMBOL_GPL(pci_host_common_delete_ports);
> +
> +/**
> + * pci_host_common_parse_port - Parse a single Root Port node
> + * @dev: Device pointer
> + * @bridge: PCI host bridge
> + * @node: Device tree node of the Root Port
> + *
> + * Returns: 0 on success, negative error code on failure
> + */
> +static int pci_host_common_parse_port(struct device *dev,
> +				      struct pci_host_bridge *bridge,
> +				      struct device_node *node)
> +{
> +	struct pci_host_port *port;
> +	struct gpio_desc *reset;
> +
> +	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> +				      "reset", GPIOD_ASIS, "PERST#");

Sorry, I missed this earlier.

Since PERST# is optional, you cannot reliably detect whether the Root Port
binding intentionally skipped the PERST# GPIO or legacy binding is used, just by
checking for PERST# in Root Port node.

So this helper should do 3 things:

1. If PERST# is found in Root Port node, use it.
2. If not, check the RC node and if present, return -ENOENT to fallback to the
legacy binding.
3. If not found in both nodes, assume that the PERST# is not present in the
design, and proceed with parsing Root Port binding further.

But there is one more important limitation here. Right now, this API only
handles PERST#. But if another vendor tries to use it and if they need other
properties such as PHY, clocks etc... those resources should be fetched
optionally only by this helper. But if the controller has a hard dependency on
those resources, the driver will fail to operate.

I don't think we can fix this limitation though and those platforms should
ensure that the resource dependency is correctly modeled in DT binding and the
DTS is validated properly. It'd be good to mention this in the kernel doc of
this API.

> +	if (IS_ERR(reset))
> +		return PTR_ERR(reset);
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->reset = reset;
> +	INIT_LIST_HEAD(&port->list);
> +	list_add_tail(&port->list, &bridge->ports);
> +
> +	return 0;
> +}
> +
> +/**
> + * pci_host_common_parse_ports - Parse Root Port nodes from device tree
> + * @dev: Device pointer
> + * @bridge: PCI host bridge
> + *
> + * This function iterates through child nodes of the host bridge and parses
> + * Root Port properties (currently only reset GPIO).
> + *
> + * Returns: 0 on success, -ENOENT if no ports found, other negative error codes
> + * on failure
> + */
> +int pci_host_common_parse_ports(struct device *dev, struct pci_host_bridge *bridge)
> +{
> +	int ret = -ENOENT;
> +
> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		if (!of_node_is_type(of_port, "pci"))
> +			continue;
> +		ret = pci_host_common_parse_port(dev, bridge, of_port);
> +		if (ret)
> +			return ret;

As Sashiko flagged, you need to make sure that devm_add_action_or_reset() is
added even during the error path:
https://sashiko.dev/#/patchset/20260407104154.2842132-1-sherry.sun%40nxp.com?part=2

- Mani

> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, pci_host_common_delete_ports,
> +					&bridge->ports);
> +}
> +EXPORT_SYMBOL_GPL(pci_host_common_parse_ports);
> +
>  static void gen_pci_unmap_cfg(void *ptr)
>  {
>  	pci_ecam_free((struct pci_config_window *)ptr);
> diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
> index b5075d4bd7eb..37714bedb625 100644
> --- a/drivers/pci/controller/pci-host-common.h
> +++ b/drivers/pci/controller/pci-host-common.h
> @@ -12,6 +12,22 @@
>  
>  struct pci_ecam_ops;
>  
> +/**
> + * struct pci_host_port - Generic Root Port properties
> + * @list: List node for linking multiple ports
> + * @reset: GPIO descriptor for PERST# signal
> + *
> + * This structure contains common properties that can be parsed from
> + * Root Port device tree nodes.
> + */
> +struct pci_host_port {
> +	struct list_head	list;
> +	struct gpio_desc	*reset;
> +};
> +
> +void pci_host_common_delete_ports(void *data);
> +int pci_host_common_parse_ports(struct device *dev, struct pci_host_bridge *bridge);
> +
>  int pci_host_common_probe(struct platform_device *pdev);
>  int pci_host_common_init(struct platform_device *pdev,
>  			 struct pci_host_bridge *bridge,
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index eaa4a3d662e8..629ae08b7d35 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -677,6 +677,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  {
>  	INIT_LIST_HEAD(&bridge->windows);
>  	INIT_LIST_HEAD(&bridge->dma_ranges);
> +	INIT_LIST_HEAD(&bridge->ports);
>  
>  	/*
>  	 * We assume we can manage these PCIe features.  Some systems may
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8f63de38f2d2..a73ea81ce88f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -636,6 +636,7 @@ struct pci_host_bridge {
>  	int		domain_nr;
>  	struct list_head windows;	/* resource_entry */
>  	struct list_head dma_ranges;	/* dma ranges resource list */
> +	struct list_head ports;		/* Root Port list (pci_host_port) */
>  #ifdef CONFIG_PCI_IDE
>  	u16 nr_ide_streams; /* Max streams possibly active in @ide_stream_ida */
>  	struct ida ide_stream_ida;
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்
