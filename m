Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B79713957E
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788409615; cv=none; b=RGViZCfCFuNrFPJJH0FZgwWbjFilnjK4wzxivA7gjPuV7omKQOWtMcgvXJYg1dzRHWoKnjLc2H6J0gAizfZdaYg/vlMrzdKDUW82L/qsDKf8nkGqn5ApSC05CyBYf98BzuRNCTYpcq3ENFTyh/HlJGXiPiD5pj2NbrntxnqNu/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788409615; c=relaxed/simple;
	bh=+j48aUVjW9qje/EymFSr7Li6BEqT2TPlb7I1DLxTGUA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iCZXao6pKg6KBkSltEIEStiVyCNZ+amVNjqQOtGyJe4wUR4LMcMGQQHupsozGTf9cooSYonxKuRytwsLh8yKpyvGziv9eZxKYMU7373fh0HJf2JUfmo+5N7pFbOWi99VH99ZQhvLpnIco1SztBeLlSVWlw32iSvHtDAZEX3Wg+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEUmP2hO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEUmP2hO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3791F000E9;
	Thu,  3 Sep 2026 04:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788409613;
	bh=EF0HVvTJyELhAVuZ4bEMw1AXn2h6VdGdNGyXlq2PW7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CEUmP2hOTqouua0gZfWVm1KxE6raZkARw0KbsjelSnpbLXLtB8soPbJUzBTIQqsIF
	 lGlt7XCDz/7onQCS5FOikdCNnL2WaZrAiuDTgk7TWs4+whbN7t97fQMWnqY0s/dOXz
	 6PFiwQcM7bCjeI1MdAQUmLlOfEH5zPwmVbwp2CfUYvW1KzZU0Tg+yLt3oqfmAy6No0
	 AtOFYbz3WqRTADQmHKmNnS7TCwn2KlHTO+Auy0DjeK8D/P/TfLGp98nRYPh9o45gtf
	 rM/SUQLEyyNPMWxi5lQ3XiCvbNJnrYtzfNAO+Lz/I2MRTDqe9Bbyi49m+Y0eOY3V2Q
	 RKMl/6uwb8cYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/6] PCI: Refactor disable_acs_redir and config_acs
 param handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB439380682B8703CB5340AD59DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB439380682B8703CB5340AD59DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 04:26:53 +0000
Message-Id: <20260903042653.8A3791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but user-provided AC=
S command line parameters silently wipe out standard IOMMU protections (SV,=
 TB, UF) for unspecified bits by reverting to hardware defaults.
--

commit 62951886e4f26a51d147451d4aa7384b487c2ff6
Author: Wei Wang <wei.w.wang@hotmail.com>

PCI: Refactor disable_acs_redir and config_acs param handling

This commit splits the intertwined disable_acs_redir and config_acs paramet=
er
handling inside __pci_config_acs() into dedicated functions. It also improv=
es
parameter parsing by checking for a matching device before parsing flags and
replacing complex string parsing with cleaner loops and switch statements.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 587c013f04db3..6cffdbba99d34 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> +static void pci_param_disable_acs_redir(struct pci_dev *dev,
> +					struct pci_acs *caps)
> +{
> +	const u16 acs_redir_mask =3D PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC;
> +
> +	if (!disable_acs_redir_param ||
> +	    !pci_dev_match_disable_acs_redir(dev, disable_acs_redir_param) ||
> +	    !pci_dev_specific_disable_acs_redir(dev))
>  		return;
> =20
> +	caps->ctrl =3D caps->fw_ctrl & ~acs_redir_mask;

[Severity: High]
This isn't a bug introduced by this patch, but does this overwrite silently
discard the standard IOMMU protections (SV, TB, UF) established earlier?

When an administrator uses pci=3Ddisable_acs_redir=3D..., pci_enable_acs()
first enables OS-level protections via pci_std_enable_acs(dev, &caps).

However, because this assignment bases the new control register completely =
on
caps->fw_ctrl, any previously configured security bits are erased. This bre=
aks
PCIe isolation guarantees for the affected devices.

[ ... ]

> +static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *ca=
ps)
> +{

[ ... ]

> +	invalid_bits =3D (enabled_bits | disabled_bits) & ~valid_ctrl;
> +	if (invalid_bits) {
> +		pci_dbg(dev, "Ignoring unsupported ACS bits: %#06x\n",
> +			invalid_bits);
> +		enabled_bits &=3D valid_ctrl;
> +		disabled_bits &=3D valid_ctrl;
> +	}
> =20
> -	pci_dbg(dev, "ACS mask  =3D %#06x\n", mask);
> -	pci_dbg(dev, "ACS flags =3D %#06x\n", flags);
> -	pci_dbg(dev, "ACS control =3D %#06x\n", caps->ctrl);
> -	pci_dbg(dev, "ACS fw_ctrl =3D %#06x\n", caps->fw_ctrl);
> +	pci_dbg(dev, "ACS enabled: %#06x, disabled: %#06x\n",
> +		enabled_bits, disabled_bits);
> =20
> -	/*
> -	 * For mask bits that are 0, copy them from the firmware setting
> -	 * and apply flags for all the mask bits that are 1.
> -	 */
> -	caps->ctrl =3D (caps->fw_ctrl & ~mask) | (flags & mask);
> +	caps->ctrl =3D (caps->fw_ctrl | enabled_bits) & ~disabled_bits;

[Severity: High]
This is a pre-existing issue, but does this assignment also inadvertently w=
ipe
out the IOMMU protections set up by pci_std_enable_acs()?

Similar to pci_param_disable_acs_redir(), when pci=3Dconfig_acs=3D... is us=
ed,
all un-masked bits revert to their fw_ctrl hardware default state rather th=
an
persisting their pci_std_enable_acs() modifications.=20

This could potentially allow DMA spoofing or unauthorized memory access on
devices where the admin only intended to tweak specific ACS bits.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB4393F337A7=
92CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D4
