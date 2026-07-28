Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371839FCCC;
	Tue, 28 Jul 2026 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260332; cv=none; b=cgT6nRSAHk+lpehHbhL+Nf4sVeH8Rw/aemHgWdPwGstHY/jnkn+/yrrpwlxoWU9Blf9qjFEkWwv52JsdIgwStGUGzNueDAJ2razuAzbGIiiqnXHqGD3weRTZPPIVtjTmEMSKo+5KIFO61fJB33SkEVhINK3ZxsZ2zEP4eYa4yH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260332; c=relaxed/simple;
	bh=/++jYSCYo1durp+iuaJG8R3Qwdami+T+7Nlrhsp8/98=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GzIwXtkvORbcKbgqRw/mjJIgdefSx9EWhYpKCaWWanVtSP/0ilpEI3h3nG/sAjouNYGJSRkblqZf2+XVlHQjWl5+P/WK6JLuvZJzGENwtpBkg7hBBe19q3BROYlDDFdNybHyqZ9iUk/vOiLmpYadTkBQZK7GojrYTfg8qvI2pOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqvOXcXy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqvOXcXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CADF1F000E9;
	Tue, 28 Jul 2026 17:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260331;
	bh=l7+xvT7uQCFGU/3PhZzVPRXalXsjtzt4VKJJC4g7R4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DqvOXcXyku1wxeqs3I8dxmAI+JJlf5dBtlRUlGp6LvGGmQtyf7mA/m3dwV87D2bKq
	 owMlqZShnha+Cwal9Ph17aCulbRdopORHKk1kCXvUq+weB4hu+HWHgyXBWicEhew72
	 vbzZJB00970rgpFqdjZ9Lxesz9ewcEzh+5KIz9kNjBBxA/Ok4TruaiIrFqM1MIlM12
	 pE2PfC9BZj1L5/Prz2zz4mGpetuTelhqhaQRFhS1EOTg1o3SAWz1QbHYanLtpPG4wa
	 3cQxlIIBUQXkkqijPQh/N9iM4Vfv/ptQZEsUpnSpwxBGcjHeLDrj5u/Af9OSXGALXX
	 t2CJFhZdVdlqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/12] dmaengine: switchtec-dma: fix channel leak on
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260728171523.112244-6-logang@deltatee.com>
References: <20260728171523.112244-1-logang@deltatee.com>
 <20260728171523.112244-6-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:38:50 +0000
Message-Id: <20260728173851.3CADF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The newly added `switchtec_dma_chans_free()` modifies `dma_dev->ch=
annels` locklessly and frees channel objects while the channel status ISR i=
s active, leading to list corruption and Use-After-Free.

Pre-existing issues:
- [Critical] Use-After-Free of `swdma_dev` in `switchtec_dma_remove()` afte=
r calling `dma_async_device_unregister()`.
- [High] The `chan_status_irq` is requested before the `dma_dev->channels` =
list is initialized, leading to a NULL pointer dereference if the ISR runs =
early.
- [High] The error path in `switchtec_dma_create()` incorrectly uses `free_=
irq()` instead of `pci_free_irq()`, and uses the flawed condition `if (swdm=
a_dev->chan_status_irq)`.
--

--- Patch [5]: [PATCH v4 05/12] dmaengine: switchtec-dma: fix channel leak =
on registration failure ---
commit a8d5be8a7824da6cc78512656e71020f75154f88
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix channel leak on registration failure

switchtec_dma_chans_release() is called in three places but the
underlying memory is not freed in all of those places. In order to
clean this up, introduce a switchtec_dma_chans_free() helper that
will free the memory.

Link: https://lore.kernel.org/dmaengine/20260717223024.9BB8A1F000E9@smtp.ke=
rnel.org
Link: https://lore.kernel.org/dmaengine/20260727190604.397DB1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 25b988e9b4afb..48da269198f3f 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1188,6 +1188,18 @@ static int switchtec_dma_chans_release(struct pci_=
dev *pdev,
>  	return 0;
>  }
> =20
> +static void switchtec_dma_chans_free(struct switchtec_dma_dev *swdma_dev)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < swdma_dev->chan_cnt; i++) {
> +		list_del(&swdma_dev->swdma_chans[i]->dma_chan.device_node);
> +		kfree(swdma_dev->swdma_chans[i]);
> +	}
> +
> +	kfree(swdma_dev->swdma_chans);
> +}

[ ... ]

> @@ -1233,12 +1243,8 @@ static void switchtec_dma_release(struct dma_devic=
e *dma_dev)
>  {
>  	struct switchtec_dma_dev *swdma_dev =3D
>  		container_of(dma_dev, struct switchtec_dma_dev, dma_dev);
> -	int i;
> =20
> -	for (i =3D 0; i < swdma_dev->chan_cnt; i++)
> -		kfree(swdma_dev->swdma_chans[i]);
> -
> -	kfree(swdma_dev->swdma_chans);
> +	switchtec_dma_chans_free(swdma_dev);
> =20
>  	put_device(dma_dev->dev);
>  	kfree(swdma_dev);
>  }

[Severity: Critical]
This is a pre-existing issue, but could this lead to a use-after-free when
the driver is unloaded?

If dma_async_device_unregister() is called in switchtec_dma_remove(), it wi=
ll
drop the reference to the DMA engine device. If there are no active clients,
the release callback switchtec_dma_release() is synchronously invoked, which
calls kfree(swdma_dev) here.

Immediately after the unregister call returns, switchtec_dma_remove() calls
iounmap(swdma_dev->bar), dereferencing the freed swdma_dev pointer:

switchtec_dma_remove() {
    ...
    dma_async_device_unregister(&swdma_dev->dma_dev);
        // eventually calls switchtec_dma_release() -> kfree(swdma_dev)
    iounmap(swdma_dev->bar);
    ...
}

[ ... ]

> @@ -1329,6 +1335,7 @@ static int switchtec_dma_create(struct pci_dev *pde=
v)
> =20
>  err_chans_release_exit:
>  	switchtec_dma_chans_release(pdev, swdma_dev);
> +	switchtec_dma_chans_free(swdma_dev);

[Severity: High]
Does this introduce a race with the active interrupt handler?

In switchtec_dma_create(), the error path calls switchtec_dma_chans_free()
before disabling the interrupt:

err_chans_release_exit:
    switchtec_dma_chans_release(pdev, swdma_dev);
    switchtec_dma_chans_free(swdma_dev);
   =20
err_exit:
    if (swdma_dev->chan_status_irq)
        free_irq(...);

If the interrupt fires concurrently, switchtec_dma_chan_status_isr() will
locklessly iterate over dma_dev->channels. At the same time,
switchtec_dma_chans_free() calls list_del() and kfree() on those channel
objects, which can cause list corruption or a use-after-free in the ISR.

>  err_exit:
>  	if (swdma_dev->chan_status_irq)

[Severity: High]
This is a pre-existing issue, but are we using the correct function and
condition to free the IRQ here?

chan_status_irq stores the MSI-X vector index (e.g., 0, 1), not the system =
IRQ
number, and it is requested using pci_request_irq().

Calling free_irq(swdma_dev->chan_status_irq, swdma_dev) passes the vector
index as the system IRQ, attempting to free an unrelated system interrupt
instead of the actual hardware interrupt.

Also, checking if (swdma_dev->chan_status_irq) will skip freeing the IRQ
entirely if the vector index happens to be 0. Should this use pci_free_irq()
and check against a valid vector indicator like >=3D 0 instead?

[Severity: High]
This is another pre-existing issue, but is it possible for the interrupt
handler to run before the channels list is initialized?

In switchtec_dma_create(), swdma_dev is allocated with kzalloc_obj(), which
leaves the dma_dev->channels list head zeroed (next =3D=3D NULL). The code =
then
calls pci_request_irq(), enabling the interrupt.

The list head isn't initialized until INIT_LIST_HEAD(&dma->channels) is cal=
led
later inside switchtec_dma_chans_enumerate().

If an interrupt fires in this window, switchtec_dma_chan_status_isr() execu=
tes
list_for_each_entry() on the zeroed list head. The loop macro evaluates the
position from head->next (NULL), bypassing the termination condition and
dereferencing the pointer, which can cause a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728171523.1122=
44-1-logang@deltatee.com?part=3D5
