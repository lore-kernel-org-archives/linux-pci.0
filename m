Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E3E3CC7D8
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580021; cv=none; b=Oe74vHbVpULcoN8X7K+EwSm1opmcQayZbVTK74Gb1xsP7IWgVilRjoPVJ1TacYRGdYTiPrWqmoJ4LIwfyHqQ0ARqLxu4l5I4ZMb6Lvc46FM0rheIca4kVL+OPePYPKJZf0QhhQDxVLGzQmElyWOm0jj51tsuoG8u6F1jdbIckcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580021; c=relaxed/simple;
	bh=yaivz4eex2V74DAZMuNvcFWjFx3MqdnRcyPfrQu9YBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TCm3i1rLDDy9nAcUzppkS9t75YccFMRx8U7Wj49Ti90DkziQOF7IAs+HtkfvZhiA3C3RZihKhWwwXjwp6j3J4xg7hmr7sv6TU8DDiCiMaAI/F44zPH3eNCI6NmO5teVM5VSzZHxTsp57y/Wm9KIncHk2jhHd5F8jOIB1KAvCBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM6hh8Xa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM6hh8Xa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BCA1F000E9;
	Thu,  9 Jul 2026 06:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783580020;
	bh=tz94LV2CAlzrcgLHEtOWPIP3gxK7tHS6xoKVhDyBcTw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VM6hh8XalLXdGP1MZH81rYitEhj/CDOl7G1sPvPTzKjn3IjCdn2DybeSymq5lCkpf
	 rFVvi+5FO2Jnia1xWRIH/iJKZ91K4FjpWWUzyolutChqTO/dNWl5mIsrEimlsFt03s
	 UccQlm4UhtiVYeIkqs6KVSq1c6XRdITyFpev1yNgSfB2ubTqE55Z0+ACkzTyMqE1pT
	 SFnzRplQRUMNOkBEOwVldJKDaLfvtxLdyr+Uc6u7Jfkv8Ftxw9RRa6O/f+jhF0jYt/
	 aY2wdpSlSM07P/SpPGPeNE4A4hzdg8kbaCPlIujWfxtMm/Y+j2/+HFmi3L8ry8foLd
	 UwXe9b8jsu2Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] PCI: qcom: Add link retention support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, neil.armstrong@linaro.org, vkoul@kernel.org, olteanv@gmail.com
In-Reply-To: <20260709-link_retain-v3-3-81a9d187bb61@oss.qualcomm.com>
References: <20260709-link_retain-v3-0-81a9d187bb61@oss.qualcomm.com>
 <20260709-link_retain-v3-3-81a9d187bb61@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 06:53:39 +0000
Message-Id: <20260709065339.D9BCA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Probe deferral causes reference count and resource leaks for clo=
cks, regulators, and PHY components when link retention is active.
- [Medium] Bypassing `post_init` during link retention skips critical contr=
oller quirks and DMA coherency settings.
- [Medium] `qcom_pcie_check_link_retain()` uses an incorrect hardcoded mask=
 (`0x1f`) to read the LTSSM state, risking state aliasing.
--

--- Patch [3]: [PATCH v3 3/4] PCI: qcom: Add link retention support ---
commit 48e4b763c5282c1440201e104587c3e6e2342ab6
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
PCI: qcom: Add link retention support

This patch adds link retention support for Qualcomm PCIe controllers. It
skips controller reset and PERST# toggling if the bootloader has already
trained the link and left it in L0 or L1 idle. It checks device tree caps
and configures base addresses in the retention path.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[ ... ]

> @@ -996,6 +998,50 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom=
_pcie *pcie)
>  	return 0;
>  }
> =20
> +/*
> + * Determine whether the link established by the bootloader can be reuse=
d.
> + *
> + * The max-link-speed and num-lanes specified in Device Tree are meant t=
o cap
> + * the link's maximum capability. Retrain the link if the controller's m=
ax
> + * link speed/width exceeds the Device Tree cap, unless the currently
> + * negotiated speed/width is already within that cap, in which case the
> + * existing link can be retained as-is.
> + */
> +static bool qcom_pcie_check_link_retain(struct qcom_pcie *pcie)
> +{
> +	u32 cap, speed, cur_speed, val, ltssm, width, cur_width;
> +	struct dw_pcie *pci =3D pcie->pci;
> +	u8 offset;
> +
> +	val =3D readl(pcie->parf + PARF_LTSSM);
> +	ltssm =3D val & 0x1f;

[Severity: Medium]
Does this hardcoded 0x1f mask truncate the LTSSM state?

The standard LTSSM state mask (PARF_LTSSM_STATE_MASK) is defined as
GENMASK(5, 0), which is 0x3f.

By discarding bit 5, higher-order states like 0x31 could erroneously alias
to DW_PCIE_LTSSM_L0 (0x11).

This might cause the driver to incorrectly assume the link is active and
retain it, skipping initialization and leaving the link broken.

[ ... ]

> @@ -1074,6 +1129,9 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pc=
ie *pcie)
>  {
>  	const struct qcom_pcie_cfg *pcie_cfg =3D pcie->cfg;
> =20
> +	if (pcie->pci->pp.link_retain)
> +		return 0;
> +

[Severity: Medium]
Does bypassing the rest of qcom_pcie_post_init_2_7_0() skip critical OS qui=
rks?

By returning early, this bypasses the configuration of NO_SNOOP_OVERRIDE and
the NCCS hot-plug quirk.

Missing NO_SNOOP_OVERRIDE can cause DMA cache coherency issues and data
corruption on ARM.

Missing the NCCS quirk can cause the OS pciehp driver to wait for
non-existent command completions, leading to hot-plug timeouts.

>  	if (pcie_cfg->override_no_snoop)
>  		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
>  				pcie->parf + PARF_NO_SNOOP_OVERRIDE);

[ ... ]

> @@ -1414,6 +1474,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *p=
p)
>  	if (!pp->skip_pwrctrl_off)
>  		pci_pwrctrl_power_off_devices(pci->dev);
>  err_pwrctrl_destroy:
> +	if (pp->link_retain && ret =3D=3D -EPROBE_DEFER)
> +		return ret;

[Severity: Medium]
Could this early return leak hardware enable counts during probe deferral?

If a downstream function like pci_pwrctrl_power_on_devices() returns
-EPROBE_DEFER, this early return explicitly bypasses the err_disable_phy
and err_deinit cleanup paths.

The driver core's devres cleanup drops the resource references but does not
manually disable them.

On the next probe attempt, qcom_pcie_init_2_7_0() will re-enable the
regulators and clocks:

	ret =3D regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
...
	ret =3D clk_bulk_prepare_enable(res->num_clks, res->clks);

This compounds the leaked reference counts, preventing the resources from
ever being powered off upon driver unbind or system shutdown.

>  	if (ret !=3D -EPROBE_DEFER && !pci->suspended)
>  		pci_pwrctrl_destroy_devices(pci->dev);
>  err_disable_phy:
>  	qcom_pcie_phy_power_off(pcie);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-link_retai=
n-v3-0-81a9d187bb61@oss.qualcomm.com?part=3D3
