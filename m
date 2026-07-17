Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC89F1C84A0
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 05:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784265709; cv=none; b=b44jR4FUjWToWYoIHcz2yPUVpKWKCBwVNjIpUE7MhCqgLA4BLd38d5qwbzuTFS9HjwuYLSai+WE2RHGEc2AFoxgzPHslC4+yh19qG56rlG6RRQeBcM/WScXdddg8s2HRUeXOUS/+1iFqhjAl3nl8XqvjiqnAIHZU9waJtqYpefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784265709; c=relaxed/simple;
	bh=GJbB0tgMW4laFEQvH3p7Rjnmwdd6GC/6bilsr4Rfudc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W+cg6vFk7J83yQjkXs2dTe/Nv+ai+BiSe5FMcN55mijYEyIVSlaiIzo4xtZnwpcChg+/B7SCGXsRFysy/FjM4xh2cO9SAwrEnnjwWU5mPIbcVknC7qrUTZgpu+Gr03RYwNjJ72yQC9nD+GvP/UxFUC/+HKImWF+gwDN+lfFjl+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3oV3knP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3oV3knP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A611F000E9;
	Fri, 17 Jul 2026 05:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784265707;
	bh=ZBmafAIRjne8WGs9NsvS2/qyqN0qESXOf3IY93ScEUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m3oV3knPjlpHd+8k4I+Sc8QYtgQUJum2heKsCB0iDNjL8kBHLlM9bhi4dMnLop90K
	 k+TVFyRGDCYFwm9Bn0P8Cc4O0y+KXcs4D5rynxZ2apOnAepFenLFJkUDIHMiJehMj5
	 r4BKWFxq6lX5M2+XM268AJL3SFmTSGfkeLSPtsoqnd1kfXBDtOJVX/YVe8udizgORu
	 Ak6RiwoC0FlFci+oo3ROBbQjIl3i8v5QdjtjMWiZu3tRdMfTlLO2EWZCekc0233Cfc
	 7d4EWk+yPAXyZJG/tuFoHlefzQ+BOp1ittD7hr1rbVbxVmaXOvssI/GNYlDylBtRi9
	 MymzQDESuDr/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/6] dmaengine: dw-edma: Add delegated channel
 request helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260717050635.2145014-6-den@valinux.co.jp>
References: <20260717050635.2145014-1-den@valinux.co.jp>
 <20260717050635.2145014-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 05:21:46 +0000
Message-Id: <20260717052147.62A611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch references undefined identifiers, functions, and struct m=
embers, causing an immediate compilation failure.
--

--- Patch [5]: [PATCH v5 5/6] dmaengine: dw-edma: Add delegated channel req=
uest helpers ---
commit f70141ab3e5ddf56089460fb55c122b5c8d3c57b
Author: Koichiro Den <den@valinux.co.jp>
dmaengine: dw-edma: Add delegated channel request helpers

This commit adds DW eDMA-specific helpers to request and release delegated
channels for remote hosts. It handles transferring interrupt ownership and
attempts to quiesce the channel on release.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 89a4c498a17b8..d7febf5ed83d7 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -1178,6 +1178,97 @@ int dw_edma_remove(struct dw_edma_chip *chip)
[ ... ]
> +static int dw_edma_delegate_chan(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> +	int ret =3D 0;
> +
> +	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +		return -EINVAL;
> +
> +	guard(spinlock_irqsave)(&chan->vc.lock);
> +
> +	if (chan->configured || chan->status !=3D EDMA_ST_IDLE ||
> +	    chan->request !=3D EDMA_REQ_NONE)
> +		ret =3D -EBUSY;
> +	else
> +		chan->irq_mode =3D DW_EDMA_CH_IRQ_REMOTE;

[Severity: Low]
Are irq_mode and DW_EDMA_CH_IRQ_REMOTE defined in this kernel tree?

Looking at struct dw_edma_chan, it doesn't appear to have an irq_mode membe=
r,
and DW_EDMA_CH_IRQ_REMOTE seems to be undeclared. This will cause a build
failure. Is it possible a prerequisite patch was omitted from this series?

> +
> +	return ret;
> +}
[ ... ]
> +void dw_edma_release_delegated_chan(struct dma_chan *dchan, bool quiesce)
> +{
> +	struct dw_edma_chan *chan;
> +
> +	if (!dchan)
> +		return;
> +
> +	chan =3D dchan2dw_edma_chan(dchan);
> +	if (quiesce && dw_edma_core_ch_quiesce(chan))

[Severity: Low]
Is dw_edma_core_ch_quiesce() defined? It appears to be undeclared.

> +		dev_warn(chan->dw->chip->dev,
> +			 "failed to quiesce delegated %s channel %u\n",
> +			 chan->dir =3D=3D EDMA_DIR_WRITE ? "write" : "read",
> +			 chan->id);
> +
> +	scoped_guard(spinlock_irqsave, &chan->vc.lock)
> +		chan->irq_mode =3D dw_edma_get_default_irq_mode(chan);

[Severity: Low]
Similarly, dw_edma_get_default_irq_mode() appears undeclared here, and
as mentioned above, irq_mode doesn't seem to exist in struct dw_edma_chan.

> +
> +	dma_release_channel(dchan);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717050635.2145=
014-1-den@valinux.co.jp?part=3D5
