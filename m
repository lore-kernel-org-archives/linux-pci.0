Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB42147C0EE
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131308; cv=none; b=TQIayLzNvHFcfZRHrBxiocPrzEko++vQ2rgkQ83vM9V5CZs+JCyzQHIGPjD8bUUWuVEgTjzQ8ImdB/yDAUPPOCMem1V1GlSNVSJ7VVhfjLpfZB1Xd+BIXrGGdQ28vkmUbztxEUYqefXYNZS0EBx4ks4GFORZ5WMui/M1+WbDCJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131308; c=relaxed/simple;
	bh=nuwrnNQNomtZGdooq/xLnvntMl5o1izXv0sZpCsukcA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bmeTCmYzV41XBrzRZd6KlQWZsBvVAe8wOfGnIEHCUsiNRH4lA+qqqfl+XPMlnpSBe9DVfL0Ih6lLOEdMgCSSAxd6rtuaQy2aiKcaVDxjo13ceWbuPfXZkbrMMPxMS36wivtgbpRa5wnfOi53ILZhnxdeXOuEA5ngKWf6cIXM1+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofiy7S/H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofiy7S/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1AB1F000FF;
	Fri, 11 Sep 2026 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131305;
	bh=xJgt4XucUcC5C0KQqzQAOHV0fPiRpyvm3IO2+Mfu7tY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ofiy7S/HNq8Yb5dLqkeyWKoCZeA1yZ8bdzZREVNWEl7iPhxBtD35D9Kr3hUyYqkWB
	 CuHr6/2TYNopH4k7wvXEUNyfSLAlhDOq4TyiMzXKdsmfo5vFTzrMBK6IUmnfVHuMRa
	 jUHwLCHBendiMn4v5v0k202t8hpZ4oTyRCwiK1OAeA1/COFTutL2iu4R+hqg8QBVeV
	 zzoCHS2sMO3hYyKIanasIXLX/sKmlBGdHzFW/86Lbc+2ZTiPNE2hil0WvE5EsEmj8m
	 oirZewI39nVwTNRryE5+TLBNNH3EV0uLfCg+92Crvgj2VfGJ4DZegje/20G31U8XYr
	 O0dQ/DxHPx4Zg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/8] powerpc/pci: Serialize pcibios_bus_add_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavol Sakac" <sakacpav@amazon.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911123147.97312-1-sakacpav@amazon.de>
References: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
 <20260911123147.97312-1-sakacpav@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:55:05 +0000
Message-Id: <20260911125505.8F1AB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential NULL pointer dereference of `pdn` in `pseries_pcibios_bu=
s_add_device`.
- [High] Potential NULL pointer dereference of the physical function's EEH =
device (`edev`) in `pseries_pcibios_bus_add_device`.
--

commit 7133056da4f8622a96d7696deea5dac9e5c2eeb4
Author: Pavol Sakac <sakacpav@amazon.de>

powerpc/pci: Serialize pcibios_bus_add_device()

This commit serializes the pcibios_bus_add_device platform hook dispatch
with an arch-local mutex to prevent race conditions during concurrent sibli=
ng
VF additions. This addresses unlocked list manipulations in the EEH PE tree.

> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-c=
ommon.c
> index 4fc52c21fe5d4..21cccd0e97f8b 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c

[ ... ]

> @@ -1068,8 +1077,11 @@ void pcibios_bus_add_device(struct pci_dev *dev)
>  	if (ppc_md.pci_irq_fixup)
>  		ppc_md.pci_irq_fixup(dev);
> =20
> -	if (ppc_md.pcibios_bus_add_device)
> +	if (ppc_md.pcibios_bus_add_device) {
> +		mutex_lock(&pcibios_bus_add_device_lock);
>  		ppc_md.pcibios_bus_add_device(dev);

[Severity: High]
This isn't a bug introduced by this patch, but can this hook lead to a NULL
pointer dereference if pdn allocation fails?

If add_sriov_vf_pdns() fails (for example, due to memory pressure), it
returns NULL instead of propagating an error. The PCI core proceeds to
instantiate the Virtual Functions and calls this platform hook.

In arch/powerpc/platforms/pseries/eeh_pseries.c:pseries_pcibios_bus_add_dev=
ice():

    pdn =3D pci_get_pdn(pdev);
    pdn->device_id  =3D  pdev->device;

Could a privileged user trigger a kernel panic by enabling SR-IOV under
memory pressure, turning a recoverable failure into a DoS?

[Severity: High]
This is also a pre-existing issue, but could this hook dereference a NULL
pointer if the physical function lacks an initialized EEH device?

When adding a Virtual Function, pseries_pcibios_bus_add_device() assumes
the physical function's EEH device pointer is valid:

In arch/powerpc/platforms/pseries/eeh_pseries.c:pseries_pcibios_bus_add_dev=
ice():

    struct eeh_pe *physfn_pe =3D pci_dev_to_eeh_dev(pdev->physfn)->pe;

If EEH initialization failed for the physical function (for instance, if the
device is not part of a PE or firmware didn't support EEH), its EEH device
pointer remains NULL.

Would writing to the sriov_numvfs sysfs file on such a physical function
cause an unconditional dereference of the NULL edev pointer here?

> +		mutex_unlock(&pcibios_bus_add_device_lock);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-vfopt-s1-v=
1-0-693271dc0226@amazon.de?part=3D5
