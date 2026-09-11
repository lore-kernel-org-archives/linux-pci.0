Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5AB475354
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133655; cv=none; b=ZcFpGF2Gb5tMIpbJ9/M/NPiD0GcNh4kxHuyTjrvi65dJKW1KPGP8uX5sh4SAC/CHjfOdzDanDc24j1D84AuGmFZwHMtanUJu13y2Gajz4nyeTT9ivbmM9YCwoZl1dLsxSTaECiGA6q66EpIVWbBURm0IanEypG/lfRU7wvN5fcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133655; c=relaxed/simple;
	bh=WNkbjzo+zMKJmsfhER0kpg15VoV8rtelxt33beomdYk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SIpxFcIEV4r1VEtvFmB+I7Xc5RzWoB/jQj/oG/xDoyDYlR1q9MjdBnrJsyIUYRpZYJG2z3wdP/QYfvfdo2/CjuxQoWitW1dydB773Lpod3e2sA3zoLEKmU0cRdibejFhoTpwGW3rMyG994Fw/AWYANiZZ9YGGJekmxqNAaB9OQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmghyJo0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmghyJo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4521F00893;
	Fri, 11 Sep 2026 13:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789133651;
	bh=AXJnD8SqAd+lgdllVDPl41ewp9+1MSyYX93crRy87Tg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PmghyJo0eW0cJTaF84qlDFeARkAZTw8y8k2mtd2MJnMgc5TqB6pbZOVQbbzNReMO5
	 CNTQQVQ2PTtlVX5QGpY7rO/XSSAmsM1ozVv+FVga2yMJUMe7G8tTYXehHrX16tRJ+d
	 llKaSiO4xx+vvAXr6fA9bl2faktVS1ND40pd8+77wMSn54xOKsB5qC1MTtsNEqFQnW
	 CTH9w1lNl/lPNmQccvrz8jmJOz/8tZAG3Vs0DDfgdsZbubHqOxgITzFRW7kRrq1u51
	 gy/G3bARp0TvmHveRcEGRMB1OQIDcvO48squqxhqygJJDFH82JcDpweUl3sU+kPVpx
	 Biw2h29OJ0hOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] PCI: dwc: Remove redundant MPS configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <20260911132145.211380-3-18255117159@163.com>
References: <20260911132145.211380-1-18255117159@163.com>
 <20260911132145.211380-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 13:34:10 +0000
Message-Id: <20260911133411.3B4521F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Unused macros PCIE_CAP_MAX_PAYLOAD_SIZE and MAX_PAYLOAD_SIZE left b=
ehind after removing the MPS configuration function.
- [Low] Misleading function name and warning message for MRRS calculation a=
fter removing MPS configuration.

Pre-existing issues:
- [High] 32-bit read-modify-write of PCI_EXP_DEVCTL inadvertently clears W1=
C error bits in PCI_EXP_DEVSTA.
--

commit 3ff79063d97cb0f265efaab65bab69ff2c512a3d
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: Remove redundant MPS configuration

The Meson PCIe controller driver manually configures maximum payload
size (MPS) through meson_set_max_payload, duplicating functionality now
centralized in the PCI core.  Deprecating redundant code simplifies the
driver and aligns it with the consolidated MPS management strategy,
improving long-term maintainability.

> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/control=
ler/dwc/pci-meson.c
> index 8559d132dcde8..8c176f78953e9 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -273,22 +273,6 @@ static int meson_size_to_payload(struct meson_pcie *=
mp, int size)
>  	return fls(size) - 8;
>  }

[Severity: Low]
With the removal of the payload configuration function, this helper is now
exclusively called by meson_set_max_rd_req_size() to calculate the Max Read
Request Size (MRRS).

Does this function name and its internal log message:

	dev_warn(dev, "payload size %d, set to default 256\n", size);

need to be updated to reflect that it is calculating MRRS? Leaving it as-is
might cause confusion for future maintainers.

> =20
> -static void meson_set_max_payload(struct meson_pcie *mp, int size)
> -{
> -	struct dw_pcie *pci =3D &mp->pci;
> -	u32 val;
> -	u16 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	int max_payload_size =3D meson_size_to_payload(mp, size);
> -
> -	val =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> -	val &=3D ~PCI_EXP_DEVCTL_PAYLOAD;
> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
> -
> -	val =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> -	val |=3D PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size);

[Severity: Low]
Should the definition of PCIE_CAP_MAX_PAYLOAD_SIZE be removed as well? Since
it is no longer used after removing this function, it appears to be dead
code now.

> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
> -}
> -
>  static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
>  {
>  	struct dw_pcie *pci =3D &mp->pci;

[Severity: High]
This is a pre-existing issue, but does meson_set_max_rd_req_size()
inadvertently clear W1C error bits in PCI_EXP_DEVSTA?

This function performs a 32-bit read-modify-write on PCI_EXP_DEVCTL:

	val =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
	val &=3D ~PCI_EXP_DEVCTL_READRQ;
	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);

Because this 32-bit access covers both the 16-bit PCI_EXP_DEVCTL and the
adjacent 16-bit PCI_EXP_DEVSTA, it fetches both. PCI_EXP_DEVSTA contains
multiple Write-1-to-Clear (W1C) error flags. Writing the entire 32-bit value
back means any W1C bit in DEVSTA read as '1' is written as '1', inadvertent=
ly
clearing the error status and masking hardware faults.

Should this be updated to use dw_pcie_readw_dbi() and dw_pcie_writew_dbi()
instead?

[ ... ]

> @@ -363,7 +347,6 @@ static int meson_pcie_host_init(struct dw_pcie_rp *pp)
> =20
>  	pp->bridge->ops =3D &meson_pci_ops;
> =20
> -	meson_set_max_payload(mp, MAX_PAYLOAD_SIZE);

[Severity: Low]
Should the MAX_PAYLOAD_SIZE macro be removed as well? Since its usage is
removed here, leaving the macro behind leaves dead code.

>  	meson_set_max_rd_req_size(mp, MAX_READ_REQ_SIZE);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911132145.2113=
80-1-18255117159@163.com?part=3D2
