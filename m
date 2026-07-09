Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5064E423160;
	Thu,  9 Jul 2026 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611968; cv=none; b=FBah3BMPzOQ0PiunUFqH4LXSpOaEhFimV2HbD4BWeQ3cvtiOFJdarRShzpuG4v1StU6BpHnnTZ3BXD4KSPs38B9J6Cg6iTmf9CDE9F+CyMTaFjMGM8FneyAeLZ/HeA10Ak/fbjRuPUGdRBo2vvSbNLnIt+ucCfSBvjLuyaoMryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611968; c=relaxed/simple;
	bh=oQMUdIx0YmqMQIweDwnKj2uMCNGyw8rvkMax3H6ofA4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J2j52yN7Drvnk0Cgc4Y4+nJefYoUsK2/oomuwCQGH6SyUYJCSOV13w2+wHXISisi36zCV8uVOjLYgHxCC1E89fIKwx2hVwDoRiqiWxSbS44TLY+Vm+kY43mMO86upoAZwzcoTLXZCSiEre8ZywJiKBI7SepxNuICBlSmRwtXwzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgG2Ywof; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgG2Ywof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734B31F00A3A;
	Thu,  9 Jul 2026 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611966;
	bh=zbJyvyhyCBILPmwKJLpwL/c4fMHsJaCJ20hc0AOLdzk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GgG2YwofmgiAjboDcCsn1xwebT9oV504lCZvkpyznXLZVLJgFC8FFBRHw09P7Gvgk
	 /4XQTEZY9dzMKuKgxyvLFqV/CKg+fNCMcCh3c7CCQiF10fUV3lCEMG5EDeWHzSCSvs
	 HQ2W8290Adm8aU1huaBLhm0UuU0r+XuwRWYzpc4wnmSmvdVuLUnLSVx89VHT86S7mx
	 xF1Oh5+ceVPNfXXx4UizKA0AWQO9uwJFLjPlBFgnt/Jum/dxAh/WsuC1ddfESgBwtt
	 rMcbZeQgVuZs1heW8eA5FYHqBfiWbUHCuQUWO60jBMc2m+Halxc5C02Ynv5SX9ylHv
	 1mFFQQKTPPklQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/10] dmaengine: dw-edma: Add xfer_sz field to
 struct dw_edma_chunk
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260709-edma_ll-v5-2-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
 <20260709-edma_ll-v5-2-e199053d4300@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:46:06 +0000
Message-Id: <20260709154606.734B31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] DMA API callbacks (`dw_edma_device_resume`, `dw_edma_device_pause`=
, `dw_edma_device_terminate_all`) execute without acquiring the virtual cha=
nnel lock (`chan->vc.lock`), causing data races, lockdep assertions, and po=
tential list corruption.
--

--- Patch [2]: [PATCH v5 02/10] dmaengine: dw-edma: Add xfer_sz field to st=
ruct dw_edma_chunk ---
commit b54484e8a9f1314d4de2bba9458c74895f047059
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk

This commit adds a new xfer_sz field to explicitly indicate the total
transfer size of a chunk, replacing the misleading use of ll_region.sz.

Tested-by: Koichiro Den <den@valinux.co.jp>
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
This is a pre-existing issue, but does dw_edma_start_transfer() have a lock
safety problem when called from dw_edma_device_resume()?

Looking at dw_edma_device_resume(), it modifies chan->status and calls
dw_edma_start_transfer() locklessly:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_resume() {
    ...
    } else {
        chan->status =3D EDMA_ST_BUSY;
        dw_edma_start_transfer(chan);
    }
    ...
}

Since dw_edma_start_transfer() manipulates the virt-dma lists and eventually
calls vchan_next_desc(&chan->vc) which has a lockdep_assert_held(&vc->lock),
this would trigger a lockdep splat.

Additionally, is there a risk of list corruption or a double free here if
this races with dw_edma_done_interrupt() or dw_edma_device_issue_pending()?
If device_resume races with dw_edma_done_interrupt, both might acquire the
same chunk and call kfree(child).

There appear to be similar missing locks in dw_edma_device_pause() and
dw_edma_device_terminate_all() when modifying shared internal state
variables like chan->status and chan->request locklessly.

>  	dw_edma_free_burst(child);
>  	list_del(&child->list);
>  	kfree(child);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-edma_ll-v5=
-0-e199053d4300@nxp.com?part=3D2
