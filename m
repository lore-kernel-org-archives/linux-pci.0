Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D87233134
	for <linux-pci@vger.kernel.org>; Sat,  4 Jul 2026 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783134258; cv=none; b=RIeUiRvQVw6CAIM3gdy3Gw3iQmoTnuX+r1ZFeX4weRq4vJuwJKS1Oh+8zRjAvLHq0oTbDmhEDuKRQTX1LZ6QohP7+mIFSoqcfnFG9V3ZnNphFCUvZUH+/E73KbLGUKGhAb8r2zl2okyeG91rVG+OXUVWKDGA7oSvkpH96zuWrBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783134258; c=relaxed/simple;
	bh=XsXBIFDH8hslHHKzEORYTb8ux6CXXXyS0K1oHRUSzGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pdj15SW2Liljj+Zn9KicWjbBRrIA6IrTxZDACz4ddtXgB+K9cz0lo1qrmy2VQZ+kFltOCwk4ibyMvuZz9d6Vbc4K6M/HEE+m78Kpn9PrwP0yX7a5GoFeTwttHbWsCkWaa+WHg0fRbfVJNoOTyu3NtZFYk37wLDgClABftmA0vpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjIlTbC7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjIlTbC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527D61F000E9;
	Sat,  4 Jul 2026 03:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783134257;
	bh=Q5yr45CzFEjhlA/DlR3lSxSTVAwrNbbKB6u8kO0XLGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cjIlTbC7RGf3Re8Ya80pbR0Ya9odQ/ZaAWs5uVKdiCQKy9GXrFg33Q0x07FRuMNky
	 ft0ZgStv7ccvoOIeXJZBWouTSqxIDAknZ0md25SPmvmSWDqP+cwHd0ypLgVDx1Z1Mj
	 QuFI8a0T35bPbH7PPTsavAKRJW+jNE+7BCDmB30ktAXKPEYwvtae+cTaCMPxIOPvxJ
	 Ha4lZDZINjCp39grZZ2HSYDBBAEWASEuxVMIbyD8IxWsQM/lTB6Y2CW657gDwLnEbE
	 wUvlFZLJIScROMYNl3qtOz+vwV1+U85WZe0NY4PZXdIXjVT/3oEgUHwVKuuhhHvjbH
	 bjX1spuJSNdcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI/ASPM: Mask ASPM states based on Devicetree
 properties
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260704-aspm-v3-1-157217aff76f@oss.qualcomm.com>
References: <20260704-aspm-v3-1-157217aff76f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 03:04:16 +0000
Message-Id: <20260704030417.527D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Software ASPM state (`link->aspm_enabled`) is not updated after =
L1 PM Substates are explicitly disabled in hardware, causing sysfs to repor=
t incorrect state.

Pre-existing issues:
- [High] The 'aspm-no-l0s' and 'aspm-no-l1' DT properties fail to prevent t=
he firmware's L0s and L1 states from being temporarily or permanently re-en=
abled, leaving broken link states active.
--

commit cd6ce2c13b26fecd26cf240bdae31606cf6afab9
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI/ASPM: Mask ASPM states based on Devicetree properties

This patch introduces pcie_link_has_aspm_override to check Devicetree
properties and mask ASPM support accordingly. It explicitly disables
L1SS if requested and moves the initialization sequence before the
restore block.

Link [1]: https://github.com/devicetree-org/dt-schema/pull/188
Link [2]: https://github.com/devicetree-org/dt-schema/pull/190

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -846,6 +889,33 @@ static void pcie_aspm_override_default_link_state(st=
ruct pcie_link_state *link)

[ ... ]

>  	/* For devicetree platforms, enable L0s and L1 by default */
>  	if (of_have_populated_dt()) {
> +		bool no_l0s =3D pcie_link_has_aspm_override(link, "aspm-no-l0s");
> +		bool no_l1 =3D pcie_link_has_aspm_override(link, "aspm-no-l1");
> +		bool no_l1ss =3D pcie_link_has_aspm_override(link, "aspm-no-l1ss");

[ ... ]

> +		/*
> +		 * Clear L1SS in hardware before updating aspm_support. Once
> +		 * aspm_capable is derived from aspm_support, pcie_config_aspm_link()
> +		 * skips pcie_config_aspm_l1ss() entirely via the aspm_capable guard,
> +		 * leaving firmware-enabled L1SS substates active in hardware.
> +		 * This applies equally when disabling L1 (which implies L1SS).
> +		 */
> +		if ((no_l1 || no_l1ss) && (link->aspm_enabled & PCIE_LINK_STATE_L1SS))
> +			pcie_config_aspm_l1ss(link, 0);

[Severity: Medium]
Does this explicit disable step leave software's tracking of enabled ASPM
states out of sync with the actual hardware state?

By directly calling pcie_config_aspm_l1ss with a state of 0 without also
clearing the corresponding PCIE_LINK_STATE_L1SS bits in link->aspm_enabled,
could sysfs attributes and kernel APIs like pcie_aspm_enabled incorrectly
report L1SS as enabled until pcie_config_aspm_link is later invoked to
reconfigure the link?

> @@ -924,6 +994,11 @@ static void pcie_aspm_cap_init(struct pcie_link_stat=
e *link, int blacklist)
> =20
>  	aspm_l1ss_init(link);
> =20
> +	/* Save default state */
> +	link->aspm_default =3D link->aspm_enabled;
> +
> +	pcie_aspm_override_default_link_state(link);
> +
>  	/* Restore L0s/L1 if they were enabled */
>  	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
>  	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
> @@ -931,11 +1006,6 @@ static void pcie_aspm_cap_init(struct pcie_link_sta=
te *link, int blacklist)
>  		pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
>  	}

[Severity: High]
This is a pre-existing issue, but does moving the override logic above the
restore block still fail to prevent the firmware's L0s and L1 states from
being temporarily or permanently re-enabled?

Because the local variables child_lnkctl and parent_lnkctl hold the original
firmware state and are not masked by the Devicetree overrides processed in
pcie_aspm_override_default_link_state, will this restore block
unconditionally write the original state back to the hardware and re-enable
L0s/L1 despite the Devicetree prohibition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704-aspm-v3-1-=
157217aff76f@oss.qualcomm.com?part=3D1
