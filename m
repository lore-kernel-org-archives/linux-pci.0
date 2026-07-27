Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0336A35C
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161822; cv=none; b=Flf4pP+15upc+jD4SRwDAJUFQ0ndyg+X8LYXgbq0sw2z9gDbF2hJp5VdStXdojGgUXgKWcDu0roFfQU9WiGSYH7sWCac0JaAgXh5S4gQOO5+PU1ZkYc6aSgkuAzZYweJIPEssz+5SO6ya3Tb6nEjlS8BRVgH39aSR3aLTIR9Xmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161822; c=relaxed/simple;
	bh=LRkMKfoqDrlFrifOo98BDkJJKs62nsiy7DCinIICSM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A97sTluyJafUOyPQ/SDn9ZMg1OCPi4+5V2l/I8KM7lAbfyGpQAHZpCoZuapD1K+3uEogRzUM374S+2nMyi7q2jTGH/MXnaYSA714l4jzhLAueloPgjQ+P5uRi/pD5gseiLT+8EjO+Yg+ALhv80YX12ksJ7SSItGSBRBmiAyoNss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpOKn1bN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpOKn1bN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E31F1F000E9;
	Mon, 27 Jul 2026 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785161817;
	bh=yiIqCRNhent5UaUKWFJz1bIfKGezaxVWf+YPCZrwaCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jpOKn1bNVJ7FZNe7gxzpdXK/lLKJ9WDZjfMWwpv6CVFxwQtaapQKF8uWTZ6L3W1Va
	 Ax2hFTcc1ZqN2n7YnlCkd5m77lhYorZzwa9JLS3+UETTTZCHah1MfwsvYb6UzV9VIM
	 r42ucbQpHtMt5ATz+Eso2JiRgXlJXhalEY92NgU3rfEaKygAIUf2lEG1PhbKqufUl7
	 4nBM4qzTM4h+jF00dXYeffY1MqMB/QP4GbLBK7dZTX/AowIVy+PvvubDtZ15Lt53wn
	 uNL5n0geFOMuBG1cmq+rF7Nm2ywvuz4hD6DwrlLUAyG05itm7FeVRj7mM593Ea+bxl
	 OnzUiNOKbRL2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] PCI/ASPM: Mask ASPM states based on Devicetree
 properties
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260727-aspm-v6-3-2ebb3ee7ef71@oss.qualcomm.com>
References: <20260727-aspm-v6-0-2ebb3ee7ef71@oss.qualcomm.com>
 <20260727-aspm-v6-3-2ebb3ee7ef71@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:16:57 +0000
Message-Id: <20260727141657.7E31F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Hardware ASPM state becomes desynchronized from the software-tra=
cked `link->aspm_enabled` state on links where firmware forced ASPM L0s/L1 =
on despite missing hardware capabilities, breaking sysfs reporting.
--

--- Patch [3]: [PATCH v6 3/3] PCI/ASPM: Mask ASPM states based on Devicetre=
e properties ---
commit d3ca900c30e202e8adf6acdf7daf494224ae2179
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI/ASPM: Mask ASPM states based on Devicetree properties

This commit introduces Devicetree property checks to selectively disable AS=
PM
states based on hardware constraints. It moves the default state override
evaluation earlier in capability initialization and ensures that states dis=
abled
by Devicetree are explicitly cleared from the hardware configuration during=
 the
L0s/L1 restore phase.

Link [1]: https://github.com/devicetree-org/dt-schema/pull/188
Link [2]: https://github.com/devicetree-org/dt-schema/pull/190

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 544f35bb25554..0a671825fac8d 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c

[ ... ]

> @@ -926,9 +999,25 @@ static void pcie_aspm_cap_init(struct pcie_link_stat=
e *link, int blacklist)
> =20
>  	aspm_l1ss_init(link);
> =20
> -	/* Restore L0s/L1 if they were enabled */
> +	/* Save default state */
> +	link->aspm_default =3D link->aspm_enabled;
> +
> +	pcie_aspm_override_default_link_state(link);
> +
> +	/*
> +	 * Restore L0s/L1 if they were enabled, but don't restore any
> +	 * state a Devicetree override just disabled in aspm_support above.
> +	 */
>  	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
>  	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
> +		if (!(link->aspm_support & PCIE_LINK_STATE_L0S)) {
> +			child_lnkctl &=3D ~PCI_EXP_LNKCTL_ASPM_L0S;
> +			parent_lnkctl &=3D ~PCI_EXP_LNKCTL_ASPM_L0S;
> +		}
> +		if (!(link->aspm_support & PCIE_LINK_STATE_L1)) {
> +			child_lnkctl &=3D ~PCI_EXP_LNKCTL_ASPM_L1;
> +			parent_lnkctl &=3D ~PCI_EXP_LNKCTL_ASPM_L1;
> +		}

[Severity: Medium]
If firmware forced ASPM L0s or L1 on despite missing hardware capabilities,
this block will correctly strip those unsupported bits before writing back =
to
hardware. However, does this leave the software state desynchronized?

Earlier during initialization, link->aspm_enabled captures the original
firmware settings. Since this restore block now selectively clears unsuppor=
ted
bits from the hardware write but doesn't synchronize those changes back to
link->aspm_enabled, won't sysfs attributes and pcie_aspm_enabled() incorrec=
tly
report these states as active?

Could this lead to incorrect sysfs reporting until pci_enable_device()
eventually triggers a heal of the state via pcie_config_aspm_link()?

>  		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
>  						   PCI_EXP_LNKCTL_ASPMC,
>  						   parent_lnkctl & PCI_EXP_LNKCTL_ASPMC);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-aspm-v6-0-=
2ebb3ee7ef71@oss.qualcomm.com?part=3D3
