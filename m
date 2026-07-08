Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC2226059D;
	Wed,  8 Jul 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536678; cv=none; b=Tf7a22XktbllvcEZlsYlXFzXWOTT0Fa/v0dfVVyGdrdSRLhgGnBYaQfe3BUDe1/1TDbl20LAbygyNhQNzUkOVCLcOfq+Pxy4BWPv/FqZ09jZdJIz0xS3UJLKEn1gApqPZ8NSHlPOSADdMJ3Caqgay9wmNOD3N+4W3F88cReTp74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536678; c=relaxed/simple;
	bh=FTJ5G32JBnNT7a3yyZz5bo9gwKK/YObMpnPfCmZuUTk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oekIsnMvvU3rKjSRIxgxYs3TOqCRkWUiFMex6sl0slq8uMGooglKYCUmWBT8rUV/Po4+QJwaEfCNHZ3872yZIHvN7ogYSu0ONy2EEwYR4JS5WXrYhD86TQzSKLIJXE51G+nMbL2g0TL4oq+0wHeRd+OC/CeUbE5UgTzcJ4KkK0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpFnsD9l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpFnsD9l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D08B1F000E9;
	Wed,  8 Jul 2026 18:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783536676;
	bh=IuE4tREelb9ER6RBZZ5Wd+EWbetWLiRX4zWRj82hRHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UpFnsD9lUPsrLzowBF7YTikbpnvUvuyz3RSjjgZhOKHheuuIwDZExn/yfjO7nqY+6
	 nU9o5rSqm31lTToBEMGfUeMyoWNeULvCGz8vI7KzZ45HLNM9cK/DKbaQDDMxOCLFcc
	 1uJ6+w2sLVGJ+nyMxvUvWXLcfyj6ROokYx0myubmm9nA5hnTaNcQxWSmXmeKzCJSol
	 iYxqoZAStM6h0XSlOu0DrkznA7zLPyznA784P4LjMDXyF1Tgr0/XBTXBDa1Yew/Vps
	 E5Oz0v0gTV6PPPhA7KCwzsRl58YQQJRl/QQ9BeRDFqqynz09dY/kGqCOItrG2/p3Gh
	 Olh5dX2iqfzhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/10] dmaengine: dw-edma: Add callbacks to fill link
 list entries
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260708-edma_ll-v4-6-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
 <20260708-edma_ll-v4-6-cc128f0afb61@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 18:51:16 +0000
Message-Id: <20260708185116.7D08B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The first burst of the initial chunk is populated but skipped duri=
ng hardware descriptor programming, leading to silent data loss.
--

--- Patch [6]: [PATCH v4 06/10] dmaengine: dw-edma: Add callbacks to fill l=
ink list entries ---
commit 8217e6927a330e1d9e36c8d3201ab9c4807b55cf
Author: Frank Li <Frank.Li@nxp.com>
Subject: dmaengine: dw-edma: Add callbacks to fill link list entries

This commit introduces four new callbacks to fill link list entries in
preparation for replacing the existing core start routines. The abstraction
allows the code to be cleanly shared between eDMA and HDMA implementations.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>

> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> index 8d38867cd9983..c0746e5351410 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
[ ... ]
> @@ -509,6 +509,48 @@ static void dw_edma_v0_core_ch_config(struct dw_edma=
_chan *chan)
>  	}
>  }
> =20
> +static void
> +dw_edma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst =
*burst,
> +			u32 idx, bool cb, bool irq)
> +{

[Severity: High]
This isn't a bug introduced by this patch, but since this new callback is
being introduced to handle filling link list data entries, does the existing
driver logic silently drop the first data segment?

Looking at dw_edma_device_transfer() in dw-edma-core.c, it allocates and
populates the first burst directly into chunk->burst:

dw_edma_device_transfer()
    ...
    burst =3D dw_edma_alloc_burst(chunk);
    if (unlikely(!burst))
        goto err_alloc;

    if (xfer->type =3D=3D EDMA_XFER_CYCLIC)
        burst->sz =3D xfer->xfer.cyclic.len;

However, the hardware descriptor programming loop in dw-edma-v0-core.c trea=
ts
chunk->burst->list as a dummy head rather than a data element:

dw_edma_v0_core_write_chunk()
    ...
    list_for_each_entry(child, &chunk->burst->list, list) {
        ...
        dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
                                 child->sar, child->dar);
    }

Since list_for_each_entry() starts from head->next and skips the head itsel=
f,
will this skip programming the first burst entirely and cause silent data l=
oss
for scatter-gather, cyclic, or single block transfers?

> +	u32 control =3D 0;
> +
> +	if (cb)
> +		control |=3D DW_EDMA_V0_CB;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-edma_ll-v4=
-0-cc128f0afb61@nxp.com?part=3D6
