Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC86442382
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046667; cv=none; b=pOMkewbIq/Vdn31h3HX/NKJICc84NSbYq58gegzwk/fGg4k69OZjS/W6UZkCIfGYyMCVxL0V0JPiQxiMqlVhUSDkchYBLm/8gURdgqw6p/H57wyXZ4ApXuOpV57LhfmXpbcDTxccFlnrA5q2qSFhYG6mKZDIXzBcHYpT9ICucfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046667; c=relaxed/simple;
	bh=v5IoMo44yLMdH1JmtXSwvyAbTMNziLn2lKiPYLN6U3g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OVt2l3QsPjwQ6JcBXESFCUKFlndaDA2hP6UqFO96ESbERzkYeOhYlT03DVADTvexhFF0fc70Nrzkw7AXRd4nGUJy43e8YHm8Y/mZrluGozG1S6+gGumOOjtBA4a0fkF+0jEbeRu4XHtdDDpDsCLCeM/Tk8aDJ2NGuKsgfNcOfiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSPCrYzD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSPCrYzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4522C1F00ADE;
	Thu,  6 Aug 2026 20:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786046657;
	bh=IYDoTS0EmUSdBVuu9EmNANoX36KCnrh030QfsbwZ1fc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HSPCrYzDrsplLZMh28pL3ckcC/gG1WPncCsMLIrJW4dxCp4LPUq8VrsdYAIlyAUm3
	 NbSQhDRcLXJBOHdAbM/jdHLLvLqlqxae+CimMcayPi4ld65so/SSnhkMvATeuvT38n
	 DQL5CQSPbZX71h9l5Y/iVmoZDzo6A529VbdYM/b4k2JzlAKgryyth30egx1hnCcpqX
	 vd/rQ95RMfs8SH2n8VS865thCR58M227emCdFjO47YQ8Qcp9excU+toSMK2VtPBlK6
	 /SgFhbnMiCkVeN3jYzZr0SFzldZhGWtC8BgSDbvBQQeEK/xoM/rCPoacr+LEdzFmw9
	 0kUWrZH8VjBUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/8] PCI: vmd: Replace hardcoded values with enum and
 defines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806221351.38592-6-szymon.durawa@linux.intel.com>
References: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
 <20260806221351.38592-6-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 20:04:16 +0000
Message-Id: <20260806200417.4522C1F00ADE@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The patch failed to completely replace the hardcoded resource in=
dices 1 and 2 with VMD_RES_MBAR_1 and VMD_RES_MBAR_2 when calling vmd_confi=
gure_membar().

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() in error paths and module removal, =
leaking IRQ vectors.
--

--- Patch [5]: [PATCH v6 5/8] PCI: vmd: Replace hardcoded values with enum =
and defines ---
commit d7c8cf241184af8f2b0d45fc458cfb88afbce3a5
Author: Szymon Durawa <szymon.durawa@linux.intel.com>

PCI: vmd: Replace hardcoded values with enum and defines

Add enum vmd_resource type to replace hardcoded values. Add defines for
vmd bus start number based on VMD restriction value. No functional
changes.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index f88a72b6309e7..78e8bdf7c3d79 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c

[ ... ]

> @@ -838,8 +850,8 @@ static int vmd_configure_membar1_membar2(struct vmd_d=
ev *vmd,
> =20
>  	ret =3D vmd_configure_membar(vmd, 2, VMD_MEMBAR2, mbar2_ofs, 0);

[Severity: Medium]
Since the cleanup paths now use the enum value VMD_RES_MBAR_1, should this =
call
and the preceding call to vmd_configure_membar() for MEMBAR1 use the new en=
um
instead of the hardcoded 1 and 2?

>  	if (ret) {
> -		devm_kfree(&vmd->dev->dev, (void *)vmd->resources[1].name);
> -		memset(&vmd->resources[1], 0, sizeof(vmd->resources[1]));
> +		devm_kfree(&vmd->dev->dev, (void *)vmd->resources[VMD_RES_MBAR_1].name=
);
> +		memset(&vmd->resources[VMD_RES_MBAR_1], 0, sizeof(vmd->resources[VMD_R=
ES_MBAR_1]));
>  		return ret;
>  	}

[Severity: High]
This is a pre-existing issue, but I noticed a potential IRQ leak during rev=
iew.

In vmd_alloc_irqs(), if devm_kcalloc() fails, does this leak the IRQ vectors
allocated by pci_alloc_irq_vectors() since pci_free_irq_vectors() is not ca=
lled?

drivers/pci/controller/vmd.c:vmd_alloc_irqs() {
    ...
	vmd->msix_count =3D pci_alloc_irq_vectors(dev, vmd->first_vec + 1,
						vmd->msix_count, PCI_IRQ_MSIX);
	if (vmd->msix_count < 0)
		return vmd->msix_count;

	vmd->irqs =3D devm_kcalloc(&dev->dev, vmd->msix_count, sizeof(*vmd->irqs),
				 GFP_KERNEL);
	if (!vmd->irqs)
		return -ENOMEM;
    ...
}

Similarly, does vmd_remove() permanently leak IRQs on unbind since it tears
down other resources but fails to invoke pci_free_irq_vectors()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806221351.3859=
2-1-szymon.durawa@linux.intel.com?part=3D5
