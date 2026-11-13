Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578487;
	b=La+wG3tahuzluekiRDq0bcMUZdm6FBmaFJPnt+OG0l72vH0mlJX09VdvDGt6+lRLeCPS
	 FZvx+ycDLQ1Hir8vv6cdSN/gs+qGJj4XZ0dYbEGUn8IV2qEeZYxrzTwzvImI+Nx+Lq9jk
	 +PF+vgD2E26Eq/4n/IlU/nXppBbNLq4X+lmYx0mepENZOUrkPAEW901o2crTahkUzVJ6t
	 +e5+pFBDfl/WBpeUOLMd986LqXNH4riiklnLo39Ic1R4IkTvOb+NqphYYFZVHzb0dNkRS
	 f862M/z0ZNhNeuyaOrwH2C3ZGhRqsp4CYfL/X8Ol1xOvNAxT8HnsWikZA7QOvyV+qyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578487;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1y0EDidIqKXfSDbysWLNSj5ASSVtEmAAepQamSQ+cJ8=;
	b=gry8pf8sL8fvEdN0KgqNv18uoxpgPy+Jjq2cJKntt0gmyHpqoyzeaHvtC781PUa40ZiE
	 6YTYOKMd17s/iFEzSxPBeYKiRmpcU6BhziOSaYp23ZU+UqMK8fBH32auJYa1W3D8M/nrx
	 ATXesiumfUpJasJekcyXpH9RjHydGGANF/rf/IpnfH/a59F3vCU26/rTNpDCXF1IKwnDH
	 p/4KPxmyhiB2gZ98bbKegsgUeqchwx26q0COox+HseX+ElmiiXe3Mnxj9hhXZ8ptGcrBi
	 iqQ+A4yVWXfRCqwER/qSTmyoDr9RolAX7F7u+vh0/6YIrwWj+1SyG2cIFQbd5Lg9l5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Hl/IsT5l";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED23606A334;
	Fri, 13 Nov 2026 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hl/IsT5l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DD81F000C4;
	Fri, 13 Nov 2026 14:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578487;
	bh=1y0EDidIqKXfSDbysWLNSj5ASSVtEmAAepQamSQ+cJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hl/IsT5lnJN2AuDgU2V5/tlCMCvVwTtoY6yLFCP+Y2BOCo9D9D2WDkrLq2AxDP9/n
	 bmuvHjvpw/SL9rSryfugbNHjXOalRw22hUsmq0h7TToQcQUoGdu/avL9R/b1odqxLC
	 rZgb9rtlYiWa24leEW1pkPqGnHcHhUdKMMyyMh52Rgce7zso5P5Vt5/ds9/w4Jy/vp
	 LqLyUVZ2Tg9eoYzrJh0UXQBbmP3+zrmOtKfWAP3BmoZpB+8aTh6V3/6HhxVA0/d4Q4
	 jCyXmz1MozuDn9zrHLajIA1MGeRtfES27UQMqGybbM3g0elKR3xB/u7X56Q5O989N7
	 X6eEdhzmRvdJg==
Message-ID: <sashiko-outbox-212948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 02/10] PCI: dwc: Expose endpoint DMA resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20261113132935.4152566-3-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
 <20261113132935.4152566-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:01:26 +0000
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

commit 220e302470d02f37d10b32b890cae93390897f07
Author: Koichiro Den <den@valinux.co.jp>

PCI: dwc: Expose endpoint DMA resources

This commit exposes the endpoint-integrated eDMA register window and
linked-list descriptor memory via the EPC auxiliary resource API, and
gates auxiliary resource reporting on virtual function checks and
local dw-edma registration.

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
> =20
> -	return 1;
> +	ll_wr_cnt =3D edma->ll_wr_cnt;
> +	ll_rd_cnt =3D edma->ll_rd_cnt;
> +
> +	if (!edma->cfg_non_ll)
> +		count +=3D 1 + ll_wr_cnt + ll_rd_cnt;
> +
> +	if (edma->db_offset !=3D ~0)
> +		count++;
> +
> +	return count;
>  }
> =20
>  static int
> @@ -885,14 +910,32 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u=
8 func_no, u8 vfunc_no,
>  	const struct pci_epc_bar_rsvd_region *rsvd;
>  	struct dw_edma_chip *edma =3D &pci->edma;
>  	enum pci_barno dma_ctrl_bar =3D NO_BAR;
> -	resource_size_t db_offset =3D edma->db_offset;
> +	resource_size_t db_offset;
>  	resource_size_t dma_ctrl_bar_offset =3D 0;
>  	resource_size_t dma_reg_size;
> -	int count;
> +	u16 ll_wr_cnt, ll_rd_cnt;
> +	bool has_ll;
> +	unsigned int i;
> +	int count, ret;
> =20
> -	count =3D dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
> -	if (count < 0)
> -		return count;
> +	if (!pci->edma_reg_size)
> +		return 0;
> +
> +	ret =3D dw_pcie_ep_check_edma_vfunc(vfunc_no);
> +	if (ret)
> +		return ret;
> +
> +	if (!edma->dw)
> +		return 0;

[Severity: Medium]
Can edma->dw remain non-NULL after the local dw-edma device is removed,
causing dw_pcie_ep_get_aux_resources_count() and
dw_pcie_ep_get_aux_resources() to report PCI_EPC_AUX_DMA_CTRL_MMIO and
PCI_EPC_AUX_DMA_DESC_MEM resources for an unregistered DMA engine?

dw_edma_probe() sets chip->dw =3D dw when registering the device, and
dw_edma_emul_irq_free() resets chip->db_offset =3D ~0 on teardown, but
neither dw_edma_remove() nor dw_pcie_edma_remove() clears chip->dw.
If dw_pcie_ep_init_registers() fails after dw_pcie_edma_detect() and
unwinds via err_remove_edma -> dw_pcie_edma_remove(pci), or if
dw_pcie_ep_cleanup() calls dw_pcie_edma_remove(pci) on a fundamental
reset, edma->dw is left holding a stale pointer and the !edma->dw check
still succeeds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113132935.4152=
566-1-den@valinux.co.jp?part=3D2
