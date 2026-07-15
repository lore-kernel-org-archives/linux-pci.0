Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98B03BD653
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784155199; cv=none; b=KjkLgwu5yhe4nXeVuCBiKAgF09NyCYBML2XdphhniWDtXjYgrgS95MTGcgkHY5U/yvHSioFLVe75YJvJMeKSWDb9tomiD4IAhloeEFsRimxiptUAewpeSvWEv+A1Ac6Yh0FWVDqoazAH0HhnP9D70g393V0LoWL3E7t8ad21YKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784155199; c=relaxed/simple;
	bh=JNs0TVrTZGyTOoBIu2d/eQYEbREThikOuBeI0ykXQGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UJKxWMWIok3DD5x1jk2Fpejmxloz7ckr5laE1nRlWRJw1ma/ZgSrz0WcWN9qVkgE8EmsFKNrwDYuhl6TgwiGvyuCMuDT3QPg0T7mJ0/qQ+0+EmDP3sTK4qQMVPoL6e/Add2O+Byuqaho7TXjr6EkNxoguAO5GFZZ/RzfoqWGzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7fzIrPd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7fzIrPd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EDD1F00A3A;
	Wed, 15 Jul 2026 22:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784155197;
	bh=Y18u+FcDbyFzGQ8faIcBNX94uJqsLREad/76/8tPQuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F7fzIrPd7KF9A+6WwLJ7Bwupeq93CF6l6vZLWNhtTR4Ac4mGzlQYyW7z8Uc1H3Dr3
	 RMUGTxkBpCZT9q3uBur4P7bIYAhJmBkYBQ9V9Cks05R+1qtV+JiyxqpIYk1WEHHXmU
	 3H4Z7ttLMr7fXaQ5UulTCIi/Ho2JWX2+ZviEnUcA1EoE6NZc7hVkkCspnyxRR7yoL0
	 saCTZ1Nq459+ddO3nylqD+1Mm/Hd8WxTVkZPCH/uBcqc4JY4a0uNTYuorD2DfKqO77
	 kyPGYAjemveRA/HTaUAoNsnGTWPzZymKe7WU2OxgQ+o3++7oS5hWbVLrJ7WFl0ovD+
	 nfHOw1nMgpSjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] PCI: rzg3s: Fix IRQ domain initialization error
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260715223019.3002237-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260715223019.3002237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260715223019.3002237-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 22:39:56 +0000
Message-Id: <20260715223957.56EDD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free window in INTx IRQ domain error handling path.
- [High] Chained INTx handlers are registered before their dependent IRQ do=
main is created.
- [High] Unsafe contiguous virtual IRQ assumption leads to incorrect hardwa=
re IRQ index calculation.
- [High] Read-Modify-Write operations corrupt Write-1-to-Clear (W1C) interr=
upt status registers.
--

--- Patch [3]: [PATCH 3/3] PCI: rzg3s: Fix IRQ domain initialization error =
handling ---
commit 7daa41537d847b29b2790ef6fee098277445112b
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
PCI: rzg3s: Fix IRQ domain initialization error handling

This commit attempts to fix the error path during IRQ domain initialization
by ensuring chained handlers are unregistered if subsequent steps fail. It
also updates the teardown path to clear INTx handlers.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
[ ... ]
>  static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
>  {
[ ... ]
>  	for (i =3D 0; i < PCI_NUM_INTX; i++) {
[ ... ]
>  		host->intx_irqs[i] =3D irq;
>  		irq_set_chained_handler_and_data(irq,
>  						 rzg3s_pcie_intx_irq_handler,
>  						 host);
>  	}
> =20
>  	host->intx_domain =3D irq_domain_create_linear(dev_fwnode(dev),
>  						     PCI_NUM_INTX,
>  						     &rzg3s_pcie_intx_domain_ops,
>  						     host);

[Severity: High]
This is a pre-existing issue, but does this sequence leave a window where
interrupts can be misrouted?

If a hardware INTx interrupt fires immediately after unmasking via
irq_set_chained_handler_and_data(), rzg3s_pcie_intx_irq_handler() will exec=
ute
while host->intx_domain is still NULL.

Passing a NULL domain to generic_handle_domain_irq() causes the IRQ core to
fall back to the system's irq_default_domain, which might route spurious
interrupts to unrelated devices.

>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		int ret =3D rzg3s_pcie_init_msi(host);
> +		ret =3D rzg3s_pcie_init_msi(host);
> =20
>  		if (ret) {
>  			irq_domain_remove(host->intx_domain);
> -			return ret;
> +			goto err_cleanup_intx;
>  		}
>  	}
> =20
>  	return 0;
> +
> +err_cleanup_intx:
> +	rzg3s_pcie_clear_intx_handlers(host, i);
> +
> +	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the error cleanup order
create a use-after-free window?

If rzg3s_pcie_init_msi() fails, the code calls
irq_domain_remove(host->intx_domain) and then jumps to err_cleanup_intx to
clear the handlers.

If a hardware INTx interrupt fires between the domain removal and unregiste=
ring
the handler, rzg3s_pcie_intx_irq_handler() could dereference the already fr=
eed
host->intx_domain pointer.

[Severity: High]
This is a pre-existing issue in the handler itself. Is it safe to assume
platform IRQs are strictly contiguous?

rzg3s_pcie_intx_irq_handler() calculates the hardware index by subtracting
virtual Linux IRQ numbers:

rzg3s_pcie_intx_irq_handler() {
        ...
        unsigned int irq =3D irq_desc_get_irq(desc);
        u32 intx =3D irq - host->intx_irqs[0];
        ...
}

Since platform_get_irq_byname() dynamically requests platform IRQs, they are
not guaranteed to be contiguous. If they are disjoint, this subtraction wou=
ld
produce an out-of-bounds index for generic_handle_domain_irq().

[Severity: High]
This is another pre-existing issue regarding interrupt acknowledgment. Will
using a read-modify-write operation on a Write-1-to-Clear (W1C) register
silently drop concurrently pending interrupts?

For example, in rzg3s_pcie_msi_irq():

rzg3s_pcie_msi_irq() {
        ...
        /* Clear the MSI */
        rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIS,
                               RZG3S_PCI_PINTRCVIS_MSI,
                               RZG3S_PCI_PINTRCVIS_MSI);
        ...
}

If RZG3S_PCI_PINTRCVIS is a W1C register, reading the current state and
writing it back means any concurrently pending interrupts (read as 1) will =
be
written back as 1, inadvertently clearing them before they can be handled.

A similar operation happens in rzg3s_pcie_intx_irq_ack().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715223019.3002=
237-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D3
