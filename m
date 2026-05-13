Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C3372067;
	Wed, 13 May 2026 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712586; cv=none; b=bTEqcbol6mjJluJg1RYdCHHeCU8iVCeVwVsl6qHPV5yu/Ij7ylFgURTJ/rbZwJD5a8uvhFLHNbqAEVEEGd6/9lyhCQs8341FCMsux8ic0LGSaFsnhsG0nQ2TokQgBhS2n+t27X1yqHMgT9ZFBuibxeyrd59bgiRTbpF2uYdhXeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712586; c=relaxed/simple;
	bh=snh8WWtSZOtloR9okUSICXDPd2H7ALbfL83v/F8Bo2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mXEsEcnnY2J5f9kM5RVAsQomfYh+VUD88Rzqv03Fv85alZvorfYVIEvmKsbCOOGXc0f6RuVFSMlAg1QDJQjw3q/NRZJ8umGQabUdoHyadfG9dPtSSw07uy2SVfy1Bn4HfWGynzzrHA6btc2CpBR3hs2QfiKThlW7DtAH4mlqUfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjmIuJTw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjmIuJTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C486C19425;
	Wed, 13 May 2026 22:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778712586;
	bh=snh8WWtSZOtloR9okUSICXDPd2H7ALbfL83v/F8Bo2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bjmIuJTwY1BMTbWxZgy5E1RLotWmdjlWb4Era4sodpTMdDSUZG+wOiZ5l8E+6rw/T
	 XFMwHr1rg6CI2uqQIENLsuWQqiApwllx8sKB/ykGHmBQWqnT7wGIWGvKdN9L7FKsx6
	 ALFn3lCDY6CyvkkJ4w0zpjTqwRCReRDf0mH/Mk+4PsCjofzyQ36oNmnrIqNov4p4EV
	 xpAtzSk6mThryFkS+xtkdEsEFIMaasqag0Bmv776QtvXuxRYlW0qN7ju/QiHuDZyyT
	 IRlTz4nhu6y58ItFD2KzKZHgwPv1KHgSpLSFvb0PNDo5w/m1fioqNjt+44kJka34ki
	 /QKfDYaZH8w5g==
Date: Wed, 13 May 2026 17:49:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, bhelgaas@google.com, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V14 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Message-ID: <20260513224944.GA341451@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422093549.407022-3-sherry.sun@nxp.com>

On Wed, Apr 22, 2026 at 05:35:39PM +0800, Sherry Sun wrote:
> Introduce generic helper functions to parse Root Port device tree nodes
> and extract common properties like reset GPIOs. This allows multiple
> PCI host controller drivers to share the same parsing logic.
> 
> Define struct pci_host_port to hold common Root Port properties
> (currently only list of PERST# GPIO descriptors) and add
> pci_host_common_parse_ports() to parse Root Port nodes from device tree.
> 
> Also add the 'ports' list to struct pci_host_bridge for better maintain
> parsed Root Port information.
> ...

> +static int pci_host_common_parse_port(struct device *dev,
> +				      struct pci_host_bridge *bridge,
> +				      struct device_node *node)
> +{
> +	struct pci_host_port *port;
> +	int ret;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&port->perst);
> +
> +	ret = pci_host_common_parse_perst(dev, port, node);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * 1. PERST# found in RP or its child nodes - list is not empty, continue
> +	 * 2. PERST# not found in RP/children, but found in RC node - return -ENODEV
> +	 *    to fallback legacy binding
> +	 * 3. PERST# not found anywhere - list is empty, continue (optional PERST#)
> +	 */
> +	if (list_empty(&port->perst)) {
> +		if (of_property_present(dev->of_node, "reset-gpios") ||
> +		    of_property_present(dev->of_node, "reset-gpio"))
> +			return -ENODEV;

This doesn't seem right to me.  The parser of per-Root Port properties
should not be responsible for deciding whether legacy methods are
valid, i.e., whether a property is in the Root Complex node.  I think
it's up to the caller to decide whether it needs to look elsewhere.

I don't think this even needs to return a "success/failure" value
because there may be more properties in the future, and not all will
be required.  This function can't tell which properties a specific
driver requires and which are optional.

The caller can check whether we found what it needs and fall back to a
legacy method as needed.

> +	}
> +
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
> + * Root Port properties (currently only reset GPIOs).
> + *
> + * Returns: 0 on success, -ENODEV if no ports found or PERST# found in RC node
> + * (legacy binding should be used), Other negative error codes on failure.
> + */
> +int pci_host_common_parse_ports(struct device *dev, struct pci_host_bridge *bridge)
> +{
> +	int ret = -ENODEV;
> +
> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		if (!of_node_is_type(of_port, "pci"))
> +			continue;
> +		ret = pci_host_common_parse_port(dev, bridge, of_port);
> +		if (ret)
> +			goto err_cleanup;
> +	}

I think we should export pci_host_common_parse_port() itself and drop
this so we deal with a single Root Port, and drivers that support
multiple RPs should include their own loop similar to this.  That way
the driver can do several things at once in each iteration of that
loop, e.g., get resources, power up, configure, etc.

I see that would require some rework of the devm_add_action_or_reset()
cleanup.

> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, pci_host_common_delete_ports,
> +					&bridge->ports);
> +
> +err_cleanup:
> +	pci_host_common_delete_ports(&bridge->ports);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_host_common_parse_ports);
> ...

> + * struct pci_host_perst - PERST# GPIO descriptor
> + * @list: List node for linking multiple PERST# GPIOs
> + * @desc: GPIO descriptor for PERST# signal
> + *
> + * This structure holds a single PERST# GPIO descriptor.
> + */
> +struct pci_host_perst {
> +	struct list_head	list;
> +	struct gpio_desc	*desc;
> +};

How do we associate an element of this list with something?

Based on the imx6 changes, I guess we don't; we don't even associate
the pci_host_port with an RP.  We just assert/deassert PERST# for
every RP at once, and we do it for every GPIO associated with each RP.

There's no way to assert PERST# for a single RP.  I guess we don't
need that?

> +/**
> + * struct pci_host_port - Generic Root Port properties
> + * @list: List node for linking multiple ports
> + * @perst: List of PERST# GPIO descriptors for this port and its children
> + *
> + * This structure contains common properties that can be parsed from
> + * Root Port device tree nodes.
> + */
> +struct pci_host_port {

"host_port" is not really a standard term.  And despite the comments
above and below, I don't think the list is restricted to Root Ports
because we traverse the whole hierarchy below the RP.

> +	struct list_head	list;
> +	struct list_head	perst;
> +};

> +	struct list_head ports;		/* Root Port list (pci_host_port) */
