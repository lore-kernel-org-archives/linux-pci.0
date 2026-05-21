Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E707A18E02A
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351110; cv=none; b=nsQB4WybjdkEqVVidecStiPcMcI8XZ93L13Tfxi3gy8RHf7cbRv2vGdT8RNpFyGuRjrFq4lBsc8UKJYC/4jweZG2eAhTa9WhSQMsByT/SnxB89DbFHrPz8JMsEG3VsX0DbNmyinCBlqmurAcnqXQU/hMkDDlnvxIYny7CgUibns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351110; c=relaxed/simple;
	bh=rOQvLjlqzYBR01N/W5jhrRGyDtT3y6F4J1QDwS/pFJY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dVDP7JzrmmQncLUp0jGgY2Wp1nPKREMxaXMihq0zeNkj1RIbYs0WSuDQmOQ3qmtPQipoSi8pYQOnvOJOk7GpGoOMmOEnnLOyOlWZLF/EJc4I3xmAFETwVJfGMOHshp1JQffU8V4i2OH57xd/TDLRpTAt5HPbKcNkwOM9tpfpP/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWuOGayb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWuOGayb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BBF1F000E9;
	Thu, 21 May 2026 08:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779351108;
	bh=T2Ps0rxsQlMKAwSd2MGUgvBxGkrtxWqo+kb6pWWIZJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hWuOGaybfa0YCoEJL6k8tMkzdNT5gEgGXPwnJEBcTTQrM6Zb69NQsJFBT1oCCd7+p
	 rWxH6tU21rwBrHA17dIesJE8kSlmTSDnpa5UqA7M8PDyzOzEoZ1addOqg7KSK+6L0B
	 TaluZfUJw1ofhqS2hlBFhLYQoS1B2aOyp3+Tpzk7GzRwKfYoC6BrdWLqS0xTO2sdBX
	 kgM73BTXaSOnRIxOSPeREeUUwHeP5adjBn+z9/HVpQ7Dwvb5ufGGT7pmW0htTbPHW4
	 yjIxsShqdwm+f2qcMJ62625W6VnE/gwplj3RTf8F/L1Jq+07LZbSYr++ow8EoVk88u
	 aCfvLPk4Q8XyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: mediatek: Free IRQ domains while freeing Root
 Ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260521071907.13614-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260521071907.13614-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 08:11:48 +0000
Message-Id: <20260521081148.A8BBF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Moving IRQ teardown to `mtk_pcie_port_free()` introduces a teardow=
n order inversion, risking unclocked MMIO access and a system crash.
- [High] Calling `irq_domain_remove()` within `mtk_pcie_port_free()` during=
 system resume causes sleep-in-atomic bugs and Use-After-Free of IRQ domain=
s.

Pre-existing issues:
- [High] The driver illegally disposes of the platform IRQ mapping obtained=
 from the generic device tree IRQ parsing subsystem.
- [High] If `mtk_pcie_setup()` fails partially, previously parsed ports are=
 leaked and their chained handlers remain active, pointing to freed memory.
--

commit 77263bff61b3d5545508fb13fb6c05cad5bf5d14
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCI: mediatek: Free IRQ domains while freeing Root Ports

This commit moves the IRQ domain freeing logic from the driver removal
path into the mtk_pcie_port_free() helper. This attempts to fix a resource
leak when mtk_pcie_enable_port() fails.

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/control=
ler/pcie-mediatek.c
> index 75722524fe744..89b83db038734 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -248,6 +248,20 @@ static void mtk_pcie_port_free(struct mtk_pcie_port =
*port)
>  	struct mtk_pcie *pcie =3D port->pcie;
>  	struct device *dev =3D pcie->dev;
> =20
> +	if (port->irq) {
> +		irq_set_chained_handler_and_data(port->irq, NULL, NULL);

[Severity: High]
Does moving the IRQ teardown here introduce a teardown order inversion?

Looking at mtk_pcie_put_resources(), mtk_pcie_port_free() is called after
all hardware clocks (e.g., sys_ck, ahb_ck) have been disabled via
clk_disable_unprepare().

This leaves the chained IRQ handler registered and active while the hardware
is unclocked. If an interrupt fires during this window, wouldn't
mtk_pcie_intr_handler() execute and attempt to read from unclocked MMIO
registers, potentially triggering a synchronous external abort and a kernel
panic?

> +
> +		if (port->irq_domain)
> +			irq_domain_remove(port->irq_domain);

[Severity: High]
Does calling irq_domain_remove() here risk sleep-in-atomic bugs during
system resume?

If mtk_pcie_enable_port() fails during the NOIRQ phase of system resume in
mtk_pcie_resume_noirq(), the error path calls mtk_pcie_port_free(). The
NOIRQ phase runs in an atomic context with local CPU interrupts disabled.

Since irq_domain_remove() acquires the irq_domain_mutex:

kernel/irq/irqdomain.c:irq_domain_remove() {
    ...
    mutex_lock(&irq_domain_mutex);
    ...
}

Could this cause a deadlock or crash the system due to sleeping in atomic
context?

Additionally, wouldn't child endpoints still have active MSI mappings at
this stage? Forcibly removing the domain here violates API contracts, which
might trigger a warning on the non-empty revmap_tree and lead to
use-after-free crashes when child devices later resume.

> +
> +		if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +			if (port->inner_domain)
> +				irq_domain_remove(port->inner_domain);
> +		}
> +
> +		irq_dispose_mapping(port->irq);

[Severity: High]
This is a pre-existing issue, but does the driver illegally dispose of the
platform IRQ mapping here?

The driver obtains its IRQ via platform_get_irq(), which returns a virtual
IRQ mapping created by the core platform subsystem. The driver does not own
the lifecycle of this mapping.

By explicitly calling irq_dispose_mapping(), the platform IRQ descriptor
mapping is destroyed while the platform device's resource structure retains
the stale virtual IRQ number. Could this cause subsequent attempts to probe
the driver (like a module reload) to fail when request_irq() is passed the
now-invalid IRQ number?

> +	}
> +
>  	devm_iounmap(dev, port->base);
>  	list_del(&port->list);
>  	devm_kfree(dev, port);
>  }

[Severity: High]
This is a pre-existing issue, but are previously parsed ports leaked if
mtk_pcie_setup() fails partially?

During driver probe, mtk_pcie_setup() iterates over device tree children to
parse multiple ports. If an earlier port is parsed successfully, its port
structure is devres-allocated, added to the pcie->ports list, and its
chained IRQ handler is registered.

If a subsequent port fails parsing, mtk_pcie_setup() immediately returns an
error to mtk_pcie_probe(). The probe function returns the error without
calling mtk_pcie_put_resources(), bypassing cleanup for the successfully
parsed ports.

The driver core then frees the port structures via devres cleanup, but the
registered chained IRQ handlers remain active. If the hardware asserts an
interrupt, wouldn't the IRQ subsystem execute mtk_pcie_intr_handler() with
a freed port pointer, leading to a use-after-free crash?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521071907.1361=
4-1-manivannan.sadhasivam@oss.qualcomm.com?part=3D1
