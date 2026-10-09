Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D86E3D9531;
	Fri,  9 Oct 2026 05:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522888; cv=none; b=r7TLBfiOGp+0X1MrcOvr7t7T1eZLkDHg0LUIMkggeBckTjcIc7Tps/K9N5G9q1/xts2xyjU2pSD3x8FD/ZqJaCqGh0ot9IsQDF1FXfG17QM+a3bTRi7rTOQyqSklJunDVsKtwCQ9UxcZtZMZTHwCrGWnrTdu2ghNg9Al9u8eEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522888; c=relaxed/simple;
	bh=Ak18Yacpag8vJWcI1fzyOxlF0qk1LfO5LVus6e0PqLk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ayuOAgn0QL3I/iGd1QQTb5NcX6b5LfGxYDQXWLs4xBvJZ8xDV+wiaS2hYs8BO13N9xDs7cs1Dq+xzQ1+P+EeLDEUcI4MrYsEtLWlsKZIpjT471WPyi3SiUGWD49ZZSkkIN1W4Tnb2ionpDf+RV72rb5rKAaN95wcQZJaUuUV5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfbIezc2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfbIezc2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E236A1F000FF;
	Fri,  9 Oct 2026 05:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791522887;
	bh=UTxVKQo7FMnKIq+2+x1ocUtyoMH0fD3OIj6Y8GhEqQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HfbIezc2AKmXu7ghYV0j/UA9h8z0c5sHMtYON5iKyU9zgMHANg/Gm6omadQ+W5KgL
	 VZIuE5S0y7FHM7d2GSyTaG6hW46DC4+99O4zONBetoYHYSzcFgMl2cIQcAd9CCRnSy
	 GrkeiF0VQW2w6DqaeidZFSIXRp80Bjp0usFk24c5gDN9XPcVc0wV8FUoVOMkNiSQgl
	 VoPuu5qS3hHd/An12bF9pz5EVG1JwJWApulBSslNxGN3sXnMMaNh4B8QgtnkFvSq1P
	 8HiF/a1/VtEFuuPET1wjasPGgIENQeItqZcrsE3hVdQrok8QxRjlk+1t+zEDdEqxrZ
	 Ef/zZudU8g1zA==
Message-ID: <sashiko-outbox-164876@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/7] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20261009045949.1109871-7-den@valinux.co.jp>
References: <20261009045949.1109871-1-den@valinux.co.jp>
 <20261009045949.1109871-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 05:14:46 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ntb: missing offset subtraction in mw_set_trans allows window to o=
verlap DMA submap
- [High] ntb: incomplete validation of mw_offset allows OOB physical memory=
 mapping
--

commit 51fd2384ff902b8fa804aedcaaf547e5f8303043
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_hw_epf: Discover vNTB-embedded DMA

A vNTB PCI function can now expose endpoint-local DMA channels to its
host. Decode the extension and register the advertised channels before
the NTB device, so clients of that NTB device can use the DMA
functionality in the same PCI function.

> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_=
epf.c
> index c47607d4f8a7f..7faa40d1ae00d 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
[ ... ]
> @@ -212,7 +483,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, =
int pidx, int idx,
>  		*size_align =3D 1;
> =20
>  	if (size_max)
> -		*size_max =3D pci_resource_len(ndev->ntb.pdev, bar);
> +		*size_max =3D ntb_epf_mw_size(ndev, bar);

[Severity: High]
Does this code accurately report the maximum available size to clients?

Because the physical memory window starts at a hardware offset, is it
necessary to deduct the offset here to ensure clients are not misled
about the actual available space?

> =20
>  	return 0;
>  }
[ ... ]
> @@ -486,7 +770,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, =
int pidx, int idx,
>  	if (bar < 0)
>  		return bar;
> =20
> -	mw_size =3D pci_resource_len(ntb->pdev, bar);
> +	mw_size =3D ntb_epf_mw_size(ndev, bar);
> =20
>  	if (size > mw_size) {
>  		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",

[Severity: High]
Does this validation successfully prevent the memory window from
overlapping the DMA submap?

Because the memory window starts at the hardware offset (read via
ntb_epf_mw_offset()), checking if size > mw_size without subtracting
the offset might allow a client to request a size up to mw_size. This
would result in the memory window ending at size + offset, which
exceeds the safe mw_size boundary.

Can this allow the host's memory window transfers to silently overwrite
the endpoint's new DMA control registers?

>  			&size, &mw_size);
>  		return -EINVAL;
>  	}
[ ... ]
> @@ -520,21 +804,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev =
*ntb, int idx,
>  				    phys_addr_t *base, resource_size_t *size)
>  {
>  	struct ntb_epf_dev *ndev =3D ntb_ndev(ntb);
> -	u32 offset =3D 0;
> +	resource_size_t offset;
>  	int bar;
> =20
> -	if (idx =3D=3D 0)
> -		offset =3D readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
> -
>  	bar =3D ntb_epf_mw_to_bar(ndev, idx);
>  	if (bar < 0)
>  		return bar;
> =20
> +	offset =3D ntb_epf_mw_offset(ndev, idx);
> +
>  	if (base)
>  		*base =3D pci_resource_start(ndev->ntb.pdev, bar) + offset;
> =20
>  	if (size)
> -		*size =3D pci_resource_len(ndev->ntb.pdev, bar) - offset;
> +		*size =3D ntb_epf_mw_size(ndev, bar) - offset;

[Severity: High]
Does this subtraction risk an integer underflow if a malicious endpoint
provides an offset larger than the window size?

If offset > mw_size, this subtraction wraps. On 32-bit systems, a
massive offset could result in a small valid size while shifting the
base physical address backwards. This might allow an untrusted endpoint
to trick the host into mapping arbitrary physical memory before the BAR
via memremap().

Is the offset thoroughly validated for all BARs in ntb_epf_init_dev()
before being used here?

> =20
>  	return 0;
>  }
[ ... ]
> @@ -630,12 +913,30 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *nde=
v)
>  {
>  	struct device *dev =3D ndev->dev;
>  	int ret;
> +	int i;
> =20
>  	ndev->mw_count =3D readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
>  	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
>  		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
>  		return -EINVAL;
>  	}
> +	ret =3D ntb_epf_dma_parse(ndev);
> +	if (ret) {
> +		dev_err(dev, "Invalid endpoint DMA layout\n");
> +		return ret;
> +	}
> +	if (ndev->dma.submap.size) {
> +		for (i =3D 0; i < ndev->mw_count; i++) {
> +			int bar =3D ntb_epf_mw_to_bar(ndev, i);
> +
> +			if (bar =3D=3D ndev->dma.submap.bar &&
> +			    ntb_epf_mw_size(ndev, bar) <=3D
> +			    ntb_epf_mw_offset(ndev, i)) {
> +				dev_err(dev, "Invalid DMA/MW boundary\n");
> +				return -EINVAL;
> +			}
> +		}
> +	}

[Severity: High]
Does this validation loop completely protect against an overly large
offset?

It currently only checks if the memory window offset exceeds the window
size when the DMA submap is present, and only for the specific DMA
submap BAR. If the DMA submap is absent, or for other BARs, the
untrusted offset seems to remain unvalidated.

Could this incomplete validation lead to the integer underflow and
out-of-bounds physical memory mapping in ntb_epf_peer_mw_get_addr()?

> =20
>  	/* One Link interrupt and rest doorbell interrupt */
>  	ret =3D ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009045949.1109=
871-1-den@valinux.co.jp?part=3D6
