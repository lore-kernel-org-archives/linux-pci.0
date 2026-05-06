Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF4617A309
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778109976; cv=none; b=kEVZWl9Q3n6ewMgSwFRRjj5ovHD1KvAJu8BOqJVHh7/aWvctWkZAPtfeekdILttBLKy/e28zaiTEXeifulO8SNJaTgo6mid8mowX2xWjlxELwWWzqoy5GfPzyIqjYSyKSkFCnZzBV7Z7PGQ0l+3m6QziGZfcbc2SMAt38c1zXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778109976; c=relaxed/simple;
	bh=gADbZnBI+PykDJFRVd3DEX1bJkECWp/Dw7IVUisBPGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TGEruICwmsfwDNMd5YGcyxk6ccrAu14fMirAyPLe5cMTr3cyV4XBU74gEd3DRa6z0AlXwY02X9vNuZCmiUlQG3GN2/z6tcTH+6qbiBKgIN6wrgiCsxaGnX4wt1+42Six6XunyGBZWDxmmNMMeLx+J2wMxpeHioC7Ji21n1q9lhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5+GlTqV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5+GlTqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2334C2BCB0;
	Wed,  6 May 2026 23:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778109975;
	bh=gADbZnBI+PykDJFRVd3DEX1bJkECWp/Dw7IVUisBPGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=e5+GlTqVMrXCMP8k9cno4M0Ts2Y+eVL5kqNptWmjJe/en52YS/YxYZh31mBTETKSH
	 X2+c3c1UsfoAIA6rzdn8hCIeKqrcV2wtUJRHdgFEj4ev4NXGxNv/T3yjQYSpErWXAj
	 YKxcX0sJ7EdLu4UWij1LomPqmXCgQmetUm7broh2Sua+kwji58thW9UJ+jyENq98zM
	 jBBqB3RFMRDlR6+NT1PzGXipJzyC9U9RJZF9Rftbzw2wmtgl5jZgq9fmHda/cwAj2o
	 yV4/xaBAHhbUqM+gs0ZKUBYvY1wjriaZiDvj4QLPIKuLSAhPVZdquX2HElMWIzxizf
	 R3pTrlmw7gvaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/9] PCI: epf-mhi: Use dmaengine_prep_config_single()
 to simplify code
Reply-To: sashiko@lists.linux.dev
To: "Frank Li" <Frank.Li@nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506-dma_prep_config-v4-8-85b3d22babff@nxp.com>
References: <20260506-dma_prep_config-v4-8-85b3d22babff@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 23:26:15 +0000
Message-Id: <20260506232615.C2334C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Asymmetric DMA workqueue teardown risks Use-After-Free on late=
 callbacks.
- [High] Synchronous transfer timeouts indiscriminately kill concurrent asy=
nc transfers, leaking their memory and mappings.
--

commit 05444e0385986a82cafbe547e6d0ad335a0e1fbb
Author: Frank Li <Frank.Li@nxp.com>

PCI: epf-mhi: Use dmaengine_prep_config_single() to simplify code

Use dmaengine_prep_config_single() to simplify pci_epf_mhi_edma_read[_sync]=
()
and pci_epf_mhi_edma_write[_sync](). No functional change.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/e=
ndpoint/functions/pci-epf-mhi.c
> index 7f5326925ed54..c3e3b58fb86cd 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -342,9 +336,10 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl=
 *mhi_cntrl,
>  		goto err_unlock;
>  	}
> =20
> -	desc =3D dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
> -					   DMA_DEV_TO_MEM,
> -					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +	desc =3D dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
> +					    DMA_DEV_TO_MEM,
> +					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
> +					    &config);
>  	if (!desc) {
>  		dev_err(dev, "Failed to prepare DMA\n");
>  		ret =3D -EIO;

This isn't a bug introduced by this commit, but in pci_epf_mhi_edma_read() =
and
pci_epf_mhi_edma_write(), if the synchronous transfer times out (e.g., if t=
he
channel is stuck processing a prior async transfer), the error recovery path
calls dmaengine_terminate_sync(chan):

	ret =3D wait_for_completion_timeout(&complete, msecs_to_jiffies(1000));
	if (!ret) {
		dev_err(dev, "DMA transfer timeout\n");
		dmaengine_terminate_sync(chan);
		ret =3D -ETIMEDOUT;
	} else {

Because async transfers run concurrently and share the channel, does this
abruptly abort them without invoking their completion callbacks?

Will this leak the transfer structures and their dma_map_single()
mappings, and stall the MHI endpoint data channel?

[ ... ]

This isn't a bug introduced by this commit, but looking at
pci_epf_mhi_dma_deinit(), it destroys the workqueue before releasing the
active DMA channels:

	destroy_workqueue(epf_mhi->dma_wq);
	dma_release_channel(epf_mhi->dma_chan_tx);
	dma_release_channel(epf_mhi->dma_chan_rx);

If an asynchronous DMA transfer completes right after the workqueue is
destroyed but before the channel is fully released, the dmaengine interrupt
handler will invoke pci_epf_mhi_dma_async_callback(). This callback
unconditionally calls queue_work(epf_mhi->dma_wq, ...).

Does attempting to enqueue work onto a destroyed workqueue cause a
use-after-free memory corruption?

Should the channels be explicitly terminated with dmaengine_terminate_sync()
before the workqueue is destroyed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506-dma_prep_c=
onfig-v4-0-85b3d22babff@nxp.com?part=3D8
