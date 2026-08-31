Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77014446F4
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185524; cv=none; b=RPWPlMDjCkPA8uU3t/hf7WkFTGTU93OjelgVZsLQiwbAnQ8J+z4pgGRrKOZfiDcJ4/1/3LGDD4gE0vM5qGkNWW4sGFomtAa11NQ65lH2nHGiLYLbz70A7QU/DZ0kOYSBbcMiH0s3D20e2EMoXcedYstj3+9Wsr6i0pV75NjoXQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185524; c=relaxed/simple;
	bh=39WJUToiizjuGxZ+2pnbatEuwx+McVAuXnOcY5IUNoM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l9hVq/gEi8t4Aq/jbKRAkz0V4VqCCkP1gnapoXuUu8C8GLS2ZAjjODxgLLJB4gBCu6KElMlBLyyp0UrYnIS88/4xa+3VyrigX+G+Op7WsBCcOb5UNfAqk+LnIMqqzC0W8tLGBuK94K+BNjYZ9tS9WuN7BxtAncW+CLh61PNVKTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZmQM+UG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZmQM+UG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC04B1F000E9;
	Mon, 31 Aug 2026 14:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788185522;
	bh=Aw/PlZJM2mUmAp/qFsgL48YNrGgqXs4radrS+RTDqYk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kZmQM+UG1qsg4XS6m3YPOtL2vQUlHq2YUcBLbd2JIUW8bxLW29yqXbfBEqy4r2wB4
	 DJBAwytj8hrWztVeniAwCYEO9WjMehBR9aTopRZUUM5imFprUf8kw4QGkB3eHHZwqn
	 IdH+t1pIhNcP4x6BHg+PKD6iM5GT3KGCWZobSL34IQsK/ywqsSqmmF4Xm//4bYTKBx
	 1wsPzpz6nGmLaTWg9VEJIWNrMovM8bdtGVCotdTG7GpwL+Hv0sgYJWzvqFgYF2P7Yd
	 Gl2Ij1ArGnuZWWPv1aoIbBxeP5h4XoEkTV4utYKRFY9HrE9gAh9nBd+goNTWbrm7xS
	 n4VrgZHf6tGTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] PCI: intel-gw: Enable clock before PHY
 init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-63-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-63-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:12:01 +0000
Message-Id: <20260831141201.CC04B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The teardown sequence in `__intel_pcie_remove()` was not updated t=
o match the new initialization order, leading to `phy_exit()` being called =
while the core clock is disabled.
--

commit f996b74a9755733be971c866c8fb2dd5071a2fa4
Author: Florian Eckert <fe@dev.tdt.de>

PCI: intel-gw: Enable clock before PHY init

This commit reorders the initialization sequence to enable the DWC PCIe
core clock before calling phy_init() to ensure the correct boot sequence.
It also updates the error handling path to symmetrically reverse this
new order.

Link: https://patch.msgid.link/20260417-pcie-intel-gw-v5-4-0a2b933fe04f@dev=
.tdt.de

> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/con=
troller/dwc/pcie-intel-gw.c
> index c21906eced618..8b51eb30112d9 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c

[ ... ]

> @@ -323,11 +323,12 @@ static int intel_pcie_host_setup(struct intel_pcie =
*pcie)
> =20
>  	return 0;
> =20
> -app_init_err:
> +err:
> +	phy_exit(pcie->phy);
> +phy_err:
>  	clk_disable_unprepare(pcie->core_clk);
>  clk_err:
>  	intel_pcie_core_rst_assert(pcie);
> -	phy_exit(pcie->phy);
> =20
>  	return ret;
>  }

[Severity: High]
Since the error handling path was updated to symmetrically reverse the new
initialization order, does the teardown sequence in __intel_pcie_remove()
also need to be updated?

Looking at __intel_pcie_remove():

static void __intel_pcie_remove(struct intel_pcie *pcie)
{
	intel_pcie_core_irq_disable(pcie);
	intel_pcie_turn_off(pcie);
	clk_disable_unprepare(pcie->core_clk);
	intel_pcie_core_rst_assert(pcie);
	phy_exit(pcie->phy);
}

This calls phy_exit() after clk_disable_unprepare() and
intel_pcie_core_rst_assert(), which leaves the PHY being exited without its
required core clock.

Can this sequence lead to unclocked hardware accesses during driver unbind,
potentially triggering an asynchronous external abort or hard bus lockup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-63-sashal@kernel.org?part=3D1
