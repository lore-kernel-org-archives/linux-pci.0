Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E83B5E15;
	Wed, 13 May 2026 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700702; cv=none; b=lxeBA8qrOstdQCswYg1lYHrj8mLe8NBcROMetJP58eSidGIuyXpSN75r96fLCdN5u9tcXB4BNGDmoPO9zWjeVMlhsSfD1FzrXMbEafflQZIoHV1uhU2Wns3EAPLszb3JshdALKkWxDjZD5PYKJeTpjexvW4b7Qw6q5hgn0ghxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700702; c=relaxed/simple;
	bh=vy3DM0yc0X0P2G9G4GSAMSY/6WAbH6F4sJWagWSmz4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bamGF4z8PoF77x++AQD6E/j37QKUr6H75Rt7ovfAeP8pvfv0fx1g3rm2389sy+xKiudYh1y0lTnanW/BTTUMnN0xEO41R1mv/q5g5IHxsutW24li3raFKZ47Mprgy1tqppX9cDw9OCYy42gj/jtwPX9qim15NIWvCrN/vk0GZr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKUsptol; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKUsptol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCCFC19425;
	Wed, 13 May 2026 19:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778700702;
	bh=vy3DM0yc0X0P2G9G4GSAMSY/6WAbH6F4sJWagWSmz4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TKUsptolDPg4VQTiwDGhu3c/ptsafXrez7cYiu1kF98VqOmaHVDwe1Nh25i3WTDpU
	 N7OJ9bhoLP/7Cs7MmaDOuR9DHMS7MmsxRL8Hyo0kpGbR03oIweYyiDiMztfVVz+xGy
	 EoIInP6j6L0C0Qw6BSz7QrXnSRSjwn5gOWzJ6YCj13eHPUfpuW9h4JPpPz2VhML4bd
	 c6oRcVPGLGhLYRFfg6u8kAy+8+VFJKmO45/QDi/CK0sBXnLPyP+QOt9A2/jDKx/IDm
	 K/K5Q26UMloyEawhGYuvtFagm7xVrgzxNtWcjzBTmYUTq83TwvYC40fuXY/AL1Hpjy
	 a8t5lJbckOurg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/23] dmaengine: sdxi: Attach descriptor ring state
 to contexts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260511-sdxi-base-v2-14-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-14-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 19:31:41 +0000
Message-Id: <20260513193141.EDCCFC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Missing Teardown Symmetry / Waitqueue Use-After-Free in `sdxi_=
free_cxt()`
- [High] Premature Publication of Context in `sdxi_cxt_new()`
- [High] RCU Writer-Side Lifetime Violation on Teardown
--

commit f4b3dc996c9b7b91b664eedfb192212e29f22172
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Attach descriptor ring state to contexts

This commit attaches an instance of struct sdxi_ring_state to each
context upon allocation. Each ring state shares the same lifetime as
its context and is freed upon context release.

> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
[ ... ]
> @@ -63,6 +64,7 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
>  		dma_free_coherent(sdxi->dev, sq->ring_size,
>  				  sq->desc_ring, sq->ring_dma);
>  	kfree(cxt->sq);
> +	kfree(cxt->ring_state);
>  	kfree(cxt);
>  }

Earlier in sdxi_free_cxt(), the context is removed from the client_cxts
xarray via xa_erase(). Since the xarray is RCU-protected, concurrent readers
could still be accessing the context under the RCU read lock.

Does this kfree(cxt->ring_state) need to be deferred via kfree_rcu() to
prevent a regression where readers might access freed memory if they obtain=
ed
the pointer just before erasure?

Additionally, if tasks are blocking on the wait queue in the ring state
(for example, during ring reservation), will they be woken up before this
memory is freed?

If a context is torn down while tasks are waiting, it seems they could
hang indefinitely in uninterruptible sleep, or encounter memory corruption
when the wait queue memory is repurposed.

Should there be a teardown sequence that marks the ring as shutting down
and calls wake_up_all(&cxt->ring_state->wqh) to unblock tasks before
freeing the ring state?

[ ... ]
> @@ -396,6 +406,10 @@ struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
> =20
>  	cxt->db =3D sdxi->dbs + cxt->id * sdxi->db_stride;
> =20
> +	sq =3D cxt->sq;
> +	sdxi_ring_state_init(cxt->ring_state, &sq->cxt_sts->read_index,
> +			     sq->write_index, sq->ring_entries, sq->desc_ring);
> +
>  	if (sdxi_publish_cxt(cxt))
>  		return NULL;

It appears sdxi_cxt_id_assign() is called earlier in this function, which
stores the context into the client_cxts xarray.

Could this lead to a race condition? Concurrent lockless lookups might
discover the context through the xarray and attempt to interact with
cxt->ring_state before sdxi_ring_state_init() has initialized its
spinlock and wait queue.

Should sdxi_ring_state_init() be called prior to sdxi_cxt_id_assign() to
ensure the object is fully constructed before it becomes externally visible?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D14
