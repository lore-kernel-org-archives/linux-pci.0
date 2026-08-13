Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D294248A1;
	Thu, 13 Aug 2026 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603811; cv=none; b=OkwkgzpfXAWewBknxycpE6mJj3OPlFjf+tZOw1VyXAdvJfqcsl382nxQVYfUdb4LRhxO0NyqsZtd0eaNWGHYxUMD1sLAqujiftr0xn1hxUOHZvSUE7NeYDUnXpkqz9GkIQ0UgE+ZbDtnFkk0HAC348XUerRDWJ2j7l83D3bKjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603811; c=relaxed/simple;
	bh=qC5YbFgusCbeB0gLTrBdZye2ZwNRW+jU0G/fqc+AkMU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HVzo69SIvchv5oWKrG67RHanhtPxsX0VN2JDiDucw+vUKHYr9y5AQlzWch6MkITB7rc6REBu+DwxrGtdXFl7BENwnSagxP9GbDoJ8XSJbxGV/18JPsC0JxghyQrqrEqTEkeQWLkwyi0j6eUSUqodUESd0OBPEC8AnLRmQSkGDhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwdxqrpG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwdxqrpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB94A1F00A3A;
	Thu, 13 Aug 2026 06:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603810;
	bh=BKnle7pYrFuiKFoP4QVaDhswqAdFWNhpusp7KlXbpSU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mwdxqrpGGl79BoDa4ltPCWGwKfdNLf+lrIAVkHCyZ8B0enc/VhgzdJ8Ir1j+9X6eD
	 6XvFGcGWY5s+zjGhlXwbpmV+MMWMWjj3mZDKgFmNrY9yKuKKp7Pg+PZldRMvb0BupH
	 rKMWZl7DCNdiT5gD83X0kUJ7b7wJHWodYTlwS8MpmLLL4/6IL1RijNC+/GxePV0y9N
	 ZP3vYmEzMvRUqJLl8SOgbjCLoCWYcDXs87samGLB6jcDr/ZFFdg0Zhfp/WEtjhW2Cd
	 yY3Y9Ch5QdrkWgjSKMkmOrN4NJqGHNpG9h+bssOeXAfpV54HqGi39+LHGFm3ESr6O+
	 r38o2m/S1w9fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/10] dmaengine: dw-edma: Add channel delegation
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260813063757.3131865-6-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 06:50:09 +0000
Message-Id: <20260813065009.BB94A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Data race on `chan->irq_mode` between channel delegation/reclaim=
 and the hardirq handler.
--

--- Patch [5]: [PATCH v7 05/10] dmaengine: dw-edma: Add channel delegation =
helpers ---
commit ada234f341417a6397309d554f4e6b955a5ce106
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Add channel delegation helpers

This commit introduces helper functions to delegate endpoint-local
DesignWare eDMA channels to a remote host. It adds dw_edma_delegate_chan()
to switch an idle channel to remote interrupt routing, and
dw_edma_reclaim_chan() to restore the channel's default routing.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index d214df55da3c3..1582ecfc2965f 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -1303,6 +1303,45 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(dw_edma_remove);
> =20
> +int dw_edma_delegate_chan(struct dma_chan *dchan)
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

[Severity: Medium]
Does this introduce a data race on chan->irq_mode?

The irq_mode is updated here using a plain store while chan->vc.lock is hel=
d,
but it appears to be read locklessly during interrupt handling:

drivers/dma/dw-edma/dw-edma-core.h:dw_edma_core_ch_ignore_irq() {
    return chan->irq_mode =3D=3D DW_EDMA_CH_IRQ_REMOTE;
}

Could the compiler optimize or tear these plain accesses, potentially causi=
ng
the interrupt handler to incorrectly ignore or process a spurious interrupt,
or trigger KCSAN warnings? Would using WRITE_ONCE() and READ_ONCE() be
appropriate here?

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_delegate_chan);
> +
> +void dw_edma_reclaim_chan(struct dma_chan *dchan, bool quiesce)
> +{
> +	struct dw_edma_chan *chan;
> +
> +	if (!dchan)
> +		return;
> +
> +	chan =3D dchan2dw_edma_chan(dchan);
> +	if (quiesce && dw_edma_core_ch_quiesce(chan))
> +		dev_warn(chan->dw->chip->dev,
> +			 "failed to quiesce delegated %s channel %u\n",
> +			 chan->dir =3D=3D EDMA_DIR_WRITE ? "write" : "read",
> +			 chan->id);
> +
> +	scoped_guard(spinlock_irqsave, &chan->vc.lock)
> +		chan->irq_mode =3D dw_edma_get_default_irq_mode(chan);

[Severity: Medium]
Similarly, does this plain store also race with the lockless read in
dw_edma_core_ch_ignore_irq()?

> +}
> +EXPORT_SYMBOL_GPL(dw_edma_reclaim_chan);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813063757.3131=
865-1-den@valinux.co.jp?part=3D5
