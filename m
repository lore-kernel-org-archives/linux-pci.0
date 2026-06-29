Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCA30EF9B;
	Mon, 29 Jun 2026 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723570; cv=none; b=ZRUtPe9q1p/RZR5H9JSCQWVA3vvvrUUtuGlv49oAIrrEoRBV4tD9zQqnbkO3wedx+VprBQne5BecCt823ujeLepxUUmiHUy8GBF+vQY7U6k/ZQtTPu8s0uMKOoGK/DdYZxtDQaLddPZtCQAOmB/TTyxIW9ggTGh5vgI+DKVLroQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723570; c=relaxed/simple;
	bh=Uc62XIOTpsi3DLRZfWn/4Ium0ocXPqNcG7vzDxtmCuM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cUNZeDyjvV3qvXwGZwmVkaZQjn2H0S1SCZ6ARdS9UAWsS7o7veNGDldLQh32pSWyWfzuRIctLPobNdQRtXEH2KSkyEi8+Lql+rmO+AixTlIKRJx+Ret/mmormp+XncHvY94jDbubISGBPdgbK2gmg0Lk2LAaUqKM6GHZZcraGY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES2/SLK3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES2/SLK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922F31F000E9;
	Mon, 29 Jun 2026 08:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782723568;
	bh=nYToRKfvJQPTL5smrz5uLQO0EPLY3BNKOkX7dD1C8gE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ES2/SLK3IYZQyECLR2pIbC8zI8iK8US1empvKvI8FDyk3Q3wNO21ARx7JJDOyqkuC
	 21MjKxuL/xp91ouoXkiF+tf9dX2hsNW6/q/GP7tEkRpdqyC1l7xo+eGTqsN6o4P291
	 B2XDO2aIqwWrCETMRjyYrBO2MH4gOughERvEd76A1VAUX/azDiTK+seVJXZXyw7PMU
	 HD3FXDRuU57PBw/8BISa1PJHkwsjrYSawV1INqkLVrU8AIhKECgAuaIcQqxVmUqMQK
	 gkVosIQ5Sul4vGXFzdaWXYWu44O7krzxi5oQ0hNo2awkD3w9kL8yxYW79Q8Tg79Evz
	 PZwvvnrySz5nA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] PCI: epf-mhi: Implement mhi_cntrl->flush_async() to
 flush DMA read/write
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260629-mhi-ep-flush-v1-3-714e0d56e87c@oss.qualcomm.com>
References: <20260629-mhi-ep-flush-v1-0-714e0d56e87c@oss.qualcomm.com>
 <20260629-mhi-ep-flush-v1-3-714e0d56e87c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 08:59:28 +0000
Message-Id: <20260629085928.922F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci_epf_mhi_edma_flush_async() violently terminates globally share=
d DMA channels, which aborts active transfers for all unrelated MHI channel=
s.
- [High] Calling dmaengine_terminate_sync() in pci_epf_mhi_edma_flush_async=
() cancels in-flight DMA operations, leaking dynamically allocated transfer=
 objects, DMA mappings, and orphaning upstream MHI buffers.
--

commit 6865f2474af30b8ecf0f56f29a02aca13c8836a3
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: PCI: epf-mhi: Implement mhi_cntrl->flush_async() to flush DMA read=
/write

This commit implements the flush_async callback for the MHI endpoint
controller. It terminates the DMA channels and flushes the workqueue to
ensure transactions complete before removing channels.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/e=
ndpoint/functions/pci-epf-mhi.c
> index 7f5326925ed54..4af3689921a3f 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -644,6 +644,15 @@ static int pci_epf_mhi_edma_write_async(struct mhi_e=
p_cntrl *mhi_cntrl,
>  	return ret;
>  }
> =20
> +static void pci_epf_mhi_edma_flush_async(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	struct pci_epf_mhi *epf_mhi =3D to_epf_mhi(mhi_cntrl);
> +
> +	dmaengine_terminate_sync(epf_mhi->dma_chan_rx);
> +	dmaengine_terminate_sync(epf_mhi->dma_chan_tx);

[Severity: High]
Does this code globally abort DMA operations for all independent MHI channe=
ls?

When a single MHI client device is unbound, mhi_ep_remove() loops over the
client's channels and calls mhi_cntrl->flush_async().

Since dma_chan_tx and dma_chan_rx are globally shared by the endpoint,
unconditionally calling dmaengine_terminate_sync() here appears to forcibly
abort all active and pending DMA operations for all other unrelated MHI
client devices currently sharing the controller.

[Severity: High]
Can this also leak dynamically allocated pci_epf_mhi_dma_transfer objects
and their DMA mappings?

The dmaengine_terminate_sync() function immediately drops pending and active
DMA descriptors without executing their completion callbacks.

Because the pci_epf_mhi_dma_transfer structures and their associated DMA
mappings are only tracked and cleaned up inside the completion callback
pci_epf_mhi_dma_async_callback(), aborting the transfers here seems to
permanently leak these resources and orphan the upstream MHI buffers.

> +	flush_workqueue(epf_mhi->dma_wq);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-mhi-ep-flu=
sh-v1-0-714e0d56e87c@oss.qualcomm.com?part=3D3
