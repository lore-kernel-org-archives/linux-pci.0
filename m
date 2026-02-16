Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A67332EA4;
	Mon, 16 Feb 2026 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258935; cv=none; b=F+FM8le5L6N39vRN74QuiInG/37Xrqc9ULhtSnT6+d/3fLHa4igzncRNlypiTkjtA0++EWWAshCrxkoMTBNJUQxKqQlyTYsWEk80wIeFpa/bhgFObCeJzj5+cyZHG23Bi13EHXwyzdHrjuNrgxTEVCTgL1t2xVt47XmTo1n0ub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258935; c=relaxed/simple;
	bh=/+qcMyQK4+5hc9Ldn03hDO8S8aBIYGQ/NqQ+XgKlnRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hu2ZS4zb6NN3i4SwI3IujIjJ9LUEAKjA+udRVF+Z5Uim22591TKBzCzP4gctfN2/pP/3usryRU7VxTZtPF4pyXBdz0iUh6m2SWGKlOg7niYq97yiq40BlEBug8UU6qLXcaowxrBsSFDgizHhaH2ysCm9+HsZ9cMgknhproxZwt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bg8pC+rq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bg8pC+rq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDAEC116C6;
	Mon, 16 Feb 2026 16:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771258934;
	bh=/+qcMyQK4+5hc9Ldn03hDO8S8aBIYGQ/NqQ+XgKlnRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bg8pC+rqbGylvy2c8iMQH3VefDPhgMnwVm3sUXgz43ApVPmA1Gt6oIrnqIn+bqZyG
	 /o1UluqSQl/d8LruUtUIpeRW1poeYQCUILIGI9RtwIk/Uk97b0gKsCa06POCCWXL6K
	 carjxr+b8e5HIfAwpsMrS5/QF41XqtxMxW2z5fN6B/kFu+KeqH915D6Jr4q8PRXJ2c
	 bqx5/YAaPCNn8oqVpAShu8C38WCbjvMSKacj1otD5/FtW97Ug+nREtUHxQLKy+cOqQ
	 /6QHGFFbWuamrP1wEdaN+Yv1LGQPFj/oVCpWKLLSIz/YHXEPLi5naZiScFTmel9F/Y
	 1Upgdr4UmxTIQ==
Date: Mon, 16 Feb 2026 21:51:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, Frank.Li@nxp.com, 
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, kernel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Message-ID: <woglgacwnhpzy3wrevjs4am4rs754tajzmhvndli4u2fycmzuf@rvbwfzcgnsrf>
References: <20260213040852.3340547-1-sherry.sun@nxp.com>
 <20260213040852.3340547-3-sherry.sun@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260213040852.3340547-3-sherry.sun@nxp.com>

On Fri, Feb 13, 2026 at 12:08:42PM +0800, Sherry Sun wrote:
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
>  drivers/pci/controller/pci-host-common.c | 58 ++++++++++++++++++++++++
>  drivers/pci/controller/pci-host-common.h | 15 ++++++
>  drivers/pci/probe.c                      |  2 +
>  include/linux/pci.h                      |  1 +
>  4 files changed, 76 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index d6258c1cffe5..0c35907a5076 100644
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
> @@ -17,6 +18,63 @@
>  
>  #include "pci-host-common.h"
>  
> +/**
> + * pci_host_common_parse_port - Parse a single Root Port node
> + * @bridge: PCI host bridge
> + * @node: Device tree node of the Root Port
> + *
> + * Returns: 0 on success, negative error code on failure
> + */
> +static int pci_host_common_parse_port(struct pci_host_bridge *bridge,
> +				      struct device_node *node)
> +{
> +	struct device *dev = &bridge->dev;
> +	struct pci_host_port *port;
> +	struct gpio_desc *reset;
> +
> +	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> +				      "reset", GPIOD_OUT_HIGH, "PERST#");

For usecases like link retention from bootloader to kernel, this could be
requested as GPIOD_ASIS:
https://lore.kernel.org/linux-pci/20260109-link_retain-v1-3-7e6782230f4b@oss.qualcomm.com/

- Mani

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
> + * @bridge: PCI host bridge
> + *
> + * This function iterates through child nodes of the host bridge and parses
> + * Root Port properties (currently only reset GPIO).
> + *
> + * Returns: 0 on success, -ENOENT if no ports found, other negative error codes
> + * on failure
> + */
> +int pci_host_common_parse_ports(struct pci_host_bridge *bridge)
> +{
> +	struct device *dev = &bridge->dev;
> +	int ret = -ENOENT;
> +
> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		if (!of_node_is_type(of_port, "pci"))
> +			continue;
> +		ret = pci_host_common_parse_port(bridge, of_port);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_host_common_parse_ports);
> +
>  static void gen_pci_unmap_cfg(void *ptr)
>  {
>  	pci_ecam_free((struct pci_config_window *)ptr);
> diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
> index b5075d4bd7eb..25d808319836 100644
> --- a/drivers/pci/controller/pci-host-common.h
> +++ b/drivers/pci/controller/pci-host-common.h
> @@ -12,6 +12,21 @@
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
> +int pci_host_common_parse_ports(struct pci_host_bridge *bridge);
> +
>  int pci_host_common_probe(struct platform_device *pdev);
>  int pci_host_common_init(struct platform_device *pdev,
>  			 struct pci_host_bridge *bridge,
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2975974f35e8..007a3fb8da86 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -647,6 +647,7 @@ static void pci_release_host_bridge_dev(struct device *dev)
>  
>  	pci_free_resource_list(&bridge->windows);
>  	pci_free_resource_list(&bridge->dma_ranges);
> +	pci_free_resource_list(&bridge->ports);
>  
>  	/* Host bridges only have domain_nr set in the emulation case */
>  	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
> @@ -671,6 +672,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  {
>  	INIT_LIST_HEAD(&bridge->windows);
>  	INIT_LIST_HEAD(&bridge->dma_ranges);
> +	INIT_LIST_HEAD(&bridge->ports);
>  
>  	/*
>  	 * We assume we can manage these PCIe features.  Some systems may
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1c270f1d5123..b05482355abc 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -634,6 +634,7 @@ struct pci_host_bridge {
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
