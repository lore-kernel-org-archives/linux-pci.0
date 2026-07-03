Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075C25B083;
	Fri,  3 Jul 2026 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783045259; cv=none; b=hUnGGlXaLqjFeXHKz6YdsZBriscvU/3Flg6chkE/TG7R1lya6rOthXzeRYnrMhyPSvbRxpnwkm+vJQNhwlp05949sKK4E/z5t6ka1NrCkb3j25Ivd5g0+jeClYu7yvBpF1FjFflNTORYJffHLuyJm+QnWFzoildmFBqtGuAqcCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783045259; c=relaxed/simple;
	bh=krHCWm2NTWPfgp41xzEyrtSznBmH9FtIm5bTjXC0OqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UpgOTTrSKDeDUOlORC4YkCiUpZdO07yBE9BdTJCrKulyvJaNz52wWI7Fqa32JFGdiQCGA9Nuu2iOfekclajEJr66ocfSNL+z1L59fbkII6DP4qsZZ4omby9+e1+wQ1q1qPWosxe4twXFxZVr0WKwCRZ1UgpMhUJE+H1y3vv3LxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sjvt75cl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sjvt75cl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD001F000E9;
	Fri,  3 Jul 2026 02:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783045258;
	bh=bbRHSqFRZyObcTCHZl7vaorWiKMARJ44wU5aL7b2jBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sjvt75clS3/+YHiehUq51hZHZoCbaHN55QEi5J+weq7EhfCWgtw9Fupmg9F4+/lhr
	 /rtWGtwVH2au9bvXU0hfxqWpynhC78+8xUH/n3zgo4WBTYH4kyfQji1SHh5h3N7nwQ
	 RWUo19yRZaF4wuRccUzpCGy6bZv7ctsxtLCGruteX9A2aR/spCx8xn3AZh8H16AugW
	 ooEUKvpJc3sp6fvpaTIy6P1qSlBglomYYnIStoq/bbfdSw6RydKVvY9CRAwegAaCNk
	 vwS5E0O/dwIVpT+lnWKiCE/aiPrOdZTSa3u1lBZoWs5fRLa8WLH9pUlTYlS83WaOZ5
	 a481sCVqwbRLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260703020003.485436-7-inochiama@gmail.com>
References: <20260703020003.485436-1-inochiama@gmail.com>
 <20260703020003.485436-7-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 02:20:57 +0000
Message-Id: <20260703022058.1FD001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Unclocked MMIO access during probe triggers a synchronous bus abor=
t.
- [High] Incorrect `.deinit` callback for K3 prevents PERST# assertion on t=
eardown.
- [High] AXI cache coherency initialization is bypassed when MSIs are disab=
led.
- [Medium] Misleading comment and potential missing initialization for Root=
 Complex mode.
--

commit 93fac4ee5b6c6ef1d779cae9b2ff5efed7a8fb39
Author: Inochi Amaoto <inochiama@gmail.com>

PCI: spacemit-k1: Add Spacemit K3 PCIe host controller support

The PCIe controller on Spacemit K3 is almost a standard Synopsys
DesignWare PCIe IP with extra link and reset control. Unlike
the PCIe controller on K1, this controller supports external MSI
interrupt controller and can use multiple PHYs at the same time.

Add driver to support PCIe controller on Spacemit K3 PCIe.

> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/=
controller/dwc/pcie-spacemit-k1.c
> index 31aac056b68ed..680acc93f5395 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
[ ... ]
> @@ -340,6 +354,109 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
>  	return ret;
>  }
> =20
> +static int k3_pcie_init(struct dw_pcie_rp *pp)
> +{
[ ... ]
> +	/*
> +	 * Put the controller in root complex mode, and indicate that
> +	 * Vaux (3.3v) is present.
> +	 */
> +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			PCIE_PERSTN_OUT | PCIE_PERSTN_OE);

[Severity: Medium]
Will this omit initializing the controller into root complex mode?

Unlike k1_pcie_init(), this code block only drives the PERST# reset pins and
seems to skip setting DEVICE_TYPE_RC.

> +
> +	val =3D dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
[ ... ]
> +static int k3_pcie_msi_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	u32 val;
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	val =3D dw_pcie_readl_dbi(pci, COHERENCY_CONTROL_3_OFF);
> +	val =3D u32_replace_bits(val, K3_CACHE_MSTR_AWCACHE_BEHAVIOR,
> +			       K3_CACHE_MSTR_AWCACHE_MODE);
> +	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_3_OFF, val);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
> +	return 0;
> +}

[Severity: High]
Does this code miss initializing AXI cache coherency when MSIs are disabled?

Since k3_pcie_msi_host_init() is only called if pci_msi_enabled() is true,
booting with pci=3Dnomsi would skip this callback, silently skipping general
cache coherency initialization for the controller.

> +
> +static const struct dw_pcie_host_ops k3_pcie_host_ops =3D {
> +	.init		=3D k3_pcie_init,
> +	.deinit		=3D k1_pcie_deinit,

[Severity: High]
Can reusing k1_pcie_deinit() prevent PERST# assertion on teardown?

During initialization, k3_pcie_init() bypasses the K1 mechanism by setting
PCIE_IGNORE_PERSTN in PCIE_CONTROL_LOGIC. Since k1_pcie_deinit() attempts to
toggle PCIE_RC_PERST, won't the K3 hardware ignore it?

> +	.msi_init	=3D k3_pcie_msi_host_init,
> +};
> +
> +static const struct dw_pcie_ops k3_pcie_ops =3D {
> +	.link_up	=3D k1_pcie_link_up,
> +	.start_link	=3D k1_pcie_start_link,
> +	.stop_link	=3D k1_pcie_stop_link,
> +};
> +
> +static void k3_pcie_clear_irq_status(struct k1_pcie *k1,
> +				     u32 *status0, u32 *status1, u32 *status2)
> +{
> +	*status0 =3D readl_relaxed(k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
> +	*status1 =3D readl_relaxed(k1->link + INTR_STATUS);
> +	*status2 =3D readl_relaxed(k1->link + K3_ADDR_INTR_STATUS1);

[Severity: High]
Could this read unclocked MMIO memory and trigger a synchronous bus abort?

In k1_pcie_probe(), data->parse_port() is called before dw_pcie_host_init():

k1_pcie_probe() {
    ...
    ret =3D data->parse_port(k1);
    ...
    ret =3D dw_pcie_host_init(&k1->pci.pp);
}

This means k3_pcie_parse_port() and k3_pcie_clear_irq_status() are executed
before the required hardware clocks are enabled, accessing hardware registe=
rs
while their backing clocks are gated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703020003.4854=
36-1-inochiama@gmail.com?part=3D6
