Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793762659;
	b=M/urMJ5CJmBCmVRcINbFLATA80MMiTljYWXoMNxwMYgOG0fCckaJ1P7xE+hDsD7w2Iiw
	 42nC7CofvTwq8QpjtwcKcFO1gYkEVgwukNVHGxygWA6E7yCp8EbH+KFqcxgl/qGF38n+0
	 eUJ3c0IoGimU4ka8h+dEMh1dAtwKiF/Dt7h2tcnBizFlYZUrFrd9JGpz2Wq30pvwUnSM7
	 xukRtfdN4NGbHCTlC6frSliCakpHGcC5FlK9p6xyk8liLAbAgC05Kucur5kXsYv8hvgVx
	 La9y2F0f8NJyCuY3ajuaUZ52M5x6PXWzoBG9DutEyZzndnyun2tMMKzidhKnexVAiVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762659;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A0veCGc5EGpXKHYWDjee/mWd0dve/lhTUFbPf1fweh4=;
	b=lKxDEtEEegGQ/qF+9hCoUbHtJj1WaBPU99wCTw3/BC6XzQ6Y+ItmRiyI5ep++fJouyYK
	 4jB+smvXBuMb/idHrBKsv6Pc6ZvMPPlbXKPdvRHFDIYcFExLucYkwLeu0kpLnvPgiUlDM
	 1KM4Nt2v6E+nBeWp692/lEEtrWfDpOScjSomf1+x5pPihGDiSfCWFG8jWGu+rVlb41c/k
	 Dy4Ut+vnTpQoh/DeKp4sUtAgacVLTqZRhrmTbfm/Bn1G777oEgRkTH6koiMTlWXnXMSAx
	 ueYgrF0LfrVCLpQeTRc2OZ580rpNSIB6BkBA9Yz5M6X+pAkpApV1atPHmdH4VSO5NWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjAag3Kq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11A6606A326;
	Wed,  4 Nov 2026 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjAag3Kq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568C51F00A16;
	Wed,  4 Nov 2026 03:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793762658;
	bh=A0veCGc5EGpXKHYWDjee/mWd0dve/lhTUFbPf1fweh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HjAag3Kq06B97XxqfdA4yVyaRhtqqVgu1FrbIposVigJAgtIrmKoM5cfI/M40U1lx
	 NE71wB1cFWQuVuH5h9x2iTUeIapiGlNavYtNDUiwhkIaZ/BlKOU1vhsXEJ6hs0eyNM
	 uAFKCsfjPtVOsDqwqZCrN1Eww+WniGHmNUU7xJEkMNhbF8zSIliwk6bNeMFDcNSzJK
	 iODLDYYxf1nlOdyHqrd0T5L68LJdqhOOYYaWNj4a0hNFlm/TfEYmiJ2hIeLrnpFE57
	 A/MdOqxTXqO65YqdyTevrdZTQncipVennrfyzQv+CVA9OOqcZfTjEFzlQlyd2pxWEI
	 cP8hB1zU7cNSQ==
Message-ID: <sashiko-outbox-196598@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 25/25] dmaengine: sdxi: Add DMA engine provider
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261103-sdxi-base-v4-25-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-25-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:24:17 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] dmaengine: sdxi: devm DMA unregister runs after sdxi_unregister() =
frees cxts
- [High] dmaengine: sdxi: sdxi_tx_status() loses error state and skips dma_=
tx_state
- [Medium] dmaengine: sdxi: sdxi_device_init() ignores sdxi_dma_register() =
error
- [Medium] dmaengine: sdxi: context stop-on-error prevents IRQ reaping and =
stalls sync
- [Medium] dmaengine: sdxi: premature AKey and vector release on context te=
ardown
- [Medium] dmaengine: sdxi: missing max_buffer check in sdxi_dma_prep_memcp=
y()
- [Low] dmaengine: sdxi: undocumented dma_channels parameter in kernel-para=
meters.txt
--

commit cdf3a67512f9931ad28471e39e5814ce577c3d81
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Add DMA engine provider

This commit registers a virt-dma memcpy provider for SDXI functions with a
configurable number of channels per function. It batches copy descriptors
behind fenced completion interrupts and implements channel termination and
synchronization callbacks.

> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index 30c4e687cedf1..265ebea1e350e 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -23,6 +23,7 @@
>  #include <linux/xarray.h>
> =20
>  #include "context.h"
> +#include "dma.h"
>  #include "hw.h"
>  #include "mmio.h"
>  #include "sdxi.h"
> @@ -424,6 +425,7 @@ static int sdxi_device_init(struct sdxi_dev *sdxi)
>  	if (err)
>  		return err;
> =20
> +	sdxi_dma_register(sdxi);
>  	return 0;
>  }

[Severity: Medium]
As reported by Sashiko on v3 [1], sdxi_dma_register() returns -ENOMEM when
devm_kzalloc() fails and returns the negative error code from
dmaenginem_async_device_register() when registration fails, but
sdxi_device_init() ignores the return value and unconditionally returns 0.

Should sdxi_device_init() check the return value of sdxi_dma_register() and
clean up via sdxi_dev_stop() on failure, or should sdxi_dma_register() retu=
rn
void if DMA engine registration is intentionally best-effort?

> diff --git a/drivers/dma/sdxi/dma.c b/drivers/dma/sdxi/dma.c
> new file mode 100644
> index 0000000000000..512855c83da27
> --- /dev/null
> +++ b/drivers/dma/sdxi/dma.c
> @@ -0,0 +1,509 @@

[ ... ]

> +static unsigned short dma_channels =3D 1;
> +module_param(dma_channels, ushort, 0644);
> +MODULE_PARM_DESC(dma_channels, "DMA channels per function (default: 1)");

[Severity: Low]
This adds the sdxi_core.dma_channels module parameter, which can also be set
on the kernel command line at boot. Should this parameter be documented in
Documentation/admin-guide/kernel-parameters.txt?

[ ... ]

> +static struct dma_async_tx_descriptor *
> +sdxi_dma_prep_memcpy(struct dma_chan *dma_chan, dma_addr_t dst,
> +		     dma_addr_t src, size_t len, unsigned long flags)
> +{
> +	struct sdxi_dma_chan *sdchan =3D to_sdxi_dma_chan(dma_chan);
> +	struct sdxi_cxt *cxt =3D sdchan->cxt;
> +	u16 akey_index =3D sdxi_akey_index(cxt, sdchan->akey);
> +	struct sdxi_dma_txd *txd;
> +	struct sdxi_copy copy =3D {
> +		.src =3D src,
> +		.dst =3D dst,
> +		.src_akey =3D akey_index,
> +		.dst_akey =3D akey_index,
> +		.len =3D len,
> +	};
> +
> +	/*
> +	 * Validate now, with a throwaway encode onto the stack. The real
> +	 * encode into the ring happens at issue.
> +	 */
> +	if (sdxi_encode_copy(&(struct sdxi_desc){}, &copy))
> +		return NULL;

[Severity: Medium]
In sdxi_fn_activate() and sdxi_publish_cxt(), the function and client conte=
xt
are configured with sdxi->max_buffer, which restricts each copy descriptor =
to
at most (u64)SZ_2M << sdxi->max_buffer bytes:

drivers/dma/sdxi/device.c:sdxi_fn_activate()
	sdxi->max_buffer =3D FIELD_GET(SDXI_MMIO_CAP1_MAX_BUFFER, cap1);
	dma_set_max_seg_size(sdxi->dev,
			     min((u64)SZ_2M << sdxi->max_buffer, U32_MAX));

drivers/dma/sdxi/context.c:sdxi_publish_cxt()
	*ent =3D (typeof(*ent)) {
		...
		.max_buffer  =3D cxt->sdxi->max_buffer,
		...
	};

However, sdxi_dma_prep_memcpy() only validates copy.len through
sdxi_encode_copy() -> sdxi_encode_size32(), which accepts any length up to
SZ_4G. Because DMA engine memcpy callers such as dmatest and async_memcpy do
not check dma_get_max_seg_size() before calling device_prep_dma_memcpy(), c=
an
a transfer with len > ((u64)SZ_2M << cxt->sdxi->max_buffer) succeed in
sdxi_dma_prep_memcpy() and then fault the hardware context when issued?

> +
> +	txd =3D kmalloc_obj(*txd, GFP_NOWAIT);
> +	if (!txd)
> +		return NULL;
> +
> +	*txd =3D (typeof(*txd)) {
> +		.copy =3D copy,
> +	};
> +
> +	return vchan_tx_prep(&sdchan->vchan, &txd->vdesc, flags);
> +}
> +
> +static enum dma_status sdxi_tx_status(struct dma_chan *chan,
> +				      dma_cookie_t cookie,
> +				      struct dma_tx_state *state)
> +{
> +	struct sdxi_dma_chan *sdchan =3D to_sdxi_dma_chan(dma_chan);
> +	struct virt_dma_desc *vdesc;
> +
> +	/* Under the lock for a consistent cookie snapshot; the IRQ reaps. */
> +	guard(spinlock_irqsave)(&sdchan->vchan.lock);
> +
> +	/* vchan_find_desc() only returns issued txds, which own a completion. =
*/
> +	vdesc =3D vchan_find_desc(&sdchan->vchan, cookie);
> +	if (vdesc) {
> +		struct sdxi_dma_txd *txd =3D to_sdxi_dma_txd(vdesc);
> +
> +		if (sdxi_cst_blk_check(txd->completion.cst_blk) =3D=3D SDXI_COMPLETION=
_ERROR)
> +			return DMA_ERROR;
> +	}
> +
> +	return dma_cookie_status(chan, cookie, state);
> +}

[Severity: High]
As reported by Sashiko on v3 [2], when a descriptor finishes with
SDXI_COMPLETION_ERROR, sdxi_dma_reap_locked() removes it from
vchan->desc_issued and calls vchan_cookie_complete():

	if (state =3D=3D SDXI_COMPLETION_ERROR)
		txd->vdesc.tx_result.result =3D DMA_TRANS_ABORTED;

	list_del(&vdesc->node);
	sdxi_cst_pool_put(sdchan->cxt->cst_pool, txd->completion.cst_blk);
	txd->completion =3D (struct sdxi_completion) {};
	vchan_cookie_complete(&txd->vdesc);

Because vchan_cookie_complete() advances chan->completed_cookie to that
descriptor's cookie and vchan_find_desc() only searches vchan->desc_issued,
won't any call to sdxi_tx_status() after the descriptor is reaped fall thro=
ugh
to dma_cookie_status() and report DMA_COMPLETE instead of DMA_ERROR?

Also, when vchan_find_desc() does find an errored descriptor still on
vchan->desc_issued, returning DMA_ERROR directly skips dma_cookie_status()
and leaves *state uninitialized when the caller passes a non-NULL state
pointer (such as in dma_async_is_tx_complete()).

[ ... ]

> +static bool sdxi_dma_idle(struct sdxi_dma_chan *sdchan)
> +{
> +	struct virt_dma_chan *vchan =3D &sdchan->vchan;
> +
> +	guard(spinlock_irqsave)(&vchan->lock);
> +
> +	sdxi_dma_reap_locked(sdchan);
> +	if (sdxi_dma_drain_locked(sdchan))
> +		sdxi_cxt_kick(sdchan->cxt);
> +
> +	return list_empty(&vchan->desc_terminated) &&
> +	       list_empty(&vchan->desc_issued) &&
> +	       list_empty(&sdchan->pending);
> +}

[Severity: Medium]
Client contexts are configured with stop-on-error enabled in
sdxi_publish_cxt():

drivers/dma/sdxi/context.c:sdxi_publish_cxt()
	ctl_cfg =3D (typeof(ctl_cfg)) {
		.se              =3D 1,
		.csa             =3D 1,
		...
	};

In sdxi_dma_drain_locked(), completion interrupts are generated by a fenced
DSC_INTR descriptor placed at the end of each copy batch. If a copy descrip=
tor
encounters an error, the context stops on that descriptor before executing =
the
trailing fenced DSC_INTR descriptor or any subsequent copies in the ring.

When that happens, won't the completion interrupt never fire, and won't
sdxi_dma_idle() in sdxi_dma_synchronize() continue waiting on the remaining
issued and pending descriptors until the 10-second SDXI_DMA_SYNC_TIMEOUT_US
expires rather than detecting that cxt->sq->cxt_sts.state has entered
CXTV_STOP_FN or CXTV_ERR_FN?

[ ... ]

> +static int sdxi_dma_alloc_chan_resources(struct dma_chan *dma_chan)
> +{

[ ... ]

> +	err =3D sdxi_start_cxt(sdchan->cxt);
> +	if (err)
> +		goto free_irq;
> +
> +	return 0;
> +free_irq:
> +	free_irq(sdchan->irq, sdchan);
> +free_akey:
> +	sdxi_free_akey(sdchan->cxt, sdchan->akey);
> +free_vector:
> +	sdxi_free_vector(sdxi, vector);
> +exit_cxt:
> +	sdxi_cxt_exit(sdchan->cxt);
> +	return err;
> +}
> +
> +static void sdxi_dma_free_chan_resources(struct dma_chan *dma_chan)
> +{
> +	struct sdxi_dma_chan *sdchan =3D to_sdxi_dma_chan(dma_chan);
> +	LIST_HEAD(head);
> +
> +	sdxi_stop_cxt(sdchan->cxt);
> +	free_irq(sdchan->irq, sdchan);
> +	sdxi_free_vector(sdchan->cxt->sdxi, sdchan->vector);
> +	sdxi_free_akey(sdchan->cxt, sdchan->akey);
> +	/* virt-dma does not know about the driver's pending list. */
> +	scoped_guard(spinlock_irqsave, &sdchan->vchan.lock)
> +		list_splice_tail_init(&sdchan->pending, &head);
> +	vchan_dma_desc_free_list(&sdchan->vchan, &head);
> +	vchan_free_chan_resources(to_virt_chan(dma_chan));
> +	sdxi_cxt_exit(sdchan->cxt);
> +}

[Severity: Medium]
In sdxi_dma_free_chan_resources(), if sdxi_stop_cxt() fails or times out (or
is interrupted in sdxi_cxt_reserve()), or if sdxi_cxt_update() fails inside
sdxi_cxt_exit(), sdxi_cxt_exit() retains the context until function shutdown
because the hardware may still reference it:

drivers/dma/sdxi/context.c:sdxi_cxt_exit()
	state =3D FIELD_GET(SDXI_CXT_STS_STATE, READ_ONCE(cxt->sq->cxt_sts.state));
	if (state !=3D CXTV_STOP_SW && state !=3D CXTV_STOP_FN && state !=3D CXTV_=
ERR_FN)
		return -EBUSY;
	...
	err =3D sdxi_cxt_update(cxt);
	if (err) {
		dev_err(sdxi->dev,
			"context %u release failed (%d), retaining resources until function shut=
down\n",
			cxt->id, err);
		return err;
	}

	sdxi_free_cxt(cxt);

Because sdxi_dma_free_chan_resources() calls sdxi_free_vector() and
sdxi_free_akey() unconditionally before sdxi_cxt_exit(), can this zero the
DMA-visible AKey entry and release sdchan->vector for reuse by another
channel while the unstopped context is still active in hardware?

Similarly, in sdxi_dma_alloc_chan_resources(), if sdxi_start_cxt() times out
after publishing DSC_CXT_START to the admin ring, jumping to free_irq frees
the AKey and vector and calls sdxi_cxt_exit() without stopping the context,
while DSC_CXT_START may still be pending or may have just transitioned the
context to CXTV_RUN.

> +
> +int sdxi_dma_register(struct sdxi_dev *sdxi)
> +{

[ ... ]

> +	err =3D dmaenginem_async_device_register(dma_dev);
> +	if (err)
> +		return dev_warn_probe(dev, err, "failed to register dma device\n");
> +
> +	return 0;
> +}

[Severity: High]
Does using dmaenginem_async_device_register() here cause a use-after-free a=
nd
double-free during driver unbind or PCI removal?

During probe, sdxi_pci_probe() -> sdxi_register() -> sdxi_device_init() ->
sdxi_dma_register() registers dma_dev with dmaenginem_async_device_register=
(),
which defers dma_async_device_unregister() to devres_release_all() after the
bus remove callback returns.

When the device is removed or unbound, sdxi_pci_remove() calls
sdxi_unregister() first:

drivers/dma/sdxi/device.c:sdxi_unregister()
	sdxi_dev_stop(sdxi);
	sdxi_client_cxts_exit(sdxi);
	ida_destroy(&sdxi->vectors);

sdxi_client_cxts_exit() frees every client context in sdxi->client_cxts via
sdxi_free_cxt() and destroys the xarray, while dma_dev and any allocated
channels are still registered. When devres_release_all() subsequently runs
dmaenginem_async_device_unregister() -> dma_async_device_unregister() ->
sdxi_dma_free_chan_resources() (or if an interrupt or channel callback runs
before devres teardown), sdxi_dma_free_chan_resources() dereferences the
already-freed sdchan->cxt, accesses the destroyed sdxi->vectors IDA and
sdxi->client_cxts xarray, and frees sdchan->cxt a second time in
sdxi_cxt_exit().

[1] https://lore.kernel.org/r/20260605-sdxi-base-v3-23-4d38ca2bdffe@amd.com
[2] https://lore.kernel.org/r/20260605-sdxi-base-v3-23-4d38ca2bdffe@amd.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D25
