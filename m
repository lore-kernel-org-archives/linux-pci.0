Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CC23563FB
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177660; cv=none; b=Dj0UTEyO1zQ33XvHO1sg3yiXIO/aEsx+1t5pMKYtQlJcLpb5NnvGZ6tNogdCgPpvletdk57OcWxi92sZ1WqGVyfuhBJwHXn7kAewtkgncTjAeFPQ38UFXdp75hzRYoKP564Ek2+S5PhlE5sO4u4Tm3anZMJq7/KKx9AcCdQsfvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177660; c=relaxed/simple;
	bh=GtkABCwORaNSv5OTGEIliEb4zmi8uCGchqwwwssld80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SI7ohPiG7DH8mVGyi1hYRQbSXOsr8HU60TxTgaFNTYK//sNrYZXryFSQ684pQp5ttthblFKyhFKIny7fliSlBtb1uOrQILV7j6FNPMM76eDxL4OqsP5p05v/IUl7nRAXb90AoGd+A8rLpepuhRTfIWliZ8duxoJ/pJJ63SphzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHVlIZ0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHVlIZ0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C2C1F000E9;
	Tue, 23 Jun 2026 01:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782177659;
	bh=7VpYeAboLvcuJbgQyear6gGFIMpcvBPmemNPmZTqVyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VHVlIZ0p1lXjgl/Kg+Oqx6riAwBRhs1kOAz0lET1j0sE4GtbidL9FLdzdKgN/0lGi
	 0U1ssQbJy5/QSXp6pyWuDMIAZLnyMp+B+C3BcDdsZiS+H6JpW3X407XUoFurWGQ1/h
	 fNk2D/dkFXwKl54AN6FP0qVz0yHbprx+hniq9CWhwAqgLd3j/de26E/ZMOIa9/Slj5
	 /gxPK9rH/QITzFrmp0bszeRJ2vul2bl0FpjS/V00ixPOmNBQsZfjylBlgOF97SOjKQ
	 u4b5CfDuf7V7Xc2dX6KRTOxk0BjJZA5NL1xbBnTtF3yQsoZzpggMSMp8CFhp8zWLbH
	 RS7nJChaMTFqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] PCI: vmd: Add feature to scan BIOS enumerated
 devices.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nirmal Patel" <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260623011305.134792-1-nirmal.patel@linux.intel.com>
References: <20260623011305.134792-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 01:20:58 +0000
Message-Id: <20260623012058.D9C2C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The IRQ domain and its associated fwnode are permanently leaked =
for devices with VMD_FEAT_USE_BIOS_INFO due to an unconditional early retur=
n in vmd_remove_irq_domain().
--

commit 0711c95d550249c54951b1f20ee8a7fe26dafc0b
Author: Nirmal Patel <nirmal.patel@linux.intel.com>

PCI: vmd: Add feature to scan BIOS enumerated devices.

This commit adds support for newer VMD hardware (like device ID 0x28c1) by
using BIOS-configured shadow registers and bus ranges instead of manually
configuring them.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -374,6 +393,9 @@ static void vmd_set_msi_remapping(struct vmd_dev *vmd=
, bool enable)
> =20
>  static void vmd_remove_irq_domain(struct vmd_dev *vmd)
>  {
> +	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
> +		return;
> +

[Severity: Medium]
Does this early return cause an IRQ domain and fwnode resource leak?

When a VMD device like 0x28c1 (which has VMD_FEAT_USE_BIOS_INFO) is probed,
vmd_enable_domain() can conditionally create an IRQ domain if running under
Xen or if the BIOS-configured shadow registers offset[0] or offset[1] are
non-zero.

If the driver is unloaded or fails later in the probe process, this return
causes the function to exit immediately before calling irq_domain_remove()
and irq_domain_free_fwnode(). Should the IRQ domain teardown still execute
even if VMD_FEAT_USE_BIOS_INFO is set?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623011305.1347=
92-1-nirmal.patel@linux.intel.com?part=3D1
