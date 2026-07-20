Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE9C286D70;
	Mon, 20 Jul 2026 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513722; cv=none; b=gAXILAU0tLya25g2DDF0W00OxnkUCgse/CKzO33fEeEaECjODW5igqpZG/iyKYeZ655gNuTpzK01lNtIS13O3bAy2cP1fgNeAqlGnJ89bgDATlzu7C+qBbQo8yV50tJsA59f4zEoP9Me/YIaNjkB8DSzuNnvrf33v15Iauqn9fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513722; c=relaxed/simple;
	bh=d8sJIA83Uzzo45KJp9aKymK6DO2fUlzS5x9ZjPz0FuE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n0T+0TVaRkC7iSoqNzU+0UjzLpWO8FdpWgldCdCooQBoYkVuwwXSmt2fB2wJJXjUfFJ+rJZ7fCNIhLEHcndQ7APuk9a5Scojsw79wXB4Lml1ySiOBoHq62XiN4hRiSNSXZYOkCk6/Nh/FUtGy+7LdFLZnF/2MeN60kkZ6MLrJ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSyuy2b/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSyuy2b/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489C21F000E9;
	Mon, 20 Jul 2026 02:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784513720;
	bh=R50qrVnt19dDTPpMiPY47lBZh/deuf/BhtPS+LDWfNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LSyuy2b/9eNWuXnVf8tGdeGvUR8py3v4c2OS94Msc10kKsP6DLsY3V6AK1C+WsiVO
	 RzrGh7pcTEwukrOVHq4FIZjgp3LdnrCZnITFREq6uBpz0nx6wWBrpB2PVW2Qp54TxF
	 FoCYYHaeDXxaA+TjJNibGly8RrCyDmwVNwgFWZhYn+kP5/LPHlop32D4DTjQa/iJNB
	 ocz0/bShAahkf7tHDjOggAhmIsKQUEl953Bb/oNzCGoUiOctNcHkv6T8U3HFi5706u
	 O2FAxZQSEPtDvwg/ry2++i+LKUemzBeIPChc/JKCfdHuWrsuGTWohIcb3ujGnpWsVJ
	 VUZChqV1qMOEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] PCI: dwc: rcar-gen4: Rework
 rcar_gen4_pcie_drvdata .additional_common_init into .init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260720020505.315335-3-marek.vasut+renesas@mailbox.org>
References: <20260720020505.315335-1-marek.vasut+renesas@mailbox.org>
 <20260720020505.315335-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 02:15:19 +0000
Message-Id: <20260720021520.489C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Silent failure in `rcar_gen4_pcie_ep_pre_init()` and asymmetric te=
ardown in endpoint error paths lead to kernel panics and unbalanced clock d=
isables.
--

--- Patch [2]: [PATCH v2 2/5] PCI: dwc: rcar-gen4: Rework rcar_gen4_pcie_dr=
vdata .additional_common_init into .init ---
commit f4863c849aaf3cf13744faee6e2f333b5420b025
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: dwc: rcar-gen4: Rework rcar_gen4_pcie_drvdata .additional_common_init =
into .init

This commit simplifies the PCIe initialization callchain for R-Car Gen4 SoC=
s.
It replaces the additional_common_init callback with a unified init callback
for both host and endpoint configurations.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index 5f7211b91ee5b..5724f64eadfad 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

[ ... ]

> @@ -487,7 +509,7 @@ static void rcar_gen4_pcie_ep_pre_init(struct dw_pcie=
_ep *ep)
>  	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
>  	int ret;
> =20
> -	ret =3D rcar_gen4_pcie_common_init(rcar);
> +	ret =3D rcar->drvdata->init(rcar);
>  	if (ret)
>  		return;

[Severity: High]
This is a pre-existing issue, but since this area is being modified, does t=
he
early return here lead to a kernel panic if initialization fails?

If rcar->drvdata->init() fails, it returns early but cannot propagate the
error because pre_init() returns void. Execution then continues into
dw_pcie_ep_init_registers(), which accesses unclocked DWC registers, result=
ing
in an SError panic.

Also, if dw_pcie_ep_init() fails before calling ep->ops->pre_init() (such as
in devm_pci_epc_create()), the error path in rcar_gen4_add_dw_pcie_ep()
unconditionally calls rcar_gen4_pcie_ep_deinit(). That function performs an
MMIO write to PCIEDMAINTSTSEN while clocks are disabled, causing another
SError panic, and warns about unbalanced clock disables.

Could these endpoint error paths be reworked so the kernel fails gracefully
instead of crashing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720020505.3153=
35-1-marek.vasut+renesas@mailbox.org?part=3D2
