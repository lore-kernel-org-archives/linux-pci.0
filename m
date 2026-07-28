Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B363379C38;
	Tue, 28 Jul 2026 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785261235; cv=none; b=bHH3hOJz8iVUkJGNke8YMSpZj15RRpfavi1n5bMkdRjJj3msqz9Hsvizo4BIAux+pfN8n1NYMb70OSsSFQyhC4WZn/rherlxydC21WdoKxaTsSFxjeVOIrC7gspU1cLmZrvd61y+6TFAFwpcaGjcFPDMVg9sEFHZ1vMQo68ofMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785261235; c=relaxed/simple;
	bh=ofdw/NT5KwP9RhHD7KNjtJxNO1dHTPLrD7B7PkQczZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tr5NSPUyN4skypZV5nGxFQlUoXQ5XxIK9Et8u4GSgojl3tMhex1+74RkEikRUcReFaChrIPn4zM1uRSieA13alU9ApTESCl1h+dMPpbA4v+l65NmBHrpOSWxCTwMLcrpRtzsNRSvTHnbj0nBPLynMTMuvm+7B56bSfcx3lgFVVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozWeLmZG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozWeLmZG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8AE1F00A3A;
	Tue, 28 Jul 2026 17:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785261234;
	bh=CYjIrSZ/t7gVHCTOMQaoHWO0N8OmwCUfA2pH2F6nl/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ozWeLmZGCGJF+Cl1pkC0ek95/qSv/WkY6wN9i0qsY0CcsJo11BUfBIW92BiOwp2Bv
	 MxnocYCwUKx1zm/so9jsvsG2PL8PpyRHbNMM0HJ0vjeeFql8gU4QiAjI+8c9gFksHp
	 DjooHEV/nu+DtmPqqcX4rx5ml/7BbpjPQD4oFIeQa11G7TddyqQRKMhDsqn5vt4xJK
	 zLxmGV6Tvifv1f0XVUx6CamQB5ZU28NiGdjFa/LJ09CuAMkhtimB7D7dQCGDC7AHlU
	 knFkbPLq55Llymkoe/U48XEVOGQo2qpvrYG05Jzdad7H7sNGZ+kJ4HfWgJ+sWTm3TP
	 qeITjtrbUJ6YQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/12] dmaengine: ioat: disable relaxed ordering
 before registering the device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260728171523.112244-11-logang@deltatee.com>
References: <20260728171523.112244-1-logang@deltatee.com>
 <20260728171523.112244-11-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:53:53 +0000
Message-Id: <20260728175353.BC8AE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free (UAF) in shared IRQ handler due to unsafe mixing of=
 manual memory management and devres IRQ registration.
- [High] Global IDA resource leak in the core DMA channel registration erro=
r path.
- [Medium] Race condition exposing DMA channels to userspace before their s=
ysfs attributes are fully created.
--

--- Patch [10]: [PATCH v4 10/12] dmaengine: ioat: disable relaxed ordering =
before registering the device ---
commit f2b93cc9001f8f226c2e33f07702973d69e902de
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: ioat: disable relaxed ordering before registering the device

ioat3_dma_probe() disabled PCIe relaxed ordering after calling
dma_async_device_register(), so if an error occurs and the code jumps
to err_disable_interrupts, the function returns with a dangling registratio=
n.
This commit moves the capability read/write ahead of registration to fix
the issue.

Link: https://lore.kernel.org/dmaengine/20260707165906.249F41F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 737496391109e..a57024c4b066e 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -1170,15 +1170,6 @@ static int ioat3_dma_probe(struct ioatdma_device *=
ioat_dma, int dca)
>  		       ioat_chan->reg_base + IOAT_DCACTRL_OFFSET);
>  	}
> =20
> -	err =3D dma_async_device_register(&ioat_dma->dma_dev);
> -	if (err)
> -		goto err_disable_interrupts;
> -
> -	ioat_kobject_add(ioat_dma, &ioat_ktype);
> -
> -	if (dca)
> -		ioat_dma->dca =3D ioat_dca_init(pdev, ioat_dma->reg_base);
> -
>  	/* disable relaxed ordering */
>  	err =3D pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &val16);
>  	if (err) {
> @@ -1194,6 +1185,15 @@ static int ioat3_dma_probe(struct ioatdma_device *=
ioat_dma, int dca)
>  		goto err_disable_interrupts;
>  	}
> =20
> +	err =3D dma_async_device_register(&ioat_dma->dma_dev);

[Severity: High]
This is a pre-existing issue, but does dma_async_device_register() leak the
global dma_ida resource when it fails?

If dma_async_device_register() fails after allocating a global ID and
populating the channel list, the error path in drivers/dma/dmaengine.c hand=
les
the cleanup:

	if (!device->chancnt) {
		ida_free(&dma_ida, device->dev_id);
		return rc;
	}

Because it skips ida_free() when chancnt is greater than zero, does this
permanently leak an ID from the global dma_ida pool every time registration
fails with populated channels?

> +	if (err)
> +		goto err_disable_interrupts;

[Severity: High]
This isn't a bug introduced by this patch, but is there a use-after-free ri=
sk
on this error path?

If ioat3_dma_probe() fails and the code takes the err_disable_interrupts
path, ioat_pci_probe() will manually free the primary device data structure.
However, because ioat_dma_setup_interrupts() registers a shared interrupt
using devm_request_irq(), the interrupt cleanup is deferred until after the
probe function completely returns.

Could a shared interrupt firing during this brief window invoke the handler,
causing ioat_dma_do_interrupt() to blindly dereference the already freed da=
ta
pointer?

> +
> +	ioat_kobject_add(ioat_dma, &ioat_ktype);

[Severity: Medium]
This is a pre-existing issue, but does this sequence expose DMA channels to
userspace before their sysfs attributes are fully created?

Because dma_async_device_register() completes core registration and sends
add uevents before ioat_kobject_add() appends the specific quickdata
sysfs attributes, can a userspace process reacting to the uevent attempt to
read device properties in the window before they are created?

> +
> +	if (dca)
> +		ioat_dma->dca =3D ioat_dca_init(pdev, ioat_dma->reg_base);
> +
>  	if (ioat_dma->cap & IOAT_CAP_DPS)
>  		writeb(ioat_pending_level + 1,
>  		       ioat_dma->reg_base + IOAT_PREFETCH_LIMIT_OFFSET);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728171523.1122=
44-1-logang@deltatee.com?part=3D10
