Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11573246ED
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170556; cv=none; b=lXXrWFUAZSq9r2NQI+rmIZmfushOcVTBM7A464YaToDIO51UdF4bdj0SIJgJ5kKxanYzavG7KPtkOgTj9l7Ng7jGYy+LIbs6LVZCS/H3+IoLXwQ48gkxcs77KKP8nSsrL2ekrjZmIzuDf1FHr4SH/abIGpdLhEXLa7Z2Tk3A2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170556; c=relaxed/simple;
	bh=AvZ6UyLSFfHfkmoLGegnpCXszZhEmNaipq9RBJ1rrqA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vDWMWTP+9uVWB6K5yklp6gj7YND88wjJrSH0njddcjRHo0ULwMS+5bR3cztG6o4cJZt9fpME31kUOY62M0vckayd6KjR5eYFjkwIF5kz4ACw2pQ3Id/3wtqtK3y0bmylXNLWM1sOTwfjhOc5BuPeZslrwZbjbRwPHKb+sTr99J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohJQP70Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohJQP70Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470DE1F000FF;
	Fri, 11 Sep 2026 23:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789170553;
	bh=XAFg63GnJruRW424Ehah0iIRFskovavZSah4iZs+iDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ohJQP70Y9PpEgJ2Yd26idqXgLtHxE7ZsvN7Pdns5z5eUtdPNIEUxeDoQOsu/AbwyI
	 n2ZB8lzI8TDmK3jFa/RjAO9eJdR72EUFGUCLJVzUqu35QBPHryPItoJbRdsdibvFnT
	 q9hT/Vwnm3xg5CiNLsBYiIL0G6ZO49+W55yDHVS4gqYdsF7yoxRJBPLNiIBUD9sxT2
	 qqGFy7ctxKJWu8uXClz5D97aIWEz8uR6dcHbvPvHiGESM+MtRRB9yytfz2MEKE5AYa
	 grG4v1aKblZybaX1GQLFn4aCGyKhPmmzIomcrvYq0XRPbYGN8KdfrAVvN3cu4cN3KA
	 HhcZokI4e3jSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/13] PCI: brcmstb: Declare and assign quirk
 PERST_PCIE_REV_CUTOFF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Quinlan" <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911233541.1650895-11-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-11-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:49:12 +0000
Message-Id: <20260911234913.470DE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free / NULL pointer dereference in error path when pci_h=
ost_probe() fails.
- [High] Use of uninitialized spinlock `pcie->bridge_lock`.
--

commit 8a2eb9e850a817eb0d5eb7cbe7b4bf1dbe6785e6
Author: Jim Quinlan <james.quinlan@broadcom.com>

PCI: brcmstb: Declare and assign quirk PERST_PCIE_REV_CUTOFF

This commit declares a new quirk for SoCs where the SW behavior for asserti=
ng
PERST# only works up to a specific PCIe HW version, and assigns it to the
bcm4908 configuration.

> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index dfd7035710918..047783e33ae42 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c

[ ... ]

> @@ -2168,7 +2171,7 @@ static int brcm_pcie_probe(struct platform_device *=
pdev)
>  		goto fail;
> =20
>  	pcie->hw_rev =3D readl(pcie->base + PCIE_MISC_REVISION);
> -	if (pcie->cfg->soc_base =3D=3D BCM4908 &&
> +	if (BQUIRK(pcie, PERST_PCIE_REV_CUTOFF) &&
>  	    pcie->hw_rev >=3D BRCM_PCIE_HW_REV_3_20) {
>  		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n"=
);
>  		ret =3D -ENODEV;

[Severity: High]
This is a pre-existing issue, but looking at the error path later in
brcm_pcie_probe(), is it safe to call brcm_pcie_remove() when
pci_host_probe() fails?

If pci_host_probe(bridge) fails (for example, due to a memory allocation
failure inside pci_alloc_bus()), the bridge's bus structure might be freed
or remain NULL.

brcm_pcie_probe() {
    ...
    ret =3D pci_host_probe(bridge);
    if (ret) {
        brcm_pcie_remove(pdev);
        return ret;
    }
}

brcm_pcie_remove() {
    ...
    pci_stop_root_bus(bridge->bus);
}

Could this pci_stop_root_bus() call dereference a dangling or NULL
bridge->bus pointer, causing a crash instead of a graceful failure? Should
this path jump to the fail label instead to clean up local resources?

[Severity: High]
This is also a pre-existing issue, but does brcm_pcie_probe() use
pcie->bridge_lock before it is initialized?

Early in brcm_pcie_probe(), brcm_pcie_bridge_sw_init_set(pcie, 0) is called.
If the controller config has the HAS_ERR_REPORT flag set, this acquires
pcie->bridge_lock:

brcm_pcie_bridge_sw_init_set() {
    if (BFLAG(pcie, HAS_ERR_REPORT))
        spin_lock_irqsave(&pcie->bridge_lock, flags);
}

However, spin_lock_init(&pcie->bridge_lock) is not called until the very end
of brcm_pcie_probe(), right before it returns success.

Can this lead to an uninitialized spinlock usage on platforms with
HAS_ERR_REPORT enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911233541.1650=
895-1-james.quinlan@broadcom.com?part=3D10
