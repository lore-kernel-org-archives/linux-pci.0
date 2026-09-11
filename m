Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A7B2DF156
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170432; cv=none; b=c3CCf+KNECo8kajtgKL/tTwS1V3nCQ3JZ/XERxbLvavA7vveyedWRIZdjXHuVOHFJHGOW5uPWKj+u45Zqf7VWEAlTzvMKywQIV8PutvGgPgbbb1/cCpuNGWbLmsJkwsPyqSWPV89A12VSExstiy++AIDljA8wfYF7AABsz2b/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170432; c=relaxed/simple;
	bh=3OqVF+4NdGyvfiYweK97/w6N/aWBptXCA7L/iUvFTmw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mn0KR9DAUhIA84hdJfAgBSkc64+MtBAF1/04drHYORE2kDkypQ3ghWPUlv52OlEwVNWaXutbOEr/i2c4Z+awSfCsdULH1qeoYtA5EXXbOc9HYIusivHgY9WG3sgD6gdN8QdjB4zo1dMHtSrAX8CQokr/3bq/EnN5AOpdSMAJWXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZJCCWQk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZJCCWQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08F21F00893;
	Fri, 11 Sep 2026 23:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789170423;
	bh=S17diILHabflzgfssyzmCWANvfnqchNSbUDqsXVdGVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZJCCWQkeitDZIU4aZswDTZ/pPLIg03GQNRsJ6KtggKnUmCF0LFo9N4YyRvoMn0Ge
	 +7XO8mpatg5MeewE8kr6MvKhqiIR4hycVMWltbRmwCV/UN7ts6/Yynq3DxwIxKk77Q
	 tlZVuSriD3qmODYzG5t+8+EsNk3HDE6zA4kTOEgsV6KIpwRZi5Hf1tXLxgoF5q1V50
	 u+fdmpkokI6RzcOBho5/tQ3CT5Xjv1K2D5xrOzTDlJTo1awJul/U830+BJdDh/JoJG
	 kyHPrJIaoI2zOgOuPMo01vV0fDVQ5NhqMlfP2/TUs6igreEcxAHhbi7LQDbBE48Ixt
	 lh8X3GUZSnOLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] PCI: brcmstb: Use flags u32 instead of bools
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Quinlan" <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911233541.1650895-3-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:47:03 +0000
Message-Id: <20260911234703.B08F21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The newly introduced BFLAG macro lacks outer parentheses around =
the bitwise AND expression, introducing a dangerous operator precedence pit=
fall.

Pre-existing issues:
- [High] Uninitialized spinlock `bridge_lock` is acquired during early prob=
e before being initialized.
--

commit c6e2c757989753d5008cfee8a289e1111796b0bf
Author: Jim Quinlan <james.quinlan@broadcom.com>

    PCI: brcmstb: Use flags u32 instead of bools

    This commit replaces separate boolean fields for SoC configurations wit=
h a
    single u32 bitvector. It introduces the BFLAG macro to provide a uniform
    way to assign and check these flags.

> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index 89aaa19d508a7..47862569937eb 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -286,16 +286,24 @@ struct inbound_win {
>   */
>  #define CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN		BIT(0)
> =20
> +/* FLAGS */
> +#define BFLAG(pcie, flag)			((pcie)->cfg->flags & CFG_FLG_ ## flag)

[Severity: Medium]
Will this macro evaluate correctly if used in a logical NOT expression like
!BFLAG(pcie, HAS_PHY)?

Without outer parentheses around the bitwise AND expression, an expression
like !BFLAG(...) expands to !(pcie)->cfg->flags & flag. This applies the
logical NOT before the bitwise AND, which could lead to incorrect evaluatio=
n.

Could outer parentheses be added to prevent operator precedence issues?

[ ... ]

> @@ -356,14 +364,14 @@ static int brcm_pcie_bridge_sw_init_set(struct brcm=
_pcie *pcie, u32 val)
>  	unsigned long flags;
>  	int ret;
> =20
> -	if (pcie->cfg->has_err_report)
> +	if (BFLAG(pcie, HAS_ERR_REPORT))
>  		spin_lock_irqsave(&pcie->bridge_lock, flags);

[Severity: High]
This is a pre-existing issue, but does this acquire an uninitialized spinlo=
ck
during early probe?

During device probe, brcm_pcie_probe() calls brcm_pcie_bridge_sw_init_set()
early in the sequence:

brcm_pcie_probe() {
    ...
    ret =3D brcm_pcie_bridge_sw_init_set(pcie, 0);
    if (ret)
        return dev_err_probe(&pdev->dev, ret,
                             "could not de-assert bridge reset\n");
    ...
}

If the SoC configuration has the HAS_ERR_REPORT flag set, this attempts to
acquire pcie->bridge_lock.

However, the spinlock isn't initialized until much later in probe:

[ ... ]

> @@ -2179,7 +2186,7 @@ static int brcm_pcie_probe(struct platform_device *=
pdev)
>  		return ret;
>  	}
> =20
> -	if (pcie->cfg->has_err_report) {
> +	if (BFLAG(pcie, HAS_ERR_REPORT)) {
>  		spin_lock_init(&pcie->bridge_lock);
>  		brcm_register_die_notifiers(pcie);
>  	}

As shown here at the end of brcm_pcie_probe(), spin_lock_init() happens
long after the first call to brcm_pcie_bridge_sw_init_set().

Could this cause lockdep splats or kernel crashes when PREEMPT_RT or lock
debugging is enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911233541.1650=
895-1-james.quinlan@broadcom.com?part=3D2
