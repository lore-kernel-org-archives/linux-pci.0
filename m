Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ABA33B969;
	Wed, 14 Oct 2026 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956936; cv=none; b=SqGeLQ+dTtscJ4XMveTWegD3HVigR3JY3XAvEDL5QrC1yqyREIzO0V9g1FAvl+/2kd4eKp+lzIxz9u7Vvsjk9ozTPw7ZlIUwZJtdSXy/iX0diBy2gN7JFfXQmXOfDPCQ+6xI+n63gHeq76R7HiFLQqIW+PvQwqXHaKmB9oc2BX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956936; c=relaxed/simple;
	bh=p0AtD+zoh0TYofCbReKjSlZS/0AweNZQ/Fq72Oo3tZA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=i+dtfaMyKYOSvOzzo9vvchKwpfspw65LPaCk7qduw3oXAsA4bWi+FIzG4GFHCRKHFLFnMb9IGgIeFcocWoxzRWuCPSZFEb1VufNJyxs2b8vlxQxq6aAcTFyfY+72UgRStgK+gbj6rzPJJz/mSggKAnMkElwArr9vEz68qz84RRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azS6ns+E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azS6ns+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BFB1F000FF;
	Wed, 14 Oct 2026 05:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791956934;
	bh=7fOmkgF92FDLNNY7gB0hu7VPQ2vQwm5/VTXeUSHS+hY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=azS6ns+EGRmQaWEkD6nNpBVgiWPhfW8viGSC/neeS7idYaLn+tDuLPxoMsMD2lUNk
	 /gmdkkGoCtEYiq8QuBiU96Jfl7Rz24/jPdwiMiO3Y+GQXCIjvlqzyRyCQsK3DIJTGG
	 z1RS06fBR8gPjUgWcJL5Ti88rDQozklhYLhCjrfd2F2PLMTwlXhjcs/k72fWcW8kNL
	 ECgHlP8+zsCenwL07iS+mib6wRsYysYsKVCvKdQM0wAuZvwKqwN1qzIeFoYg9pHNSr
	 MmQSZiyhhXvPZY9G5HWikHpHWMtnsrltzJpg0DaiMXZMRsRKoc+oxg+X6TH65gw5HR
	 1ZNqyjemPmaxQ==
Message-ID: <sashiko-outbox-170843@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20261014053256.2378817-1-den@valinux.co.jp>
References: <20261014053256.2378817-1-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 05:48:54 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: vntb endpoint triggers out-of-bounds MSI/MSI-X vectors
--

commit d370d48a0be90734250ec28295637550cdfa6363
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-epf-vntb: Honor MSI-X selection

ntb_hw_epf tries MSI-X first and falls back to MSI. It reports the
result in COMMAND_CONFIGURE_DOORBELL. pci-epf-vntb ignores MSIX_ENABLE,
configures only MSI, and always raises peer doorbells with PCI_IRQ_MSI.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index 07ba338732d4e..c30a73c537a0b 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c

[ ... ]

> @@ -308,6 +311,15 @@ static void epf_ntb_cmd_handler(struct work_struct *=
work)
> =20
>  	switch (command) {
>  	case COMMAND_CONFIGURE_DOORBELL:
> +		epc_features =3D pci_epc_get_features(ntb->epf->epc,
> +						    ntb->epf->func_no,
> +						    ntb->epf->vfunc_no);
> +		if (((argument & MSIX_ENABLE) && !epc_features->msix_capable) ||
> +		    (!(argument & MSIX_ENABLE) && !epc_features->msi_capable)) {
> +			ctrl->command_status =3D COMMAND_STATUS_ERROR;
> +			break;
> +		}
> +		ntb->peer_msix =3D argument & MSIX_ENABLE;

[Severity: High]
Does epf_ntb_cmd_handler in drivers/pci/endpoint/functions/pci-epf-vntb.c
only extract MSIX_ENABLE from argument while failing to extract and apply
the host's allocated doorbell count (argument & DB_COUNT_MASK)? If so,
could this leave the endpoint's doorbell count unbound?

>  		ctrl->command_status =3D COMMAND_STATUS_OK;
>  		break;
>  	case COMMAND_TEARDOWN_DOORBELL:

[ ... ]

> @@ -532,16 +553,24 @@ static int epf_ntb_configure_interrupt(struct epf_n=
tb *ntb)
>  	}
> =20
>  	if (epc_features->msi_capable) {
> -		ret =3D pci_epc_set_msi(ntb->epf->epc,
> -				      ntb->epf->func_no,
> -				      ntb->epf->vfunc_no,
> -				      16);
> +		ret =3D pci_epc_set_msi(epf->epc, epf->func_no, epf->vfunc_no, 16);

[Severity: High]
Is MSI allocation hardcoded to 16 vectors here in
epf_ntb_configure_interrupt, even though ntb->db_count can be up to 32?
Could this mismatch cause out-of-bounds MSI raises when MSI fallback is
used?

>  		if (ret) {
>  			dev_err(dev, "MSI configuration failed\n");
>  			return ret;
>  		}
>  	}

[ ... ]

> @@ -1553,16 +1584,16 @@ static void vntb_epf_peer_db_work(struct work_str=
uct *work)
> =20
>  		while (db_bits) {
>  			/*
> -			 * pci_epc_raise_irq() for MSI expects a 1-based
> -			 * interrupt number. The first usable doorbell starts
> -			 * at EPF_IRQ_DB_START in the legacy slot layout.
> +			 * pci_epc_raise_irq() expects a 1-based interrupt
> +			 * number for MSI and MSI-X. The first usable doorbell
> +			 * starts at EPF_IRQ_DB_START in the legacy slot layout.
>  			 *
>  			 * Legacy mapping (kept for compatibility):
>  			 *
> -			 *   MSI #1 : link event (reserved)
> -			 *   MSI #2 : unused (historical offset)
> -			 *   MSI #3 : doorbell bit 0 (DB#0)
> -			 *   MSI #4 : doorbell bit 1 (DB#1)
> +			 *   IRQ #1 : link event (reserved)
> +			 *   IRQ #2 : unused (historical offset)
> +			 *   IRQ #3 : doorbell bit 0 (DB#0)
> +			 *   IRQ #4 : doorbell bit 1 (DB#1)
>  			 *   ...
>  			 *
>  			 * Do not change this mapping to avoid breaking
> @@ -1573,7 +1604,7 @@ static void vntb_epf_peer_db_work(struct work_struc=
t *work)
>  			db_bits &=3D ~BIT_ULL(db_bit);
> =20
>  			ret =3D pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
> -						PCI_IRQ_MSI, interrupt_num);
> +						irq_type, interrupt_num);

[Severity: High]
Since interrupt_num is calculated based on the un-negotiated db_count,
could this loop in vntb_epf_peer_db_work raise IRQs exceeding the host's
actual allocated vectors?

If this happens when the endpoint's local doorbell is triggered, could it
trigger an out-of-bounds access in the controller driver's MSI/MSI-X
table, leading to a wild DMA write?

>  			if (ret)
>  				dev_err(&epf->dev,
>  					"Failed to raise IRQ for interrupt_num %u: %d\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014053256.2378=
817-1-den@valinux.co.jp?part=3D1
