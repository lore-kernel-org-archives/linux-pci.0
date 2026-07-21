Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4846D2DA;
	Tue, 21 Jul 2026 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651402; cv=none; b=uloLs73b8iWD3N/BG+vGH/SGZNo0rPCRUqY8M5nJeCMMh6BndqUxBOMnHI+3JPkSyCXAHyI9Up+Tmc2AjTJ8hj+U9dv+LTbG907iPvkWNhcfmWk0FKg1aeR8jYyY5dcG2wDcPCQHIvuHRnWQLQZquf2R5s302gkpeM3hJQc6c5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651402; c=relaxed/simple;
	bh=iy4dxzr6/PU4f/dIAJRGAO9UNg5dW+bwQS/djVfPKpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sYbqxJpuCtKfe8PtrdvmkhauZTEMbDT33G3uaa1ojvDBZuebF249YpOPMGZPjndG+AJdCjPhazbkzF1nMtIXsXJRgtcZvf+e5JmyfezVm8lz6aXrB3R9mGuxAWKMBfdrij8VEO1rRfBENN242Zr9b3/ZsWnQ3JOxfxoSY5/mleA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UV7RYXYj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UV7RYXYj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA791F00A3A;
	Tue, 21 Jul 2026 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651401;
	bh=LmtnLeuAjWf4HXo0CWgXBr+/hjW87nVl0VL0ToXLTpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UV7RYXYjOV7cJ1KuqRT8/HTyeAdVKuxCEc/UHqvbUt+iKX2y9hiNJPNt3BAWVljK4
	 yQqtGqUWtGe0L193tmja3Xy6t0QaQKfRlzDBMeXMI3kJsCyn/Vo4C2O5Wr22Rngawd
	 9Db4c1KiMZsJ3tFTF6f3al2SgUNTXtSggnbYTcUSBU9BRWWLtYHUOFt/kXx1JIjoQC
	 CKkCLPCjuoQcHKnfDEjWtv8p25dlGb7yTOyXFanJVZwZbxN/c/VgAYc1/Gy9Xjzwh/
	 yiLQ9rCBSBhJKxL7DguOM6gMilDoISD46ONFgX1xpPPt4BwWEeeZoWbgYm1Lsh5Lxz
	 ZvUcsfIp7P57Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/11] dmaengine: switchtec-dma: fix channel leak on
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260721155739.62120-5-logang@deltatee.com>
References: <20260721155739.62120-1-logang@deltatee.com>
 <20260721155739.62120-5-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:30:00 +0000
Message-Id: <20260721163001.2DA791F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free of `swdma_dev` when unmapping BAR in driver rem=
oval.
--

--- Patch [4]: [PATCH v2 04/11] dmaengine: switchtec-dma: fix channel leak =
on registration failure ---
commit 180269dedc262dabc95c3a154c59d53224e70c16
Author: Logan Gunthorpe <logang@deltatee.com>

    dmaengine: switchtec-dma: fix channel leak on registration failure

    switchtec_dma_chans_release() is called in three places but the
    underlying memory is not freed in all of those places. In order to
    clean this up, introduce a switchtec_dma_chans_free() helper that
    will free the memory. Ensure each call to switchtec_dma_chans_release()
    has a corresponding switchtec_dma_chans_free() call.

    Link: https://lore.kernel.org/dmaengine/20260717223024.9BB8A1F000E9@smt=
p.kernel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 107769cca772f..13efd4189bbb4 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
[ ... ]
> @@ -1221,12 +1229,8 @@ static void switchtec_dma_release(struct dma_devic=
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

[Severity: Critical]
This is a pre-existing issue, but does this kfree() result in a
use-after-free during driver removal?

In switchtec_dma_remove(), when dma_async_device_unregister() drops the
final reference, it synchronously invokes this switchtec_dma_release()
callback which frees swdma_dev.

However, switchtec_dma_remove() then immediately accesses the freed
swdma_dev pointer:

drivers/dma/switchtec_dma.c:switchtec_dma_remove() {
    ...
	dma_async_device_unregister(&swdma_dev->dma_dev);

	iounmap(swdma_dev->bar);
    ...
}

Should the iounmap() be moved before dma_async_device_unregister(), or
should the bar pointer be saved to a local variable to prevent memory
corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721155739.6212=
0-1-logang@deltatee.com?part=3D4
