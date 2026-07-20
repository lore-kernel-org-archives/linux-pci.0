Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE92B29BD87;
	Mon, 20 Jul 2026 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513789; cv=none; b=P7L+/dCpHxCKKOMUN5vLKNLmuExZKxQ6LVv38cvR5P1sCSFFnMG/NMa7fT0hETIC52AUQ/DTmGdorjrrtRkhsEzoD5qlaQBOrndRu7jLY/GGGbGLxpyK4I2tVHV0SUiThAT2BFwiFfqlXw9Fj9NR3BYoR7L6bd3CHGMn1FpqMjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513789; c=relaxed/simple;
	bh=m1xAcEg9H2LbaVkw+nczo7HXyiRjqy/c+7qHP2S7wR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=La18FxprIgN62Y+ooAONb7+DYnkJfGCqUiCjhz7Nl9J0Tz+VTCUA3Dx2+ZNea+Auwfq1WNFNT5yO1nh3OAUeDCPV+GXmGq3GvjcSQ4o6+7XDZriARc8PLVH1XagfHtPXzRSAWsmqEVejXMR9WkafY5FV+SoxoQlmZ/tbHWw6EbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MM8MRE3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MM8MRE3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8391F000E9;
	Mon, 20 Jul 2026 02:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784513787;
	bh=77YufwCdeMGTlpTiPlNfLuIViltyHcInD2f/vpKnfXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MM8MRE3Ge35nmkr8xqpRVpSltIerdT2aSFlKIRlN7MGhPXvBlPlTJdJ4YnrWLZggd
	 O7PE9zljWS7weDJZBjYmR9eQL4YsHsTdm6jFNh1mCLGc0OUHrqEANNcZPOqSEwJJBb
	 1K+S+vsVKZhbKaGcRv8AwcHvcLABVfDFeO6SkA/jUA+B+oWIo6w3p6GfZ4J5bVvj7Y
	 k4Ae1KH7Nd6iOm73wemxn7a66n78p7OgwHD9a0eP+UNGLMel89Da2PHEXk5089LrX0
	 Ix34QM65TDuOX4vB07AJrUuVjPEDfHEhWQISG3RSKJbF+ryBp/+BGiKniOaM/DHpiN
	 Pgn7o9UOlh59A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] PCI: dwc: rcar-gen4: Handle PERST via reset
 subsystem
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260720020505.315335-5-marek.vasut+renesas@mailbox.org>
References: <20260720020505.315335-1-marek.vasut+renesas@mailbox.org>
 <20260720020505.315335-5-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 02:16:27 +0000
Message-Id: <20260720021627.7F8391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrectly ordered error labels in `rcar_gen4_pcie_probe()` resul=
t in a leaked reset control and unbalanced runtime PM operations.
- [High] Probe fails unconditionally with -EINVAL on device trees without a=
 root port child node (e.g., existing R-Car Gen4 DTs and PCIe endpoints).
--

--- Patch [4]: [PATCH v2 4/5] PCI: dwc: rcar-gen4: Handle PERST via reset s=
ubsystem ---
commit ee4c8b0343b92a78672b94439fca7074d908ca06
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: dwc: rcar-gen4: Handle PERST via reset subsystem

Handle PERST via both GPIO and reset subsystem. On R-Car Gen4, the PERST
signal is operated as a GPIO, on R-Car Gen5 it might only be accessible via
SCMI reset via reset subsystem. Support both options.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index 73b01e74b42cb..f88168f2df195 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
[ ... ]
> @@ -316,12 +317,23 @@ static void rcar_gen4_pcie_unprepare(struct rcar_ge=
n4_pcie *rcar)
> =20
>  static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
>  {
> +	struct device *dev =3D rcar->dw.dev;
> +	struct device_node *root_port;
> +
>  	rcar->phy_base =3D devm_platform_ioremap_resource_byname(rcar->pdev, "p=
hy");
>  	if (IS_ERR(rcar->phy_base))
>  		return PTR_ERR(rcar->phy_base);
> =20
> +	root_port =3D of_get_next_available_child(dev->of_node, NULL);
> +	rcar->perst =3D of_reset_control_get_optional_exclusive(root_port, "per=
st");

[Severity: High]
Does this cause a probe failure on device trees without a root port child
node?

If of_get_next_available_child() returns NULL (for example, on existing R-C=
ar
Gen4 setups or endpoints), passing a NULL root_port to
of_reset_control_get_optional_exclusive() will return ERR_PTR(-EINVAL). This
error is then returned, causing the probe to fail unconditionally.

> +	of_node_put(root_port);
> +	if (IS_ERR(rcar->perst))
> +		return dev_err_probe(dev, PTR_ERR(rcar->perst), "Failed to get PERST#\=
n");
> +
>  	/* Renesas-specific registers */
>  	rcar->base =3D devm_platform_ioremap_resource_byname(rcar->pdev, "app");
> +	if (IS_ERR(rcar->base))
> +		reset_control_put(rcar->perst);
> =20
>  	return PTR_ERR_OR_ZERO(rcar->base);
>  }
[ ... ]
> @@ -654,7 +682,7 @@ static int rcar_gen4_pcie_probe(struct platform_devic=
e *pdev)
> =20
>  	err =3D rcar_gen4_pcie_prepare(rcar);
>  	if (err)
> -		return err;
> +		goto err_prepare;
> =20
>  	err =3D rcar_gen4_add_dw_pcie(rcar);
>  	if (err)
> @@ -662,6 +690,8 @@ static int rcar_gen4_pcie_probe(struct platform_devic=
e *pdev)
> =20
>  	return 0;
> =20
> +err_prepare:
> +	reset_control_put(rcar->perst);
>  err_unprepare:
>  	rcar_gen4_pcie_unprepare(rcar);

[Severity: High]
Are the error labels out of order here?

If rcar_gen4_pcie_prepare() fails, the code jumps to err_prepare which then
falls through to err_unprepare. This calls rcar_gen4_pcie_unprepare() and
performs an unbalanced pm_runtime_put().

Conversely, if rcar_gen4_add_dw_pcie() fails, the code jumps to err_unprepa=
re,
skipping err_prepare entirely. This results in a leaked rcar->perst reset
control.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720020505.3153=
35-1-marek.vasut+renesas@mailbox.org?part=3D4
