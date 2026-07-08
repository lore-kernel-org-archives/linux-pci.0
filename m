Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE63BB106;
	Wed,  8 Jul 2026 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536386; cv=none; b=cEhQvsfsY1GW7+ofWmqbY1HTOrLdXiBV9PvwsSAzy10KaOIocOLknikkoaXY/oU/O4thSjljoC93r57Kcqn/Mi782aFzgnR9WoCgu4wIADGcJ2MG1S8bJ/AnUTZM5TvHvZLhAXro8/Mz0spscYZSjfq/Mu4NufRpicQ/z7t671g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536386; c=relaxed/simple;
	bh=+AaJZDGVUrO+DzRD9lN02cyx2j2JjI54VI1gu72PifY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CL+5GIBgUBRV25VNzL7awN+6liSZajnsIfaj9MUPIm7KssIcMUSDa4hnMjOzFggc26ffXa/fy7wM2mq3ymDUMdPW5wVdKjEEeF9jrjMSnLHQtBOuITPUUX7LtayY7/3CfcFDd6APzui1dCXvVWacMxc+YV+zjoQkteX1nO4lFyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyWAK+Po; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyWAK+Po"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E0E1F000E9;
	Wed,  8 Jul 2026 18:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783536384;
	bh=6RDtGPOLJFBuQgboHKf5T5EV2TfqHkgKbyRkPcS7FaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nyWAK+Po8wAPeEB8u66XSGiZ4bslZexetdYX7c9pH/6So1zCS20C3jlCsNSFPbCPy
	 fwg9KblADbj1IXLrYdK6zGbI/9a2JmPhJMFa2vRV2W5X/e1q72s1XKrqnOqOpkaqsS
	 vtYnblTk4pFuAata/fqYI4Tz+R6Kh9AyOuU7Wow3B6jAr6jZ2EFwub/pITpW/YZzFh
	 dkV+s2ArN5SdG0tk+UFvviKQJ2HH5G1DtemUl+9xbLKtq3xctkcrWDQy7L0HkjKV6y
	 1GwSLEYW+8wzQr+MIAulBd7nfXafKGgb7LFye6Oaa6iweacwr1sQpTc2dv1yZbuZzs
	 T1ii5t9IIF4+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/10] dmaengine: dw-edma: Move ll_region from struct
 dw_edma_chunk to struct dw_edma_chan
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260708-edma_ll-v4-3-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
 <20260708-edma_ll-v4-3-cc128f0afb61@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 18:46:24 +0000
Message-Id: <20260708184624.88E0E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] dw_edma_device_resume() accesses and modifies channel states and c=
alls dw_edma_start_transfer() without holding the channel lock.
--

--- Patch [3]: [PATCH v4 03/10] dmaengine: dw-edma: Move ll_region from str=
uct dw_edma_chunk to struct dw_edma_chan ---
commit 1e85ecaff6d1547be3e5049908d131f91651e11f
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_e=
dma_chan

ll_region is identical for all chunks belonging to the same DMA channel,
so there is no need to copy it into each chunk. Move ll_region to
struct dw_edma_chan to avoid redundant copies.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 53469c8c8b82e..2652ad8e7a8f6 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c

[ ... ]

While reviewing this file, I noticed a pre-existing issue in dw_edma_device=
_resume():

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_resume() {
    ...
	} else if (chan->request !=3D EDMA_REQ_NONE) {
		err =3D -EPERM;
	} else {
		chan->status =3D EDMA_ST_BUSY;
		dw_edma_start_transfer(chan);
	}

	return err;
}

[Severity: High]
This isn't a bug introduced by this patch, but I noticed that
dw_edma_device_resume() modifies the channel state and calls
dw_edma_start_transfer() without holding the channel lock.

The vchan_next_desc() function, which is called by dw_edma_start_transfer(),
explicitly asserts lockdep_assert_held(&vc->lock). Modifying channel state
and manipulating virt-dma lists without holding chan->vc.lock can cause data
races and list corruption.

Any client driver triggering a channel resume will consistently hit the
lockdep splat and risk kernel panics from list corruption.

Could we acquire chan->vc.lock before updating chan->status and calling
dw_edma_start_transfer() here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-edma_ll-v4=
-0-cc128f0afb61@nxp.com?part=3D3
