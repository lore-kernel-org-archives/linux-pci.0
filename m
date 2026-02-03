Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443234C83D;
	Tue,  3 Feb 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770124108; cv=none; b=cEfu1f/oPzi4zuNmWdP8Lo6m6+WjyA7byXudi0BCGfiV04n271r29nQambELd5rR0FhHyBmWbJ7UoJxskNLKFKD0OMyqqG2//iWju7dbhXdt7rdLaKjWMY9KkGF42srX7A+wJQMbVEOdv18Mw5S2gzlQdKuUzaR4oWKFvLVl6+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770124108; c=relaxed/simple;
	bh=ERzJQs+ogmgSsz2jOjgrhJNR97TY+ErDM0YSHLbWBPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWwf8zBdibx1YsauVno4HAo3wMgkrWz4HmB/LrkBt2pJOoLbwMqhr6fPenwY7HPa2kvKeQGls46zmDmWWds/rqEaaonWKdm2JLtNAZYziokbPpI6AdayGwrvm0oEJVDpTRc4MSKSpmo5oiFyFP3WgTf8I89p4J4sAeS+5Dy8na0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZzukd4W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZzukd4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E4BC19421;
	Tue,  3 Feb 2026 13:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770124107;
	bh=ERzJQs+ogmgSsz2jOjgrhJNR97TY+ErDM0YSHLbWBPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZzukd4WV0HQ4RfqAwiKZ3wguxJQbATAMAs0jIB2ffv6Mouu5hLwh20jwt9YgArTK
	 RLN0xWMoXW1R4OYA3xmVjCjCuFzS7zofmgNLixa5hKuslzVDzMyb7FOHJwsWSGC8Fg
	 5AaIixXcmpWIWt+ee/OqESW+R97Wq908ZzW9knvyRSnDTOQfFKbq6xb5xHrmfLVv53
	 QhfX7zD+R5OgKiefemLK8sfVMaEBPhMgq76cAc3oVdXjmGRQQM8qr1jZj7FnxFGeW3
	 a2zkOTytfjKHuYosjXSt1wOXHALk927DhF6T5Kg+mucwIYl/GDPrcyu7aP7AVhwQWf
	 sAciYqCZ2XsJQ==
Date: Tue, 3 Feb 2026 18:38:18 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, Frank.Li@nxp.com, 
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, kernel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 02/10] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Message-ID: <nekxn5osukwkumqfh4qabj6okhtv4tdwrnthza4x54psrhauyf@p3lhia4mkhb4>
References: <20260203015614.2957479-1-sherry.sun@nxp.com>
 <20260203015614.2957479-3-sherry.sun@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260203015614.2957479-3-sherry.sun@nxp.com>

On Tue, Feb 03, 2026 at 09:56:06AM +0800, Sherry Sun wrote:
> DT binding allows specifying 'reset' property in both host bridge and
> Root Port nodes, but specifying in the host bridge node is marked as
> deprecated. So add support for parsing the new binding that uses
> 'reset-gpios' property for PERST#.
> 
> The initial idea is to add the PCIe M.2 KeyE connector support and PCI
> power control framework to the pcie-imx6 driver. Since the new
> M.2/pwrctrl model is implemented based on Root Ports and requires the
> pwrctrl driver to bind to a Root Port device, we need to introduce a
> Root Port child node on i.MX boards that provide an M.2 connector.
> 
> To follow a more standardized DT structure, it also makes sense to move
> the reset-gpios and wake-gpios properties into the Root Port node. These
> signals logically belong to the Root Port rather than the host bridge,
> and placing them there aligns with the new M.2/pwrctrl model.
> 
> To maintain DT backwards compatibility, fallback to the legacy method of
> parsing the host bridge node if the reset property is not present in the
> Root Port node.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 123 +++++++++++++++++++++++---
>  1 file changed, 109 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index a5b8d0b71677..e3ba68976bee 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -148,10 +148,15 @@ struct imx_lut_data {
>  	u32 data2;
>  };
>  
> +struct imx_pcie_port {
> +	struct list_head	list;
> +	struct gpio_desc	*reset;
> +};
> +

I'd love to abstract the Root Port properties in a generic struct so that we can
introduce generic APIs to parse the ports. But I'm not asking you to implement
it :)

>  struct imx_pcie {
>  	struct dw_pcie		*pci;
> -	struct gpio_desc	*reset_gpiod;
>  	struct clk_bulk_data	*clks;
> +	struct list_head	ports;
>  	int			num_clks;
>  	bool			supports_clkreq;
>  	bool			enable_ext_refclk;
> @@ -897,29 +902,35 @@ static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  
>  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  {
> +	struct imx_pcie_port *port;
> +
>  	reset_control_assert(imx_pcie->pciephy_reset);
>  
>  	if (imx_pcie->drvdata->core_reset)
>  		imx_pcie->drvdata->core_reset(imx_pcie, true);
>  
>  	/* Some boards don't have PCIe reset GPIO. */
> -	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
> +	list_for_each_entry(port, &imx_pcie->ports, list)
> +		gpiod_set_value_cansleep(port->reset, 1);
>  }
>  
>  static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
>  {
> +	struct imx_pcie_port *port;
> +
>  	reset_control_deassert(imx_pcie->pciephy_reset);
>  
>  	if (imx_pcie->drvdata->core_reset)
>  		imx_pcie->drvdata->core_reset(imx_pcie, false);
>  
>  	/* Some boards don't have PCIe reset GPIO. */
> -	if (imx_pcie->reset_gpiod) {
> -		msleep(100);
> -		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
> -		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
> -		msleep(100);
> -	}
> +	list_for_each_entry(port, &imx_pcie->ports, list)
> +		if (port->reset) {
> +			msleep(100);

PCIE_T_PERST_CLK_US

> +			gpiod_set_value_cansleep(port->reset, 0);
> +			/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
> +			msleep(100);

Remove the comment and just use PCIE_T_PVPERL_MS.

> +		}
>  
>  	return 0;
>  }
> @@ -1642,6 +1653,76 @@ static const struct dev_pm_ops imx_pcie_pm_ops = {
>  				  imx_pcie_resume_noirq)
>  };
>  
> +static void imx_pcie_delete_ports(void *data)
> +{
> +	struct imx_pcie *pcie = data;
> +	struct imx_pcie_port *port, *tmp;
> +
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> +		list_del(&port->list);
> +}
> +
> +static int imx_pcie_parse_port(struct imx_pcie *pcie, struct device_node *node)
> +{
> +	struct device *dev = pcie->pci->dev;
> +	struct imx_pcie_port *port;
> +	struct gpio_desc *reset;
> +
> +	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> +				      "reset", GPIOD_OUT_HIGH, "PCIe reset");

s/"PCIe reset"/"PERST#"

> +	if (IS_ERR(reset))
> +		return PTR_ERR(reset);
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->reset = reset;
> +	INIT_LIST_HEAD(&port->list);
> +	list_add_tail(&port->list, &pcie->ports);
> +
> +	return 0;
> +}
> +
> +static int imx_pcie_parse_ports(struct imx_pcie *pcie)
> +{
> +	struct device *dev = pcie->pci->dev;
> +	int ret = -ENOENT;
> +
> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		if (!of_node_is_type(of_port, "pci"))
> +			continue;
> +		ret = imx_pcie_parse_port(pcie, of_port);
> +		if (ret) {
> +			imx_pcie_delete_ports(pcie);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie)
> +{
> +	struct device *dev = pcie->pci->dev;
> +	struct imx_pcie_port *port;
> +	struct gpio_desc *reset;
> +
> +	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset))
> +		return PTR_ERR(reset);
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->reset = reset;
> +	INIT_LIST_HEAD(&port->list);
> +	list_add_tail(&port->list, &pcie->ports);
> +
> +	return 0;
> +}
> +
>  static int imx_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1660,6 +1741,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	if (!pci)
>  		return -ENOMEM;
>  
> +	INIT_LIST_HEAD(&imx_pcie->ports);
> +
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  
> @@ -1688,12 +1771,24 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  			return PTR_ERR(imx_pcie->phy_base);
>  	}
>  
> -	/* Fetch GPIOs */
> -	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> -	if (IS_ERR(imx_pcie->reset_gpiod))
> -		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
> -				     "unable to get reset gpio\n");
> -	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
> +	ret = imx_pcie_parse_ports(imx_pcie);
> +	if (ret) {
> +		if (ret != -ENOENT)
> +			return dev_err_probe(dev, ret, "Failed to parse Root Port: %d\n", ret);
> +
> +		/*
> +		 * In the case of properties not populated in Root Port node,
> +		 * fallback to the legacy method of parsing the Host Bridge
> +		 * node. This is to maintain DT backwards compatibility.
> +		 */
> +		ret = imx_pcie_parse_legacy_binding(imx_pcie);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Unable to get reset gpio: %d\n", ret);
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, imx_pcie_delete_ports, imx_pcie);
> +	if (ret)
> +		return ret;

I'd prefer to do it in err labels.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
