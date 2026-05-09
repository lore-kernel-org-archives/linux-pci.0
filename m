Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C3022576E
	for <linux-pci@vger.kernel.org>; Sat,  9 May 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778339225; cv=none; b=rACXcn6LG2CtApKj7bt7peTRbP1uUJ5HJqHJRfFva8c0Vfmf8oQ+n1A94lCBXNRikxP7l432SgpFUH9XaYursyXtl/IL/wYnfWqSIv+nOny4ZeSaaKP15MxtRRWHi3E+6/j+6zJzWAugjLMWqhw8maIzAd1eZdWYtK0K481PlLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778339225; c=relaxed/simple;
	bh=ObWaibKeZqvVBinXskxxP7VvkrZE9Upg5XpvGL83EQs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jO56YM/158E4j0S33aGd+YrhsUSCvpbNUvLQxB2e5pleWVkvnVKfW05rbsgQp/P7OES3f8tZLV90yRdnBJ606XxyZJmj8luYpglfYYYGwtBmHQM2emqL+IrQkQlhVtYOXbhpXRibd6bcO81/JIzTeWSXer+iraXyhDjBuvknkFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIkK1wCE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIkK1wCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2EDC2BCB2;
	Sat,  9 May 2026 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778339225;
	bh=ObWaibKeZqvVBinXskxxP7VvkrZE9Upg5XpvGL83EQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hIkK1wCEPtj3la4ikp5bkY2HlpcWiBxhdEJS6GBOY+hCQP52wWI8xYdSdWxa52fsY
	 g9k6j3F8si8iNxp+0DDHPc0tXiD9ieHEDguCcucH+oEzzmElSpF39Lh1pdkeLh9jZH
	 fzd8p0UV1ETZP2LJgEY8cvxqCk+nYJH2MdX7Fhk7Zc4t3kjSKMea1PZjJxxPVnMX/Y
	 9xTeyYpKSVFAfNJ+BG/niejXogueZorSTTMGScWadrgiVi0uV9H/mf5almLvMqhvWi
	 Gqr8hpmwxnxj0YKdusHKbOOxFHlsLd5dWC4Glxg9UhWoiFuWdTuk62vMHp/HPfz1vq
	 sy8TyXVaSNPoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] PCI: dwc: Use cached PCIe capability offset in core
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260509135152.2241235-3-18255117159@163.com>
References: <20260509135152.2241235-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 15:07:04 +0000
Message-Id: <20260509150705.4E2EDC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Calling `dw_pcie_get_pcie_cap()` before `ops->init()`/`ops->pr=
e_init()` accesses unclocked hardware registers, causing a kernel panic or =
system hang.
- [High] Direct access to `pci->pcie_cap` bypasses lazy initialization, lea=
ding to invalid register reads/writes and silent PCI config space corruptio=
n.
--

commit 26cd77098a4771b4de6b7f3b4769d54179db8507
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: Use cached PCIe capability offset in core

This commit modifies the DWC core functions to use a cached pcie_cap offset
rather than looking up the capability each time.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1390,6 +1390,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	ep->msi_msg_addr =3D 0;
>  	ep->msi_map_size =3D 0;
> =20
> +	dw_pcie_get_pcie_cap(pci);
> +
>  	epc =3D devm_pci_epc_create(dev, &epc_ops);

Will this dw_pcie_get_pcie_cap() call cause a crash by accessing unclocked
hardware registers?

Looking at dw_pcie_ep_init(), clocks and regulators aren't enabled until
ep->ops->pre_init(ep) is executed further down in this function.

Calling dw_pcie_get_pcie_cap() here performs MMIO reads on the DBI
configuration space. On architectures like ARM/ARM64, reading from unclocked
MMIO space can trigger a synchronous external abort and kernel panic. If the
bus instead returns 0xFFFFFFFF, it could loop infinitely searching for the
next capability.

[ ... ]

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -575,6 +575,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> =20
>  	raw_spin_lock_init(&pp->lock);
> =20
> +	dw_pcie_get_pcie_cap(pci);
> +
>  	bridge =3D devm_pci_alloc_host_bridge(dev, 0);

Does this have the same early MMIO access issue as dw_pcie_ep_init()?

The platform-specific pp->ops->init(pp) callback isn't called until after
bridge allocation and resource fetching, so clocks might not be ready yet.

[ ... ]

> @@ -1218,7 +1220,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
> =20
>  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  {
> -	u8 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u8 offset =3D pci->pcie_cap;

Is it safe to bypass the lazy initialization provided by
dw_pcie_get_pcie_cap(pci)?

If pci->pcie_cap is 0, this direct struct access means the fallback
capability search is completely skipped.

[ ... ]

> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -807,8 +807,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  	if (pci->max_link_speed > 2)
>  		msleep(PCIE_RESET_CONFIG_WAIT_MS);
> =20
> -	offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	val =3D dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> +	val =3D dw_pcie_readw_dbi(pci, pci->pcie_cap + PCI_EXP_LNKSTA);

Could bypassing dw_pcie_get_pcie_cap() here lead to silent PCI config
space corruption?

If pci->pcie_cap remains 0, reading or writing to pci->pcie_cap +
PCI_EXP_LNKSTA would operate on offset 0x12. This maps to the standard PCI
Header Type and BIST registers rather than the PCIe capability region,
potentially breaking link status checking and speed configuration.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260509135152.2241=
235-1-18255117159@163.com?part=3D2
