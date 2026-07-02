Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA63264C7;
	Thu,  2 Jul 2026 21:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027882; cv=none; b=iovj65uXLAuj/begDqJ9DpWMyPpE1EMI3cBji3iFSEONu3MSk57/XMKoY8JwMiT4B4MuclHSwEYdTHac2jSnSzlXjU/SnP2hFHW3pvohocpCBaS35GyW9RctdYHWnAV8yEhsLc9ko+kDOe//lmgneb2ncuN1ohK3GQ0yrBBFThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027882; c=relaxed/simple;
	bh=LlhYnzV1pT2T4sp1DPbQwKprrN6AHAzA4zUxMJQxGoU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t9r+O4Zg4+sKoNjjJVIwspKU73OFW1kwRJha1Kk/fEBapofp3nnWbXSWjLM1XB/ndXB/EZ2ZW1hmbt+NEAKBMne0iW4Ds8O5qaZeonOrpyuCyHBTkz67wW3bOBzZ0RDgLAM3nHQkfWD3fERye3VIP8NCa/I2mTF0ZVeAl6wJres=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foj5yIGc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foj5yIGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8A91F000E9;
	Thu,  2 Jul 2026 21:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783027881;
	bh=kUpZTwnD6/kp6cafFlUIPqH49c1OEK5pPn6xn41gBtQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=foj5yIGc0ecRWLp3FIvKtYmo3QWt9dwNIxiq8QiTnnai3gr6cQfCFnOz+C3TYS37v
	 645eMLY1UNf8bcH5+hN5ONY9Wau1ewVP/Tk6GoGDATF3egGp1Rto4nvjjddVxXAlMU
	 aA1MJ402tbLfLH3ThO9EzUbrLNTOIFjF7NOQpNSdXc1+H1M7VOVAV7XChxkuCCQ4Sy
	 YW9Tea0q4IPZ3N8KTR6VU6TIr5X5JvKF3mNdgKju534JhOo8umKBnNxoXJZPECCnj/
	 8t779XjC/ZjoWdUvJUyTDQrlJ+wDf4kYTiZ7TDmJRDdDWfbR1UmVtqZFFbHvE6aSMP
	 RmbGs0uxqyCWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] dmaengine: dw-edma: Add callbacks to fill link
 list entries
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, vkoul@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702-edma_ll-v3-6-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
 <20260702-edma_ll-v3-6-877aa463740c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:31:20 +0000
Message-Id: <20260702213121.0F8A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `addr` parameter is completely ignored in both the `dw_edma_v0_=
core_ll_link` and `dw_hdma_v0_core_ll_link` callbacks, with the code incorr=
ectly hardcoding `chan->ll_region.paddr` instead.
--

commit b095560e132d78a5d96555e8baeab1d49da1b0c1
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Add callbacks to fill link list entries

This commit introduces four new callbacks to fill link list entries and han=
dle
channel operations. This abstraction allows sharing logic between the eDMA =
and
HDMA paths to avoid duplicating code.

> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> index 8d38867cd9983..10ad63d7e6016 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c

[ ... ]

> @@ -509,6 +509,48 @@ static void dw_edma_v0_core_ch_config(struct dw_edma=
_chan *chan)
>  	}
>  }
> =20
[ ... ]
> +static void
> +dw_edma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64=
 addr)
> +{
> +	u32 control =3D DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
> +
> +	if (!cb)
> +		control |=3D DW_EDMA_V0_CB;
> +
> +	dw_edma_v0_write_ll_link(chan, idx, control, chan->ll_region.paddr);

[Severity: Low]
Could this omission cause a regression if the caller expects the provided a=
ddr
to be used? The callback signature explicitly takes a u64 addr argument, but
the implementation ignores it and hardcodes chan->ll_region.paddr instead.

> +}
> +

[ ... ]

> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/=
dw-hdma-v0-core.c
> index 31bbdc6a40642..52c6ea09fcab5 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c

[ ... ]

> @@ -348,6 +348,40 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma=
_chan *chan)
>  	SET_CH_32(dw, chan->dir, chan->id, msi_msgdata, chan->msi.data);
>  }
> =20
[ ... ]
> +static void
> +dw_hdma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64=
 addr)
> +{
> +	u32 control =3D DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
> +
> +	if (!cb)
> +		control |=3D DW_HDMA_V0_CB;
> +
> +	dw_hdma_v0_write_ll_link(chan, idx, control, chan->ll_region.paddr);

[Severity: Low]
What about the HDMA implementation? The addr argument passed to
dw_hdma_v0_core_ll_link() is also completely ignored in favor of hardcoding
chan->ll_region.paddr.

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-edma_ll-v3=
-0-877aa463740c@nxp.com?part=3D6
