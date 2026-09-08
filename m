Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A804CA297
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879961; cv=none; b=H332ZWrZG7/ejc9h/8O80imW9eqaaxpPMt5KU+p/B6Bk3UPIB8rkDw3p1Nbjd9gRvvZr396UCusIBtb5pYxrMAqS+bdkqOdBOL1j1TgPPPgBHsjSbEsFMz9EladWxthJw1rP7mS4p8lPsH5OkC3H1aQEK9YYzXTiWYG9JY5kBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879961; c=relaxed/simple;
	bh=FY9sAzTu1C/xtq1Bd/426PW7X5giqHhnBHIG0tWHfWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ik8Km3mLROuuX6O0Tjb7yy/9N3I2x+1K5MMvN4MUjTrKEHOQYQ6zte0mLPVWhJBwbsSxBdozzjLA4QIQYQIFZjyRtrMQ5NHsrPL2fZHY0GccMzaoD+Dn1CUeMbUVAwFpU31Xzq8dSymPnqYr8bKfPeIJ/mMQNWVqurMgRpC+Z7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5H4d7E2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5H4d7E2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358561F00A3A;
	Tue,  8 Sep 2026 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788879952;
	bh=Me3FmeSj/ypQAD0gGQsTjZfkKZfJOvgo0oRDP+nGnBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h5H4d7E2v5I0NHWw6HSx6phB8DL2OrpcctzrzrYQZn2mZtuK0XZZEXPJtl3QpWnjb
	 rpwLp3XuyWHJIM1joi1dJacDojLAd/4wunE8QP+GhfvWiYdqqbpXDA91r7VmzGehA0
	 RVg+9swNzRE25YKRRbcPlZ/iGkQb3Q5bmUe1VsttCenlrptPBR2Gc+WYWYY3xXM2MZ
	 m3BQzTdOdaPB2R4D7nZ1ptatuRSTM/k2qKVaOTKLqB2xT2/7koeeFHV9QyUe2joDJa
	 AM82MCYnO/X1sVX9jN6KdD7/ph7ClwY7xyQRvr0apUtghtKPaOLJ/tAXA8bXDLS76i
	 BAoNu8toS/X8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/10] PCI: dw-rockchip: Restore vpcie3v3 regulator
 handle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-2-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-2-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:05:51 +0000
Message-Id: <20260908150552.358561F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] Silent failure when phy_init() or phy_power_on() fails due to dr=
opped dev_err_probe().

Pre-existing issues:
- [High] Repeated devres memory and clock reference leaks during root port =
resets.
- [High] Failure to create IRQ domain causes potential arbitrary interrupt =
execution or NULL pointer dereference.
- [High] IRQ handler is active while clocks are disabled on probe error pat=
hs, causing a potential crash if the IRQ fires.
- [High] The chained legacy IRQ handler is not cleared on probe failure, le=
ading to a permanent use-after-free and crash.
--

commit f70d8a03f10e09b0300fff37e8aa493a89895114
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

PCI: dw-rockchip: Restore vpcie3v3 regulator handle

This commit reverts a previous cleanup that removed the explicit vpcie3v3=20
regulator handle. It restores storing the regulator in the rockchip struct=
=20
and explicitly disables it in the probe error path. This change is needed=20
to support disabling the regulator during system suspend in a future patch.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index dc85564e50013..f67ad3c31c35b 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
[ ... ]
> @@ -844,15 +845,22 @@ static int rockchip_pcie_probe(struct platform_devi=
ce *pdev)
[ ... ]
>  	ret =3D rockchip_pcie_phy_init(rockchip);
>  	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "failed to initialize the phy\n");
> +		goto disable_regulator;

[Severity: Medium]
Is it possible that removing this dev_err_probe() call causes failures in
phy_init() or phy_power_on() to happen silently? This seems like it could
make device initialization issues significantly harder to debug when they
occur.

> =20
>  	ret =3D reset_control_deassert(rockchip->rst);
[ ... ]
> @@ -885,6 +893,9 @@ static int rockchip_pcie_probe(struct platform_device=
 *pdev)
>  	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);

[Severity: High]
This is a pre-existing issue, but does manually disabling the clocks here on
the error path leave a window where the devm-managed IRQ handler (requested
via devm_request_threaded_irq() earlier in probe) is still active?

If the IRQ fires before devres cleans it up after the function returns, cou=
ld
the handler attempt to read APB registers with clocks gated, causing a bus
fault and kernel panic?

>  deinit_phy:
>  	rockchip_pcie_phy_deinit(rockchip);
> +disable_regulator:
> +	if (rockchip->vpcie3v3)
> +		regulator_disable(rockchip->vpcie3v3);
> =20
>  	return ret;
>  }

While reviewing this patch, I also noticed a few pre-existing issues in the
same file:

> @@ -570,9 +570,9 @@ static int rockchip_pcie_clk_init(struct rockchip_pci=
e *rockchip)
>  {
>  	struct device *dev =3D rockchip->pci.dev;
>  	int ret;
> =20
>  	ret =3D devm_clk_bulk_get_all(dev, &rockchip->clks);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "failed to get clocks\n");

[Severity: High]
This isn't a bug introduced by this patch, but does calling
devm_clk_bulk_get_all() during root port resets cause a persistent memory
and clock reference leak?

Since rockchip_pcie_clk_init() is called by rockchip_pcie_rc_reset_root_por=
t():

drivers/pci/controller/dwc/pcie-dw-rockchip.c:rockchip_pcie_rc_reset_root_p=
ort() {
	...
	ret =3D rockchip_pcie_clk_init(rockchip);
	if (ret)
		goto deinit_phy;
	...
}

Will repeated root port resets, such as those triggered by hardware
link-down events or userspace sysfs requests, continually allocate devres
structures and leak clock subsystem references, since they are only freed on
unbind?

> @@ -437,6 +437,6 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp =
*pp)
>  {
[ ... ]
>  	ret =3D rockchip_pcie_init_irq_domain(rockchip);
>  	if (ret < 0)
>  		dev_err(dev, "failed to init irq domain\n");
> =20
>  	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>  					 rockchip);

[Severity: High]
This is a pre-existing issue, but does ignoring the error code from
rockchip_pcie_init_irq_domain() allow rockchip_pcie_intx_handler to be
registered with a NULL irq_domain?

If the legacy interrupt triggers when rockchip->irq_domain is NULL:

drivers/pci/controller/dwc/pcie-dw-rockchip.c:rockchip_pcie_intx_handler() {
	...
	for_each_set_bit(hwirq, &reg, 4)
		generic_handle_domain_irq(rockchip->irq_domain, hwirq);
	...
}

Could generic_handle_domain_irq() fall back to irq_default_domain and
potentially execute completely unrelated interrupt handlers belonging to
other devices if the default domain resolves the hwirq (0-3)?

[Severity: High]
Additionally, this is a pre-existing issue, but is the chained legacy IRQ
handler correctly cleared on probe failure?

If initialization fails later in the probe path, the rockchip structure will
be freed by devres. Because irq_set_chained_handler_and_data() is used
without a corresponding devres cleanup or manual cleanup in the error path,
could a subsequent legacy IRQ trigger a use-after-free when
rockchip_pcie_intx_handler() dereferences the freed rockchip structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rockchip-p=
cie-system-suspend-v6-0-fbabcca9921b@collabora.com?part=3D2
