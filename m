Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB496274658;
	Mon, 13 Jul 2026 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963027; cv=none; b=pcqF7FIL9ty+Milv+5a0FQyD/nxw+uDCr6D7duvZIouT0sHeGBY8zghBVdv1FqxeCKmgnW4rgnKrvEKcuGeuwuIEeyrm5xdVqtJgUEq80roEfa6UE7FLmvGUB/9IdO7F5wbnkYKYvakbgwxUyaYMZ5UFiAEUeNOcxw8FbIXzwPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963027; c=relaxed/simple;
	bh=s28AuOkjvL/i/HLAAPcBiO0lo7VFWcfVu4n7H8RvWEs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X81di3B05lPmD4W6s+hqUXIvKMSlYYJ3Arxg2YFo84uDAE0KybYl6Yx8vjJQxqDRePFGhi/DGPoOCJUCfOKt1b1RzPe1M71r4vai0zE+O/WFnrNWBdz7BY5JV/88c3CRC0tsJUWI+Rx58dM7H0wN15ZvadnsFSs0+a6rvVhA5TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkzObDg4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkzObDg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90E71F00A3F;
	Mon, 13 Jul 2026 17:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783963025;
	bh=SVjSsyjKWmruGaWb6WysXjlU9sgpPQ4o3YxHOnQG0BY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EkzObDg4BbgBWICgis6MyX684zpNmQYy6RQJoeA2HizLaRheeeu/f+OEaaM9pB1wr
	 PPvlcSs9z1rmcQ4EYsKYNlcwenkV9bVwyWfcKxPttgQtDhSS5UQgGXzR9OdAfr6hhm
	 lATzuS0xUB0SGAFK6RQcxIDzj6u2QZa5/TfrwkzY/2xwvnX+vpdIz7P1yHV266Hfo2
	 hGyCt7iUdG/uCpm7Ajzb3pAA5ER08jKKT1xkag4NFtRD72c8+Z5cFvJb74OaDQGfwn
	 oTlbFtYmYXLorCQPflaf+0JL7hnwjhk809Jf9gD6bM88afQllbkl1R9lXwhh0ftGhp
	 okVqmM9EGcvQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/10] dmaengine: dw-edma: Add xfer_sz field to
 struct dw_edma_chunk
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260713-edma_ll-v7-2-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-2-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:17:04 +0000
Message-Id: <20260713171704.C90E71F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The dmaengine API functions `dw_edma_device_resume`, `dw_edma_devi=
ce_pause`, and `dw_edma_device_terminate_all` modify shared channel state a=
nd process descriptor lists without holding the `chan->vc.lock`.
- [High] The driver improperly handles `DMA_CYCLIC` transfers by treating t=
hem as finite transfers that complete after `cnt` periods, rather than runn=
ing continuously. It calls `vchan_cookie_complete()` instead of `vchan_cycl=
ic_callback()`, causing the transfer to terminate and the descriptor to be =
freed.
- [High] The `dw_edma_device_terminate_all()` function fails to remove and =
free pending descriptors from the virt-dma queues. It only sets a state fla=
g (`EDMA_REQ_STOP`) for the active transfer without flushing the `desc_subm=
itted` or `desc_issued` lists.
--

--- Patch [2]: [PATCH v7 02/10] dmaengine: dw-edma: Add xfer_sz field to st=
ruct dw_edma_chunk ---
commit 1deb608bf55aafc03752bddfec980c583d0db45e
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk

This commit adds a new xfer_sz field to struct dw_edma_chunk to explicitly
track the total transfer size. It replaces the misleading use of
ll_region.sz, which represents the memory size of the EDMA link list rather
than the data payload. The core start and setup functions are updated to
use this new field to correctly calculate transfer sizes.

Tested-by: Koichiro Den <den@valinux.co.jp>
Tested-By: Devendra Verma <devendra.verma@amd.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 1fec1b52e3d47..53469c8c8b82e 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -192,7 +192,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan=
 *chan)
>  		return 0;
> =20
>  	dw_edma_core_start(dw, child, !desc->xfer_sz);
> -	desc->xfer_sz +=3D child->ll_region.sz;
> +	desc->xfer_sz +=3D child->xfer_sz;

[Severity: High]
This is a pre-existing issue, but since dw_edma_start_transfer() is being
modified here, is it safe to call this function without holding
chan->vc.lock?

When a client driver calls dmaengine_resume(), it invokes
dw_edma_device_resume(), which directly calls dw_edma_start_transfer()
without acquiring the lock:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_resume() {
        ...
        chan->status =3D EDMA_ST_BUSY;
        dw_edma_start_transfer(chan);
        ...
}

Inside dw_edma_start_transfer(), vchan_next_desc() is called, which has a
strict lockdep_assert_held(&vc->lock) requirement. Since
dw_edma_device_pause() and dw_edma_device_terminate_all() also modify
shared channel state without the lock, could this lead to list corruption
or use-after-free when competing with the hardirq handler
(dw_edma_done_interrupt) that does hold the lock?

>  	dw_edma_free_burst(child);
>  	list_del(&child->list);

[ ... ]

[Severity: High]
This is a pre-existing issue, but does dw_edma_device_terminate_all()
leave stale descriptors in the virt-dma queues?

When termination happens, the driver sets a state flag but skips flushing
the lists:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_terminate_all() {
        ...
        } else if (chan->status =3D=3D EDMA_ST_PAUSE) {
                chan->request =3D EDMA_REQ_STOP;
        }
        ...
}

Without calling vchan_get_all_descriptors() and vchan_dma_desc_free_list(),
if a client calls dmaengine_terminate_all() while descriptors are pending
and then reuses the channel, will those old descriptors be erroneously
executed and cause data corruption?

[Severity: High]
This is a pre-existing issue, but does the DMA_CYCLIC implementation
correctly support continuous hardware looping?

In dw_edma_device_prep_dma_cyclic(), the driver blindly accepts the cyclic
request and sets a finite count:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_prep_dma_cyclic() {
        ...
        xfer.xfer.cyclic.cnt =3D count;
        ...
}

Later, the interrupt handler completes the descriptor instead of
triggering periodic callbacks:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_done_interrupt() {
        ...
                        list_del(&vd->node);
                        vchan_cookie_complete(vd);
        ...
}

Should the interrupt handler call vchan_cyclic_callback(vd) so that
continuous audio or capture buffers don't incorrectly halt after the
initial count iterations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-edma_ll-v7=
-0-6fb7498c901e@nxp.com?part=3D2
