Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAAD35BDC7
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030024; cv=none; b=ah2OuxxqkftbUhVhA0aq83FbyuBBLpHIu35jp8pMf7rjzVkVa7EtQtSmmy5C4yIm2Zoleyqv1zpdIHrbY/MIflSzyqU1wO6mpc/cYAkSyIdiDOedcxFVljn1jL0RwblGbeLZDVnyd4byqPlE8FRX60bn18+VaG4byLbS3cLTkBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030024; c=relaxed/simple;
	bh=F2n+o4K2UcrtRCLog6CgMdUAmqrlxM+7F2x9INhP+gQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QbURIV5YK5Fh+PuT+0I4Lzpem4zGbHbVluf1SEnMxndkPRw160CR5Ywytn/XaQUtCOkZFFA/RGalM4F/krbQ4XDLtazEpZBSG3mSCdB9ETH8R0QpeK8p2rj9FPeLPL+RoXbDpC1/j3ob9dQcK+gCnITtAUKm5X96fDhL2UTLGnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xg+eW4JJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xg+eW4JJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D49E1F000E9;
	Tue, 14 Jul 2026 11:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784030023;
	bh=TDjHGapvxlpcSLaK0dOjDmm23YDgxwPoj8TAyX2bJ9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xg+eW4JJheHnjkLNlrRJqy9225ad7+7M/AY006Ze/jmQ3EXXzoURr0lqEp3rvcmJO
	 tatfIpdWNnfN5KieYD25A8FHxJUXTBg2ZnWvLyNW5gXJtYNs7FwQ0QnmAr8HU0s+Ja
	 /nDuW36EfZuap1Jnu8WrCRWioQMPM4IalWdyz7GeqsUk/s8Nu50l0/rfdaGtugJ2s+
	 uf/VP8PsUjVijM1yLjSU/c+Yp7Qu1wPRnu4HfTLIG14GUkq9XZwZj8y+b6DlyNJWTE
	 HPRn7+P1fysNHiTRBw4jDQVFmE7WddK5reiDwyB5V3F20Z/VrWu6gv8DY+vLV2Wwb+
	 QpjxWZmlUcExw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: starfive: Fix resource leaks on error paths in
 host_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ali Tariq" <alitariq45892@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260714113029.326207-1-alitariq45892@gmail.com>
References: <20260714113029.326207-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:53:42 +0000
Message-Id: <20260714115343.4D49E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free of IRQ domains during driver unbind or when probe f=
ails after interrupt initialization.
--

--- Patch [1]: [PATCH] PCI: starfive: Fix resource leaks on error paths in =
host_init() ---
commit 64603196409722c49e238cd53d9d6a6b7efd0b22
Author: Ali Tariq <alitariq45892@gmail.com>

PCI: starfive: Fix resource leaks on error paths in host_init()

This commit unwinds previously acquired PHY and clock/reset resources in
starfive_pcie_host_init() when subsequent initialization steps or regulator
enablement fails.

> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/co=
ntroller/plda/pcie-starfive.c
> index 298036c3e7f94..86b248a1ea758 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c
[ ... ]
> @@ -303,13 +303,19 @@ static int starfive_pcie_host_init(struct plda_pcie=
_rp *plda)
>  			   STG_SYSCON_CLKREQ, STG_SYSCON_CLKREQ);
> =20
>  	ret =3D starfive_pcie_clk_rst_init(pcie);
> -	if (ret)
> +	if (ret) {
> +		starfive_pcie_disable_phy(pcie);
>  		return ret;
> +	}
> =20
>  	if (pcie->vpcie3v3) {
>  		ret =3D regulator_enable(pcie->vpcie3v3);
> -		if (ret)
> +		if (ret) {
>  			dev_err_probe(dev, ret, "failed to enable vpcie3v3 regulator\n");
> +			starfive_pcie_clk_rst_deinit(pcie);
> +			starfive_pcie_disable_phy(pcie);
> +			return ret;
> +		}
>  	}

[Severity: High]
This is a pre-existing issue, but since we are fixing error paths in the
host initialization, I noticed a potential use-after-free in the related
PLDA host initialization code.

In drivers/pci/controller/plda/pcie-plda-host.c, plda_init_interrupts()
allocates the interrupt using devm_request_irq():

plda_init_interrupts() {
    ...
    ret =3D devm_request_irq(dev, event_irq,
                           plda_event_handler,
                           0, NULL, port);
    ...
}

However, on device removal or if probe fails, plda_pcie_host_init() calls
plda_pcie_irq_domain_deinit(), which explicitly removes and frees the event
domain:

plda_pcie_host_init() {
    ...
err_probe:
    plda_pcie_irq_domain_deinit(port);
    ...
}

plda_pcie_irq_domain_deinit() {
    ...
    irq_domain_remove(pcie->event_domain);
    ...
}

Because the IRQs are devm-managed, their cleanup is deferred until after the
driver's probe or remove function returns.

When devres eventually calls free_irq(), will the IRQ core attempt to
deactivate the interrupt using the now-freed irq_data->domain pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714113029.3262=
07-1-alitariq45892@gmail.com?part=3D1
