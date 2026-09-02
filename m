Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACC52D2385;
	Wed,  2 Sep 2026 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330999; cv=none; b=isPVM4hpdsAkEP3qybtgGNvQcHpgDG1BwypbhiSmnkapQc9LwxLSB6Lya0gBf5Jo6N7PHOWX1R0/BO3hB7Gbte5PKrbnQ+fNqCgCQ0dSJqS8NtMZcgsgXUWdUSX/WhwqtgZNwH4kqGr1K+xP+1guJaNnKs5/3vTHP6xQW3uZ89g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330999; c=relaxed/simple;
	bh=VkL/xT76S0Amjgo9G6AMcIjlt/wZQunl/W2ZuMxitd8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tIzloPBUufLRXjTL54+sntvqcdG1cL7E/oG7CXFIJqRsU2TSzbyjSZNL+Z2ZMIZjy2M79koTqU+hh3rVnfHxFV9RAU8IkNqgvo2H7HrknCpVHRO7VZJYuO+CPccHzVXSkrtToUzMx7yZfyU/pKBnQMZCFMySnJFbKAKZDBY/N0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d01W6tm/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d01W6tm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ACF1F000E9;
	Wed,  2 Sep 2026 06:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788330998;
	bh=LEb9kZgS3HiHCpQpq3RshEygxkeLVFR6L8I8Gvd7jLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d01W6tm/5AeX7l6JjD/uvFvzV3bnhyHXeWHYjJ4wYFpKEjqyQDkliVcc+bj0VZzFl
	 Q9VutmBt/nxzCO7uATiGNj5I2jDFQz9aQW+52p7DQAvZss2LYoy4qjKiotInGiqWto
	 RF4gOROD952unIRBwojVsuzf/2/ENLqMlZRQ8aKmI00FRyHCikyIm5nMvHWCnQYp9e
	 SVdSVqypPzBfygXMa+KfUBLGjo0N/DqgzD7XDUvvBIt+TkftkykFxEO/c3SNLaQE//
	 bbVXqXUxhB2Ja/0aSZkPFNlzCI62XoVteufVdUTHJ2mDh4bP/FOZokz6nDHIznSBYp
	 dmcGCvuYu9iSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/10] dmaengine: switchtec-dma: fix resource leak in
 alloc_chan_resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260902062153.31048-3-logang@deltatee.com>
References: <20260902062153.31048-1-logang@deltatee.com>
 <20260902062153.31048-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:36:37 +0000
Message-Id: <20260902063638.07ACF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition in switchtec_dma_remove allows concurrent channel a=
llocations on a broken channel.
--

commit f369eaa9794c069cc909c5cee24ba55c0cfa8c48
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix resource leak in alloc_chan_resources

This commit adds an error-unwind path to switchtec_dma_alloc_chan_resources=
()
to prevent resource leaks when channel initialization fails. It ensures
descriptor rings are freed and the channel is disabled and marked inactive
on error.

Link: https://lore.kernel.org/dmaengine/20260707165555.350951F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index a10818efba4e5..e55fe9ff7e2c5 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c

[ ... ]

> @@ -1007,7 +1007,8 @@ static int switchtec_dma_alloc_chan_resources(struc=
t dma_chan *chan)
>  	rcu_read_lock();
>  	if (!rcu_dereference(swdma_dev->pdev)) {

[Severity: High]
This isn't a bug introduced by this patch, but is there a pre-existing race
condition here between channel allocation and device removal?

During device unbind or hot-unplug, switchtec_dma_remove() calls
switchtec_dma_chans_release(), which frees the channel IRQs and kills
tasklets, then clears swdma_dev->pdev:

drivers/dma/switchtec_dma.c:switchtec_dma_remove() {
    ...
    switchtec_dma_chans_release(pdev, swdma_dev);
    rcu_assign_pointer(swdma_dev->pdev, NULL);
    synchronize_rcu();
    pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
    pci_free_irq_vectors(pdev);
    dma_async_device_unregister(&swdma_dev->dma_dev);
}

Because dma_async_device_unregister() happens much later, a concurrent
client calling dma_request_chan() can still invoke
switchtec_dma_alloc_chan_resources(). If this executes before
swdma_dev->pdev is set to NULL, it successfully allocates the channel and
sets ring_active =3D true, unaware that the IRQ and tasklet were already
destroyed.

Could this cause the client to hang waiting for a freed IRQ, or trigger a
system crash due to unmapped memory access when switchtec_dma_remove()
subsequently unmaps the hardware registers?

>  		rcu_read_unlock();
> -		return -ENODEV;
> +		rc =3D -ENODEV;
> +		goto err_ring_inactive;
>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902062153.3104=
8-1-logang@deltatee.com?part=3D2
