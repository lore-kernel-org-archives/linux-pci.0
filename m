Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9461346AD5;
	Mon, 16 Mar 2026 05:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773639651; cv=none; b=C6OF8NSdBWD3rJLfV1xS8TVXgkOlFVdjH0AgC4O2/8c8eOff+DNvUjspbgGNxVxtRRTHUX6rvTj06+F7g7/895qo3RKfdRap6ghzEKn4bpLaJ/FgWP5tvT6jOcLzUL9Q6mnwfkaXLvMQEPxEnzoH/5Owos4OlZQTKTDSla0cr2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773639651; c=relaxed/simple;
	bh=EOcJg2rpMZmxLxL/nNrRabAiSunwZmxsgympFKG+XVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqSIy++uUUrx11Z8YORmj2cwlvA38OpMVwefEsvIsYq/S0ZNlgyFvV/QosoTs7lCiD+oy4YCWg4qJBGVZvznL6aACEeESFIUQSte9l2ka21ex4ROGqTe5yzGC/2WfrWkVYzxY+y8woRahol8MwRTmfTJjJsex4eLHVEVjawuwiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGHy4Pr0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGHy4Pr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5C8C19425;
	Mon, 16 Mar 2026 05:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773639651;
	bh=EOcJg2rpMZmxLxL/nNrRabAiSunwZmxsgympFKG+XVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uGHy4Pr0PmUsDIgPv4FBqyIqU2K4MeQ9n5w8oZaHRMBKLskR6ENL7+AIZfjPvOfZ5
	 sI68ch2mCPD+Sx5vXoS4Bdw0bgOaeTO2MVOhGSyUxLqE9O+h+fCwRdHv6NVSlyKVXh
	 wWhoTMSLLrtp+cGs4FFPjq3OP2vNUlyDIEyIQTJQAm9YID70+Ls8DQQGqXjUtWsxMz
	 QtVBU8VRHBzkf2sadpYGKxgLMn2KZYraktuuGp0aKSyHwJIoHSYUYA0WL6oYjieVyD
	 9n9uG9UNwMc+iuM7wirF01zTxp92zpHg0xZEcrLsgZGHQIW0uaWnR2O9jygB84smcP
	 zOlULZMRWVqHQ==
Date: Mon, 16 Mar 2026 11:10:42 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, Frank.Li@nxp.com, 
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, kernel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 02/13] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Message-ID: <phrbp7ypfsilv75dh723l5hekjfm7hn7wetihibjqgix7czyyf@rq3sgaqsvu2s>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
 <20260313020823.1592389-3-sherry.sun@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313020823.1592389-3-sherry.sun@nxp.com>

On Fri, Mar 13, 2026 at 10:08:12AM +0800, Sherry Sun wrote:
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
>  drivers/pci/controller/pci-host-common.c | 78 ++++++++++++++++++++++++
>  drivers/pci/controller/pci-host-common.h | 15 +++++
>  drivers/pci/probe.c                      |  1 +
>  include/linux/pci.h                      |  1 +
>  4 files changed, 95 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index d6258c1cffe5..2f012cf80463 100644
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
> @@ -17,6 +18,83 @@
>  
>  #include "pci-host-common.h"
>  
> +/**
> + * pci_host_common_delete_ports - Cleanup function for port list
> + * @data: Pointer to the port list head
> + */
> +static void pci_host_common_delete_ports(void *data)
> +{
> +	struct list_head *ports = data;
> +	struct pci_host_port *port, *tmp;
> +
> +	list_for_each_entry_safe(port, tmp, ports, list)
> +		list_del(&port->list);
> +}
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
> +	int err;
> +
> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		if (!of_node_is_type(of_port, "pci"))
> +			continue;
> +		ret = pci_host_common_parse_port(dev, bridge, of_port);
> +		if (ret)
> +			return ret;
> +	}
> +

I think you should just do:

	if (ret)
		return ret;

and get rid of 'err'.

> +	err = devm_add_action_or_reset(dev, pci_host_common_delete_ports,
> +				       &bridge->ports);
> +	if (err)
> +		return err;
> +
> +	return ret;

return 0;

- Mani

-- 
மணிவண்ணன் சதாசிவம்
