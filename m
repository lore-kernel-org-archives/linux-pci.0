Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CF6331A57
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198199; cv=none; b=BC01Ac1bNKJZro88vbJiU5DFXV9BjWCzHFfw2pao8zN0uZ2zOgBzvSMCTtXpL1VLtPEXpfrr4qVwlrq/SxTeEl87olRXDF3JkCQuduxOTgVVz+XmQnTc+3MA65GHWh9jtSAEU18EvR89/HRLOk2Uv4hhDaS+RaRS8/rxYc4TNJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198199; c=relaxed/simple;
	bh=CKs7y/n9X1xcgSKNUKGdt/PXbdlLQ+jO7vTjFtqkw1s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=daHJXVXtWzeE4BJmT7FYfg6bQ1nzd91C69/ouZdWT7GucQ2DnGl2OeX7fxjZ5yC6DQaAUZId5DxeS0yriLbJwDbwKR2kq4ndb7CagEOugXSDX2r5BsRVPayT+q1QwbomhqprPc1pnCnh3zPPssNwWy4y0pSZGvKJRTTcndSBGsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTV0BoaR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTV0BoaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3DD1F000E9;
	Thu, 16 Jul 2026 10:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784198198;
	bh=9nDO5og5A1meKbNqDpXQs4Kqr0VAIeNFJIMG87BelSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VTV0BoaRyeTNsKLG6n7qOR6cbdkb9S7jxwNH+VwGgkP1yS2JxPJ45I2G23S/CtvaF
	 XO9x4Tw4FBFjczrfk07OaCpb2ePYRNx9j9WwuZOKauzn3a8UgDlrlXqw3P0y3puLln
	 BF7RrTok+woqQOo6tu6viGbdV7Q6CeO+nAkpn3ub+C4B9UuYDM2cIyPOvX9GDrlSdE
	 sK4/1+CKPinTxqIVB901selJ4+fhb7E9IETm8yOmYKiWHstmIcT9kEOSpJZQyZsMOg
	 dL6IHHEf9IVlLksJjF11hYkcyfjRygZptLXQwh4bsHCl7ysSeQn13fyTQIlVCrBldm
	 NuYJ/JIu8Owcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: starfive: Fix resource leaks on error paths in
 host_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ali Tariq" <alitariq45892@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260716102053.185276-1-alitariq45892@gmail.com>
References: <20260714113029.326207-1-alitariq45892@gmail.com>
 <20260716102053.185276-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 10:36:37 +0000
Message-Id: <20260716103638.0A3DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] pm_runtime_get_sync() return value is not checked in probe, which =
can lead to a system crash due to hardware access failures.
--

--- Patch [1]: [PATCH v3] PCI: starfive: Fix resource leaks on error paths =
in host_init() ---
commit 312c978532200464dd10047fcee7a0fbb43cf2dc
Author: Ali Tariq <alitariq45892@gmail.com>

PCI: starfive: Fix resource leaks on error paths in host_init()

This commit addresses resource unwind paths in starfive_pcie_host_init().
It ensures the PHY is properly disabled if clock/reset initialization fails,
and that clocks, resets, and the PHY are correctly deactivated if the
regulator fails to enable.

> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/co=
ntroller/plda/pcie-starfive.c
> index 298036c3e7f94..628f8c8d67471 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
issue nearby in starfive_pcie_probe() regarding pm_runtime_get_sync():

drivers/pci/controller/plda/pcie-starfive.c:starfive_pcie_probe() {
	...
	pm_runtime_enable(&pdev->dev);
	pm_runtime_get_sync(&pdev->dev);

	plda->host_ops =3D &sf_host_ops;
	...
	ret =3D plda_pcie_host_init(&pcie->plda, &starfive_pcie_ops,
				  &stf_pcie_event);
	...
}

Is it safe to ignore the return value of pm_runtime_get_sync() here?

If it fails to enable the device power domain or clock, it will return an=20
error, but the function proceeds to call plda_pcie_host_init() which will=20
access memory-mapped hardware registers.

Accessing unpowered hardware registers can trigger an asynchronous external=
=20
abort or synchronous bus fault on RISC-V systems, causing a kernel crash.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716102053.1852=
76-1-alitariq45892@gmail.com?part=3D1
