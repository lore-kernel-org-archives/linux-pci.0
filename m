Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F133A2F0680
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 05:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352060; cv=none; b=NHTPnrasjuIB/DOmI3kksw9g4KLHrtJNv5rBekfBADkHYCCRBTHXofuRj7jzEIfSXdPJKY8nP348iMciXRVrnXg2x4eRVsLZuBBNV2NF6Ikg3p5+WP2l4QTkmfaOUVD6SXvrlDJ3+8/nJryLWVTwQb2w5Jnqru8nh6mTMqSpHTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352060; c=relaxed/simple;
	bh=DZLw7F+KY/D/4gWT+/pea+eQAgXsr9gNtR1qhDEeAoY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=f+l8drXULvE/BCGRuhMUCSXfBFJSOuBUrxRHAbLial02OUy03GcrMJCnHueWBWeQ9DUxr63NDal4cpMC1GUrKtxsBQmKAffZUZJV2XEnyb2dmS0KUJ8Di1j99H80kc/mOVyZkqruOYxuNheQ7C1r+o0pGVcVdUvmpdZeaksPMro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+Dq+u06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+Dq+u06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30261F0089B;
	Wed,  7 Oct 2026 05:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791352059;
	bh=y3njmA7kugpWCofpIaDsIJ16PS06c/03iPoqkBM9osw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G+Dq+u06ROBNeA3zK3/Y0iYQTLdEN0j2B/lvxboiaI29sC7Y2lqGGEeMTyKniCJsj
	 nBgWKYdqdu23GPaGCF2v72ArGhMObYrrmFbR1nxFn5mksEAR/T6EBz38sFygc/ZyU1
	 o9i/JzXawKg+cil6w1jnzwomZvav8i1DaCvapM0Qmk+nmbnq5F0eVyKP1kvlBJzIJb
	 qJiFSGWr5BONWTKo+hEophT47KReZ4DyyDcZarUEK3wmMZBzkn+obIWZXuVxBGjxry
	 zVERFar+Bt0fBwjCrzkch0Ddd6KzQomZsCfBY+AKsHnVMMFspMittaW6n77aewSVfa
	 Wuoc3QykIij3Q==
Message-ID: <sashiko-outbox-162649@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/9] PCI: rzg3s-host: Move IRQ domain setup code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261007053645.1391545-7-claudiu.beznea@kernel.org>
References: <20261007053645.1391545-1-claudiu.beznea@kernel.org>
 <20261007053645.1391545-7-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 05:47:39 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] irq: race in INTx chained handler setup before domain creation
--

commit 3d8eb4132e9198313898445e6472b136f82e2b3d
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

PCI: rzg3s-host: Move IRQ domain setup code

Subsequent patches add support for the event IRQ to handle link
up/down events. The event IRQ handler will use
rzg3s_pcie_set_max_link_speed(). In preparation for adding event IRQ
support, move the IRQ domain initialization code after
rzg3s_pcie_set_max_link_speed().

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 40d5ef3e347e4..3b62b1be5b2a1 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
[ ... ]
> @@ -1169,6 +1095,79 @@ static int rzg3s_pcie_set_max_link_speed(struct rz=
g3s_pcie_host *host)
[ ... ]
> +static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
> +{
> +	struct device *dev =3D host->dev;
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	int i, ret;
> +
> +	for (i =3D 0; i < PCI_NUM_INTX; i++) {
> +		char irq_name[5] =3D {0};
> +		int irq;
> +
> +		scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + i);
> +
> +		irq =3D platform_get_irq_byname(pdev, irq_name);
> +		if (irq < 0) {
> +			ret =3D irq;
> +			dev_err_probe(dev, ret,
> +				      "Failed to parse and map INT%c IRQ\n",
> +				      'A' + i);
> +			goto teardown_intx;
> +		}
> +
> +		host->intx_irqs[i] =3D irq;
> +		irq_set_chained_handler_and_data(irq,
> +						 rzg3s_pcie_intx_irq_handler,
> +						 host);
> +	}
> +
> +	host->intx_domain =3D irq_domain_create_linear(dev_fwnode(dev),
> +						     PCI_NUM_INTX,

[Severity: High]
Does registering the chained handler here open a race window before the dom=
ain
is created?

If the interrupt fires after irq_set_chained_handler_and_data() but before
irq_domain_create_linear(), rzg3s_pcie_intx_irq_handler() will execute with
host->intx_domain still being NULL.

This would result in a call to:
    generic_handle_domain_irq(NULL, intx);

Since the domain is NULL, __irq_resolve_mapping() will fall back to
irq_default_domain, which could incorrectly map the hardware IRQ (usually 0=
-3)
to an unrelated system interrupt.

Can this lead to unpredictable panics or memory corruption if an unintended
handler is executed?

> +						     &rzg3s_pcie_intx_domain_ops,
> +						     host);
> +	if (!host->intx_domain) {
> +		ret =3D -EINVAL;
> +		dev_err_probe(dev, ret,
> +			      "Failed to add irq domain for INTx IRQs\n");
> +		goto teardown_intx;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007053645.1391=
545-1-claudiu.beznea@kernel.org?part=3D6
