Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775293B27E3
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104976; cv=none; b=Q9ASA2my/sPOzzxuL5FuC+sS2cfGNupc6IFchu1f9+tFcBZ6hBMz0k3y6GoHgAapYHFxKuf7WD4x+ohNqTvjCT1X9RnKDkNEZpgWJIhuJNQ3wr3gkmzd+4v29VqW8KsVp8WlUDy88D9D7rrKJt5HCVwHUsgohbrzeW7MD8DXDTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104976; c=relaxed/simple;
	bh=9QazxRb2+ueSeTAZWTMCpmbU+O51bA/Pk/ohHQhQWi4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KO7Kt8n9bEbdsynomh6BYj9/4iu0nygxeULlOau67FObC/zI97RTp6dpKLjqcJ4Wun3cTHRb4/RStigLOcogIxvzgx/hhL8cwVsIeV9yi6SKwmOmUDkgAvre0u9fQDqm16o8KMa+cYXrTIe7feUoI4dZbduyxmldiRwVqNXIFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjpnHmBe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjpnHmBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02992C2BCB0;
	Wed,  6 May 2026 22:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104976;
	bh=9QazxRb2+ueSeTAZWTMCpmbU+O51bA/Pk/ohHQhQWi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZjpnHmBepSWtWl9u/RRhGGb4HBQLhv8U8DZH/6OerXtz+3+6OQt/i/dIuj52pSfBn
	 sr2u7xpz2i6MeE2e+doFhysskbVFnGMcrWozRVOuEJE2sUHzkPliPdnz5WwAfKPafy
	 B0931/b32vloMBoGfL3JJfwBYe7dARO4TIGfhFZ0xbgNxl1anGgxHKXbFgp5KgQsHM
	 195I07y/sYixT/7Vh5/bgBlN+1c2neTN6z7KlMqVGJde+MI4OcHZ0ldwwUrrzmhq7r
	 J3qY92q9C0zZaq+1QGYLT6rBXkXsZlqqKjIO+9ykfJTe6RsqB6u71CjLlijrhab62O
	 KxquuI/AlFFHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/9] dmaengine: Add safe API to combine configuration
 and preparation
Reply-To: sashiko@lists.linux.dev
To: "Frank Li" <Frank.Li@nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506-dma_prep_config-v4-2-85b3d22babff@nxp.com>
References: <20260506-dma_prep_config-v4-2-85b3d22babff@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 22:02:55 +0000
Message-Id: <20260506220256.02992C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Deadlock risk due to using `spin_lock()` instead of `spin_lock_irq=
save()`.
- [High] Calling `dmaengine_slave_config()` while holding a spinlock causes=
 'sleeping while atomic' kernel panics.
- [Medium] Meaningful code and commit message mismatch regarding lock type,=
 and truncated comment.
--

commit 4872a557291e0d82176d77b1a17c5e410863322e
Author: Frank Li <Frank.Li@nxp.com>
dmaengine: Add safe API to combine configuration and preparation

This commit introduces dmaengine_prep_config_single_safe() and
dmaengine_prep_config_sg_safe() to provide a safe way to combine slave
configuration and transfer preparation. Drivers can implement a new
device_prep_config_sg() callback or the code falls back to executing both
steps under a per-channel lock.

>  Drivers may implement the new device_prep_config_sg() callback to perform
>  both steps atomically. If the callback is not provided, the helpers fall
>  back to calling dmaengine_slave_config() followed by
>  dmaengine_prep_slave_sg() under per-channel mutex protection.

This isn't a bug, but the commit message mentions per-channel mutex
protection, while the implementation actually uses a spinlock. Could the
commit message be updated to match the code?

> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -341,6 +343,12 @@ struct dma_chan {
>  	dma_cookie_t cookie;
>  	dma_cookie_t completed_cookie;
> =20
> +	/*
> +	 * protect between config and prepare transfer because *_prep() may be
> +	 * called from complete callback, which is in GFP_NOSLEEP context.
> +	 */
> +	spinlock_t lock; /* protect between config and prepare transfer since */

This isn't a bug, but the inline comment for the lock appears to be truncat=
ed
mid-sentence after the word since.

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

Since this API can be called from process context, and completion callbacks
might attempt to re-queue transfers from hardware interrupt context, could
using spin_lock() here cause a deadlock regression if the CPU is interrupted
while holding chan->lock?

Would it be safer to use spin_lock_irqsave() here instead? If so, we might
need a new variable to save the interrupt state to avoid shadowing the
existing flags function argument.

> +
> +	tx =3D dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, config);

Does calling dmaengine_prep_config_sg() while holding a spinlock introduce a
regression where scheduling while atomic panics can occur?

Looking at dmaengine_prep_config_sg(), it calls dmaengine_slave_config(),
which invokes the driver's device_config() callback. Many DMA drivers
expect device_config() to be called in process context and perform sleeping
operations like acquiring mutexes, making sleeping memory allocations, or
calling pm_runtime_get_sync().

> +
> +	if (!chan->device->device_prep_config_sg)
> +		spin_unlock(&chan->lock);
> +
> +	return tx;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506-dma_prep_c=
onfig-v4-0-85b3d22babff@nxp.com?part=3D2
