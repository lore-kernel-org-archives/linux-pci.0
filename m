Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374844;
	b=kuS8w8jMclvsV6a8sE32Lt2mGSNgkhtL7O/cN09zb+ypqazUyyxaC/3WoGQipwMlZ53M
	 Fukmy4uiWieaC/ycQBGUZ41IVnY45EvHNtm56HypJ3KRpzLmfrikR9ciL9e7J+avtNLPQ
	 QN8xZVHtDKykJZdOLdswPhrJrlhlklmFrav4xWLP8iQ4UCfksf/jmP/JMFJNgBi0a32vb
	 gTZ1em9UzdwOGjRm6WwhiQ4PmTbd62lj1JRAhT/ug1soTw85uei1Lz6YRrjLJ8I8t3sKm
	 1LNv4AvolyXbpeW6eH9FrBvRSZVA1KX3PKOZokFSBMorspo78tMTxGrv5e2POwFRSfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374844;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OPt1MyGy5nmepVBwYIPMUYgHNzk00vlmLXaHzorvQ88=;
	b=hX61oGObkLG/RA6B5e99W3wz/b8KZ6TcGoHcx6/ZlQ4/47XO76JMmaBJecGRZI750+Oi
	 RFaouNfl1MhB8jTWnfyjFjcU9mCk1EAzSGY2fQFLlqDvBx8KsAaXG8vvqgAmK8rIvVLW9
	 MCz+asvGxVAo7cBFycnxmdBKfEdbKiNGwceSQl2EIE9J9Bgw2f59Y2g6C30rG+Fq8V00b
	 eiEK1aF6eZEISRi9POGDK+DNM94LU451vBMYhl62+Mn65IzKFFEJ1AiVyEhA9x0lI228d
	 8xXqNwcIL/hyLlkOooLgb9Hca5nfxzFFgH3bnk2LRk+D2UxGb8wtRKaEGSr4g1XPe2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmrVCIxC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A676E606A31A
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmrVCIxC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410E81F000C1;
	Fri, 30 Oct 2026 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793374843;
	bh=OPt1MyGy5nmepVBwYIPMUYgHNzk00vlmLXaHzorvQ88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PmrVCIxCMRpeFMRhsy0I/bGNrkp7jc80OENYnWvRq/WvgkpyyXQoKGdA5mqcdTmDO
	 iAoY+HS6ucX9SO/vP5f+3wHBXc7iX6pBfQI+/hLgQEvM2UlwddiQceEC+YgeHn27+G
	 TivngxcZhJV9/28+KhN4fkMIOHiMZT6mUtwl43oz1r45qTEQKH3ifUjFBIRJQHgs/f
	 poQ0tRUW5VqGo7VzfvCYofIwTwScozhYnSc7vbfcEOco+5Wdb6sYYfDYk3h49IsqVY
	 7VkM0TxXAhkQ+AuV6DBxUr/aRXYpz3q0E145TQHRoIjzr9HFlOLd7ApZgt16KmULdg
	 /sW9f+xaUSKNQ==
Message-ID: <sashiko-outbox-191182@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: exynos: Handle PCIe PHY initialization errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261030151701.3100-1-sreekuttan2156239@gmail.com>
References: <20261029131006.2744-1-sreekuttan2156239@gmail.com>
 <20261030151701.3100-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:40:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] PCI: exynos: return of int in void exynos_pcie_remove() and regula=
tor leak
- [Medium] PCI: exynos: regulator leak in exynos_pcie_resume_noirq() on PHY=
 exit error
- [Medium] PCI: exynos: unrecovered hardware state on exynos_pcie_suspend_n=
oirq() error
--

commit 0c8cd2248f61d9e01add8f3a5e1b399c6f9c0fd4
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

PCI: exynos: Handle PCIe PHY initialization errors

This commit checks the return values of phy_init() and phy_power_on() in
exynos_pcie_host_init() and tracks PHY and regulator state across probe,
remove, suspend, and resume paths.

> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/contro=
ller/dwc/pci-exynos.c
> index e3c05ade381bb..d7504b0e5d96c 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c

[ ... ]

> @@ -332,22 +381,42 @@ static int exynos_pcie_probe(struct platform_device=
 *pdev)
>  static void exynos_pcie_remove(struct platform_device *pdev)
>  {
>  	struct exynos_pcie *ep =3D platform_get_drvdata(pdev);
> +	int ret;
> =20
>  	dw_pcie_host_deinit(&ep->pci.pp);
>  	exynos_pcie_assert_core_reset(ep);
> -	phy_power_off(ep->phy);
> -	phy_exit(ep->phy);
> -	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +
> +	ret =3D exynos_pcie_phy_exit(ep);
> +	if (ret)
> +		return ret;
> +
> +	if (ep->supplies_enabled) {
> +		ret =3D regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +		if (ret)
> +			dev_err(&pdev->dev, "failed to disable regulators: %d\n", ret);
> +		else
> +			ep->supplies_enabled =3D false;
> +	}
>  }

[Severity: High]
In drivers/pci/controller/dwc/pci-exynos.c, exynos_pcie_remove() has a void
return type, so returning ret when exynos_pcie_phy_exit(ep) fails causes a
build error.

Also, if exynos_pcie_phy_exit(ep) returns a non-zero error during driver
removal, doesn't returning early here skip regulator_bulk_disable() and lea=
ve
the vdd18 and vdd10 supplies in ep->supplies enabled? Should this log an
error and continue to disable ep->supplies, similar to the fail_probe path =
in
exynos_pcie_probe()?

> =20
>  static int exynos_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct exynos_pcie *ep =3D dev_get_drvdata(dev);
> +	int ret;
> =20
>  	exynos_pcie_assert_core_reset(ep);
> -	phy_power_off(ep->phy);
> -	phy_exit(ep->phy);
> -	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +
> +	ret =3D exynos_pcie_phy_exit(ep);
> +	if (ret)
> +		return ret;
> +
> +	if (ep->supplies_enabled) {
> +		ret =3D regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +		if (ret)
> +			return ret;
> +
> +		ep->supplies_enabled =3D false;
> +	}
> =20
>  	return 0;
>  }

[Severity: Medium]
In exynos_pcie_suspend_noirq(), exynos_pcie_assert_core_reset(ep) is called
before exynos_pcie_phy_exit(ep) and regulator_bulk_disable().

If exynos_pcie_phy_exit(ep) or regulator_bulk_disable() returns an error,
device_suspend_noirq() in the PM core aborts before setting
dev->power.is_noirq_suspended, which means device_resume_noirq() will not
call exynos_pcie_resume_noirq() during suspend-abort recovery.

Would that leave the Exynos PCIe controller held in core reset (and with its
PHY powered off or regulators still enabled) when the system aborts suspend?

> @@ -358,13 +427,33 @@ static int exynos_pcie_resume_noirq(struct device *=
dev)
>  	struct dw_pcie *pci =3D &ep->pci;
>  	struct dw_pcie_rp *pp =3D &pci->pp;
>  	int ret;
> +	int err;
> =20
>  	ret =3D regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
>  	if (ret)
>  		return ret;
> =20
> +	ep->supplies_enabled =3D true;
> +
>  	/* exynos_pcie_host_init controls ep->phy */
> -	exynos_pcie_host_init(pp);
> +	ret =3D exynos_pcie_host_init(pp);
> +	if (ret) {
> +		err =3D exynos_pcie_phy_exit(ep);
> +		if (err)
> +			return err;
> +
> +		if (ep->supplies_enabled) {
> +			err =3D regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies=
);
> +			if (err)
> +				return err;
> +
> +			ep->supplies_enabled =3D false;
> +		}
> +
> +		return ret;
> +
> +	}

[Severity: Medium]
In exynos_pcie_resume_noirq(), regulator_bulk_enable() enables ep->supplies
before calling exynos_pcie_host_init(pp).

If exynos_pcie_host_init(pp) fails (for instance, when phy_init() succeeds
and phy_power_on() fails) and the subsequent cleanup call to
exynos_pcie_phy_exit(ep) also returns an error, won't returning err early
bypass regulator_bulk_disable() and leak the regulator enable reference on
ep->supplies?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030151701.3100=
-1-sreekuttan2156239@gmail.com?part=3D1
