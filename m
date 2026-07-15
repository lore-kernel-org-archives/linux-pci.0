Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174EF1917CD
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 01:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078386; cv=none; b=ijvh80j1NAqtiXLSKfnwGLBQ6gDNgOvBGcse3TTIC/hhLcSi/yHOBUCMITSuptJZkPGlv/3gsewL+akZjA9V+TRmMiJvk8O+UUkXuJTRnq2Me22YfEptxCkNtu5pOU3tQnT1mVMfHnjblWk1Mjb78EXE9WOTyeLI0rgmKdjvk3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078386; c=relaxed/simple;
	bh=+udn5sqFNV9kysT0ZpfiJPKqfjCInzsYsOg8CaQA4dI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OSUk/LwSOsxUqtrSe177dBpjSjmnO3FQh1tq0RhJbOLYpt55w0cgSuBeri9gE1zmFugKaxXIkZNYYhA1aKYQBUlKEVzkfAAPf6Rqyy3+zxIoHqWSH4tmoQ6i+btWYT8tA9rXH9/XJ4NFnQ+QQy2Au4kAQy2eWgKDbSdea5o28BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8Mow5WR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8Mow5WR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F6C1F000E9;
	Wed, 15 Jul 2026 01:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784078384;
	bh=HzJhHo8cX0Imleb/yHm/D/laDQWmbwZ47DYHV6qnobk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e8Mow5WRCl/hEGoIXsM6s1jN1pK6OHqYpxMWydZl+bHQQx6Hb8Pf9tRCEbd+ecpjz
	 1y8Wt8zIB/w0LFvrIigNvjbRKDk+uFE28OyBe+eibohOzq1141PIDx9nHQB2c0WfXl
	 snJ9EhGyC9F2b0Ef8lLJ+k6JgkC+6+P1xXyes/M1qliVonU7JszwdjflyaMlkiV8rU
	 rey604c2y9slJM3ELfnLUg6kC1V87gRhr6A58FyGHXTD3UZ0hVw9cQPfyekIhfq3Pf
	 198Rrkl87Ot2hh2VC7oL0B0xrdECZajsZUbzsSysWHbR4ZcrCPA5aWL+f86H2TE4Jz
	 QeQYSlCtCoRbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: xilinx: use fwnode_irq_get() for INTx IRQ lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260715011142.1261469-1-rosenp@gmail.com>
References: <20260715011142.1261469-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 01:19:44 +0000
Message-Id: <20260715011944.84F6C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing `dev_err_probe()` causes spurious boot log spam on probe de=
ferral.
--

--- Patch [1]: [PATCH] PCI: xilinx: use fwnode_irq_get() for INTx IRQ looku=
p ---
commit 3b83750c982aed2e3747f9f586daf87ae00edeec
Author: Rosen Penev <rosenp@gmail.com>

PCI: xilinx: use fwnode_irq_get() for INTx IRQ lookup

This commit replaces irq_of_parse_and_map() with fwnode_irq_get() in
xilinx_pcie_parse_dt(). It also introduces error handling for the returned
IRQ value, propagating negative errors (including -EPROBE_DEFER) up the
stack instead of passing failures to devm_request_irq().

> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controlle=
r/pcie-xilinx.c
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c

[ ... ]

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

[Severity: Low]
Does this introduce spurious boot log spam during probe deferral?

Since fwnode_irq_get() can return -EPROBE_DEFER, returning it directly here
propagates the deferral up to the caller, xilinx_pcie_probe().

In xilinx_pcie_probe(), the error is handled like this:

	err =3D xilinx_pcie_parse_dt(pcie);
	if (err) {
		dev_err(dev, "Parsing DT failed\n");
		return err;
	}

Would it make sense to update xilinx_pcie_probe() to use dev_err_probe()
to handle the newly propagated -EPROBE_DEFER quietly?

>  	err =3D devm_request_irq(dev, irq, xilinx_pcie_intr_handler,
>  			       IRQF_SHARED | IRQF_NO_THREAD,
>  			       "xilinx-pcie", pcie);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715011142.1261=
469-1-rosenp@gmail.com?part=3D1
