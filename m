Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AD83BED0C
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784235903; cv=none; b=MBrkw+8fK8aXh5mTf3/fPL4X4Im+bFH79dFoiV3KToCRzAY6GuuGRj1EdConzaTrJ4EM7PWFpKtqvv3V2LCJ8b3vpyBi+o7kw9oqBDx4sU5NOIDGUSZfBa0YpfkbziNXGjFdQ4fKXh68sEUD1lablknT/McF0sA7AXYiJj8TofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784235903; c=relaxed/simple;
	bh=yhGAA+f/93d/uWo+/PneUWs49D0MJ+Brm5w4qiWvwaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l2jNasr8QeH8xcXpOyEBqOY+ol8GpDCJBvI1Ma82ELz1Q9FQQ+A9kmLkscLfCl/BuNIu9qm3pelTf/hVzu/bh+m9UGASXpKWnjaz9AEfA83DILC5IjKs+EfCHhEQ4fl7napXh9IvRHf+qRFn8dFf5TBxu62HFRGi5M0tGwY4nW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyvTfee+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyvTfee+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1921F00A3E;
	Thu, 16 Jul 2026 21:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784235902;
	bh=tuGbG7hZBEbJfiVpGS9Rh9qqpxTvnhlb2iciH8dOpps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NyvTfee+yrztd4SnmexTFQmxDjwz558lMDOf0L7e0g1dUq7xDPA10u9hZD2XKtQk/
	 zH1xQjK0UFnjZ6/n1oPxY163IHXySnV6uRn8pyMKparpqX43LlZ05mgDtMsvWglJx4
	 nRLIACO3Dh7APABkFXPrF9/P4teuw30FI/yg41kEjZ5XB8JRVx9TUHeSJ+isGvpBHO
	 S1fKN0Ai3bafHBwKjI62B82Lwp7kkECDLg7SaifujKFrF9GhLnrIE0YcCXaVYYc/g8
	 KdUvvlUKkJUFUMSnC3ixi2jJZ8LfbyKpTr6A/0zeh1nqyrr/X4Ee40exy0AS9PLyfc
	 wxgkq6deWqe6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] PCI: xilinx: use fwnode_irq_get() for INTx IRQ lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260716205811.800920-1-rosenp@gmail.com>
References: <20260716205811.800920-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 21:05:01 +0000
Message-Id: <20260716210502.2D1921F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver requests a shared IRQ before it masks hardware interrup=
ts and before it allocates its IRQ domains, creating a race condition that =
can lead to an interrupt storm.
--

--- Patch [1]: [PATCHv2] PCI: xilinx: use fwnode_irq_get() for INTx IRQ loo=
kup ---
commit 02b4ee51408c6b762dcc417c028ea4f662761599
Author: Rosen Penev <rosenp@gmail.com>

PCI: xilinx: use fwnode_irq_get() for INTx IRQ lookup

This commit replaces irq_of_parse_and_map() with fwnode_irq_get() for
looking up the INTx IRQ, checking the return value to properly propagate
errors such as -EPROBE_DEFER.

> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controlle=
r/pcie-xilinx.c
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -548,7 +548,10 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie *=
pcie)
>  	if (IS_ERR(pcie->reg_base))
>  		return PTR_ERR(pcie->reg_base);
> =20
> -	irq =3D irq_of_parse_and_map(node, 0);
> +	irq =3D fwnode_irq_get(dev_fwnode(dev), 0);
> +	if (irq < 0)
> +		return irq;
> +
>  	err =3D devm_request_irq(dev, irq, xilinx_pcie_intr_handler,
>  			       IRQF_SHARED | IRQF_NO_THREAD,
>  			       "xilinx-pcie", pcie);

[Severity: High]
This is a pre-existing issue, but does requesting the shared IRQ here
create a race condition?

Looking at xilinx_pcie_probe(), xilinx_pcie_parse_dt() is called before
xilinx_pcie_init_port() masks the hardware interrupts, and before
xilinx_pcie_init_irq_domain() allocates the MSI and legacy IRQ domains.

If the shared IRQ fires before the domains are created,
xilinx_pcie_intr_handler() will execute with pcie->msi_domain and
pcie->leg_domain as NULL.

In that scenario, generic_handle_domain_irq() will return -EINVAL, leaving
the level-triggered interrupt unserviced. Because the handler returns
IRQ_HANDLED, could this immediately re-enter the handler and cause an
unhandled interrupt storm?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716205811.8009=
20-1-rosenp@gmail.com?part=3D1
