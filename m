Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A243E7BCE
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148538; cv=none; b=p8XgS1ql/6OaZYZbuygnWZvGUL2pFc+ww0Anjy/KtlmVFjqmMfllh3rj+CWY/yTUVPLPvXTOV8PbU9Fj4dz9xaZrzj5gb9QH/K1eI9ZXp9NZ0zxVMQcoM4q1nHngq3lx0lDiHls/kGlWQRfQ8jNEgV1kqEVB+qpEJklGRQfjoos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148538; c=relaxed/simple;
	bh=srCLwlbOpkbTAihm2YUEhb+y3W8FUN9vQBZwvaY2uSw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mBN89Hg0tKOuUIIIzzOuCfK/v0p6qczyjuI3IYkv7b6TV2kHzJENKhayC4Z7BXTtu1KuvUwANv9IgiLX+ILyphaswVUCRvTs1+2SDYXuMsherXo4haEwN6oFfh5iHwhDRofD9fhOtw7ChGPSatRHnXG8TQ1KcUVOchaS55izd7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5VH09np; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5VH09np"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDDC1F000E9;
	Mon, 27 Jul 2026 10:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785148528;
	bh=iqIfW7A32smsxPnnfSXO9S7ZuKi6/mnXJ6TCHl7eMKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5VH09np4CPqBoT5LbLMQ2Rqv4ow/fnmqtwREvFEFQUVSrceGoM9ziFFAaxMiaTXP
	 9Gcc/40Be8kcP0crrUNVNxCE1PeI5CB7G8Qos9fHJL+OFdzj1bYVXp3L7PqtnZom5r
	 SWlF1NRyReY3Z/+tGmpEatXpRT3XzMKa3iap0gofYMUFzNNVVPHGEvEY7HKk7EoCNj
	 pIddbOzKkyHQf/eurrXC4uKrMReWLSfVZQouxtj0oZEyj28g+YhNwNfsB6KvGOK05i
	 837TXLnTA4F4zXU/4DyBizR9Y9NrGKjWTJzxw17QPYRGmFMIDM7Vkszxxj5PHAqk9v
	 eX3J72Jygbb6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] PCI: rzg3s: Fix IRQ domain initialization error
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260727095843.116950-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260727095843.116950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260727095843.116950-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:35:27 +0000
Message-Id: <20260727103527.DBDDC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The err_cleanup_intx error path destroys the INTx IRQ domain befor=
e clearing the active chained handlers, creating a use-after-free race.

Pre-existing issues:
- [High] rzg3s_pcie_intx_irq_handler() incorrectly assumes Linux virtual IR=
Q numbers are contiguous, which can lead to out-of-bounds domain mapping lo=
okups and interrupt storms.
--

--- Patch [3]: [PATCH v2 3/3] PCI: rzg3s: Fix IRQ domain initialization err=
or handling ---
commit 895e108af15957f16a4f68cbf1072bd988ee57dc
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

PCI: rzg3s: Fix IRQ domain initialization error handling

This commit attempts to fix a resource leak by unwinding chained handler
registrations on error paths in rzg3s_pcie_init_irqdomain(). It also adds
teardown logic to clear the handlers, mirroring the initialization sequence.

Cc: stable@vger.kernel.org

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index f51b5d7c19983..70f1faf7e4227 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c

[ ... ]

> @@ -1006,22 +1006,35 @@ static const struct irq_domain_ops rzg3s_pcie_int=
x_domain_ops =3D {
[ ... ]
>  static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
>  {
>  	struct device *dev =3D host->dev;
>  	struct platform_device *pdev =3D to_platform_device(dev);
> +	int i, ret;
> =20
> -	for (int i =3D 0; i < PCI_NUM_INTX; i++) {
> +	for (i =3D 0; i < PCI_NUM_INTX; i++) {
>  		char irq_name[5] =3D {0};
>  		int irq;
> =20
>  		scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + i);
> =20
>  		irq =3D platform_get_irq_byname(pdev, irq_name);
> -		if (irq < 0)
> -			return dev_err_probe(dev, irq,
> -					     "Failed to parse and map INT%c IRQ\n",
> -					     'A' + i);
> +		if (irq < 0) {
> +			ret =3D irq;
> +			dev_err_probe(dev, ret,
> +				      "Failed to parse and map INT%c IRQ\n",
> +				      'A' + i);
> +			goto err_cleanup_intx;
> +		}
> =20
>  		host->intx_irqs[i] =3D irq;
>  		irq_set_chained_handler_and_data(irq,
>  						 rzg3s_pcie_intx_irq_handler,
>  						 host);
>  	}

[Severity: High]
This is a pre-existing issue, but does this code assume that the Linux virt=
ual
IRQ numbers returned by platform_get_irq_byname() are always contiguous?

Looking at rzg3s_pcie_intx_irq_handler():

drivers/pci/controller/pcie-rzg3s-host.c:rzg3s_pcie_intx_irq_handler() {
    ...
    unsigned int irq =3D irq_desc_get_irq(desc);
    u32 intx =3D irq - host->intx_irqs[0];

    chained_irq_enter(chip, desc);
    generic_handle_domain_irq(host->intx_domain, intx);
    ...
}

If the dynamically allocated virtual IRQs are not strictly sequential, could
this calculation yield an out-of-bounds index for generic_handle_domain_irq=
()?

If the mapping fails to resolve, could the incoming level-triggered interru=
pt
remain unacknowledged, leading to an interrupt storm?

[ ... ]

>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		int ret =3D rzg3s_pcie_init_msi(host);
> +		ret =3D rzg3s_pcie_init_msi(host);
> =20
> -		if (ret) {
> -			irq_domain_remove(host->intx_domain);
> -			return ret;
> -		}
> +		if (ret)
> +			goto err_cleanup_intx;
>  	}
> =20
>  	return 0;
> +
> +err_cleanup_intx:
> +	if (host->intx_domain)
> +		irq_domain_remove(host->intx_domain);
> +	rzg3s_pcie_clear_intx_handlers(host, i);

[Severity: High]
Is there a race condition in this error path?

If MSI initialization fails, irq_domain_remove(host->intx_domain) is called
before rzg3s_pcie_clear_intx_handlers().

Since irq_set_chained_handler_and_data() was already called earlier, the
interrupts are unmasked and active.

If a hardware INTx interrupt fires before the handlers are cleared, could
rzg3s_pcie_intx_irq_handler() run and dereference the freed host->intx_doma=
in
via generic_handle_domain_irq(), causing a use-after-free?

Should rzg3s_pcie_clear_intx_handlers() be called before destroying the IRQ
domain?

> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727095843.1169=
50-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D3
