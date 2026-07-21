Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6A25392A;
	Tue, 21 Jul 2026 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651732; cv=none; b=YwiG65OMhLwAQFYcjw9u/B9tdTNJ6ZDEMISMKp7l1HGXmKTIDj2zMybZ8rtFCumKgCPwo44/OIiAuER8o9WYH8wdnjLm1z+x7t/bNJdTgM1Euer3+Pf1JAEKqRIoAgtR2BacjEdS1iCTeD+UJ1/J98s1KxjEO3qLpSqSC5ker9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651732; c=relaxed/simple;
	bh=xdjZO9f8ZzjGLf1fH2fYAwbHdf5sRimwUGjFZJW3OXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e4DTthqHSU2NLZT6piNqSQp9o5CIG+/tlBqMxqIf0xJrfTijko21ubPa9uQpfRQgv60iYONcu8DS8Xjz1XLZ+BGNSAsYdAGctgr26+NZYJbTDf6Yr4dLj2R2N/deDizq686HqoY1tMms5QcEIK5kAckC4P+buErCCmkF4zgKpzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGdvIfJo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGdvIfJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955891F00A3A;
	Tue, 21 Jul 2026 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651730;
	bh=874nwZ4mVNwt2lQB6+iP6PqGXhQIGZZLp7w9QXmJ14M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GGdvIfJoyc8yYiktQ6jqLxkA+nCnUt739ilej03GgtLBkq+1iUIZvCr5rvW559biz
	 h9BbfvqZO+GlQN5YMYNHETHQVFn/O9HWyQvt3pwrPGy/xO+/tNV6Mmp5/lGms+RPAB
	 VaN+E+DtK/znYduCxuJLFah51H8kbVldDTnxIYtoqd/YmI1Ex/MFX9s5tJ1tnch6oO
	 vcAh3ubtWJaQZt96gQ8fiMGLEqJ8mrLFcTKTJjkS14rsn8YcKOZxcm97X8lW4xz4cS
	 MTz3fOlie+NdLTGLdPJLHzQd3ueF2rL35824syfQdL8aFa+wVBU6Lk73VwHneGqUFd
	 Mnn9bAlt+1mDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/11] dmaengine: plx_dma: fix NULL pointer deref in
 plx_dma_isr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260721155739.62120-12-logang@deltatee.com>
References: <20260721155739.62120-1-logang@deltatee.com>
 <20260721155739.62120-12-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:35:30 +0000
Message-Id: <20260721163530.955891F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Deadlock in `plx_dma_process_desc()` because it uses `spin_lock()`=
 instead of `spin_lock_bh()`, allowing preemption by softirqs/tasklets.
- [High] Recursive deadlock in `plx_dma_process_desc()` and `plx_dma_abort_=
desc()` due to invoking client callbacks while holding `ring_lock`.
--

--- Patch [11]: [PATCH v2 11/11] dmaengine: plx_dma: fix NULL pointer deref=
 in plx_dma_isr() ---
commit eb45a79e5c7876e25dd34346cbd03538a3ed67e0
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()

This commit moves the plxdev->bar initialization before calling
request_irq(). This prevents a NULL pointer dereference that could occur if
an interrupt fires immediately and plx_dma_isr() attempts to access the
uninitialized bar.

Link: https://lore.kernel.org/all/20260610112121.676561-1-jjy600901@snu.ac.=
kr

> diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
> index 84941a918b01f..409898e92c320 100644
> --- a/drivers/dma/plx_dma.c
> +++ b/drivers/dma/plx_dma.c
> @@ -504,17 +504,17 @@ static int plx_dma_create(struct pci_dev *pdev)
>  	if (!plxdev)
>  		return -ENOMEM;
> =20
> -	rc =3D request_irq(pci_irq_vector(pdev, 0), plx_dma_isr, 0,
> -			 KBUILD_MODNAME, plxdev);
> -	if (rc)
> -		goto free_plx;
> -
>  	spin_lock_init(&plxdev->ring_lock);
>  	tasklet_setup(&plxdev->desc_task, plx_dma_desc_task);
> =20
>  	RCU_INIT_POINTER(plxdev->pdev, pdev);
>  	plxdev->bar =3D pcim_iomap_table(pdev)[0];
> =20
> +	rc =3D request_irq(pci_irq_vector(pdev, 0), plx_dma_isr, 0,
> +			 KBUILD_MODNAME, plxdev);
> +	if (rc)
> +		goto free_plx;
> +

[Severity: High]
This is a pre-existing issue, but can this code cause a deadlock?

When plx_dma_tx_status() is called from process context with softirqs enabl=
ed,
it invokes plx_dma_process_desc() which acquires ring_lock using spin_lock(=
):

drivers/dma/plx_dma.c:plx_dma_tx_status() {
    ...
    plx_dma_process_desc(plxdev);
    ...
}

drivers/dma/plx_dma.c:plx_dma_process_desc() {
    ...
    spin_lock(&plxdev->ring_lock);
    ...
}

If a hardware interrupt occurs on the same CPU while the lock is held, the =
IRQ
handler schedules the desc_task tasklet. When the IRQ returns, the softirq
handler executes the tasklet on the same CPU, which also calls
plx_dma_process_desc() and attempts to acquire the already-held lock.

Should plx_dma_process_desc() use spin_lock_bh() instead to disable softirq=
s?

[Severity: High]
This is a pre-existing issue, but does invoking the client callback while
holding ring_lock cause a recursive deadlock?

Looking at plx_dma_process_desc(), the client callback is invoked via
dmaengine_desc_get_callback_invoke() while the lock is still held:

drivers/dma/plx_dma.c:plx_dma_process_desc() {
    ...
    spin_lock(&plxdev->ring_lock);
    ...
    dmaengine_desc_get_callback_invoke(&desc->txd, &res);
    ...
}

This also happens during abort:

drivers/dma/plx_dma.c:plx_dma_abort_desc() {
    ...
    dmaengine_desc_get_callback_invoke(&desc->txd, &res);
    ...
}

If the DMA client's completion callback prepares and submits chained DMA
transactions by calling dmaengine_prep_dma_memcpy(), it re-enters the drive=
r:

drivers/dma/plx_dma.c:plx_dma_prep_memcpy() {
    ...
    spin_lock_bh(&plxdev->ring_lock);
    ...
}

Could this attempt to re-acquire the non-recursive ring_lock on the same CPU
cause a hard lockup? Should the lock be dropped before invoking the callbac=
k?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721155739.6212=
0-1-logang@deltatee.com?part=3D11
