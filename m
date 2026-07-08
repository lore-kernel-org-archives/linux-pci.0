Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8170D38BF6C
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505095; cv=none; b=lIcCb1KCt86M8GOzuGKFDWnV7PdGCZ8oCvXISQHCAHwAKnVp4OF2DSs7TnOq5WPr3lEto5uKQhABCTXhXvId1PCRL7DNLayMc0TLbFI4BEQLGABMeA8uNlVmwZPWvCgyt3QV0CrSlqjdD/PQHLtXSIQQHQq9YVqeyReEPU+lP/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505095; c=relaxed/simple;
	bh=LmUkoIJL4++leoQBziNDPcAXO07FsSR0hCorhNFIoO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pfkygXkxUF+b5n33i4TuDRIdu0A73M74CgZHxMpNR/dI9anx4Lujp3qqDkWMPrVxMHS4cMWL8OQui6aF4XV+9ErWCSrRfjh8qd/lPn2wJlvZDmIXgaQbx1TNPeehhotPzInrl6YDH1Y4C7dfqTz0S8YWKbaG9IiPH1zw6fk2xQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOLEE9nf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOLEE9nf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A621F000E9;
	Wed,  8 Jul 2026 10:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783505094;
	bh=pkang7y9RnFSvS/KW0qylm49cN3pNWTBejIps/C2DqM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jOLEE9nfgGTbHO0yexoUv8m2ezhhxjIWUpXs+WuNE7jmEKvHBcZ4uQLigfDES3scC
	 smtp75V3ut8R3vmWn7jGR1ho17W2GMLITI4VTJ96YHfUmUZp4uiEtn1deGNJ9e1Zr4
	 ceG3cU3n3ail/3wrP5n0Ipw1NHB9bb4VJbZH6ravU4w241axlQv8Al7udDvbwdBDrY
	 eTL8cN9S4mof3inIdjLUCwPanRBwmjjQqZlAirmAT1nzgAyBOZZrhCMulZtJnYcF/l
	 wznOFBYMijYfhjT5JJcrEHphbSN0al+8eCBEO994aki1Rm9fYb91rAw3WRuHROfjlX
	 /Ov20aNhu3zcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: aspeed: Switch to irq_domain_create_linear()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260708095814.385480-1-jirislaby@kernel.org>
References: <20260708095814.385480-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 10:04:53 +0000
Message-Id: <20260708100454.00A621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims to use `of_fwnode_handle()`, but the c=
ode actually uses `dev_fwnode()`.
--

--- Patch [1]: [PATCH] PCI: aspeed: Switch to irq_domain_create_linear() ---
commit aee46b37ad2da511a238368770cbd10115b36171
Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>

PCI: aspeed: Switch to irq_domain_create_linear()

This commit updates the driver to use the modern irq_domain_create_linear()
function instead of the obsolete irq_domain_add_linear(). It adjusts the
first parameter to pass a fwnode_handle rather than a device_node.

> irq_domain_add_linear() is going away as being obsolete now. Switch to
> the preferred irq_domain_create_linear(). That differs in the first
> parameter: It takes more generic struct fwnode_handle instead of struct
> device_node. Therefore, of_fwnode_handle() is added around the
> parameter.
>=20
> Note some of the users can likely use dev->fwnode directly instead of
> indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
> guaranteed to be set for all, so this has to be investigated on case to
> case basis (by people who can actually test with the HW).

> diff --git a/drivers/pci/controller/pcie-aspeed.c b/drivers/pci/controlle=
r/pcie-aspeed.c
> index 9aa9e14c61484..74b03a55643fa 100644
> --- a/drivers/pci/controller/pcie-aspeed.c
> +++ b/drivers/pci/controller/pcie-aspeed.c
> @@ -725,10 +725,10 @@ static int aspeed_pcie_init_irq_domain(struct aspee=
d_pcie *pcie)
>  {
>  	int ret;
> =20
> -	pcie->intx_domain =3D irq_domain_add_linear(pcie->dev->of_node,
> -						  PCI_NUM_INTX,
> -						  &aspeed_intx_domain_ops,
> -						  pcie);
> +	pcie->intx_domain =3D irq_domain_create_linear(dev_fwnode(pcie->dev),
> +						     PCI_NUM_INTX,
> +						     &aspeed_intx_domain_ops,
> +						     pcie);

[Severity: Medium]
Does this code change contradict the commit message?=20

The commit message explicitly mentions adding of_fwnode_handle() around the
parameter and warns against using dev->fwnode directly since it is not
guaranteed to be set.

The patch uses dev_fwnode(pcie->dev) here, which fetches dev->fwnode, rather
than using of_fwnode_handle(pcie->dev->of_node) as described. Should the
implementation be updated to use of_fwnode_handle(), or does the commit
message need to be revised to match this dev_fwnode() approach?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708095814.3854=
80-1-jirislaby@kernel.org?part=3D1
