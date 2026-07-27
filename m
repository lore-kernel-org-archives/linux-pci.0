Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBAF40862A;
	Mon, 27 Jul 2026 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176676; cv=none; b=WhAnSYIIkbHL4Kq3N4rid+ugBymLfINnwJmW94CK6F2lGH13pYhXeBKLt2KdEJ/l+NOfkQwPgpzrdspc3TyRsPj38Qh2OMsFAriMq/gGEbNr706Mg8be/qEds55b4Z7RAksR2spGU75V0fQRMKEMfNMbVOA95m9MBMMard6mRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176676; c=relaxed/simple;
	bh=Ujfs5ovPmQC7YWSxqFhEmRsZcmeN5lhJGnnTC6tfAAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cqUq2tEOrlw6EWuiSFf7Z2o7xEwExUAlBisXPNmJy8vzZKHZXHDu9vXxjN5i2P2Q2EQTyxo9F54y6p315uOLUTYc1z0nuD31xx4pnLQpAqISDnfGm0TPuzuWIc2GDaXOJ0pLICjPF9JqrAtCVAZdcaKlwI2NmrpcKZrcGoXWT6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbIenhbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbIenhbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE301F00A3A;
	Mon, 27 Jul 2026 18:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785176674;
	bh=ReY6fMuGgyD4FzvzlcTXbz4xuCCxHAoJtj99gzTc4yM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FbIenhbv4WkV6Oud4gxKdA5NmfZVik8nbv/AxOwfUZWatZCCBR8Wc7ittaC9qqpI2
	 kKr2UAoVuwDLp1VH4+CXFz0MQY+qkC73iHI/yc0hdqd8sGVQ6fZecYiiy7TwNjhVVA
	 wvGQG+xvA+6GGp8hjtX8HW7oHSRmFgeWSGQSjxUk8Q6UEf99y6syAGepR+DrDQ6J4v
	 /1iMc4Y8qJCgO4veO9Mwai2vi4l/pG0OkduA9wOyX9RPePCvT6LWvGjgSM7KocAyEK
	 S1jnQcbw4hADo5R/bvMT786BgKfuwILoqy/rNQbmdsFAlKyzGEkA20bNSvbjc8ue2Q
	 ylYgmTeXKs3DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/6] dmaengine: plx_dma: fix NULL pointer deref in
 plx_dma_isr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260727174837.6645-7-logang@deltatee.com>
References: <20260727174837.6645-1-logang@deltatee.com>
 <20260727174837.6645-7-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:24:34 +0000
Message-Id: <20260727182434.8BE301F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Softirq deadlock due to using `spin_lock()` instead of `spin_lock_=
bh()` in `plx_dma_process_desc()`.
- [High] Missing check for surprise removal (0xffff) in interrupt handler c=
auses IRQ storms on shared legacy interrupts.
--

--- Patch [6]: [PATCH v1 6/6] dmaengine: plx_dma: fix NULL pointer deref in=
 plx_dma_isr() ---
commit 80fb3e2fa6bbdc673ef54e009946f1184a4c94ca
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()

plx_dma_create() registered the interrupt handler with request_irq()
before initializing plxdev->bar. This patch moves the bar assignment
ahead of request_irq() so everything is initialized before the handler
can run.

Link: https://lore.kernel.org/all/20260610112121.676561-1-jjy600901@snu.ac.=
kr/T/#u

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

[Severity: High]
This is a pre-existing issue, but could this lock and tasklet setup lead to=
 a
softirq deadlock?

Looking at plx_dma_process_desc(), it acquires plxdev->ring_lock using
spin_lock() without disabling softirqs. If called from process context, and=
 a
hardware interrupt occurs on the same CPU, the ISR will execute and schedule
this desc_task tasklet.

Upon returning from the ISR, the kernel will execute the softirq on the same
CPU, which attempts to acquire the same ring_lock in plx_dma_desc_task(),
deadlocking the CPU.

Should plx_dma_process_desc() be using spin_lock_bh() instead?

> =20
>  	RCU_INIT_POINTER(plxdev->pdev, pdev);
>  	plxdev->bar =3D pcim_iomap_table(pdev)[0];
> =20
> +	rc =3D request_irq(pci_irq_vector(pdev, 0), plx_dma_isr, 0,
> +			 KBUILD_MODNAME, plxdev);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the ISR hook=
ed
up here, could a surprise removal of the PCI device cause an IRQ storm?

If the device is removed, MMIO reads from plxdev->bar + PLX_REG_INTR_STATUS
in plx_dma_isr() will return 0xffff. Because 0xffff is non-zero, it bypasses
the !status check, writes 0xffff back, and returns IRQ_HANDLED.

Since IRQ_HANDLED is returned, the interrupt subsystem assumes the interrupt
was serviced. If the IRQ line is shared, it will immediately re-trigger,
causing an infinite loop.

Should the ISR explicitly check for 0xffff and return IRQ_NONE?

> +	if (rc)
> +		goto free_plx;
> +
>  	dma =3D &plxdev->dma_dev;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727174837.6645=
-1-logang@deltatee.com?part=3D6
