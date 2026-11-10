Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300614;
	b=FLCq+rQO7IMRd1gRscN8i/5pnZ17q5qkDjy7a7bvej+G7kM45gBpWbJ2FAHM1jrEVdmO
	 zkqYCd3p/mqVRprHzRyVQnSwigen1tpOyLSnaINfPQ/V7Y5Gog9Ngo0SBrcBjM3hwTbw2
	 cxQ7KOA4bSm/VSr7XOnpDKJ6Ci/189Rhfs8X3E0ZvfQODENuftX2Ln2qiI4TbuTJbYoZs
	 KlIDvR7E4GvrOfSR3PJrP8PsvHEecp+71VJW46qH9o1qJsBevaR7g+n6fz8w1mrP0SI1J
	 iuA0Q5JfsTTNeYkORx9GwpDzHXNdAkBJ5Nx9xPfPoqDm0DUiutuWle2HHKi3H2PBhcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300614;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=26zipfpBS1u5Nu9qSXM7UeBDEHx6TRH3cfFvihN2SS0=;
	b=b2lwdcOmLxrLuiOiIyunss8oIdVEkl3NlhsU6Z0cGG/nojRqST1agRqagoOZRGCwrA1o
	 ctjyE42nN7KWg6QSUEXpUG0PmknS/quREyID6GBPzsMmm7soTRHu/1LHVY/EHfnJd0Qq3
	 9yrd2HiCQe/dr2GSuT5awqApD7TTlKm9t5X0g6urGjVJPUDJ7PqDbAqwkxENaoDZheIir
	 S6iHt0VgLZsJXyNevg4NRlt6Du6gCCotp6KcZGUgnPM5i0VUO2PPH08KU8YpO5KB09fR5
	 6KAaP/9Kpn4QttlYDp2d/6UbmIH9AJT8Hcg70FtSoFLcxcgmEGFK988QVCjoux/Gcgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQCOVZ6O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A414606A31C;
	Tue, 10 Nov 2026 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQCOVZ6O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA711F0089F;
	Tue, 10 Nov 2026 08:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300613;
	bh=26zipfpBS1u5Nu9qSXM7UeBDEHx6TRH3cfFvihN2SS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CQCOVZ6OlXrnIG6CjO7mpIwpw6Co6f02D/YaUk3I9M7QhRtYXUta3yJr/Icj8hEQJ
	 aK9nWudt58NFtlgQcxKhj1UVfZ+3V0OdP2dlmTkI40Kp9EEULEnPnfL6yp1uT1q2fX
	 cS5A3BQPOvsN2QS1vRzzfOK6UL2zdZnnBKiXOHFdLv8TJ2oDxJZhjyKbr1LXofBEDB
	 Xb+hE9is1P/nNy/70Ul3xOjrEg6OeJoPV11KD2AJRc2jcIZR8wvEg8wOGllMHr06C6
	 y3ow11bDDrP+P9dMBMQygPLHhVzDSANnL3kkUilwEHiJqjAk2O9KqVLmf43XW3SfsI
	 hT1uKl5cDXjHg==
Message-ID: <sashiko-outbox-206666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/10] PCI: dwc: Expose endpoint DMA resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20261110082459.1798763-3-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
 <20261110082459.1798763-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:50:12 +0000
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
- [Medium] PCI: dwc: stale edma->dw in dw_pcie_ep_get_aux_resources()
  after eDMA removal
--

commit 2170b2570701b4b321fbbb9a308f0eed9f7a8dda
Author: Koichiro Den <den@valinux.co.jp>

PCI: dwc: Expose endpoint DMA resources

This commit exposes the endpoint-integrated eDMA register window and
linked-list memory through the EPC auxiliary resource API, gated on the
local dw-edma device being registered.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 630ba172280c2..7166ec7f212bd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -858,6 +858,15 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *e=
p,
>  	return NULL;
>  }
> =20
> +static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
> +{
> +	/*
> +	 * The DWC endpoint databook says it is not possible to assign the
> +	 * DMA/HDMA registers to any Virtual Function.
> +	 */
> +	return vfunc_no ? -EOPNOTSUPP : 0;
> +}
> +
>  static int
>  dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
>  				   u8 vfunc_no)
> @@ -865,14 +874,30 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *=
epc, u8 func_no,
>  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	struct dw_edma_chip *edma =3D &pci->edma;
> +	u16 ll_wr_cnt, ll_rd_cnt;
> +	int count =3D 0;
> +	int ret;
> =20
>  	if (!pci->edma_reg_size)
>  		return 0;
> =20
> -	if (edma->db_offset =3D=3D ~0)
> +	ret =3D dw_pcie_ep_check_edma_vfunc(vfunc_no);
> +	if (ret)
> +		return ret;
> +
> +	if (!edma->dw)
>  		return 0;

[Severity: Medium]
Can edma->dw remain a non-NULL stale pointer here (and in
dw_pcie_ep_get_aux_resources()) after the local dw-edma device is removed?

dw_edma_probe() sets chip->dw =3D dw, but when the device is torn down via
dw_pcie_edma_remove() -> dw_edma_remove() (for example, on the
err_remove_edma error path in dw_pcie_ep_init_registers() or during a
PERST# reset in dw_pcie_ep_cleanup()), neither function clears chip->dw.
While dw_edma_emul_irq_free() resets db_offset to ~0, the
PCI_EPC_AUX_DMA_CTRL_MMIO and PCI_EPC_AUX_DMA_DESC_MEM resources only check
!edma->dw and !edma->cfg_non_ll, so callers will still receive DMA control
and linked-list resources for an unregistered dw-edma device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110082459.1798=
763-1-den@valinux.co.jp?part=3D2
