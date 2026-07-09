Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D688405C3B;
	Thu,  9 Jul 2026 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612230; cv=none; b=oe3esMZs5pi39qwzgmBtERWkrVWur/2tLV35DzSH/4LmKoZgG7T9y1zOMDRo4X3Mic5rTqTVGlVaD+Rw58RbJeUaE6f6hzJJH9OIX+dGcI6keokB1j1Iy6214gwtKMlaMDegCJabZ+DjGMQkvh44DgwbY5yqUAqQIvnWVPRY1KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612230; c=relaxed/simple;
	bh=p61JnNmORJCAS5qpy197F3v+UJ8Cus4bOe/jeDUJJKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MPodqHoR+k2cbiQasNptniGqP0J0ak1R2OsF+tyjBYKdYbyrtu73N/tV9gX9153qnEauQTr/RyTrCTFXVFMudzCT4eD9p3SVvcaOiK1HE5mVU6iRANd3E2f6FHfR4FZUZz1NL4hgb13jPTCGqcyPqf6ktJ91ML0W9Sr6zg4sOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJRZckMR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJRZckMR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBDF1F000E9;
	Thu,  9 Jul 2026 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783612227;
	bh=DnH83pvC0h4TUwGP2rKo4bDR733vXWJJf+PZeTxwNoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MJRZckMReQxWPGJ1m9AuSnP1BxB8pxTuokTP4bi1J+/qNQRSsdChVfkhF6kjISqKY
	 en+3I6zj0c/vN3CXJMlfFoeAqI0io36ewFFtQILsoHWuApGqcNjUNCEnaqUHiGn/0P
	 V70aPmpRNED+8UWiTAVI4uOtpsh6ykKnhTyLOUmnwUzMad6So9CWPoEP3t3vc/fV6m
	 6AavjiWpd104AdSoG4W24BgUyhutaXeisxKX3L0yIEe6rLFIv37L8/nQDyE6EhzHla
	 8G3j40oU0oZatCUrqyWX+ljX7Wv/RUhxX9M0UEKiujnp9HpJ5XxrGFWFigVBMSTjqy
	 /qgZiwqQQAlUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/10] dmaengine: dw-edma: Add non_ll_start()
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260709-edma_ll-v5-7-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
 <20260709-edma_ll-v5-7-e199053d4300@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:50:26 +0000
Message-Id: <20260709155026.BEBDF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing spinlock in dw_edma_device_resume leads to list corruption=
 and double-free vulnerabilities.
--

--- Patch [7]: [PATCH v5 07/10] dmaengine: dw-edma: Add non_ll_start() call=
back ---
commit ea651917c2d3298c559360685146e9b6a9ee99c3
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Add non_ll_start() callback
   =20
Add a non_ll_start() callback and move the common non-linked-list channel
handling into the EDMA core so it can be shared by both the EDMA and HDMA.
Prepare for the upcoming reorganization of the burst and chunk structures.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-=
edma-core.h
> index bab4d49c92feb..e18d6e827c2c9 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h

[ ... ]

> @@ -201,7 +202,16 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, =
enum dw_edma_dir dir,
>  static inline
>  void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk,=
 bool first)
>  {
> -	dw->core->start(chunk, first);
> +	if (chunk->chan->non_ll) {
> +		struct dw_edma_burst *child;
> +
> +		child =3D list_first_entry_or_null(&chunk->burst->list,
> +						 struct dw_edma_burst, list);
> +		if (child)
> +			dw->core->non_ll_start(chunk->chan, child);

[Severity: High]
This isn't a bug introduced by this patch, but does dw_edma_device_resume()
safely call dw_edma_start_transfer() without holding the virtual channel
spinlock (chan->vc.lock)?

In drivers/dma/dw-edma/dw-edma-core.c:

dw_edma_device_resume()
    chan->status =3D EDMA_ST_BUSY;
    dw_edma_start_transfer(chan);

When dw_edma_start_transfer() executes, it starts the hardware and then fre=
es
the chunk descriptor:

dw_edma_start_transfer()
    dw_edma_core_start(dw, child, !desc->xfer_sz);
    desc->xfer_sz +=3D child->xfer_sz;
    dw_edma_free_burst(child);
    list_del(&child->list);
    kfree(child);

Since hardware is started before the descriptor is safely removed from
the list and freed, and no lock is held during resume, could the hardware
complete the transfer and fire an interrupt immediately?

This would cause the interrupt handler (dw_edma_done_interrupt) to acquire
the spinlock and concurrently process the same chunk, leading to list
corruption and a double-free on the descriptor memory.

> +	} else {
> +		dw->core->start(chunk, first);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-edma_ll-v5=
-0-e199053d4300@nxp.com?part=3D7
