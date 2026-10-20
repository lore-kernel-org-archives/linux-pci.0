Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485987;
	b=P36nVBC1PdvaNYOYE7gC5yv1sSqVMWvMEo5S7zwcKSR+7dfFo/CJTj03db0MD708P1hV
	 6Nhu+lrBAPaIZ6TpDB0Fju2e8xVidq4jwSC1ZmsdzEDHzbEoEpmDhL9AFC4wh+ArolYmn
	 gNLp+oCo9Ad5UzBO658Xj7GAFl4MTpr6k8SJRGQI/yY2I9hyM+rS1H3JNDHmQvckBWePN
	 G1KgUL34rIRuFHbMw0CNl+pJHFsjffTf1YKNlhXRAlQ/sQnKuvg7er37mfwqxpf91s9oJ
	 OJM+7UAodCRiV5aco9E2sAXvtQuh8BELd0i+H1rorj9awqZMcwob7FQrSAoXfDeEs6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485987;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oE70mBNTxkntbarAB8p4fSuFwcwZIAY5vL/fHWJXBak=;
	b=VHkbo5H18+EGjDsNRqwxm6qXN8R4O2uq8GbRXltSmF19ggUruEjLi1JtukgBMa+KT0P/
	 4anXVOnTM+4SvVVLW7spLMChUDgMzGAO9PWmpztUIxwI8VU1V+IVn5KgNsOAs1r3rwGZ6
	 6X5BGazUj36nl5Nrb6pqUlYF2/cw7c90NYOq7kjYMKaEiibxmbQolBNd303LCRToa/6RQ
	 YvWCmj8cJr2cc3t8CdXpRoAbxOyk0JPFAsSninIw6avAoZVxPjIarG/lQcj6M69G5f8zc
	 AMEoNAyt2MqHg2wcGNXLsLUrENS6C73es28s+gVVEWiCo+lZqJlQ2grtTIzJBGnaRlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtLmX0Fh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E760A260F;
	Tue, 20 Oct 2026 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtLmX0Fh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94CD1F000C4;
	Tue, 20 Oct 2026 08:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792485986;
	bh=oE70mBNTxkntbarAB8p4fSuFwcwZIAY5vL/fHWJXBak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JtLmX0FhOpOBZix4KP4x/U4XRn1hCoVKnNTVHowpkUvSyXrFRr9M1n7fPibQ1kv4x
	 f5CBg4o8uxKDHIKzyLPbn2/qz1gSFGMNWf07juSZoyWlBEMZIjEDLg1kPYf/77ojjJ
	 ME0X7vGqB5np/jivqDr7NCxqBA7hf4cBUVD4g0RhEgy6Zwcq6IKyiuNvL3oZR7ihzd
	 OCHmc7vrx7CJmaTSQdj3pK5QDsyOBx7aEiD9V6EQrIvb9DWvsh2YAYLPkhDalbpDAX
	 xzF7I1gGo6mIZAw4prE8izqCeRjsnsIHtbGBJ3OVJGbdxmwqh/oQ05QccHnN6HynBG
	 vM/ViBJQ8rV0Q==
Message-ID: <sashiko-outbox-178617@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/17] PCI: rcar-gen4: Add Root Port reset support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261020031049.969895-10-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-10-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:46:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCI: rcar-gen4: missing ltssm_control() unwind in rcar_gen4_pcie=
_start_link()
--

commit d7293bc34efbc4c17b8f7975af710d02c706b7d0
Author: Koichiro Den <den@valinux.co.jp>

PCI: rcar-gen4: Add Root Port reset support

This commit implements the host bridge reset_root_port() callback to
reset and reinitialize the R-Car PCIe controller without releasing clocks
or the R-Car Gen5 SoC PHY. It also synchronizes APP interrupt enables and
tracks the R-Car Gen5 PHY power state across resets.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index cbd22e6bb44b9..420392ace349f 100644
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
> +
> +	/* Ignore errors, the link may come up later */
> +	dw_pcie_wait_for_link(dw);
> +	dev_dbg(dev, "Root Port reset completed\n");
> +
> +out:
> +	rcar_gen4_pcie_resume_irqs(rcar, !ret);
> +	if (ret)
> +		dev_err(dev, "Root Port reset failed (%d); interrupts stay masked unti=
l a reset succeeds\n",
> +			ret);
> +
> +	return ret;
> +}

[ ... ]

> @@ -944,11 +1061,17 @@ static int rcar_gen5_pcie_ltssm_control(struct rca=
r_gen4_pcie *rcar, bool enable
>  	}
>  	writel(val, rcar->base + PCIERSTCTRL1);
> =20
> +	/* A reset retry may find the PHY already powered off. */
> +	if (enable =3D=3D rcar->phy_powered)
> +		return 0;
> +
>  	if (enable)
>  		phy_power_on(rcar->phy);
>  	else
>  		phy_power_off(rcar->phy);
> =20
> +	rcar->phy_powered =3D enable;
> +
>  	return 0;
>  }

[Severity: Medium]
On R-Car Gen5, dw_pcie_start_link() calls rcar_gen4_pcie_start_link(), which
enables LTSSM and powers on the PHY before running speed_control():

drivers/pci/controller/dwc/pcie-rcar-gen4.c:rcar_gen4_pcie_start_link() {
	...
	if (rcar->drvdata->ltssm_control) {
		ret =3D rcar->drvdata->ltssm_control(rcar, true);
		if (ret)
			return ret;
	}

	return rcar->drvdata->speed_control(rcar);
}

If rcar_gen5_pcie_speed_control() times out and returns -ETIMEDOUT,
rcar_gen5_pcie_ltssm_control(rcar, true) has already enabled LTSSM, called
phy_power_on(rcar->phy), and set rcar->phy_powered =3D true.

In rcar_gen4_pcie_reset_root_port(), this failure jumps to out: and leaves
rcar->reinit_pending set to true (keeping APP interrupts masked) while
PERST# is deasserted, LTSSM remains enabled, and the PHY remains powered
on.

Similarly, if dw_pcie_start_link() fails during dw_pcie_resume_noirq() or
dw_pcie_host_init(), those callers bypass their dw_pcie_stop_link() error
label and call rcar_gen5_pcie_deinit() -> phy_exit(rcar->phy) while the PHY
is still powered on and rcar->phy_powered is still true. On a subsequent
resume, rcar_gen5_pcie_ltssm_control(rcar, true) will hit the (enable =3D=3D
rcar->phy_powered) check and skip phy_power_on().

Should rcar_gen4_pcie_start_link() unwind with
rcar->drvdata->ltssm_control(rcar, false) when speed_control() fails?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D9
