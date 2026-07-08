Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3D306741
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522288; cv=none; b=X+oS0ZJbCWGDuEFh019/n/QVNGNgn1G5NN6956YuYCUxQlzkZpfJU+gSKB57QO5dVxHqv8sPu4QPiBibuVFmzJTOJdJgvq7xmVQyE3VRfqfAq0SNlf1UNJ7LyOkKfGDZzvbQp6rXbPPsSCSJXJflqz9Jcp7SkF2shqCcE7tXiuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522288; c=relaxed/simple;
	bh=Y9pSIv3XMe01kr9AXQsigejkDzGp+dOPUG23Hy9u3SM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iPtgXPTSLwUKjE4uHp5Vmcw8bYbqtSrVNMaNA0hZ5ALKvk2luRkNxO6p0YgliraAD8Gg8rQoPASUjDMzAS6u/hgv7bsYQKxqsBR45i0tvqrjwmrD6hc7MdzQlgG+MT+KhqJh82CbFDj6G9oMbKXcooByBXO0Isx6KMR2vJEDKqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOoYa5yF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOoYa5yF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BF11F000E9;
	Wed,  8 Jul 2026 14:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783522287;
	bh=kzuFsxsLq5Ly4vOgdzpEQpY7laZlqQGJoOuPvgJopr0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WOoYa5yFLwwCIqPdB4zG9zZ6YFtdA45UBQw35pugRpgH8R1vJKyH1IYBxd1suY4Le
	 /7SaoBV9/qiAPajnTQijAhYId0UwuEamOeSuo70FePtRPw5v8a7QauWvilRbEMnWyb
	 L3GWGISvIYZVybOG9pMlb5BvxzkfQEiVPjrl9/8DhtqXzHESUjaBrMO5JoLsmGBCwN
	 R2Qe9fotBiSaLYJWO1CFI41SFXnc0pzwNHXb9B6ZyfCdaOwgVjUZ+wN00hJ4uZctgt
	 JXQcdEf0xi34CJnVZhYBrd2R21xrb1PtVE8tQXELN4eCk3pQ5RJimdUQgn3OLyee0O
	 kM/mLwwg0KVgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] wifi: ath10k: Use
 pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260708-pci-aspm-fix-v3-8-6bd72451746e@kernel.org>
References: <20260708-pci-aspm-fix-v3-0-6bd72451746e@kernel.org>
 <20260708-pci-aspm-fix-v3-8-6bd72451746e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:51:25 +0000
Message-Id: <20260708145125.D8BF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unnecessary strict dependency on `CONFIG_PCIEASPM` breaks the driv=
er on systems without ASPM enabled.
- [Medium] Temporary ASPM disablement potentially permanently poisons the P=
CI link's `aspm_disable` mask for states that were not currently active (Sp=
eculative).
--

--- Patch [8]: [PATCH v3 8/8] wifi: ath10k: Use pci_{enable/disable}_link_s=
tate() APIs to enable/disable ASPM states ---
commit f0b7b0f10e0387bb33b3201d0eb417f52d2cc145
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

wifi: ath10k: Use pci_{enable/disable}_link_state() APIs to enable/disable =
ASPM states

The commit replaces direct LNKCTL register manipulation with PCI core APIs
for enabling and disabling ASPM states. This ensures the PCI core's
knowledge of the device's ASPM state remains accurate.

> diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wirele=
ss/ath/ath10k/Kconfig
> index efb9f022d8c66..eac3ec5a4e78f 100644
> --- a/drivers/net/wireless/ath/ath10k/Kconfig
> +++ b/drivers/net/wireless/ath/ath10k/Kconfig
> @@ -17,7 +17,7 @@ config ATH10K_CE
> =20
>  config ATH10K_PCI
>  	tristate "Atheros ath10k PCI support"
> -	depends on ATH10K && PCI
> +	depends on ATH10K && PCI && PCIEASPM

[Severity: High]
Does this strict dependency on PCIEASPM break the driver build on systems
where ASPM is disabled?

The PCI subsystem provides no-op stubs for ASPM functions (like
pci_disable_link_state, pci_force_enable_link_state, and pcie_aspm_enabled)
in <linux/pci.h> so drivers can use these APIs without requiring a strict
dependency.

[ ... ]

> diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless=
/ath/ath10k/pci.c
> index 335bc7c488e41..2e27a70065cce 100644
> --- a/drivers/net/wireless/ath/ath10k/pci.c
> +++ b/drivers/net/wireless/ath/ath10k/pci.c
> @@ -1965,9 +1965,7 @@ static int ath10k_pci_hif_start(struct ath10k *ar)
>  	ath10k_pci_irq_enable(ar);
>  	ath10k_pci_rx_post(ar);
> =20
> -	pcie_capability_clear_and_set_word(ar_pci->pdev, PCI_EXP_LNKCTL,
> -					   PCI_EXP_LNKCTL_ASPMC,
> -					   ar_pci->link_ctl & PCI_EXP_LNKCTL_ASPMC);
> +	pci_force_enable_link_state(ar_pci->pdev, ar_pci->aspm_states);
> =20
>  	return 0;
>  }

[ ... ]

> @@ -2822,10 +2820,9 @@ static int ath10k_pci_hif_power_up(struct ath10k *=
ar,
> =20
>  	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot hif power up\n");
> =20
> -	pcie_capability_read_word(ar_pci->pdev, PCI_EXP_LNKCTL,
> -				  &ar_pci->link_ctl);
> -	pcie_capability_clear_word(ar_pci->pdev, PCI_EXP_LNKCTL,
> -				   PCI_EXP_LNKCTL_ASPMC);
> +	ar_pci->aspm_states =3D pcie_aspm_enabled(ar_pci->pdev);
> +
> +	pci_disable_link_state(ar_pci->pdev, PCIE_LINK_STATE_ASPM_ALL);

[Severity: Medium]
Since all ASPM states are disabled here using PCIE_LINK_STATE_ASPM_ALL, but
pci_force_enable_link_state() in ath10k_pci_hif_start() only restores the
previously active states (ar_pci->aspm_states), could this permanently
poison the PCI link's aspm_disable mask for states that were not active?

If the API only clears the disable mask for the requested states, any ASPM
states that were not initially active will remain permanently disabled in t=
he
PCI core.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-pci-aspm-f=
ix-v3-0-6bd72451746e@kernel.org?part=3D8
