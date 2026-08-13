Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C61042C513;
	Thu, 13 Aug 2026 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603601; cv=none; b=jIU6vCWRku13SNG8nXC1OhCDGBUTbFpz2uJV5tIR1CiZII992QIl2+fGNpscq7ytfW1w7mpDJg8fRlVOkjUknt19pKwOtqSnp4wzUjbg6adMCsvqMi3t5FM8YOTi1E3xiSHLKpdiwcFTIWhLr+LmAo9Nwrq/HzSr/kY4wXJpxg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603601; c=relaxed/simple;
	bh=/ulbjJFrXG1Agw/H3pmPn5+f+znEDhaAziIxfKa8+9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N4A9yDz+3cKJ3lTVAmE/NMatDfpcFh2VIahvkITyVBehhcCIMcdPcqCBr5caKr7C0AWoXrHP/g7ffySQo3ZPaYu/ZIHumzFfizmvpJscFB4Zl4xfRmvaD/0jUlv+VQiBlb1QyB4T71SLbKZ42afOhzzFo3pW/dkIfpHu+afu+jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu+Aawn5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu+Aawn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C70C1F000E9;
	Thu, 13 Aug 2026 06:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603597;
	bh=+YNFbfPBSRr1sYwfTuTWCPHF7oKYOsmhV+e8DAEc5Ak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yu+Aawn5T7cfH9vyyJTf3wsrq0oyrQVhvxAC1QG6NVJ3MSgaKmb1VdTlBu5RdJ3B1
	 vYE5eoBdLH4KhV2JrAnBOgVOXMmGH22OecLIWRO+PuIwMDXJ771T5fY5jLCmtnKPwU
	 EYfu6Qrewg1Ha4otLu3xIdD+ZVVlDSkwhd2+qfvi3R3A+rMl4/YugZqWg83lB8Aebw
	 lPKLuVGE8wFcfNhFLBl+Mlumfjfg3uPa5SKjVkSBVwT6KzUOEQUhShggS5aJQHXTnR
	 LzfhD8RNm6n31VFm9C+6r4+MzkDqlh+VHNxmNLiI7CAEzWdoa4PF5whfnPhzTXgqF/
	 wqSfT+NFgczAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/10] PCI: endpoint: Add API to delegate EPC DMA
 channels to the host
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260813063757.3131865-5-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 06:46:36 +0000
Message-Id: <20260813064637.7C70C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `pci_epc_reclaim_dma_chan()` fails to validate the `epc` pointer=
 for `ERR_PTR` values and omits function number bounds checks.
--

--- Patch [4]: [PATCH v7 04/10] PCI: endpoint: Add API to delegate EPC DMA =
channels to the host ---
commit de98f70ea5d6f77029b0c89f0e6b02055a9ff0a1
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: Add API to delegate EPC DMA channels to the host

This commit introduces pci_epc_delegate_dma_chan() and=20
pci_epc_reclaim_dma_chan() to allow endpoint functions to expose an=20
integrated DMA controller to the host. The endpoint reserves the local DMA=
=20
engine channel and passes it to the backend. Reclaiming allows the caller=20
to specify whether the hardware needs to be quiesced before local ownership=
=20
is restored.

> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/p=
ci-epc-core.c
> index 831b40458dcd8..d0bcf3dc7039b 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c

[ ... ]

> +void pci_epc_reclaim_dma_chan(struct pci_epc *epc, u8 func_no, u8 vfunc_=
no,
> +			      struct dma_chan *chan, bool quiesce)
> +{
> +	if (!epc || !chan || !epc->ops->reclaim_dma_chan)
> +		return;

[Severity: Medium]
Should this use pci_epc_function_is_valid(epc, func_no, vfunc_no) here
instead of just checking !epc?

If an error pointer is passed during a teardown path, the !epc check will
fail to catch it, leading to a potential crash when dereferencing epc->ops.
Additionally, missing pci_epc_function_is_valid() means the func_no and
vfunc_no bounds are completely unvalidated before reaching the backend ops,
which could lead to out-of-bounds accesses in the backend drivers.

> +
> +	mutex_lock(&epc->lock);
> +	epc->ops->reclaim_dma_chan(epc, func_no, vfunc_no, chan, quiesce);
> +	mutex_unlock(&epc->lock);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_reclaim_dma_chan);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813063757.3131=
865-1-den@valinux.co.jp?part=3D4
