Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D59309EE7
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522024; cv=none; b=OUzhVv2wqitkNKGAHO4Mi5IGvZmGRI0s28hpohTX7Cf7jh6AFfUh+xOn8aXHVnUCxiGH4blnma6BZYLK5HEuUpL0xccTHI+bgFQfRfuT09kMnZ3Jqq5iBzr/d5xQHpUoq3FvkRnf6Mw1VvyQWaY8ZV7I1a6ggvuct+F8D0UFVHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522024; c=relaxed/simple;
	bh=JG38d7S1SGtF1NqevhI9JA8ruIne2bNQa3amkYEXwos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OkMI+U3XBHDEfLLAp+0x3r+CkrFvgk+7LePsVxXIHOQ98miV+YqYY+fx4BYbiOKdn+pqSgfc22sRP4Ff7Z2o7vtxr6pdeW3ge+ZN/XHXxHx+ncDz3vRdfeiU2HjZ0+hlSl3/W9VFX+9iioMLk3SMQR8DavNfgLYur++Wlg3A+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkk4hByI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkk4hByI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965051F000E9;
	Wed,  8 Jul 2026 14:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783522022;
	bh=HTIt6sTcpXFbRY5qhlg+8YoHB5n7FwsQUa+4W5RgdZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kkk4hByIDvNgF341rbaYDByfEo/cvcnovrDerOPUKaByzetYIglOFt4ZZfy8Cz/RR
	 Li+7VnX01EGUnxNCEAvYOXWvtko9XGxIk96ylbB6qlMsReRUK9RrFZDump5uzYIVjo
	 w7SDhZdms0xaGtpnfqya0N7VCBkxO62Q3moFemEAdsUyVQqAM+5pNqN/FzClJQ74IA
	 9SXheBiZFwGgAxKII1/ABv0u8c5XOF6qK2rpCxMPTwI6C+aDQqUDODHcAXLP41kB3R
	 xG7EwMv7DM2qz3c9+TNKKs3pFG/Z9qMDeW/cKBzRRD+2Thsi4Xd8PcO3/pYsv5b59n
	 J1EIXL2Qyfj/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] wifi: ath11k: Use
 pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260708-pci-aspm-fix-v3-7-6bd72451746e@kernel.org>
References: <20260708-pci-aspm-fix-v3-0-6bd72451746e@kernel.org>
 <20260708-pci-aspm-fix-v3-7-6bd72451746e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:47:01 +0000
Message-Id: <20260708144702.965051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Using PCI core ASPM APIs for temporary disable/restore of ASPM p=
ermanently corrupts link state tracking (veto leak and default state overwr=
ite).
--

--- Patch [7]: [PATCH v3 7/8] wifi: ath11k: Use pci_{enable/disable}_link_s=
tate() APIs to enable/disable ASPM states ---
commit 3c3d38d66376257335d9c989bd98925dd8c4bb20
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

wifi: ath11k: Use pci_{enable/disable}_link_state() APIs to enable/disable =
ASPM states

This commit replaces direct LNKCTL register manipulation with PCI core APIs
to temporarily disable and restore ASPM states.

> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless=
/ath/ath11k/pci.c
> index 35bb9e7a63a20..da980e01d1fc2 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c

[ ... ]

> @@ -604,19 +604,9 @@ static void ath11k_pci_free_region(struct ath11k_pci=
 *ab_pci)
> =20
>  static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
>  {

[ ... ]

> +	ab_pci->aspm_states =3D pcie_aspm_enabled(ab_pci->pdev);
> =20
> -	/* disable L0s and L1 */
> -	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> -				   PCI_EXP_LNKCTL_ASPMC);
> +	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_ASPM_ALL);

[Severity: Medium]
Will this permanently disable supported but inactive ASPM states?=20

By calling pci_disable_link_state() with PCIE_LINK_STATE_ASPM_ALL, all ASPM
bits are added to the PCI core's link->aspm_disable mask.

>  	set_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags);
>  }
> @@ -624,10 +614,7 @@ static void ath11k_pci_aspm_disable(struct ath11k_pc=
i *ab_pci)
>  static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
>  {
>  	if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
> -		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> -						   PCI_EXP_LNKCTL_ASPMC,
> -						   ab_pci->link_ctl &
> -						   PCI_EXP_LNKCTL_ASPMC);
> +		pci_force_enable_link_state(ab_pci->pdev, ab_pci->aspm_states);

[Severity: Medium]
Does this restore sequence leak the veto for inactive states and overwrite =
the
default ASPM state?

When restoring, pci_force_enable_link_state() only clears the bits in
link->aspm_disable that correspond to the previously active states (capture=
d via
pcie_aspm_enabled()). Any state that was supported but not active remains in
the aspm_disable mask forever, preventing users from enabling it via sysfs =
or
global policies.

Additionally, pci_force_enable_link_state() overwrites link->aspm_default
with the restored states, erasing the actual BIOS defaults.

(Note: This same pattern appears to occur in the ath12k driver modified
earlier in this series).

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-pci-aspm-f=
ix-v3-0-6bd72451746e@kernel.org?part=3D7
