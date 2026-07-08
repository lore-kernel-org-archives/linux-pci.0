Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59B175A75
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522145; cv=none; b=LsEtXnQcnIDRntK9NPEPbkz+k+gTYaUwoeCwh/oEAC0mqUAD3DM0jvaVntOk90MG6BkRvGzxgPFHBnR7ZUQneAicOThNKATuZt6VW/6rV0g5RPa5iUpPlekF2J2QQjPYzI7eKsKXSeO8fSdoQiqc3gOLGTfbmNRfexIy8+nhtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522145; c=relaxed/simple;
	bh=OH0ZgcC2t+nR7YNnis1bo/t3xXj8L49Yj8Wm7tUEIvc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CeL4vXcoUq0FHRAqxRrdMevfuky2PIC2odpG9THS5++un0C+EaAQf0jyfT3x409EVJY1dN42kMLf/fCFVrU3IK28dNUxRVu71H672VWEkwsFslr8sReLwWa08CSfRSLlZLCnTz0otQ+f9TpTaeK75DoTBWk4pDdAB3+fwnAFaQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsZA2j1o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsZA2j1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC4F1F000E9;
	Wed,  8 Jul 2026 14:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783522144;
	bh=a+wG6LcWmYz9w2DSgF+ke8M98EsJo43uBgcB6hAqix4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PsZA2j1o2RdDjkt6DOJdZf3M8IwlW2lhU+fFnlhHG28pnSA5FIC2LJTwSLRtq7rM7
	 uPEASC3Zg7GSmgYdecj4z/5VqpaSK3RnUJT8hFC9wjVMXThqxCw83etDlkWm78OTFh
	 Nt2npUqXib9DUC04shnWXVfGmR+2AwNg9pGt/01MX0crvDB+K5a2JieyNU2IDkm3fY
	 MfcnTvLeMe1mgFOxnxfDD6hPWnfWUeaM5uOcuxOIF569kseno5vcJYYjcMlGt8ZeoL
	 W7TdN10jxoBxlXkctNDfmlDRksDs5KfFVoEKW1McWuK+o47GRMca4tnukOW/M9dMYi
	 v/AUyQpn4GUAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] wifi: ath12k: Use
 pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260708-pci-aspm-fix-v3-6-6bd72451746e@kernel.org>
References: <20260708-pci-aspm-fix-v3-0-6bd72451746e@kernel.org>
 <20260708-pci-aspm-fix-v3-6-6bd72451746e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:49:03 +0000
Message-Id: <20260708144904.0CC4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Adding `depends on PCIEASPM` unnecessarily restricts the driver =
from being built on kernels where ASPM control is disabled.

Pre-existing issues:
- [High] ASPM state is permanently lost (leaked as disabled) if initializat=
ion fails before `ath12k_pci_start()`.
--

--- Patch [6]: [PATCH v3 6/8] wifi: ath12k: Use pci_{enable/disable}_link_s=
tate() APIs to enable/disable ASPM states ---
commit 6aeb96e7a1d3a96df659d6e1d629f287d946f802
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

wifi: ath12k: Use pci_{enable/disable}_link_state() APIs to enable/disable =
ASPM states

This commit changes the ath12k driver to use the PCI core's
pci_disable_link_state() and pci_force_enable_link_state() APIs for managing
ASPM states instead of directly modifying the LNKCTL register. It also adds=
 a
Kconfig dependency on PCIEASPM.

> diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wirele=
ss/ath/ath12k/Kconfig
> index 4a2b240f967af..7852ede3eaea8 100644
> --- a/drivers/net/wireless/ath/ath12k/Kconfig
> +++ b/drivers/net/wireless/ath/ath12k/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: BSD-3-Clause-Clear
>  config ATH12K
>  	tristate "Qualcomm Wi-Fi 7 support (ath12k)"
> -	depends on MAC80211 && HAS_DMA && PCI
> +	depends on MAC80211 && HAS_DMA && PCI && PCIEASPM

[Severity: Medium]
Is the PCIEASPM dependency necessary here?

The PCI subsystem provides static inline no-ops for pci_disable_link_state(=
),
pcie_aspm_enabled(), and pci_force_enable_link_state() in linux/pci.h when
CONFIG_PCIEASPM is not set. Adding this strict dependency restricts the
driver from being built on kernels where ASPM control is intentionally
disabled.

>  	select QCOM_QMI_HELPERS
>  	select MHI_BUS
>  	select QRTR

[ ... ]

> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless=
/ath/ath12k/pci.c
> index d9a22d6afbb02..6d48fb25690de 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -884,19 +884,9 @@ static void ath12k_pci_free_region(struct ath12k_pci=
 *ab_pci)
> =20
>  static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
>  {
> -	struct ath12k_base *ab =3D ab_pci->ab;
> -
> -	pcie_capability_read_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> -				  &ab_pci->link_ctl);
> -
> -	ath12k_dbg(ab, ATH12K_DBG_PCI, "pci link_ctl 0x%04x L0s %d L1 %d\n",
> -		   ab_pci->link_ctl,
> -		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L0S),
> -		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
> +	ab_pci->aspm_states =3D pcie_aspm_enabled(ab_pci->pdev);

[Severity: High]
This is a pre-existing issue, but does this logic permanently lose the ASPM
state if initialization fails before ath12k_pci_start()?

If ath12k_mhi_start() fails in ath12k_pci_power_up(), the initialization
is aborted. The current ASPM state is unconditionally saved to
ab_pci->aspm_states here and then disabled. On failure,
ath12k_pci_power_down() is called to clean up, but it returns early if
ATH12K_PCI_FLAG_INIT_DONE is not set:

drivers/net/wireless/ath/ath12k/pci.c:ath12k_pci_power_down() {
	if (!test_bit(ATH12K_PCI_FLAG_INIT_DONE, &ab_pci->flags))
		return;

	/* restore aspm in case firmware bootup fails */
	ath12k_pci_aspm_restore(ab_pci);
	...
}

This early return skips the restore and leaves ASPM disabled. When the
device is later retried, ath12k_pci_power_up() is called again, overwriting
ab_pci->aspm_states with the now-disabled state (0). When initialization
finally succeeds, it restores 0, permanently disabling ASPM.

> =20
> -	/* disable L0s and L1 */
> -	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> -				   PCI_EXP_LNKCTL_ASPMC);
> +	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_ASPM_ALL);
> =20
>  	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-pci-aspm-f=
ix-v3-0-6bd72451746e@kernel.org?part=3D6
