Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708E25C818
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 02:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983833; cv=none; b=lEiGWSYCDpZNsNU4W3dhv3gowW7lpDTSqXvZ0hiiCLYKWfQx5N/tOBWlfd57eR8usEF3NHyn1NSogtaGMbnAhp4oYa/7mAurk8UROScWp9CYtW/Xe0d5WNyl6Z3FBtoeD0FYApGlGzHqkM6D7PGCsa4ksA4IT4TcbYax9zp2OkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983833; c=relaxed/simple;
	bh=9GkJKiqoFSkhLs8/Evie0FlAS7pgKsAU06ZHaENx7jg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nkri82sETDw1yP4fLvF6QrE5EpTt8qOj8zxz6XkzQQ58mxTxI2P5kk7m/+0NMDWGfjdM50xVxFHuXHiqT2yHgXSXZyk8jI3NELVzUylruVNVG1ttB+FJf8FEwOY/xeM/Q00fCAxTFvNnMo3L/Tp/zWq72YBxoz4XgUm4oAOFGtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIrGmCT0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIrGmCT0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FA71F000E9;
	Thu,  6 Aug 2026 02:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785983831;
	bh=5asnv2NAFlLOu0LZ7W17Kep8eK4IUKaauxCmHFlMwzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hIrGmCT0AYft91vX6K6RAxZgx2OysHvHBTKT4BU5bGf2ggSpc+ZwqGDx3l85slLB9
	 mkAhqqUOBUdZLEQ4zwpsG0FT8R6n31xUpWcxzaXvVkLEUE+HgBZMF3x/o5CUuTJH6z
	 CmbjRZuZAvae2LUSP4rh805GEGsz669Wi6KDTJVDaxG/LBsuL7UiUFmWScjoqdTJP6
	 T+DR0teZolif/8jGNITIxQfQ/vUcHBd/0014zCvY+Z0t2lhag+SRC2zlxDnZ1pBwJY
	 6Bahhuh7wCifD4/0DKCDhEa1mpyNd2KQeMDYwlLgkODsVHaybEdDjz3JbfaaQ3fUqi
	 VIeIfhgmCtHig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: switchtec: Fix use-after-free in
 switchtec_pci_remove due to race condition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pei Xiao" <xiaopei01@kylinos.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1f52d931ec7a7f5b36837cabf07b36e0463bf182.1785982054.git.xiaopei01@kylinos.cn>
References: <1f52d931ec7a7f5b36837cabf07b36e0463bf182.1785982054.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 02:37:10 +0000
Message-Id: <20260806023711.52FA71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The delayed work `mrpc_timeout` can be concurrently re-armed by `s=
witchtec_dev_write()` after being cancelled in `stdev_kill()`, leading to U=
AF of devm-freed MMIO or `stdev`.
- [High] Probe error path bypasses `stdev_kill()`, leading to UAF of `stdev=
` by active devm-managed IRQs and uncancelled workqueues.
- [High] Missing `dma_rmb()` between reading DMA status and DMA data.
--

--- Patch [1]: [PATCH v2] PCI: switchtec: Fix use-after-free in switchtec_p=
ci_remove due to race condition ---
commit 1cdcc605287dd43ead581c21636460c8793d36f2
Author: Pei Xiao <xiaopei01@kylinos.cn>
Subject: PCI: switchtec: Fix use-after-free in switchtec_pci_remove due to =
race condition

This commit attempts to fix a use-after-free bug during device removal by
explicitly clearing bus master and freeing IRQs before cancelling workqueue=
s.

> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchte=
c.c
> index 41fc4b5127081..4b0988013c69d 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1318,6 +1318,13 @@ static void stdev_kill(struct switchtec_dev *stdev)
> =20
>  	pci_clear_master(stdev->pdev);
> =20
> +	if (stdev->event_irq >=3D 0)
> +		devm_free_irq(&stdev->pdev->dev, stdev->event_irq, stdev);
> +	if (stdev->dma_mrpc_irq >=3D 0)
> +		devm_free_irq(&stdev->pdev->dev, stdev->dma_mrpc_irq, stdev);
> +
> +	cancel_work_sync(&stdev->mrpc_work);
> +	cancel_work_sync(&stdev->link_event_work);
>  	cancel_delayed_work_sync(&stdev->mrpc_timeout);
> =20
>  	/* Mark the hardware as unavailable and complete all completions */

[Severity: High]
This is a pre-existing issue, but can the delayed work mrpc_timeout be
concurrently re-armed after it is cancelled here?

During device removal, stdev_kill() cancels mrpc_timeout before holding
mrpc_mutex and setting alive =3D false:

drivers/pci/switch/switchtec.c:stdev_kill() {
	...
	cancel_delayed_work_sync(&stdev->mrpc_timeout);
	scoped_guard (mutex, &stdev->mrpc_mutex) {
		stdev->alive =3D false;
	...
}

Could userspace concurrently call switchtec_dev_write(), pass the alive
check, and re-arm the delayed work?

drivers/pci/switch/switchtec.c:switchtec_dev_write() {
	...
	rc =3D lock_mutex_and_test_alive(stdev);
	if (rc)
		return rc;
	...
	schedule_delayed_work(&stdev->mrpc_timeout, ...);
}

If the timeout fires later, could this result in a use-after-free when
stdev has already been freed by devres?

[ ... ]

> @@ -1529,7 +1539,11 @@ static int switchtec_init_isr(struct switchtec_dev=
 *stdev)
>  				switchtec_dma_mrpc_isr, 0,
>  				KBUILD_MODNAME, stdev);
> =20
> -	return rc;
> +	if (rc)
> +		return rc;

[Severity: High]
This isn't a bug introduced by this patch, but if switchtec_init_isr() fails
here, does the probe error path leak resources or cause a use-after-free?

If we return rc here, the caller switchtec_pci_probe() jumps to err_exit_pc=
i:

drivers/pci/switch/switchtec.c:switchtec_pci_probe() {
	...
	rc =3D switchtec_init_isr(stdev);
	if (rc) {
		dev_err(&stdev->dev, "failed to init isr.\n");
		goto err_exit_pci;
	}
	...
err_devadd:
	stdev_kill(stdev);
err_exit_pci:
	switchtec_exit_pci(stdev);
err_put:
	ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
	put_device(&stdev->dev);
}

Since err_exit_pci bypasses stdev_kill(), active devm-managed IRQs and
uncancelled workqueues (like mrpc_work) are not cleaned up before
put_device() frees stdev.

Could an interrupt fire during this window and execute switchtec_event_isr(=
),
leading to a use-after-free of stdev?

> +	stdev->dma_mrpc_irq =3D dma_mrpc_irq;
> +
> +	return 0;
>  }

Additionally, while reviewing the code, I noticed another pre-existing issue
in mrpc_complete_cmd():

[Severity: High]
This is a pre-existing issue, but is there a missing dma_rmb() between
reading the DMA status and the DMA data?

drivers/pci/switch/switchtec.c:mrpc_complete_cmd() {
	if (stdev->dma_mrpc)
		stuser->status =3D stdev->dma_mrpc->status;
	else
		stuser->status =3D ioread32(&stdev->mmio_mrpc->status);

	if (stuser->status =3D=3D SWITCHTEC_MRPC_STATUS_INPROGRESS)
		return;
	...
	if (stdev->dma_mrpc)
		memcpy(stuser->data, &stdev->dma_mrpc->data,
			      stuser->read_len);
}

Since the DMA buffer is allocated with dma_alloc_coherent(), memory accesses
are coherent but not strictly ordered on weakly-ordered architectures like
ARM64.

Can the CPU speculatively read the payload data before the status
read completes, resulting in stale data being processed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1f52d931ec7a7f5b368=
37cabf07b36e0463bf182.1785982054.git.xiaopei01@kylinos.cn?part=3D1
