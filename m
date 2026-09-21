Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC8475342;
	Mon, 21 Sep 2026 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005592; cv=none; b=n3/kYN3/eiG5wUqeawIURwh3h89qrMQ0+6R1aePTiaiCUMdezoMUlHx1yUkwdQ6qGACmgtIqGqnQWTjx9AgDpjg3kc19ROnPVftYpbbvDR1eDjTUaYkjZRRldqptAlRI02ycg8MJh6AB4CiMyY/54UM50ymEPDufc8TTbJSptDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005592; c=relaxed/simple;
	bh=YH7dd7nmVDIYpExQlL40HE59/Q1O3Y6Z22Cro4sosHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aC1ZMXUTVypl+u6UNylwBYnNsnzZ32qCs8aOgRmRAIaYBclH/Bp7/WJ7mcPYUxWGlE027uRzt9yGRtXv/UT3aWvsVhoM0YhtOK5XrKdwFMgQDwccbCBtvZbHiWRMXmQIukQkxBm4ST/jctOBbq68tjQIOrxBwC86Ql6ehJuhYoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Awjc7CQ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Awjc7CQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DDB1F000FF;
	Mon, 21 Sep 2026 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790005590;
	bh=wtAWY4UOgMsDtGmwPaOVo/YohvZdMJTG3nDB7UNWK3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Awjc7CQ5UAPLZEFbtu6Dr7+Ugo9fVa98qwiPwJ4+sPPjKHIR+2lq5Py4bYSRcD9vU
	 BN+msvop/XqRX2hXl9RkOiuyIMuHTn158g29NB6tapfs6Z9XInEPOS3qpNadBCf4mp
	 S/kxtfKP4ganLGDw9slJQhrEZqe4H/+Y7YOlbhcqDzNG6pcR4slGz3HNEUeT5a6ib2
	 5k0IMdDenXatIBX8YNx/nTnJcP9SsWftWtI3cDOJyGALoDRoZ6ty8nq7KaAHSdgOkV
	 MBpGKsoj6GV2zajYYBl32o1mVen6VO3jRoBdjf3QGszzBh/OvbxA3b4f1FvjvqRPOQ
	 270qpH7qVD0KQ==
Date: Mon, 21 Sep 2026 17:46:22 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 5/6] PCI: dwc: rcar-gen4: Handle PERST via reset
 subsystem
Message-ID: <zwdqspl2uno35uffgzsel57ed2umpejgfeqrkwvxiqd2pgfpm6@h6w3qsgc6rny>
References: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
 <20260905212649.360498-6-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260905212649.360498-6-marek.vasut+renesas@mailbox.org>

On Sat, Sep 05, 2026 at 11:26:26PM +0200, Marek Vasut wrote:
> Handle PERST via both GPIO and reset subsystem. On R-Car Gen4, the
> PERST signal is operated as a GPIO, on R-Car Gen5 it might only be
> accessible via SCMI reset via reset subsystem. Support both options.
> This is a preparatory patch for R-Car Gen5 support.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: - Use dev_err_probe() for perst in rcar_gen4_pcie_get_resources()
>     - Use of_get_next_available_child() to obtain root port OF node
>     - Switch to of_reset_control_get_optional_exclusive() to deal with
>       R-Car Gen4, where the PERST is handled as GPIO instead of reset
>     - Rename rcar_gen4_pcie_host_perst() to rcar_gen4_pcie_host_perst_assert()
>       and use bool type for assert and deassert selection
>     - Add missing reset_control_put() into rcar_gen4_pcie_probe() fail path
> V3: - Handle controllers without root port DT node
>     - Swap fail path order
> V4: Rebase on next-20260904
> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 44 +++++++++++++++++++--
>  1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index c768a9c7b3b76..89472a4becc46 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -99,6 +99,7 @@ struct rcar_gen4_pcie {
>  	void __iomem *base;
>  	void __iomem *phy_base;
>  	struct platform_device *pdev;
> +	struct reset_control *perst;
>  	const struct rcar_gen4_pcie_drvdata *drvdata;
>  };
>  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
> @@ -317,12 +318,27 @@ static void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
>  
>  static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
>  {
> +	struct device *dev = rcar->dw.dev;
> +	struct device_node *root_port;
> +
>  	rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
>  	if (IS_ERR(rcar->phy_base))
>  		return PTR_ERR(rcar->phy_base);
>  
> +	root_port = of_get_next_available_child(dev->of_node, NULL);
> +	if (root_port) {
> +		rcar->perst = of_reset_control_get_optional_exclusive(root_port, "perst");
> +		of_node_put(root_port);
> +		if (IS_ERR(rcar->perst))
> +			return dev_err_probe(dev, PTR_ERR(rcar->perst), "Failed to get PERST#\n");
> +	} else {
> +		rcar->perst = NULL;

'rcar->perst' is NULL by default.

> +	}
> +
>  	/* Renesas-specific registers */
>  	rcar->base = devm_platform_ioremap_resource_byname(rcar->pdev, "app");
> +	if (IS_ERR(rcar->base))
> +		reset_control_put(rcar->perst);
>  
>  	return PTR_ERR_OR_ZERO(rcar->base);
>  }
> @@ -494,6 +510,22 @@ static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
>  	return 0;
>  }
>  
> +static void rcar_gen4_pcie_host_perst_assert(struct dw_pcie_rp *pp, bool assert)
> +{
> +	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +
> +	gpiod_set_value_cansleep(dw->pe_rst, assert);
> +
> +	if (!rcar->perst)
> +		return;
> +
> +	if (assert)
> +		reset_control_assert(rcar->perst);
> +	else
> +		reset_control_deassert(rcar->perst);

So the controller will only have one form of PERST# implemented at a time. Even
though this code is technically correct, it also gives an impression that both
form could co-exist.

So I'd recommend using:

        if (dw->pe_rst) {
                gpiod_set_value_cansleep(dw->pe_rst, assert);
        } else {
                if (assert)
                        reset_control_assert(rcar->perst);
                else
                        reset_control_deassert(rcar->perst);
        }

to makes it clear that only one form of PERST# is supported.

I'll implement both of these changes while applying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
