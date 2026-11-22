Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795317312;
	b=ujYTD0veAbRPh/6y4ZyAjiT5Jh9sYjyRkTxX0hKywRbgfsdTvMCBYMTXTCKR0/X1Pi0T
	 UrhicDDcIRAG6nZ6jQ1RB5smlVL4pYGrDFDJPbRwKPYfmToZtHQ+g8adL7mBFlyDEPCov
	 +8IpWH24s7wlS8kBA0WYHm0PeO1XycDOr/PGw0p5KnYL1cRGitIXceTAyKG7v1fFRzZpv
	 F3NBsyQk7dUGl1pLjvW1dw5AOTMBt/+/oOZYwBa9tcvXYmqHvHBPWeaUG+T6zXNgiAs4v
	 g914fN0kCu+OCfBPIVOFpXn/DfnuHkBFdDd+MdrdtRhQSFUI+fAz1zr6TcKMHGBDv+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795317312;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gC2L8A/xX6AMbsjCXTmvRJXjfVShUg85VKkmaW4euas=;
	b=238XzE8Y8w4PM9M0sx5W23WC6I2x78qzZOGGEbj8n+HyL8h1wMf/clMBy60KrN5sqzu0
	 HKqkGSKoRMnTHpPr4Z7b/LgEqeitowgsgwdykkMvoQZUNI0ShqUSdkEh3314u6rcoedBC
	 8F6+Cmkk54BBwQPnhnSoyrzSCPevB/uPQRYOn2hePOFe/fwqzGi/2d3w37n8tRmlHf6XX
	 DCIRTW9qYnRkKj8qSNBU6ePxgWIlIyCKetgEWmMjOWrgHXNQuWjJB0Vik3qpjgMG+7IMT
	 P1wZpPA1TpQDtR2SpSwirgC/mrZ5pY4Xi1BdSTVc3VykgUDuLDXEamgOZzoNx2AVjRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GuuF/54s";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7598606A32A;
	Sun, 22 Nov 2026 03:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuuF/54s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058D91F000C0;
	Sun, 22 Nov 2026 03:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795317312;
	bh=gC2L8A/xX6AMbsjCXTmvRJXjfVShUg85VKkmaW4euas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GuuF/54s0kjrcqBexBtZbaIRAlmAG0o1usvLTpJN8exRtIrT0h8GGKI6tJvTSIVoE
	 83m9p+TMo+7e01SE1/bxNbjqgQ9AWg/NDtDo686M36GKCmxs6GMDpjkvq33FFyFp2b
	 n8CjSICtqYHwoJkyJsO7NThJDOFJiXTRt33ivvKePWd1PHvvh3GRVkQy+wtKEI1T5n
	 qBam93854nXy+me6u0FuTUVym+SKfeCUu1HDSuE4R+nfcTIELUZCsCtcPk1Px9mWUa
	 RINvG4SPEyG3GWY9fmpsFpkPsn5x2e7CAgx7qQKMhqW64/B5hh9eoD8lodbEMcEmXR
	 rleu1HboZxK6Q==
Message-ID: <sashiko-outbox-227666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] PCI: epf-mhi: Add MSI-X support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-phy@lists.infradead.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261122-nord_ep-v1-3-6d8839ffa9aa@oss.qualcomm.com>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
 <20261122-nord_ep-v1-3-6d8839ffa9aa@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 03:15:11 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] PCI: epf-mhi: msix_bar and epf_bar collide on BAR_0 in
  pci_epf_mhi_epc_init()
- [Medium] PCI: epf-mhi: stale msix_phys retained across unbind in
  pci_epf_mhi_bind()
- [Medium] PCI: epf-mhi: unguarded pci_epc_get_msix() in
  pci_epf_mhi_raise_irq()
--

commit ff5df916c7bb4879ef75224bb4a16f16be1ead17
Author: Anvita T <anvita.t@oss.qualcomm.com>

PCI: epf-mhi: Add MSI-X support

This commit adds MSI-X support to the MHI PCI endpoint function driver by
configuring BAR_0 from an optional "msix" platform memory resource and
selecting PCI_IRQ_MSIX when MSI-X is enabled.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/e=
ndpoint/functions/pci-epf-mhi.c
> index 52cfffcfd5ca0..a8765beffe060 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
[ ... ]
> @@ -230,12 +232,16 @@ static void pci_epf_mhi_raise_irq(struct mhi_ep_cnt=
rl *mhi_cntrl, u32 vector)
>  	struct pci_epf_mhi *epf_mhi =3D to_epf_mhi(mhi_cntrl);
>  	struct pci_epf *epf =3D epf_mhi->epf;
>  	struct pci_epc *epc =3D epf->epc;
> +	unsigned int type =3D PCI_IRQ_MSI;
> +
> +	if (pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no) > 0)
> +		type =3D PCI_IRQ_MSIX;
> =20
>  	/*
>  	 * MHI supplies 0 based MSI vectors but the API expects the vector
>  	 * number to start from 1, so we need to increment the vector by 1.
>  	 */
> -	pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no, PCI_IRQ_MSI,
> +	pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no, type,
>  			  vector + 1);
>  }

[Severity: Medium]
Should pci_epf_mhi_raise_irq() check epf_mhi->epc_features->msix_capable
before calling pci_epc_get_msix()?

Without that check, every MHI interrupt acquires epc->lock an extra time
(contending with pci_epc_map_addr() and pci_epc_unmap_addr() in the data
path) and calls epc->ops->get_msix(), which on DesignWare controllers
walks ep->func_list and reads PCI_MSIX_FLAGS over DBI MMIO even when
msix_capable is false.

> @@ -714,11 +720,40 @@ static int pci_epf_mhi_epc_init(struct pci_epf *epf)
>  {
>  	struct pci_epf_mhi *epf_mhi =3D epf_get_drvdata(epf);
>  	const struct pci_epf_mhi_ep_info *info =3D epf_mhi->info;
> +	struct pci_epf_bar *msix_bar =3D &epf->bar[BAR_0];
>  	struct pci_epf_bar *epf_bar =3D &epf->bar[info->bar_num];
>  	struct pci_epc *epc =3D epf->epc;
>  	struct device *dev =3D &epf->dev;
>  	int ret;
> =20
> +	epf_mhi->epc_features =3D pci_epc_get_features(epc, epf->func_no, epf->=
vfunc_no);
> +	if (!epf_mhi->epc_features)
> +		return -ENODATA;
> +
> +	if (epf_mhi->epc_features->msix_capable) {
> +		if (!epf_mhi->msix_phys) {
> +			dev_err(dev, "MSI-X BAR address not configured in DT\n");
> +			return -EINVAL;
> +		}
> +
> +		msix_bar->phys_addr =3D epf_mhi->msix_phys;
> +		msix_bar->size =3D epf_mhi->msix_size;
> +		msix_bar->barno =3D BAR_0;
> +		msix_bar->flags =3D info->epf_flags;
> +		ret =3D pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, msix_bar);
> +		if (ret) {
> +			dev_err(dev, "Failed to set MSI-X BAR: %d\n", ret);
> +			return ret;
> +		}
> +
> +		ret =3D pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
> +				       info->msi_count, BAR_0, 0);
> +		if (ret) {
> +			dev_err(dev, "Failed to set MSI-X configuration: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	epf_bar->phys_addr =3D epf_mhi->mmio_phys;
>  	epf_bar->size =3D epf_mhi->mmio_size;
>  	epf_bar->barno =3D info->bar_num;

[Severity: High]
Does msix_bar collide with epf_bar on BAR_0 when info->bar_num is BAR_0?

All existing pci_epf_mhi_ep_info configurations (sdx55_info, sm8450_info,
and sa8775p_info) set .bar_num =3D BAR_0.  When bound to an MSI-X capable
controller, msix_bar and epf_bar point to the same epf->bar[BAR_0] entry:
pci_epf_mhi_epc_init() sets BAR_0 for MSI-X and points the MSI-X table at
BAR_0, then overwrites epf->bar[BAR_0] in place with mmio_phys and
mmio_size and calls pci_epc_set_bar() on BAR_0 a second time.

Because epf->bar[BAR_0] is mutated in place before the second call,
dw_pcie_ep_set_bar() compares the overwritten size against itself, tears
down the MSI-X inbound iATU mapping on BAR_0, skips updating the BAR mask
register (leaving BAR_0 sized to msix_size), and remaps BAR_0 to
mmio_phys while PCI_MSIX_TABLE still points at BAR_0.  In addition,
pci_epf_mhi_epc_deinit() and pci_epf_mhi_unbind() call
pci_epc_clear_bar() twice on &epf->bar[BAR_0].

[ ... ]
> @@ -880,6 +914,13 @@ static int pci_epf_mhi_bind(struct pci_epf *epf)
>  	if (!epf_mhi->mmio)
>  		return -ENOMEM;
> =20
> +	/* MSI-X BAR address is optional; only present on EPCs that support MSI=
-X */
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "msix");
> +	if (res) {
> +		epf_mhi->msix_phys =3D res->start;
> +		epf_mhi->msix_size =3D resource_size(res);
> +	}
> +
>  	ret =3D platform_get_irq_byname(pdev, "doorbell");
>  	if (ret < 0) {
>  		iounmap(epf_mhi->mmio);

[Severity: Medium]
Can epf_mhi->msix_phys and epf_mhi->msix_size retain stale values across
an unbind and rebind?

struct pci_epf_mhi is allocated in pci_epf_mhi_probe() and reused across
binds, and neither pci_epf_mhi_unbind() nor the !res path here clears
msix_phys or msix_size.  If the function is unbound from an EPC with an
"msix" resource and rebound to an MSI-X capable EPC where "msix" is
missing, pci_epf_mhi_epc_init() will see the previous controller's
non-zero msix_phys and program BAR_0 with the stale physical address.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-nord_ep-v1=
-0-6d8839ffa9aa@oss.qualcomm.com?part=3D3
