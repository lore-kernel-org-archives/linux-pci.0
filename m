Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82013DA5DB;
	Mon, 31 Aug 2026 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788219046; cv=none; b=A25UTlNmPGlUlYCzosccD1PdbsnbQYv/mf/QSNbkYx3tfm48qDz3uDDbToHcu0ZtnCdCzj0memt2sRg4eOiV8CLYYkdcdMyw46JGiB9xkLMRCyjYQwC4dKII6Rky6x8LnVW1nEM0lwZ0VLIXpmhstqIybQQhdC00DFeHHMYDtRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788219046; c=relaxed/simple;
	bh=U+KH953cSuE5VOPSZIj9eaAT5gjuEAmb7gPVaoiemZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qdt2RgPECbMD2+Iij46Td2a3x1e6Xt7Kdo4h70VoDQKY5pELP3LBCUsRLbIgoqxCZVZfd9Rpo0Odxv2JROsCU5H1rTOQRqi8O2DSERvuPHR/F/8GexaeWGL6YVRak38L5RkRLPx6f6zIwCrMe60dV9GRp8KCRoqmEmOZCfepDyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABKiNgQK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABKiNgQK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCB01F000E9;
	Mon, 31 Aug 2026 23:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788219044;
	bh=ZOhGd2zZP7oigzcpyJCpddYJWQZ73IjNrIvdhiuSqkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ABKiNgQKBvV+LVJN3lzwrjv6HYBYgyvRvZqHPYkhj99YTlxctopbBD3K7DX2O13Fi
	 RL+VYhl1ECd8lo+jgMcpSlsL+1UyQxTFK3579DxzoZ9UrOl9skOjestB3EO+pCXr5o
	 ZVHy4tHOveh4ynbYJpwgGUa2bJx+0NZEp0hSD1DcmRBIL0xiW/Y00KHiiCofBDdI48
	 i7I2Ao3KJ2GY1UnVUsgP77/PZVIeT+tmeyPWaYdfjJQjLFJLphv3kNdRih6PIXtdXy
	 uU6V0WL2QOrdpGGQvFPal8xWC1bIQumk6baep03S3dUv3v3hgfrop13zNV7C08THL/
	 rHHW7GscMZYrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/12] dmaengine: plx_dma: fix NULL pointer deref in
 plx_dma_isr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260831191403.207631-13-logang@deltatee.com>
References: <20260831191403.207631-1-logang@deltatee.com>
 <20260831191403.207631-13-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 23:30:43 +0000
Message-Id: <20260831233044.3CCB01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Softirq preemption deadlock in `plx_dma_process_desc()` due to usi=
ng `spin_lock()` instead of `spin_lock_bh()`.
- [High] Recursive deadlock in `plx_dma_process_desc()` when a client callb=
ack submits a new DMA transaction.
- [High] `plx_dma_prep_memcpy()` acquires a spinlock and returns without re=
leasing it, violating the DMA API contract.
--

commit eba3f5594a9491de8ee08b096a4a7e95dd48da19
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()

This commit prevents a NULL pointer dereference in the interrupt handler.
It achieves this by moving the assignment of plxdev->bar ahead of
request_irq() during hardware initialization.

Link: https://lore.kernel.org/all/20260610112121.676561-1-jjy600901@snu.ac.=
kr

> diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
> index 84941a918b01f..409898e92c320 100644
> --- a/drivers/dma/plx_dma.c
> +++ b/drivers/dma/plx_dma.c
[ ... ]
> static void plx_dma_process_desc(struct plx_dma_dev *plxdev)
> {
> 	struct dmaengine_result res;
> 	struct plx_dma_desc *desc;
> 	u32 flags;
>=20
> 	spin_lock(&plxdev->ring_lock);

[Severity: High]
This is a pre-existing issue, but does using spin_lock() here instead of
spin_lock_bh() leave us vulnerable to a softirq preemption deadlock?

If plx_dma_tx_status() is called from process context, it will call
plx_dma_process_desc() and acquire this lock while leaving softirqs enabled.
If a hardware interrupt occurs on the same CPU while the lock is held,
plx_dma_isr() will schedule the plx_dma_desc_task tasklet.

Upon return from the interrupt, the softirq executes the tasklet, which cal=
ls
plx_dma_process_desc() again. Can this result in a recursive deadlock when =
it
attempts to acquire the already-held ring_lock?

[ ... ]
> 		dmaengine_desc_get_callback_invoke(&desc->txd, &res);

[Severity: High]
This isn't a bug introduced by this patch, but does invoking the client
callback while holding the internal spinlock expose us to a recursive deadl=
ock?

It is a common DMA engine pattern for client callbacks to chain descriptor
submissions. If the callback submits a new DMA transaction, it will call:
plx_dma_prep_memcpy() -> spin_lock_bh(&plxdev->ring_lock)

Since the lock is already actively held by plx_dma_process_desc() on the sa=
me
CPU, will this cause an immediate deadlock?

[ ... ]
> static struct dma_async_tx_descriptor *plx_dma_prep_memcpy(struct dma_cha=
n *c,
> 		dma_addr_t dma_dst, dma_addr_t dma_src, size_t len,
> 		unsigned long flags)
> 	__acquires(plxdev->ring_lock)
> {
> 	struct plx_dma_dev *plxdev =3D chan_to_plx_dma_dev(c);
> 	struct plx_dma_desc *plxdesc;
>=20
> 	spin_lock_bh(&plxdev->ring_lock);
[ ... ]
> 	/* return with the lock held, it will be released in tx_submit */
>=20
> 	return &plxdesc->txd;

[Severity: High]
This is a pre-existing issue, but does returning to the caller with the
spinlock held and bottom halves disabled violate the DMA API contract?

If a client driver prepares multiple descriptors sequentially, such as call=
ing
dmaengine_prep_dma_memcpy() twice before submitting, won't it deadlock on t=
he
second call?

Additionally, if the client encounters an error between preparation and
submission and never calls tx_submit(), will the lock be permanently leaked,
leaving softirqs disabled on that CPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831191403.2076=
31-1-logang@deltatee.com?part=3D12
