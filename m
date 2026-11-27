Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795750074;
	b=IM5mY6NOeRJVO6udCB5tdGI2VT0Cwq46EFCZKy2unNSDcXZo34JKFfJKeDRpo4+rSyYH
	 gcuIuuJsjUfzuZj9VfAsorhv1HmTacBgpdvaXo3KyYYbltIXcN70mXaxmdoDqAltEsYfT
	 C7a7K5WP2yxja54QefQi2NcgCYtxBpIj/40QNyUo1dVa3cJayo0aG4+mbft3Mitd0pJdV
	 g0nxF4EcqeI5PJiv2NOo85HTUM6XDu1ObvFOgnC2R/0sO5OqrSmSre2L9aYWblIcj5L0w
	 pfvuxIsH0Ir5U2fmzMwwpnWwrm9FCWOnL4K2Csraa5M5My5Z9jcd0iNN414DThAS3cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795750074;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vjE0EG7IfETTmay7P988Wu7Z2L796T7347+5HkCBw3c=;
	b=sixxpJAfrTMuwpUrGfiTUtIihgcNsz+A3sZlLI51M/2CeWnSjOOZHW3ddHUE/FMbKN81
	 fBGmbz+6m+492HwfxhaRWVcoZ/5gqlFMVaevqXIXh16pyViIPOmlHQRf0pkjX4yHFxg8J
	 3thwM3VWH/B5q1sZhqEaXovkqOsIyG80O6in3mFmqZAWTN24OnV2U7H1kFByiLY7P3jYc
	 MQF2OOBQxTgNsnvWSEXv1CeU4avV1NSpxCFB5qfv8/873C672kmzVbHXLNsoaHerjGJXG
	 fblZQkUBlYZiNF4/ATIbP1hFKKn8gYS+lKFnUNUNUu6is+iFo3UCG7U2+L4Ac1/6ngQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hzyjtbrt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484AC606A31E;
	Fri, 27 Nov 2026 03:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hzyjtbrt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C201F000C1;
	Fri, 27 Nov 2026 03:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795750073;
	bh=vjE0EG7IfETTmay7P988Wu7Z2L796T7347+5HkCBw3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HzyjtbrtNxkQjBiEB6+zzvRcNygqrfcWSygiLlsDJwICCHgWq9R6MNCzBnrfAWe9V
	 xOPXgRET5oAUaQmgZar5G77O+2MJmilXts+kMnISZBcktCj3+uruuX7rSZCRxfyaeN
	 nNEJk/R1bsD69WURvthUt+nH4UeIofagpEGxWJdX1koWDhwuct6gSoXABF4vBrSLtX
	 SG+PBNUCUP0hwJmE/9WCouJgrrx3rwOzWSkbcSfUlwLPbmgyCpzp4kLi4Uc5R6Yl4f
	 5YwwxYywaouoPuCo035ZMU1gZ7sAmsXR1sl26hFUWNgBj52ySGVNIy76b0BeU9wcO7
	 NYrY+POKFWgsg==
Message-ID: <sashiko-outbox-236532@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/17] PCI: rcar-gen4: Add Root Port reset support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261127031145.2521228-10-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
 <20261127031145.2521228-10-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 03:27:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] PCI: rcar-gen4: missing ltssm_control() unwind in
  rcar_gen4_pcie_start_link()
--

commit 6d9424fac1ef6138c07c2b9182818e25dae74e0d
Author: Koichiro Den <den@valinux.co.jp>

PCI: rcar-gen4: Add Root Port reset support

This commit implements the host bridge reset_root_port() callback to
reset and reinitialize the R-Car PCIe controller while keeping clocks and
the R-Car Gen5 PHY initialized, and tracks PHY power state and APP
interrupt masking across resets.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index c513294df5a04..4277ddcffccda 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

[ ... ]

> @@ -661,14 +703,87 @@ static int rcar_gen4_pcie_host_setup(struct dw_pcie=
_rp *pp)
>  	return 0;
>  }
> =20
> +static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
> +{
> +	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
> +		rcar->reinit_pending =3D true;
> +		rcar_gen4_pcie_app_irq_sync_locked(rcar);
> +	}
> +}
> +
> +static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
> +				       bool recovered)
> +{
> +	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
> +		rcar->reinit_pending =3D !recovered;
> +		rcar_gen4_pcie_app_irq_sync_locked(rcar);
> +	}
> +}
> +
> +/*
> + * R-Car Gen4 SoC PCIe controllers and R-Car Gen5 SoC PCIe4 controller h=
ave
> + * a single Root Port per instance, so the 'pci_dev' is ignored and the =
whole
> + * controller is reset. The PCI core serializes the callers through its
> + * device locks.
> + */
> +static int rcar_gen4_pcie_reset_root_port(struct pci_host_bridge *bridge,
> +					  struct pci_dev *pdev)
> +{
> +	struct rcar_gen4_pcie *rcar =3D dev_get_drvdata(bridge->dev.parent);
> +	struct dw_pcie *dw =3D &rcar->dw;
> +	struct dw_pcie_rp *pp =3D &dw->pp;
> +	struct device *dev =3D dw->dev;
> +	int ret;
> +
> +	/* A failed resume may have left the controller powered down. */
> +	if (dw->suspended)
> +		return -EBUSY;
> +
> +	rcar_gen4_pcie_quiesce_irqs(rcar);
> +
> +	dw_pcie_stop_link(dw);
> +
> +	rcar_gen4_pcie_host_perst_assert(pp, true);
> +
> +	ret =3D rcar_gen4_pcie_common_reinit(rcar);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D rcar_gen4_pcie_host_setup(pp);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D dw_pcie_setup_rc(pp);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D dw_pcie_start_link(dw);
> +	if (ret)
> +		goto out;

[Severity: Medium]
Does a failure in dw_pcie_start_link() leave LTSSM enabled and the R-Car
Gen5 PHY powered on?

drivers/pci/controller/dwc/pcie-rcar-gen4.c:rcar_gen4_pcie_start_link() {
	...
	if (rcar->drvdata->ltssm_control) {
		ret =3D rcar->drvdata->ltssm_control(rcar, true);
		if (ret)
			return ret;
	}

	return rcar->drvdata->speed_control(rcar);
}

On R-Car Gen5, ltssm_control(rcar, true) enables LTSSM, powers on
rcar->phy, and sets rcar->phy_powered =3D true before
rcar_gen5_pcie_speed_control() polls PCI_EXP_LNKSTA_LT.  If that poll
times out, rcar_gen4_pcie_start_link() returns -ETIMEDOUT without calling
ltssm_control(rcar, false).

In rcar_gen4_pcie_reset_root_port(), jumping to out leaves LTSSM enabled
and the PHY powered on while APP interrupts stay masked.  In
dw_pcie_host_init() and dw_pcie_resume_noirq(), a dw_pcie_start_link()
failure bypasses err_stop_link, so rcar_gen5_pcie_deinit() calls
phy_exit() while the PHY is still powered on and leaves rcar->phy_powered
set to true.

Unwinding with ltssm_control(rcar, false) in rcar_gen4_pcie_start_link()
when speed_control() fails would avoid both issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127031145.2521=
228-1-den@valinux.co.jp?part=3D9
