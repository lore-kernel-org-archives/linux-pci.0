Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E5B5540AE
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929488; cv=none; b=pL0Q9uQ9/cqcqCBg/JbUc4HLyrHRrBB9DOYEO43IlqSLwfqRfIs7fZjnMf8JQ/4+Be62EwBHWCRgtOPaIUzEFx6ABYLVJqt9o5P80K/D+G7RBv0amQm32Szg6oz3J25j/BjV0BUE9IXf6QeUaHwDeCzjt6iOcWByIVHLxekHqA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929488; c=relaxed/simple;
	bh=VJ0KPVLyZkOA+J4DyefRzuYzQayUCNe80UL3+iG19Po=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gEOdMhypIxtlmYHqYV2TMR+OhgHyG/O7nRncJcD1Xf2ttjyOXP40GdpocGNF5vG7BdUUxZG8ID+geczEqWTJCj5OK4YxNdoAJeABD+YGGmt4/dDLR2vBCgclJHSskWSOT7kbo+38FzvsMPP1vWo9wlU9qShW8KC8b7QLaPSK/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMLVhjPx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMLVhjPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03701F000FF;
	Tue, 13 Oct 2026 22:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791929486;
	bh=4tbrLCXq4TjLHeNydsugIyb9yBq7x3BhXuQf2aPb0B4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IMLVhjPxb83y5uhXNtTIdWuj79keZ4tNbYO/iBAyYADg7ze1dutf7EKGG+6EEtxzV
	 8IDV9aHa/NRiwjArEAaHE3yY/EYCflo85dkOwX10mpoBlngXlZlAKXd1iw9P6LoFA1
	 FzJIByflE322BS6r4LT7tbr8LCXVamvqjPCSJ9l0PoayRG0P12vnPO1oe6YPYgpLOr
	 QVBiGdd4g58FuW14FfOF5yhDhg3vWUajap/6jeUJQaDN8ktnFABtap9EIiyb+sY9wQ
	 d3YKwp+Rib/Lo7xdz4oU727O2k9dr1isl1LdRSUD6hdratjeLjUiRWAtY2N0If+SBA
	 sN5otlae5+fDg==
Message-ID: <sashiko-outbox-170561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] PCI: Expose devm_pci_alloc_host_bridge_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261013220421.1588051-2-bhelgaas@google.com>
References: <20261013220421.1588051-1-bhelgaas@google.com>
 <20261013220421.1588051-2-bhelgaas@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:11:26 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing EXPORT_SYMBOL for devm_pci_alloc_host_bridge_release()
--

commit 3991d0ede1a56c908c8b226f72de68fc49a12993
Author: Bjorn Helgaas <helgaas@kernel.org>

PCI: Expose devm_pci_alloc_host_bridge_release()

This commit exposes devm_pci_alloc_host_bridge_release() so drivers can
avoid device tree parts by calling pci_alloc_host_bridge() directly and
adding the devm release function manually.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ea6e77ecfd3f5..b4f781f423a35 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -699,7 +699,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t =
priv)
>  }
>  EXPORT_SYMBOL(pci_alloc_host_bridge);
> =20
> -static void devm_pci_alloc_host_bridge_release(void *data)
> +void devm_pci_alloc_host_bridge_release(void *data)

[Severity: Low]
Does this function need an EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL()
declaration?

Because devm_pci_alloc_host_bridge_release() is defined in the built-in
PCI subsystem but lacks an export, it cannot be linked by external
modules.

Compiling a host controller driver utilizing this devres action
(like drivers/pci/controller/pcie-iproc-bcma.c) as a loadable kernel module
will result in a modpost linker error for an undefined symbol.

>  {
>  	pci_free_host_bridge(data);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013220421.1588=
051-1-bhelgaas@google.com?part=3D1
