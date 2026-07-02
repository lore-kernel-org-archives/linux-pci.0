Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B5F38C2AA;
	Thu,  2 Jul 2026 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028380; cv=none; b=hr72Jb/vaBCXS72qIV/iylK/Js9ADJYLJI5rm98E6rJ5QUuRs1NN8VygKyZLiWhlSwzNlyZmoop4fEU4jb+eG6fjkAm7lAs+6upTJ9t/rLmE+59S/hFzoiBQNyNA33ZDTbZ08Kl+Q4CwHKuyTg44koX4bBuJb8KKEwGGNa4DdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028380; c=relaxed/simple;
	bh=goaM+iqliH1emmh4o6HXiIOmBUWe9nw7wotxwnAdYI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GTPhitDCL0g515legR3cXuHXDfIGgoJY4ed+tl8nnBnj/ho3HjgbdkMmKZTzbNTUfZYu2+WRKSoxquWQZhtGtW2/pCHMxDr3HGJlehjQEoK6cYXEMrw1SegJEhWz05/XYBx9VRMu5h3R0nxPiQs8e/j3goy8mDMqhSQOPX+nPCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksCS+Vc9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksCS+Vc9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067D91F000E9;
	Thu,  2 Jul 2026 21:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783028379;
	bh=B9XuWjqsirmUOu+KSvx5G0WOF7jwyC+9qMGQB5/IK/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ksCS+Vc9w7WJmpAsynFBe0RLTvAYHDPzCDlFRxI9utsDunVfb+zX5K1vdP6V+6m6R
	 s+cKLO84/qpvrfq4ck8cHEp5jebIem0uJgKs0ihJurLSPdNUlt9RCXEhzaqT6dWTl+
	 jc2QNScieNMet/yFRZd9XAOo2fHT3WfaOJRjm8ROR1b5QxDmJEMIrTnaGCv5G4lVNr
	 /mOR/x5KPvTq6sPtOB8JtsNMpMBJWE/1L72st5PvbfhFX+aib5EudS5132XqIL0Clr
	 OG6AE8lfRVgzsbtFqbE1DVt9Or70OPbIBpjFZdnbtg2+uol4y95sYjbj4kI8MMpNw4
	 shSw9PTDRFVnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/10] dmaengine: dw-edma: Add xfer_sz field to
 struct dw_edma_chunk
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260702-edma_ll-v3-2-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
 <20260702-edma_ll-v3-2-877aa463740c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:39:38 +0000
Message-Id: <20260702213939.067D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `vc.lock` acquisition in `dw_edma_device_resume`, `dw_edma=
_device_pause`, and `dw_edma_device_terminate_all` leads to severe race con=
ditions with the interrupt handler.
- [High] Missing endianness conversions for DMA descriptors on DW_EDMA_CHIP=
_LOCAL configurations.
--

commit 4cc66a09b65be2e8496de1853db67b385be4c5bb
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk

Reusing ll_region.sz as the transfer size is misleading because
ll_region.sz represents the memory size of the EDMA link list, not the
amount of data to be transferred.

Add a new xfer_sz field to explicitly indicate the total transfer size
of a chunk.

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
This is a pre-existing issue, but I noticed a potential race condition
involving dw_edma_start_transfer() and the DMA control functions.

Does dw_edma_device_resume() safely handle concurrent accesses with the
interrupt handler?

It appears dw_edma_device_resume() calls dw_edma_start_transfer()
locklessly, which eventually invokes vchan_next_desc(). However,
vchan_next_desc() explicitly requires vc.lock to be held.

Similar unlocked modifications occur in dw_edma_device_pause(), where
chan->request is modified without locks:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_pause() {
    ...
    else
        chan->request =3D EDMA_REQ_PAUSE;
}

Can this race with dw_edma_done_interrupt() (which accesses these fields
under vc.lock) and lead to list corruption or lockdep warnings?

>  	dw_edma_free_burst(child);
>  	list_del(&child->list);
>  	kfree(child);

[ ... ]

[Severity: High]
This is a pre-existing issue, but are there missing endianness conversions
for DMA descriptors on DW_EDMA_CHIP_LOCAL configurations?

In drivers/dma/dw-edma/dw-edma-v0-core.c:dw_edma_v0_write_ll_data():

    lli->transfer_size =3D size;
    lli->sar.reg =3D sar;
    lli->dar.reg =3D dar;
    dma_wmb();
    lli->control =3D control;

These native assignments write host-endian values. On Big-Endian systems
using local eDMA controllers, will the Little-Endian eDMA hardware
misinterpret addresses, lengths, and control bits?

Similar native assignments also appear in dw_edma_v0_write_ll_link() and
dw_hdma_v0_write_ll_data().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-edma_ll-v3=
-0-877aa463740c@nxp.com?part=3D2
