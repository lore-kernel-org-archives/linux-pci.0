Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC83546C2
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 03:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785815552; cv=none; b=E0JdkJ+1h62ax+48bIKfadT7P3gfzWtYo64+b+XpwAA+gbejUDB+XstUjrVwXwnc9SmuFpiIW4+GF+tvEdJgr8dWXd4AnFoGfqj5L40xxHf0d6dDgwjfb15FnEaVCI56rc7jQwqRQ5YqKfmXl04Igl8f1ay01zhhN9+mVG7wrCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785815552; c=relaxed/simple;
	bh=Cj3DeA3BUya1OCjB+K9HrC/1rpatV6rGZ73P8UqoUiI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VfU+y933/HuUhpvlwkyMG8FgxvEVmKBl/m9uu/pHog3vRxlZ20XFUrs4g6GSkWkOx891ONlReufbLXY2lDN1UmlVfScTf4vH6SsXS1ef71CTTvDXYTC8OFFSV+IzejB8rHWBpb15/frBOA4A39dJlxb1osyx4WCIO2odY4dt8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKPTV0kH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKPTV0kH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538CD1F000E9;
	Tue,  4 Aug 2026 03:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785815550;
	bh=BRPCkCN+OGFWOxKzIUcJKOxT3skSoQwYR5mBiTAorSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CKPTV0kHdMhDofrDamSrF0z9Vb5DMuQt1/bkIh/wwcbO05+VD3oW/HtETW+IVoxOp
	 iaVTrJOQ/KEceGF1pDSoQ4kMx3AW186Xwi5q3cvsZ7an1LpRRu8JK/l9KHT4nsKeaK
	 MNMzXQqg7saQySgLGfUgNXmMeI0KnEo8/fAAkR0QlOjk8nNonnC5HMaxXnZbJcrORi
	 N0uly9N7hKBi0WZrc36gBqCfH880s35VxtE06hSBTtRat5ub1Yku67CcsPZW2mpmmP
	 ktn1gvnS8TWzxVoNhXdTdUf8G8IztfVQfxclrZjdAJyNPNdVTAF/hh2gc+eHXjC0oR
	 wzX5usKlSogvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] dmaengine: dw-edma: Add delegated channel
 request helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260804033855.2115817-5-den@valinux.co.jp>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 03:52:29 +0000
Message-Id: <20260804035230.538CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Releasing a single delegated channel with `quiesce=3Dtrue` on eDMA=
 v0 hardware causes a data race on `engine_en` and incorrectly shuts down t=
he entire DMA direction, disrupting all other local channels.
--

--- Patch [4]: [PATCH v6 4/6] dmaengine: dw-edma: Add delegated channel req=
uest helpers ---
commit 0987248b986738e4870e25b1f36d8c9f2eb69d8b
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Add delegated channel request helpers

This commit adds DesignWare eDMA-specific helpers to request and release
hardware channels for delegation to a remote host. The release helper
supports quiescing the channel before restoring default routing and
releasing the DMAengine reservation.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 1f893dc54c793..4c0d2bba755b5 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
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

[Severity: High]
Does releasing a delegated channel with quiesce set to true unintentionally
disrupt all other active local channels in the same direction?

If an endpoint driver uses some channels locally while delegating others to=
 a
remote host, this call to dw_edma_core_ch_quiesce() appears to escalate to a
direction-wide shutdown on eDMA v0 hardware:

drivers/dma/dw-edma/dw-edma-v0-core.c:dw_edma_v0_core_ch_quiesce() {
    ...
    return dw_edma_v0_core_dir_off(chan->dw, chan->dir);
}

dw_edma_v0_core_dir_off() forcefully masks interrupts for all channels in t=
he
direction and locklessly clears the engine_en register via
dw_edma_v0_core_engine_disable():

drivers/dma/dw-edma/dw-edma-v0-core.c:dw_edma_v0_core_engine_disable() {
    ...
    SET_RW_32(dw, dir, engine_en, 0);
}

Since the per-channel delegation API does not enforce exclusive ownership of
the direction, does this cause a data race and abort ongoing DMA transfers =
on
unrelated active local channels?

> +		dev_warn(chan->dw->chip->dev,
> +			 "failed to quiesce delegated %s channel %u\n",
> +			 chan->dir =3D=3D EDMA_DIR_WRITE ? "write" : "read",
> +			 chan->id);
> +
> +	scoped_guard(spinlock_irqsave, &chan->vc.lock)
> +		chan->irq_mode =3D dw_edma_get_default_irq_mode(chan);
> +
> +	dma_release_channel(dchan);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804033855.2115=
817-1-den@valinux.co.jp?part=3D4
