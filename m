Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C821431F984
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786664402; cv=none; b=kbEqRoDcs4CU2sjM4Lpr1iiyuQ2iCRoFMtwBB+N2aB9xO1lj5ubF5+xXJyQdPeRGYccKq/lYeR9cQA09xDYNNRy2tGW3zw5enF2qkF5dEknh6nVlCmIvQHinc64TFa6+cE9IVWwgGBb8ufnUPmCukMA+sWRNcls1hqEHMYvzo70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786664402; c=relaxed/simple;
	bh=/w1Kyo3li/shXsh22HKfuX/nu7VY/ieqKXc/FpM1eVM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h5cQNeBH37mUM0uYvn1QBzAlCFS+d78OqGhvfLhLIv4533vfMIkeSd8iv/aBwRQd0YxIblS54dUlX/WBuaxZ7ydALSd3p4pHEm07ae9N+83Ub6MiIdfPH+uAp64OlAWxBLGt80EWyvZf7pgWqI5ZAi70YrnMvY+UixcywkblxLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7/aIcTH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7/aIcTH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB341F000E9;
	Thu, 13 Aug 2026 23:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786664401;
	bh=zJW2RuOTZl+DrBoL0ivPadDa5ZQlZKa0uzSNU5ceKck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l7/aIcTHlR9cJdIjGGYTBsdniW2AedXsAKu8RR91uCRv4CeEPcF5jpyloWqmVLMCC
	 Ck37PX8pCeNMkzhTUP+QB2K42fMbvS4lZTS3e6pkqARcBi0KeiRNF8rIVb2LQt45DN
	 Q5IVeegug5/o/hxiw0pKTpArqXgbwkU2s4zdfaISsDobuhVSCNqJ01pAcHGsursmn8
	 HewM0jcQRbs3+qXI6cHqc2bqDS/soQPM6C+iNJ/qgx+ci2QBoZUUwMV1+bb9l5zT30
	 ihoKvhbB2MhdMc/e0Mod11pE1fcxpB6d8Ygc8WM0w9Z8Z6unviB/kCnAqFEV4ZmkF5
	 Cl4BuzP8qxKTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/14] PCI: tegra194: Disable L1.2 capability of
 Tegra234 EP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260324190755.1094879-14-mmaddireddy@nvidia.com>
References: <20260324190755.1094879-14-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:40:00 +0000
Message-Id: <20260813234001.3AB341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Endpoint hardware bug workaround is incorrectly conditionalized on=
 CONFIG_PCIEASPM.
--

--- Patch [13]: [PATCH v8 13/14] PCI: tegra194: Disable L1.2 capability of =
Tegra234 EP ---
commit 565b1a8d658f7e3ba31d5fa1ddf41455dcfe18ed
Author: Vidya Sagar <vidyas@nvidia.com>

    PCI: tegra194: Disable L1.2 capability of Tegra234 EP
   =20
    When Tegra234 is operating in the Endpoint mode with L1.2 enabled, PCIe
    link goes down during L1.2 exit. This is because Tegra234 is powering up
    UPHY PLL immediately without making sure that the REFCLK is stable.
    This is causing UPHY PLL to not lock to the correct frequency and leadi=
ng
    to link going down. There is no hardware fix for this, hence do not
    advertise the L1.2 capability in the Endpoint mode.

> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/con=
troller/dwc/pcie-tegra194.c
> index 47df4c6b5fe0f..b159836b7e9a0 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c

[ ... ]

> @@ -679,6 +680,22 @@ static void init_host_aspm(struct tegra_pcie_dw *pci=
e)
>  	if (pcie->supports_clkreq)
>  		pci->l1ss_support =3D true;
> =20
> +	/*
> +	 * Disable L1.2 capability advertisement for Tegra234 Endpoint mode.
> +	 * Tegra234 has a hardware bug where during L1.2 exit, the UPHY PLL is
> +	 * powered up immediately without waiting for REFCLK to stabilize. This
> +	 * causes the PLL to fail to lock to the correct frequency, resulting in
> +	 * PCIe link loss. Since there is no hardware fix available, we prevent
> +	 * the Endpoint from advertising L1.2 support by clearing the L1.2 bits
> +	 * in the L1 PM Substates Capabilities register. This ensures the host
> +	 * will not attempt to enter L1.2 state with this Endpoint.
> +	 */
> +	if (pcie->of_data->disable_l1_2 && pcie->of_data->mode =3D=3D DW_PCIE_E=
P_TYPE) {
> +		val =3D dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
> +		val &=3D ~(PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2);
> +		dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
> +	}

[Severity: High]
Does this conditionally compile out the endpoint hardware bug workaround if
CONFIG_PCIEASPM is disabled?

Looking at drivers/pci/controller/dwc/pcie-tegra194.c, init_host_aspm() is
guarded by a configuration check:

#if defined(CONFIG_PCIEASPM)
static void init_host_aspm(struct tegra_pcie_dw *pcie)
{
    ...
}
#else
static inline void init_host_aspm(struct tegra_pcie_dw *pcie) { return; }
#endif

Since ASPM configuration on the root complex (host) can be entirely
independent of the endpoint's kernel configuration, would this allow the ho=
st
to still enable L1.2 based on the endpoint's hardware advertisement if the
endpoint kernel is built without CONFIG_PCIEASPM?

> +
>  	/* Program L0s and L1 entrance latencies */
>  	val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
>  	val &=3D ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324190755.1094=
879-1-mmaddireddy@nvidia.com?part=3D13
