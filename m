Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794622395;
	b=Nk86+5nOd42mynYAaQ/rAC+EOmrpAgI+A/DvfbwaLgqr0U0sZa0l70JXaHmdwDlqujyV
	 E1bdqe95iM2PgVU8eBG12PytN+0BbLdG+IknTMgnv1C9zn/+GNxOF2+XPt1hrDcCyyThF
	 rwVc4UDlqd89rvFWUCQXyQjgBS29bLwdKBC3Dzo+xz3jtqe8+XXepnaI3gJ0OZuA0elJL
	 YiNpTjq6sMcBMyzJOkLXpiJmxJLewrfe2OHWvAOBJKA2eMAnWzA4iJ4OPMsRrqSwM+iap
	 bCve+Ir8y25V7POvjDfzOKfcj/d8gY9SWQy7AzJ/IVVcgk365O/xD1K4waqNt4Wc62Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794622395;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CQMxZfqsFf75Vn5A1IqsrJ+ZSPsszUSfkVllroejaAw=;
	b=EQgvGV8ND9mmugCbROkVZVBboTHPLbwfnds+q2WO0Cd2cJIcU7D2ewwC+pU9dLh8ceuP
	 vCxpuLAV3dcPZr0Y9//Gd4HZTVTWx5u1FvXDEOZfVis7KXjMUM29jVg6pGlJ7Zr3QRli0
	 izyA5fvfBsqxTD/rPScRn5FCxV/82dDXu5zHM/6S+znFMuM3nKJBuxzRX5dXyGojQ5+P+
	 Mxcjq3knP8XOLXMVSaH/Fn0tuvgM+/fgsExE7sKTFYB4W1A7NtnTHA1vnagnB3q4NwpcT
	 wXcJ4VNwFXSKyeU+fiTzv/RHWwt6f6RfbuU5F/r9pmQlC8Vd/y6555VLwKr5oT84nXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETjLCxHq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC83606A336
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETjLCxHq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FCB1F000C4;
	Sat, 14 Nov 2026 02:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794622395;
	bh=CQMxZfqsFf75Vn5A1IqsrJ+ZSPsszUSfkVllroejaAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ETjLCxHqg7n/xe0u6FbD2o4RyhBcxlKQtl+TnMZIia+Kavaf51cC5gVKzlyqQGgv8
	 qo/unHNFQqZAFVnTe+jB1hux7VUZKODaKvEl9gKxX8mwHCw849hcSScXvzH7EI+jmG
	 f5BCU/4l+Cn452ygDZql0+ZTlJwI2IZp5HBibO7584tL3N3L0A56dwy3ZB6KT85V+h
	 SEol2kETZJ/wJzEYjY0xRqhGOnMhQDvfTk7Ftd0Is7DNdPONGe4VnxgdcK5fIPAbvr
	 lIJIZfKv6vNnT6ZssHqHwAzsS8p/XH/X67bvjJ82VNklvbzTnZDnt8EKK4IEbGUnVk
	 D6kvg7DJipYPQ==
Message-ID: <sashiko-outbox-214045@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/4] PCI: dwc: Force L2 link entry on shutdown/reboot
 without D3cold check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261114-shutdown-v9-2-5430c9f242ed@oss.qualcomm.com>
References: <20261114-shutdown-v9-0-5430c9f242ed@oss.qualcomm.com>
 <20261114-shutdown-v9-2-5430c9f242ed@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 02:13:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] PCI: dwc: unupdated dw_pcie_suspend_noirq() call in
  rockchip_pcie_suspend()
--

commit bf9695dc1baada77eb514fb928ceb40aa4b4b9f7
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: dwc: Force L2 link entry on shutdown/reboot without D3cold check

This commit adds a force parameter to dw_pcie_suspend_noirq() so callers
can force L2 link entry regardless of whether downstream endpoints support
D3cold, and updates callers across the DesignWare controller drivers.

> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 0ece9c4332297..f774fc6d2a248 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -902,7 +902,7 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(st=
ruct dw_pcie *pci)
>  const char *dw_pcie_ltssm_status_string(enum dw_pcie_ltssm ltssm);
> =20
>  #ifdef CONFIG_PCIE_DW_HOST
> -int dw_pcie_suspend_noirq(struct dw_pcie *pci);
> +int dw_pcie_suspend_noirq(struct dw_pcie *pci, bool force);
>  int dw_pcie_resume_noirq(struct dw_pcie *pci);
>  void dw_handle_msi_irq(struct dw_pcie_rp *pp);
>  void dw_pcie_msi_init(struct dw_pcie_rp *pp);
> @@ -915,7 +915,7 @@ int dw_pcie_allocate_msi_domains(struct dw_pcie_rp *p=
p);
>  void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int=
 devfn,
>  				       int where);
>  #else
> -static inline int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> +static inline int dw_pcie_suspend_noirq(struct dw_pcie *pci, bool force)
>  {
>  	return 0;
>  }

[Severity: High]
Does rockchip_pcie_suspend() in drivers/pci/controller/dwc/pcie-dw-rockchip=
.c
also need to be updated to pass the new force parameter?

drivers/pci/controller/dwc/pcie-dw-rockchip.c:rockchip_pcie_suspend() {
    ...
	if (rockchip->data->mode =3D=3D DW_PCIE_EP_TYPE)
		return 0;

	ret =3D dw_pcie_suspend_noirq(pci);
    ...
}

Leaving that caller with a single argument breaks the build when
pcie-dw-rockchip.c is compiled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-shutdown-v=
9-0-5430c9f242ed@oss.qualcomm.com?part=3D2
