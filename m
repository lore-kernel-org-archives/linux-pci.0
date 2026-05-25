Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E93B3BFE5A;
	Mon, 25 May 2026 07:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693069; cv=none; b=tYaCcyaxw3Yr84RFXYtanEsd7XxYpMuchrknGcmECJ7uSaeqZfn36OSAF8CZWWc9SZgBjftTGnA/6FiFGUILyDAhD09tJ7p9K73MGLqvF0k49nc55r5jEsuMeAp5DuaB26vQxeJB6Sm+uqGF4fsW9T/GEr49nn5Fr2mwH1a+jpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693069; c=relaxed/simple;
	bh=dUWramHZV89lmlWuUu86XpRZrCSy0baHbbma7koyXKw=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rglOdw7YguzTkNefrjJhv5ismouNQZs4Xei/0MleVcfk0SPZjhGT+u8y2NWC42WiDEQcdDukqWLYhFwvhSJBPI7XGAmM6qdmWpA8Qc5iBe2PcpAgf4EYke67buDOgcrF4f576t/7xpS+rIU36grNL2PDdnBGUa5kFUbNMA9bkMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vba0wNyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vba0wNyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03071F000E9;
	Mon, 25 May 2026 07:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779693067;
	bh=Ymj6p4G1gd8jUYtvg5dmrv8SQVLwDNMBNQsG3tpyces=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Vba0wNyk28CmbQFDirtFX7cz0DFdMcWpfFNG9JhO6kblRrBwv1Y6FDYVN2NnwZJpX
	 ZcrtKpdvL58PbI0EwSMTo6OcuNmjs9NCdwPuwagYqB4Rl7E+FyY1GmRdfFYd4DmVcb
	 m1LzNCceiCzSHmcqXm/FsKrjPWJcx42edcAc9ZIZQVdKb1CxzAi8uEnlRnj4ofZ/5N
	 mX1Dl4mjuaUn9jrjDmL4fe9b9QvfiMCqAOFSQaEFClrgRb0u3nlfSnSKGutskR4V3G
	 pJkHuGqLgymF3N7gcW9DMG/+civ9xlffpBXT/Ma3rfk7fuZQIKTd3A4x4lMSqgMkAV
	 LXftWdmyOw/9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 1/2] PCI: host-generic: Simplify return value
 handling in pci_host_common_parse_port(s)
Reply-To: sashiko-reviews@lists.linux.dev
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260525065443.2338629-2-sherry.sun@oss.nxp.com>
References: <20260525065443.2338629-2-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 07:11:07 +0000
Message-Id: <20260525071107.A03071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch changes the return value semantics of `pci_host_common_p=
arse_ports()` from `-ENODEV` to `0`, silently breaking legacy device tree b=
ackward compatibility for i.MX6 PCIe.
--

commit dd3d8b79463f9da53267b3bb06dcedefaa9d7673
Author: Sherry Sun <sherry.sun@nxp.com>

PCI: host-generic: Simplify return value handling in pci_host_common_parse_=
port(s)

This commit simplifies pci_host_common_parse_port and=20
pci_host_common_parse_ports to return 0 when no ports are found instead
of returning -ENODEV. It also removes the RC-level binding check,
delegating that policy decision to the caller.

> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/contr=
oller/pci-host-common.c
> index 2ce6f4b661334..c93de5a107581 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
[ ... ]
> @@ -158,13 +141,11 @@ static int pci_host_common_parse_port(struct device=
 *dev,
>   * Iterate through child nodes of the host bridge and parse Root Port
>   * properties (currently only reset GPIOs).
>   *
> - * Return: 0 on success, -ENODEV if no ports found or PERST# found in RC
> - * node (legacy binding should be used), Other negative error codes on
> - * failure.
> + * Return: 0 on success, negative error codes on failure.
>   */
>  int pci_host_common_parse_ports(struct device *dev, struct pci_host_brid=
ge *bridge)
>  {
> -	int ret =3D -ENODEV;
> +	int ret =3D 0;
> =20
>  	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
>  		if (!of_node_is_type(of_port, "pci"))
> @@ -174,8 +155,8 @@ int pci_host_common_parse_ports(struct device *dev, s=
truct pci_host_bridge *brid
>  			goto err_cleanup;
>  	}
> =20
> -	if (ret)
> -		return ret;
> +	if (list_empty(&bridge->ports))
> +		return 0;

[Severity: High]
Does returning 0 instead of -ENODEV here break bisectability for legacy
device trees on i.MX6?

Looking at the caller imx_pcie_host_init() in=20
drivers/pci/controller/dwc/pci-imx6.c, it relies on this exact -ENODEV=20
return value to detect the absence of Root Port nodes and fall back to=20
parsing legacy bindings:

imx_pcie_host_init()
    ret =3D pci_host_common_parse_ports(dev, bridge);
    if (ret =3D=3D -ENODEV)
        ret =3D imx_pcie_parse_legacy_binding(imx_pcie);
    if (ret)
        return ret;

Since this helper now returns 0 when no ports are found, the caller bypasses
its error-handling and legacy fallback block entirely, leaving the
bridge->ports list empty. Consequently, imx_pcie_assert_perst() will do
nothing, and the PERST# GPIO will never be parsed or asserted.

I see that this issue is fixed later in the series by commit=20
0dd88230fe087b9c6a87eed08edc4d3be7f1fe1a (PCI: imx6: Add
imx_pcie_perst_found() to inspect the parsed result), but updating the API
without updating the caller in the same commit could break bisection.

>  	return devm_add_action_or_reset(dev, pci_host_common_delete_ports,
>  					&bridge->ports);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525065443.2338=
629-1-sherry.sun@oss.nxp.com?part=3D1
