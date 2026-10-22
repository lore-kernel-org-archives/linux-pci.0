Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659181;
	b=pFGjswcL04D7sQA0ulpE50Tx0Z1Ti0cF7yfM+FOhwpi84brY4MDvVu6xrH4HiQ+pvWF0
	 cxoSZPSjn+OEsp8WWLGZlHSnFAzE+7Vrp4oQD5sOxrxa8/HQJACBb7eqbbiG5jEzPLta1
	 zgZiupmM/BHCLvspv5ln4/5w+lSG+GSOBEDYoX/85eP4kKk2bW1mSyK9bDfDhAvNL5ViK
	 kc3pIDE6/bXSQKxCK8mj1uk1DS4ABTNjvn2DY3Ewf0JyLZ+iOpqjMFljH411hma258IIx
	 WLRZMhXCjhS3Jht6lkSwhFO59tOBQzc8IUxgWG/dsAp1fURFjk39EJN52PpeE71eSwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659181;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z7HJx7bcUbbxd3+jBZfRE3Uz4DC96xFcukWBu3wvPu4=;
	b=TRy0siP6wD6tx3C4V2luu5tnDjVCtkcmL8B3ZHCCK4WGUVEy7WzONWY9Vf6bvq3Ds9kS
	 dCfXDTJUhElU+Bi+OZnIkNcd8Y6d59Pe+ulK+ikJts6G9hvjFD4z9lQkoYLNo/RvLtXAp
	 n6PrTVScp+QDKIVWAZsfNZUQjRINYW0hGoRB07aEyM/FWasJTKw+D2Y7gap7ZFuBejuwJ
	 6Hpf4/JI0q9CLqCcQRXqYVNxLrui5l8ziJiV4BU3x0I1t32raLKW8gJtQMrUEYH4xiFvA
	 J4VFtBfwluX3/PbgDmmods17Cjo5f7oy2EPGFfHmpIiI2lg0BM2wjDa34FkD1+RxrWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljpb+krZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E71606A319;
	Thu, 22 Oct 2026 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljpb+krZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7B51F000C1;
	Thu, 22 Oct 2026 08:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792659180;
	bh=Z7HJx7bcUbbxd3+jBZfRE3Uz4DC96xFcukWBu3wvPu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ljpb+krZgJtqDbxMKgzbMd4yB4q/BaN782sCQUp6ZVgOuals1YD8gDkSRG8VBLjc+
	 hEwdM1PpmVNxHb/4qB4QzXb4fcfQ8GyX0HVE9zbjfK8lPMz/5ZgCOF+sHZEDoalWUs
	 0iKlerFU+ggOClloMqu7dfZucTmpqTzEovvwhCfDSZGqjUxyMd3ajbOBH7rJYBVW+v
	 LJSvTgfiDAjy3uiX+x/1WYZUKhZdmWGX1+pVz3hWuTJ1NZ0wxOg+WgsQ0ZB38DIUbP
	 06n5H34Bz+OfFwNEmyIA/rah2hn17R6NGlTLcdtsLLSLmPrXMT3eWTpNIAuw1kcLM2
	 D4ql5PRAByA5w==
Message-ID: <sashiko-outbox-181210@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/10] PCI: endpoint: pci-epf-vntb: Export endpoint
 DMA channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20261022082230.3164834-6-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
 <20261022082230.3164834-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:53:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCI: endpoint: pci-epf-vntb: epf_ntb_dma_set_bar() returns 0 whe=
n DMA is disabled
--

commit 2da1c2a8d12099e9d914603258e8edaefa818fbc
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels

This commit adds support for exporting endpoint-local eDMA read channels to
the root complex through a configurable dma_bar configfs attribute and a
control-region extension in pci-epf-vntb.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index 3adbaa9d85db2..ac83af54122f7 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c

[ ... ]

> +static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> +{
> +	struct pci_epf_bar_submap *old_submap;
> +	struct epf_ntb_dma *dma =3D ntb->dma;
> +	unsigned int old_num_submap;
> +	struct pci_epf_bar *bar;
> +	int restore, ret;
> +
> +	if (!dma)
> +		return 0;
> +
> +	bar =3D &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> +
> +	old_submap =3D bar->submap;
> +	old_num_submap =3D bar->num_submap;
> +	bar->submap =3D dma->submap;
> +	bar->num_submap =3D dma->num_submap;
> +
> +	ret =3D pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> +			      ntb->epf->vfunc_no, bar);
> +	if (!ret)
> +		return 0;
> +
> +	/* A failed dynamic update may have already removed the old mapping. */
> +	bar->submap =3D old_submap;
> +	bar->num_submap =3D old_num_submap;
> +	restore =3D pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> +				  ntb->epf->vfunc_no, bar);
> +	if (restore)
> +		dev_warn(&ntb->epf->dev,
> +			 "failed to restore DMA BAR mapping: %d\n", restore);
> +
> +	return ret;
> +}
> +
>  /**
>   * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHO=
ST
>   *   to access the memory window of HOST
> @@ -342,6 +774,11 @@ static void epf_ntb_cmd_handler(struct work_struct *=
work)
>  		epf_ntb_teardown_mw(ntb, argument);
>  		ctrl->command_status =3D EPF_NTB_COMMAND_STATUS_OK;
>  		break;
> +	case EPF_NTB_COMMAND_SETUP_DMA_BAR:
> +		ret =3D epf_ntb_dma_set_bar(ntb);
> +		ctrl->command_status =3D ret ? EPF_NTB_COMMAND_STATUS_ERROR :
> +					     EPF_NTB_COMMAND_STATUS_OK;
> +		break;

[Severity: Medium]
When dma_bar is left unassigned (NO_BAR), epf_ntb_dma_collect() returns 0
without allocating ntb->dma, leaving ntb->dma as NULL.

If the peer subsequently writes EPF_NTB_COMMAND_SETUP_DMA_BAR to
ctrl->command, epf_ntb_cmd_handler() calls epf_ntb_dma_set_bar(ntb), which
checks if (!dma) and returns 0. epf_ntb_cmd_handler() then sets
ctrl->command_status to EPF_NTB_COMMAND_STATUS_OK even though DMA export is
disabled and no DMA BAR or subrange mapping was configured.

Should epf_ntb_dma_set_bar() in drivers/pci/endpoint/functions/pci-epf-vntb=
.c
return a negative error code (such as -EINVAL or -EOPNOTSUPP) when ntb->dma
is NULL so that ctrl->command_status is set to EPF_NTB_COMMAND_STATUS_ERROR?

>  	case EPF_NTB_COMMAND_LINK_UP:
>  		ret =3D epf_ntb_set_link_enabled(ntb, true);
>  		if (ret < 0)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022082230.3164=
834-1-den@valinux.co.jp?part=3D5
