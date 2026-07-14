Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33A4448CF3;
	Tue, 14 Jul 2026 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031887; cv=none; b=gJkHdmhLzBrtCR5O0ZWeGlggdaBGVrt5HCP9vikxHUFa1UeqNZx1jYJ0wxGO1vVW1WY2Zd4b3P79ZHIKLXGSyk6RCLTXeBKKfeZ5CgVnF1Rq+ri8E7xHF58GwNdUoHn0bVA+YaUUZugfV3mv4vL1uou4IegyYGtx5UeYqmtlABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031887; c=relaxed/simple;
	bh=j78u1E0gALDGnFDci+xc3vgZYGnIlh40nM2h8inPv2I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D01mw5qzilUzHvEiDulAgDJIKWUQOM76KhgaZ0r4vsy8CxMObtvKtqpLQXABfLN7kAGxOn1a5S9y+6HhEcU4T6AqIiyRcVnMDHdsTm3sr3cQyyea+OfQdLOe/19BZGSqE7bink9M5ViOiBWiJfc/pMDGaVJbheXYluAljixggYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldOyzhJv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldOyzhJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B951F000E9;
	Tue, 14 Jul 2026 12:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784031871;
	bh=LfNHxuOL0nkeZZQ+xWQxzyWUn5mqtMhOSAN53+qaUuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ldOyzhJvw0PlfJRGxQa7fLkJ5R/0+tWzLugRtukhv0mw8dFbyvWtmbwnpuxfRZ8xz
	 37O3iAV8WRkXwE6I9zKY++nvsuEPr/WT0uWHJOGhWO55yO/S0D6d931yrxIsMqb4b2
	 tXnDk+zAodj02jLIY+quHCpUXpu6DUEWqjLQkV4tV+NOMSPewDUC0H8FRDTcnoE2ai
	 LLdtpAJIyqSke6pSNdidWfzPyy/RINCiAFMdRUS9rd3WHcRY7b4z/s5ybDNgAaMaTM
	 8kMrEFwbPO6Wnt1yMZck0t77/6LQGVhQGZ8N29eI1U4x7D1Tr1gTgPNbA+FZz53YXP
	 bE04UQhUW/Bgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] dmaengine: dw-edma: Implement
 device_synchronize() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260714-mhi-ep-flush-v2-1-b6a9db011e85@oss.qualcomm.com>
References: <20260714-mhi-ep-flush-v2-0-b6a9db011e85@oss.qualcomm.com>
 <20260714-mhi-ep-flush-v2-1-b6a9db011e85@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 12:24:31 +0000
Message-Id: <20260714122431.72B951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Misuse of the `read_poll_timeout` macro causes an unlocked read-mo=
dify-write data race on `chan->status`, which can overwrite the interrupt h=
andler's state completion and lead to an infinite loop.

Pre-existing issues:
- [High] The `dw_edma_device_terminate_all()` function performs read and wr=
ite access to the state machine variables `chan->status` and `chan->request=
` without acquiring the required `chan->vc.lock` spinlock.
--

--- Patch [1]: [PATCH v2 1/3] dmaengine: dw-edma: Implement device_synchron=
ize() callback ---
commit dad772ddd69c60671b5bb40802d893826d2fa9c5
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

dmaengine: dw-edma: Implement device_synchronize() callback

This commit implements the device_synchronize() callback for the dw-edma
driver. It uses read_poll_timeout() to wait for all in-flight DMA operations
to complete by polling the channel status. Once complete, it drains the
tasklet using vchan_synchronize().

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index c2feb3adc79fa..df0d1a946ed06 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -331,6 +332,20 @@ static int dw_edma_device_terminate_all(struct dma_c=
han *dchan)
>  	return err;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does
dw_edma_device_terminate_all() perform read and write accesses to state
machine variables without acquiring the required chan->vc.lock spinlock?

Looking at dw_edma_device_terminate_all(), it modifies chan->status and
chan->request locklessly:

    } else if (chan->request > EDMA_REQ_PAUSE) {
        err =3D -EPERM;
    } else {
        chan->request =3D EDMA_REQ_STOP;
    }

Since the DMA engine API allows asynchronous termination, could this race w=
ith
dw_edma_done_interrupt() or dw_edma_device_issue_pending(), both of which h=
old
the spinlock while modifying the same fields? If the interrupt handler reads
chan->request right before terminate_all writes it, it might mistakenly sta=
rt
the next pending transfer instead of stopping it.

> =20
> +static void dw_edma_device_synchronize(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> +
> +	/*
> +	 * Make sure all the in-flight DMA operations are completed before
> +	 * draining the tasklet using vchan_synchronize().
> +	 */
> +	read_poll_timeout(READ_ONCE, chan->status, chan->status !=3D EDMA_ST_BU=
SY,
> +			  10, 0, false, chan->status);

[Severity: High]
Could this read_poll_timeout() macro usage introduce a regression by causing
an unlocked read-modify-write data race on chan->status?

The read_poll_timeout() macro expands to (val) =3D op(args). By passing
chan->status as the val parameter, it expands to:

    (chan->status) =3D READ_ONCE(chan->status)

This loop executes without the chan->vc.lock spinlock. If the hardware
interrupt handler dw_edma_done_interrupt() fires exactly after READ_ONCE()
reads EDMA_ST_BUSY but before the assignment back to chan->status, it will
cleanly set chan->status =3D EDMA_ST_IDLE.=20

Would the polling thread then overwrite the newly set EDMA_ST_IDLE state wi=
th
its stale EDMA_ST_BUSY value? Because the timeout parameter is 0, if this
corrupted EDMA_ST_BUSY state is written back, no further interrupts will ar=
rive
to clear it, which could result in a permanent hang.

> +
> +	vchan_synchronize(&chan->vc);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-mhi-ep-flu=
sh-v2-0-b6a9db011e85@oss.qualcomm.com?part=3D1
