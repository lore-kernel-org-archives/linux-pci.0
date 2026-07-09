Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727C34FF55;
	Thu,  9 Jul 2026 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611895; cv=none; b=dDVvekGnL1WdlogepTDvzUuzZcD/FhZulIdKA3171UjToxomrmx+yzVbdUbnSzdjkiWtaR8CIX1CBcrPlgw/rVc4KxFac8MIvjpEwqSZjG5KirA5ifNCDTs4/w2YgNVaacngg7KVME2QESHNmwY6sT0FYk+ims+Eqv/RpXBnWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611895; c=relaxed/simple;
	bh=5M89FzVoUbUXlpBBL6AKdX8JnWlhOk88LjOMdW0/Mao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WOdWdEJA2n/+xp6D1fufvqiU1MHd8gtOxkdAuQUwoGF4Vpfm2a8n9/54Sr1Ysal65bOtc6i3GzUgNVUSaB0U+R1UBvdlAuPojD0iEMp3SeuHS9P8Hlx53c8mUrF8519146u+JXrz80gtvilYWVTbPZKBBIgeLZadzBJm0mWEB24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpHd4N7b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpHd4N7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D151F000E9;
	Thu,  9 Jul 2026 15:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611893;
	bh=YcQzB/g3XCjMchOnhxsCZgBvR+MxljbmTAF8ukv56kY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DpHd4N7bMvrXq3i3dt881aQWzNqbH38D8mPgZEy7sK4ciq0DQkj6kS07LnTgJjqxW
	 M+ud0twi1EWKScWUvrDAPpTEKl+HDq3LhL40D88KLUwXscDbsXzEpjLbZT0QC9Hbe/
	 nExiRoGfcCPcrdNy4u3NQOMwRvSyLzvCjwh5ji3v3V7poB4YG78htqKxKdms98MPzD
	 0Tm4UdeR15pUB5J+v4nQ3rvzNu0PnYlsClcO9bwtXMdXTfou2ws399gxUEccCPt6VX
	 gtzAkkS4PXmfJi5H/AD5EBhRV3Rh1I8dxR47KpRb95ivEndYNfWDB+Zo78SqLRbeJ7
	 RJA+nb7S+InIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/10] dmaengine: dw-edma: Add helper
 dw_(edma|hdma)_v0_core_ch_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260709-edma_ll-v5-5-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
 <20260709-edma_ll-v5-5-e199053d4300@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:44:52 +0000
Message-Id: <20260709154453.34D151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Multiple dmaengine control functions (resume, pause, terminate_all=
) modify channel state flags and access descriptor lists without holding th=
e required virt-dma lock (`chan->vc.lock`).
--

--- Patch [5]: [PATCH v5 05/10] dmaengine: dw-edma: Add helper dw_(edma|hdm=
a)_v0_core_ch_enable() ---
commit def5321a113246514770ebf2362c6bd5549dc443
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()

Move the channel-enable logic into a new helper function,
dw_(edma|hdma)_v0_core_ch_enable(), in preparation for supporting dynamic
link entry additions. No functional changes.

> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> index c341aa5343417..8d38867cd9983 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c

[ ... ]

> @@ -366,74 +427,11 @@ static void dw_edma_v0_core_start(struct dw_edma_ch=
unk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan =3D chunk->chan;
>  	struct dw_edma *dw =3D chan->dw;
> -	unsigned long flags;
> -	u32 tmp;
> =20
>  	dw_edma_v0_core_write_chunk(chunk);
> =20
> -	if (first) {
> -		/* Enable engine */
> -		SET_RW_32(dw, chan->dir, engine_en, BIT(0));

[Severity: High]
This isn't a bug introduced by this patch, but it appears multiple dmaengine
control functions (resume, pause, terminate_all) modify channel state flags
and access descriptor lists without holding the required virt-dma lock
(chan->vc.lock).

For example, dw_edma_start_transfer() (which ends up calling
dw_edma_v0_core_start()) is called locklessly from
drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_resume():

        chan->status =3D EDMA_ST_BUSY;
        dw_edma_start_transfer(chan);

Could calling dw_edma_start_transfer() locklessly here lead to list
corruption, use-after-free, or a kernel oops?

This function evaluates vchan_next_desc(&chan->vc) to inspect vc->desc_issu=
ed
and modifies desc->chunk->list via list_del():

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_start_transfer() {
...
        vd =3D vchan_next_desc(&chan->vc);
        if (!vd)
                return 0;

        desc =3D vd2dw_edma_desc(vd);
...
        list_del(&child->list);
...
}

Concurrently, dw_edma_done_interrupt() or dw_edma_device_issue_pending()
on another CPU can acquire chan->vc.lock and execute list updates. Modifying
and iterating these lists without holding the protecting vc.lock during
concurrent modification structurally leads to list corruption.

A similar lockless state modification happens in dw_edma_device_pause():

        else
                chan->request =3D EDMA_REQ_PAUSE;

And also in dw_edma_device_terminate_all():

        else {
                chan->request =3D EDMA_REQ_STOP;
        }

Should these state updates and list accesses be protected by the virt-dma l=
ock?

> -		if (dw->chip->mf =3D=3D EDMA_MF_HDMA_COMPAT) {
> -			switch (chan->id) {
> -			case 0:

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-edma_ll-v5=
-0-e199053d4300@nxp.com?part=3D5
