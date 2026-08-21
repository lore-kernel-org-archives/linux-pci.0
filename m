Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F03E3876DE
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316242; cv=none; b=HO6CEaZS3jkvQ1P40MVubtr+dZHBYukIDdJamlyF6aEkCkqBW5XTP0KaIummfULbtGFK/JrRv5zNtZPUhFJmGItas6FPJGZVbiWxQnivLcXeZ7Y/9/vWHKqAD2FqHf9gjETa727yrEa9LgeCb9UydTQLwKZg1tCvl0HI/8g3bSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316242; c=relaxed/simple;
	bh=Bqevv0sjF1NGXiZZ/7cayB3e7MVd3pnXUrzLBOblPtA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RbXr+dzx24oCosA12hNLNAvnFcFuUU5w95LtsRebjbuNkmRpQFrRpI6SBGLsOMNaL1ep658GAYJzqwp0LhSYzWJ5LSAe7Zf5/kA3V2s8znqfd3ydGJxXCchFVi3bCCBAuYA1t19pwyN4XjhHr8QSmaJV2rbum/VRDtG04l69BqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhNBMySA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhNBMySA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EEC1F000E9;
	Fri, 21 Aug 2026 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787316241;
	bh=Nyi45l14GmDvXhlCwfVbjUNMFD+kRleiWvhsgfGNngI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LhNBMySApQXMOP8F+lfikIWUUUURxKuIqUAbcep8LyTuMNnypF9X6+hlyAh2iRncu
	 DQHmx+4PykFL5IVmKUO6Dpp11BUoIEZdcbn1X+/Laup/gPU1t4qPdoZL44XMztDfiD
	 iVJMZut/YKDkfh/kaB/YS25Ex2zcmxyyypXpetoarBrI6U4N8Q4suzqqma9llXSZBJ
	 tYybrNBuGfSOD0+24YzOcOVaQS31jrIKIUHofLSCNULW/0yruWegJ/uahAii+64ysK
	 zGVT1+QyCW9s5LTozGMZZoLi9fl0NLijyR4k63uyFvssjogNY8GtFhgpDC17U1J1Uf
	 ZAPGnn9QHWqsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] PCI: dwc: rcar-gen4: Use .post_deinit to handle
 dw_pcie_ep_init() failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260821122808.238248-2-marek.vasut+renesas@mailbox.org>
References: <20260821122808.238248-1-marek.vasut+renesas@mailbox.org>
 <20260821122808.238248-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 12:44:00 +0000
Message-Id: <20260821124401.14EEC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing early return on error path leads to invalid EPC initializa=
tion notification and potential unclocked access panic.
--

--- Patch [2]: [PATCH v3 2/2] PCI: dwc: rcar-gen4: Use .post_deinit to hand=
le dw_pcie_ep_init() failures ---
commit 983f248d176d3915fd934d946c124b82fe3530d1
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: dwc: rcar-gen4: Use .post_deinit to handle dw_pcie_ep_init() failures

This commit implements the .post_deinit() callback in the R-Car Gen4
endpoint ops to handle reset assertion and clock stopping upon failure.
It drops duplicate deinitialization calls in the failure paths to prevent
stopping the clock or asserting resets twice. It also initializes
PCIEDMAINTSTSEN early to ensure EDMA bits are clear on failure.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

[ ... ]

> @@ -576,13 +576,10 @@ static int rcar_gen4_add_dw_pcie_ep(struct rcar_gen=
4_pcie *rcar)
> =20
>  	ret =3D dw_pcie_ep_init_registers(ep);
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
>  		dw_pcie_ep_deinit(ep);
> -		rcar_gen4_pcie_ep_deinit(rcar);
>  	}
> =20
>  	pci_epc_init_notify(ep->epc);

[Severity: High]
This isn't a bug introduced by this patch, but should there be an explicit
return statement here?

If dw_pcie_ep_init_registers() fails, execution falls through and
unconditionally calls pci_epc_init_notify(ep->epc).

Could this incorrectly set epc->init_complete =3D true and invoke the
initialization callbacks of any bound EPF drivers on a controller where
the memory is freed, resets are asserted, and clocks are stopped?

If an EPF driver binds and accesses the controller in this deinitialized
state, could it trigger a synchronous external abort (unclocked access) or a
use-after-free?

> =20
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821122808.2382=
48-1-marek.vasut+renesas@mailbox.org?part=3D2
