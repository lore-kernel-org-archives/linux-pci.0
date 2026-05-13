Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239FD184;
	Wed, 13 May 2026 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778716501; cv=none; b=DZ2Mt+oRivcK8VLQs/3VK0LvGS/NF2D+hUhSecKah6PPp8Y4FpXNQsYgpAN6K6aqEbQP+JCTQ25cx6Cwm3ZC6LG5ROs5I/1Z0G0Uji4ear8oNsfAIxjP27NEU8trlT7vBmUQ9eXH4DM+FTNndSKPIKwklvW2g9yoDlbmSbAqDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778716501; c=relaxed/simple;
	bh=evQHOw2dQf4OuTeUzalmIlHr3ylZFYPAqqfBiZOG6MA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CvIvwMSfN+L4y+ZSNYzLRj0WWyGlBPziEls19QgTg66PPxZ9FdxfLdLGMETWkqox27i6GAM5N6x8wDb5Iu7wCHeC+hdaqUse+kfdlJM7rvkSRsg6a3KDEsLjLalsvTe4zgUIt0oMYnJqBGGuro0h2m3ciRFU6HEqNYsqC5NTcSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvUydXaJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvUydXaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738CDC19425;
	Wed, 13 May 2026 23:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778716500;
	bh=evQHOw2dQf4OuTeUzalmIlHr3ylZFYPAqqfBiZOG6MA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nvUydXaJ9/IJsDq4V7IXClUJ2cJucEO9+F1qS+f71vjiQkKo6FfKC8IfvXSlJvTL5
	 vzm367jR3TXI2BpqI3AE9xvAZiKw4zW2fFF+mS+S4yGPL4+3LoKZVCAqHfd17O892S
	 CQMOI1zRxQ4ffza8xln2KEU+6JnPldowU7BVUK9O3CJTE5dyr7hhu4qB71KCa+tuAB
	 UAZ89LWM4lv0AvTdNJX+0eyfOuBFnbBhxkAWgcHGDZIPAwyzsIREIvURpsBBCMjDsA
	 Cr8jzxOPk7dqz9VKNGHG5ukGxR5XyJoPx6l1whMuKYK1f+VVbNKkO6e3+Wn+AngNK2
	 /XgcWQ68g4Olw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] dmaengine: Add safe API to combine configuration
 and preparation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frank Li" <Frank.Li@nxp.com>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260512-dma_prep_config-v5-2-26865bf7d935@nxp.com>
References: <20260512-dma_prep_config-v5-2-26865bf7d935@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 23:54:59 +0000
Message-Id: <20260513235500.738CDC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Same-CPU deadlock due to `spin_lock()` usage in `dmaengine_prep_co=
nfig_sg_safe()` without disabling interrupts or bottom halves.
- [Medium] Meaningful documentation and implementation mismatch regarding t=
he synchronization primitive.
--

commit ed90e3a56790f8af46ffd2c002993a841a7927be
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: Add safe API to combine configuration and preparation

This commit introduces dmaengine_prep_config_sg_safe() and
dmaengine_prep_config_single_safe() to provide a reentrant-safe way to
combine slave configuration and transfer preparation. It uses a new device
callback or falls back to a per-channel lock.

> Drivers may implement the new device_prep_config_sg() callback to perform
> both steps atomically. If the callback is not provided, the helpers fall
> back to calling dmaengine_slave_config() followed by
> dmaengine_prep_slave_sg() under per-channel mutex protection.

This isn't a bug, but the commit message mentions mutex protection while
the code implements a spinlock. Could the commit message be updated to
reflect the actual synchronization primitive used?

> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index defa377d2ef54..83e8547de89bf 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h

[ ... ]

> +static inline struct dma_async_tx_descriptor *
> +dmaengine_prep_config_sg_safe(struct dma_chan *chan, struct scatterlist =
*sgl,
> +			      unsigned int sg_len,
> +			      enum dma_transfer_direction dir,
> +			      unsigned long flags,
> +			      struct dma_slave_config *config)
> +{
> +	struct dma_async_tx_descriptor *tx;
> +
> +	if (!chan || !chan->device)
> +		return NULL;
> +
> +	if (!chan->device->device_prep_config_sg)
> +		spin_lock(&chan->lock);

Can this cause a same-CPU deadlock?

The documentation in struct dma_chan notes that *_prep() may be called
from a completion callback. Since completion callbacks often execute in
softirq or hardirq contexts, if a thread calls this function from
process context, local interrupts remain enabled.

If a DMA interrupt fires on the same CPU while the lock is held, the
completion callback could attempt to call this function again to queue
the next transfer, leading it to wait on the already-held chan->lock.

Does this fallback path need to use spin_lock_irqsave() and
spin_unlock_irqrestore() to safely disable interrupts?

> +
> +	tx =3D dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, config);
> +
> +	if (!chan->device->device_prep_config_sg)
> +		spin_unlock(&chan->lock);
> +
> +	return tx;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512-dma_prep_c=
onfig-v5-0-26865bf7d935@nxp.com?part=3D2
