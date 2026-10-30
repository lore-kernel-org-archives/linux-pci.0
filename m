Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374753;
	b=NuEcv/VinAmI7h8sn/iYf2yhEnHyH0Vc5ZdvX1sKJYoMCdGfGBL8jJ5Ci7mTwR4i8WCu
	 OhvtgxpFrhRmPe8pvcHjf/3ouOoME16y3ujhJ1LGlt9z/DlNV+fsU8WZN3HV+WalWsz9R
	 laOsaVpGWpt4w226CJR37JuHg8ILs0liYhhYu5yDUOjlHYzx1FSdNjtcDKS+bXChbu80B
	 mDRgP2bLzBLoQsIMq0hSYJg+0i02zbsxDnYXR/FDrybdAzLcUv/G8XvwyskHoJwOPDZZV
	 KjNTz/5/xyT6GlKNpACFgItQLZ4FQ7sSs/M11OxgE+EOgflDpFW2kff3SewWzEspHgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374753;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WsbI19ZM0C65UHMEAaPBBNn+A5Up89pxax5gUd1XIYI=;
	b=yKVvopWlHnDjqhyouRcLvaHdNaZLyo/GinAo+62ba+NVSgcXuuE1aGOoU9AKouaDdUHy
	 WLByjtpxtIGruiZy/rwbDLI5CwxZszkSnJLUuowKSQo3DSHHq0D78MefwFhm67cUtiI6C
	 IbD3ZVdCnSXGOBFU4c08sSenzo5fHxrEWXpY3UeO+U/LYWit9mtMf78Zw5OcLI7Fj5dgP
	 4STPHmuDP/ZHnu9+lGFY1oQxoFw6UE/uvmXo2SJ++bcese2TuEy0FbIIh7Qga/pFrqvVv
	 7eE8uw1WeQFLMqwutdWBT13Y9VdhWgGEhKMj0MyD8M07PW781ib9RQ276tUTBJqCRrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBlU7DJ0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A1E606A321;
	Fri, 30 Oct 2026 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBlU7DJ0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCD51F000C1;
	Fri, 30 Oct 2026 15:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793374751;
	bh=WsbI19ZM0C65UHMEAaPBBNn+A5Up89pxax5gUd1XIYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PBlU7DJ081Jf6b+eFKltnGKqY6Bz4R8vxwHCFLsnWRJYJO5g//b1BQ00dKJaHt91J
	 4qoFMF9w04zTpBk1GdOp1a8apMv0kYCN90IggwpSZtJIPE+sDinS1pS2fW9BBuiOhL
	 /AYPhATjLhE1+YCtsvOYBTduqjU3aKMGqXBRi0DI1Fz0HnxdAj87YjCRgkL5UlUEz9
	 5DquGUlxhqAQs+iPUguMO3gOm77WbI4kOW3/WnhUQ9EXaVc36ESi0KvVYwnApPyQYa
	 da6y/MaiFHNj1zybezou3OasfdYO7qF7rV+MTbWveR2T6VZXLiwSUu7ammyY6MQb0+
	 qDnaMFfSCpfbA==
Message-ID: <sashiko-outbox-191180@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] dmaengine: dw-edma: Reclaim LL entries from
 hardware progress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261030150742.2586776-3-den@valinux.co.jp>
References: <20261030150742.2586776-1-den@valinux.co.jp>
 <20261030150742.2586776-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:39:11 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] dmaengine: dw-edma: callbacks scheduled on STOP in dw_edma_ll_adva=
nce()
--

commit cb11666c731e633531785427e3b24bbfbd73eb2b
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Reclaim LL entries from hardware progress

This commit updates the linked-list completion handling to use DMA_LLP to
advance ll_done and reclaim completed ring entries in issue order. It also
defers STOP and PAUSE completion until the channel stops.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index b08bb31657c9e..74613c95ae112 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c

[ ... ]

> @@ -283,6 +345,45 @@ static void dw_edma_core_ch_maybe_doorbell(struct dw=
_edma_chan *chan)
>  	dw_edma_core_ch_doorbell(chan);
>  }
> =20
> +/*
> + * Must be called with vc.lock held.
> + *
> + * HDMA does not update LLP continuously. Only use it to track running
> + * transfers when handling an interrupt.
> + */
> +static void dw_edma_ll_advance(struct dw_edma_chan *chan, bool event)
> +{
> +	bool stopped =3D dw_edma_ll_stopped(chan);
> +
> +	if (stopped || event)
> +		dw_edma_ll_consume(chan, dw_edma_core_ll_cur_idx(chan),
> +				   stopped);
> +
> +	if (chan->request !=3D EDMA_REQ_NONE) {
> +		/* Wait for the channel to stop before completing STOP or PAUSE. */
> +		if (!stopped)
> +			return;
> +
> +		if (chan->request =3D=3D EDMA_REQ_STOP) {
> +			dw_edma_finish_termination(chan);

[Severity: High]
Does calling dw_edma_ll_consume() in drivers/dma/dw-edma/dw-edma-core.c
before checking chan->request =3D=3D EDMA_REQ_STOP cause completion callbac=
ks to
be scheduled on a channel that is being terminated?

When dw_edma_device_terminate_all() is called while an LL channel is active=
ly
transferring, it defers termination by setting chan->request =3D EDMA_REQ_S=
TOP.
When the interrupt fires:

dw_edma_irq_work()
  dw_edma_ll_interrupt()
    dw_edma_ll_advance(chan, true)
      dw_edma_ll_consume()
        list_del(&vd->node);
        vchan_cookie_complete(vd);

In dw_edma_ll_consume(), any descriptor in chan->vc.desc_issued whose bursts
finished before the channel stopped is removed from chan->vc.desc_issued,
placed on chan->vc.desc_completed, and has chan->vc.task scheduled via
vchan_cookie_complete() to run its completion callback.

When dw_edma_ll_advance() then checks chan->request =3D=3D EDMA_REQ_STOP and
calls dw_edma_finish_termination(), dw_edma_terminate_all_descs() only clea=
ns
up descriptors still on chan->vc.desc_issued and chan->vc.desc_submitted,
leaving the descriptors already moved to chan->vc.desc_completed to invoke
their callbacks.

By comparison, the non-LL handler dw_edma_done_interrupt_locked() checks
EDMA_REQ_STOP and calls dw_edma_finish_termination() without calling
vchan_cookie_complete(), matching commit 99109a51efd2 ("dmaengine: dw-edma:
Terminate all descriptors without callbacks").

Should dw_edma_ll_advance() check for EDMA_REQ_STOP before calling
dw_edma_ll_consume() so that terminated descriptors do not schedule
completion callbacks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030150742.2586=
776-1-den@valinux.co.jp?part=3D2
