Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820B135504D
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372905; cv=none; b=PI6ot7nO3mkk0pvi1aWLwrdwyPpa3gWE3ZsvPdj+mQwJbHWEcsQkG03Ptx5hysjdEBzDEWRq3GY9tHMdM8Ft48CfPJsrc0MwEDFig858p4EqwA9RAKg6NQuFWLAtV7r9HvvTpzN1aEC46hY2hMifFhu0xSfVFg2YcCaLbjEzxlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372905; c=relaxed/simple;
	bh=7vA5g6BlQqufnex/kCV+60AYvUBEzqUD8++odnBKtiQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W4j1M6VtLFYJmIPPdaidiEP/Zn/D2QZRWXGxib38ze3b55Dvm1JIAI33rL1xRescpPUbT4udZ6wWisWzF053HWHepm4Y2RhufdSKc7xQK3UeYe4cT//V4/zm8bEtYSHJNXzKFLBQoapeMOLRZfbPsYXpZX1eENd1GINF9kd/hfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvDKhTW+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvDKhTW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7461F000E9;
	Thu, 21 May 2026 14:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372904;
	bh=d9OLDgAjE81Gf5UnBAayq6SLmtpglCrBffoDOsIOEck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LvDKhTW+9mRIwxcVChEF81dgpNHVzU5HwoVZ+2jPdUyG/atCjx//uhl8FNJ+hQw10
	 i/ZhIRstPqTORuL8eWGz9vWfZeBeQw3McJeCFvcMO8esZkGRywdyPC/wJqXUerG5J5
	 hZiUhC47WV/iDpEO07uFk5gOPeIuRlz74SP6UWuRWCB7Bhv8aPFV7gdvIzUA2kkw+N
	 cCmaW1D/4EIgMm9GdWn8eW8ZziMUeMBPPqBCYc6sa+YSH0oTRBtw16MjxvjWP6N2um
	 a0ErM1Y6zzzAgnt2o72eteTUCAG1+nkc94rjaFLDaNXXTKZX6GCTEFjohMfJWH56PO
	 u8E1XTvlUiaRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] PCI: qcom: Add link retention support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com, linux-phy@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <20260521-link_retain-v2-3-08ed448b081c@oss.qualcomm.com>
References: <20260521-link_retain-v2-3-08ed448b081c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 14:15:03 +0000
Message-Id: <20260521141503.DF7461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Checking hardware link capabilities instead of negotiated link sta=
tus to determine current link speed and width.
- [High] Returning 0 instead of -EPROBE_DEFER defeats the probe deferral me=
chanism and leaves the controller partially initialized.
- [High] Early returns during link retention bypass critical controller sof=
tware state initialization and hardware capabilities.
--

commit 6dd7e9bfe9f104689a018777f9dcaa31b6e736f8
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
PCI: qcom: Add link retention support

This patch introduces link retention support for Qualcomm PCIe controllers,
skipping reinitialization and PERST# toggling if the bootloader left the
link active in L0 or L1 idle. It falls back to normal initialization and
link retraining if the current link does not meet device tree constraints.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index bfe873cbf44f6..b061eaa227b39 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[ ... ]

> @@ -960,6 +962,42 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom=
_pcie *pcie)
>  	return 0;
>  }
> =20
> +/*
> + * Determine whether the link established by the bootloader can be reuse=
d.
> + *
> + * Reuse the existing link only if its current speed and lane count match
> + * the max-link-speed and num-lanes specified in Device Tree; otherwise,
> + * retrain the link.
> + */
> +static bool qcom_pcie_check_link_retain(struct qcom_pcie *pcie)
> +{
> +	u32 cap, speed, val, ltssm, width;
> +	struct dw_pcie *pci =3D pcie->pci;
> +	u8 offset;
> +
> +	val =3D readl(pcie->parf + PARF_LTSSM);
> +	ltssm =3D val & 0x1f;
> +	if ((val & LTSSM_EN) &&
> +	    (ltssm =3D=3D DW_PCIE_LTSSM_L0 || ltssm =3D=3D DW_PCIE_LTSSM_L1_IDL=
E)) {
> +		qcom_pcie_configure_dbi_atu_base(pcie);
> +
> +		offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +		cap =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> +		speed =3D FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
> +		width =3D dw_pcie_link_get_max_link_width(pci);

[Severity: High]
Does this check the maximum hardware capabilities instead of the currently
negotiated link status?

Reading PCI_EXP_LNKCAP (and using dw_pcie_link_get_max_link_width) retrieves
the hardware capabilities rather than the current link speed and width from
PCI_EXP_LNKSTA.

If the bootloader brought up the link at a degraded speed (e.g., Gen1x1 on a
port capable of Gen3x2), could this incorrectly pass the constraint checks
and leave the system with severely degraded PCIe performance?

> +
> +		if (pci->max_link_speed > 0 && speed > pci->max_link_speed)
> +			return false;
> +
> +		if (pci->num_lanes > 0 && width > pci->num_lanes)
> +			return false;
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_7_0 *res =3D &pcie->res.v2_7_0;
> @@ -978,6 +1016,14 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *p=
cie)
>  	if (ret < 0)
>  		goto err_disable_regulators;
> =20
> +	if (pcie->cfg->link_retain) {
> +		pci->pp.link_retain =3D qcom_pcie_check_link_retain(pcie);
> +		if (pci->pp.link_retain) {
> +			dev_info(dev, "Retaining PCIe link\n");
> +			return 0;
> +		}
> +	}

[Severity: High]
Does this early return bypass critical software state initialization?

Returning early here skips the assignment of pci->l1ss_support =3D true lat=
er
in this function. Because struct dw_pcie is zero-initialized, the downstream
DesignWare core might falsely assume ASPM L1 Substates are unsupported and
fail to configure them correctly.

> +
>  	ret =3D reset_control_assert(res->rst);
>  	if (ret) {
>  		dev_err(dev, "reset assert failed (%d)\n", ret);
> @@ -1038,6 +1084,9 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pc=
ie *pcie)
>  {
>  	const struct qcom_pcie_cfg *pcie_cfg =3D pcie->cfg;
> =20
> +	if (pcie->pci->pp.link_retain)
> +		return 0;
> +

[Severity: High]
Could this early return skip necessary hot-plug configurations?

By returning early, this skips the call to qcom_pcie_set_slot_nccs() located
further down. Missing the No Command Completed Support (NCCS) configuration
could break PCIe hot-plug command completions and lead to timeouts during
hot-plug operations.

>  	if (pcie_cfg->override_no_snoop)
>  		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
>  				pcie->parf + PARF_NO_SNOOP_OVERRIDE);

[ ... ]

> @@ -1337,8 +1388,9 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *p=
p)
>  err_pwrctrl_power_off:
>  	pci_pwrctrl_power_off_devices(pci->dev);
>  err_pwrctrl_destroy:
> -	if (ret !=3D -EPROBE_DEFER)
> -		pci_pwrctrl_destroy_devices(pci->dev);
> +	if (pp->link_retain && ret =3D=3D -EPROBE_DEFER)
> +		return 0;

[Severity: High]
Does returning 0 here defeat the probe deferral mechanism?

If pci_pwrctrl_power_on_devices() earlier in this function returns
-EPROBE_DEFER, returning 0 instead of propagating the error code causes
the driver core to treat the probe as successful. This means the driver
will not be re-probed when resources become available.

Additionally, returning early from this error cleanup path leaves the rest
of the host initialization incomplete (such as SMMU setup and removing
MSIX/DPC capabilities), potentially leaving the controller in an unusable
state while the kernel believes the probe succeeded.

> +	pci_pwrctrl_destroy_devices(pci->dev);
>  err_disable_phy:
>  	qcom_pcie_phy_power_off(pcie);
>  err_deinit:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521-link_retai=
n-v2-0-08ed448b081c@oss.qualcomm.com?part=3D3
