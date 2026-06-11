Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A962426698
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198567; cv=none; b=oEWtZ+PU939f9VpPZ3dt487Qg7A46Adp/ChHke6pcOiiyhqg/78FVZCePfH4Le4fQGENpHbV+DrHqlCOe0JrZmQ1Tm/J+gCzNqbJmda/eq4JcHX3BLoOINEcoOsi6Np4fOBJyU4bAen3v2PD4Slv1mej2zeGQqICn/wAUPdHN6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198567; c=relaxed/simple;
	bh=r0QYddBf6F7MetxGlL7RjY3uwhfDX7GtrDKDbjUb2rc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O7CUmrLl6kldFxa/JfxAyAoF1wQHf7uMJN0hoIEkHeGTFGft4v/gZ6MbHX2Gc6O2rKGjUjSGKPDg136hWTZgTU7nL3i9lFHUbTJF1T/qwtQ9ypyWtsKfWmUZRuLQ6L32NG7xKFbGYn07/FZjoQyNKK3XrdIZXxuCs7kzll3ZkNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEU02LFL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEU02LFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6D01F00893;
	Thu, 11 Jun 2026 17:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781198561;
	bh=XoJr99D+8NJskcurXIYGuubDLuC/NQuldiRI9Nqu3fs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SEU02LFLyjP+gOLoUBnqTOcDwr1yu9NBICNN64T9Uy4ZXVMoV1AuieogOnIb0fx9v
	 8PrTCoPBdUCOuGxjlqfDZyhU2QR/Iv5gbqzQs0y+uWhp2kXGC/mhBP/hOmsjyV2CXR
	 l/jhtqGo3lTrQ2pJ6UnOmzXO1583Bb0sesiklMoxstlsOGPMM0to6TmYUZnFbmh5Ff
	 HlJKf8vlQYU21hzWF/ppgUfKxDCbqteerv8cqlCXLjuXhueSMQrphsWtXjY0/KH0fY
	 1fgajZCmG7lvQPNb8U75kwkwUPGSuGwjZk7eWlA9iARnQSLRXHKFvJIyBLLnNo7n/s
	 S+U0AJ7WGW3dA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/3] PCI: cadence: Add HPA IP debugfs for LTSSM
 status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260611165933.20071-3-18255117159@163.com>
References: <20260611165933.20071-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:22:40 +0000
Message-Id: <20260611172240.CC6D01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Building PCIE_CADENCE_HOST as built-in and PCIE_CADENCE_DEBUGFS as =
a module results in a linkage error.
--

commit 20cc8aa0f1ba6b094082684b8473490c278a0462
Author: Hans Zhang <18255117159@163.com>

PCI: cadence: Add HPA IP debugfs for LTSSM status

This commit adds debugfs support for HPA-based Cadence PCIe controllers.
It creates a new ltssm_status file under debugfs to allow users to read
the current LTSSM state as a string and raw value.

> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/control=
ler/cadence/Kconfig
> index 9e651d5459735..cb010bc97aad3 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
>  config PCIE_CADENCE
>  	tristate
> =20
> +config PCIE_CADENCE_DEBUGFS
> +	tristate "Cadence PCIe debugfs entries"
> +	depends on DEBUG_FS
> +	depends on PCIE_CADENCE_HOST || PCIE_CADENCE_EP

[ ... ]

> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/=
controller/cadence/pcie-cadence.h
> index 9a464cbaf073d..8de2924057659 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h

[ ... ]

> @@ -535,4 +676,16 @@ bool cdns_pcie_hpa_link_up(struct cdns_pcie *pcie);
> =20
>  extern const struct dev_pm_ops cdns_pcie_pm_ops;
> =20
> +#if IS_ENABLED(CONFIG_PCIE_CADENCE_DEBUGFS)
> +void cdns_pcie_debugfs_deinit(struct cdns_pcie *pci);
> +void cdns_pcie_debugfs_init(struct cdns_pcie *pci);
> +#else
> +static inline void cdns_pcie_debugfs_deinit(struct cdns_pcie *pci)
> +{
> +}
> +static inline void cdns_pcie_debugfs_init(struct cdns_pcie *pci)
> +{
> +}
> +#endif

[Severity: Low]
Does this cause a linkage error if CONFIG_PCIE_CADENCE_HOST is built-in (=
=3Dy)
and CONFIG_PCIE_CADENCE_DEBUGFS is built as a module (=3Dm)?

When configured this way, IS_ENABLED(CONFIG_PCIE_CADENCE_DEBUGFS) evaluates
to 1, so the preprocessor does not provide the empty inline stubs. Then,
when the built-in host code calls cdns_pcie_debugfs_init(), it results in
an undefined reference at vmlinux link time because the debugfs code is in
a separate module.

Would using IS_REACHABLE() instead of IS_ENABLED(), or restricting the
tristate dependencies in Kconfig, prevent this build failure?

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/dri=
vers/pci/controller/cadence/pcie-cadence-host-hpa.c
> index 0f540bed58e88..89f1d75c2c38d 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c

[ ... ]

> @@ -360,7 +373,13 @@ int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
>  	if (!bridge->ops)
>  		bridge->ops =3D &cdns_pcie_hpa_host_ops;
> =20
> -	return pci_host_probe(bridge);
> +	ret =3D pci_host_probe(bridge);
> +	if (ret)
> +		return ret;
> +
> +	cdns_pcie_debugfs_init(pcie);
> +
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611165933.2007=
1-1-18255117159@163.com?part=3D2
