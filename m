Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD12D0605;
	Wed, 22 Jul 2026 05:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784699924; cv=none; b=tnOT+AdrgvhSTe1yxLRqFFcLNoJBqMj/AAiWwVkzx1gLJ4eQO1kvsxzDlBxqtHtjezU8ZH2bVOspFV91r0vu0hQ6kVW8fcKuHqQnqzgRFA3EGxODTwYyPqlECV+3rRDoOy/CPCO72RThyWMG1ikJ7tbeWrDEb/0xU0BQWF9WvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784699924; c=relaxed/simple;
	bh=0u0FhLDzl/Ofwfay/25ek4tyFIxmtmmR3ZzB4gEOehA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmPizRz39eSPMSWfgqmNRJvxFxKAkNd3KH+q3M83R5u8vZZvfnikhPS+kbpVaCuFxGwJ7cPk+vwN9ifa3i/0FE1vl/O5DWvIHGSofnyQcaAupbK97XJBTCFvnunmmtEbZ6D/5+dQ31koDlf1M2OibUy5ThL/mBKsIZf+PRlqjEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTT2w9zq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTT2w9zq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4131F000E9;
	Wed, 22 Jul 2026 05:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784699922;
	bh=5T+9Zo3cTjyaTauys3fPWTruOr/6JMUDiMzHi2ct70E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VTT2w9zqPup8HDv24ijAZ5UufMCABEfuAhGZrUHsWDmO4Kqp/6A7Jom1Dxb0C1gGu
	 OnN06DmlP7R/ZnIZe766maHtdIxV2VM9DVByVVKgEMi/l61ruoAPdNr/1MltqcEObD
	 xsWHrKlM1j5h2fHEsMuYWwSqpuzuEOCQtT/uCdOfRTjIRM6jWGZp9+k5FFgIHito51
	 TQINBjQ2oZnB9RW6ifBTpCcSqIzPxQSsq4XlZTGfydGnFngIEI6qBz9Y1VuqusskFn
	 0Rw/IpAxnoSH6mgQ8EQto5CdCGVHo44b059AD6WjzdgYJN7dcLGSVcdoYxtGrkolht
	 CsX86tCrodUKg==
Date: Wed, 22 Jul 2026 07:58:34 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dmaengine: dw-edma: Implement
 device_synchronize() callback
Message-ID: <a7rswvi476dml2vuvqycnzsq7orc5jxzxl3n4wixclly4cvqrl@x26rz7ytdrr3>
References: <20260714-mhi-ep-flush-v2-0-b6a9db011e85@oss.qualcomm.com>
 <20260714-mhi-ep-flush-v2-1-b6a9db011e85@oss.qualcomm.com>
 <amAXdwI_pYA4p_0P@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amAXdwI_pYA4p_0P@lizhi-Precision-Tower-5810>

On Tue, Jul 21, 2026 at 09:05:59PM -0400, Frank Li wrote:
> On Tue, Jul 14, 2026 at 02:08:32PM +0200, Manivannan Sadhasivam wrote:
> > device_synchronize() callback is required by the client drivers to ensure
> > all the DMA operations are completed so that they can free the memory
> > associated with the complete callbacks.
> >
> > So implement this callback by first making sure that all the in-flight DMA
> > operations are completed and then call vchan_synchronize() to drain the
> > DMA tasklet.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> 
> Similar implement already in linux-next, recent many fixes and update about
> dw edma already merged in dma tree.
> 

Ah, I didn't notice this patch. I've dropped this patch from my series.

This patch also suffers from the same RMW issue that Sashiko pointed out. So
I'll send a separate fix for that.

- Mani

> commit 99109a51efd28c9a661fbfb9469b023c517b31d1
> Author: Koichiro Den <den@valinux.co.jp>
> Date:   Sat Jul 18 03:06:32 2026 +0900
> 
>     dmaengine: dw-edma: Terminate all descriptors without callbacks
> 
>     The DMA Engine client documentation says in the "Terminate APIs" section
>     of Documentation/driver-api/dmaengine/client.rst:
> 
>     "No callback functions will be called for any incomplete transfers."
> 
>     dw-edma instead calls vchan_cookie_complete() when a deferred STOP reaches
>     the interrupt handler. This schedules a callback for the active descriptor
>     and leaves other issued or submitted descriptors queued. A late callback
>     after dmaengine_terminate_sync() can dereference client state that has
>     already been freed, while leftover descriptors may later restart into
>     reused buffers or leak.
> 
>     Move all issued and submitted descriptors to the terminated list whenever
>     termination completes. For a pending STOP, do this from both the DONE and
>     ABORT paths. Complete their cookies in order without scheduling callbacks.
> 
>     A STOP can remain pending until the running transfer raises an
>     interrupt. Make device_synchronize() wait for such a pending STOP to
>     complete before releasing terminated descriptors. Reuse it from
>     free_chan_resources(), then release the remaining virt-dma resources.
>     Sleep instead of busy-polling while waiting, and warn if the existing
>     timeout expires.
> 
>     Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
>     Reviewed-by: Frank Li <Frank.Li@nxp.com>
>     Signed-off-by: Koichiro Den <den@valinux.co.jp>
>     Link: https://patch.msgid.link/20260717180639.2643243-3-den@valinux.co.jp
>     Signed-off-by: Vinod Koul <vkoul@kernel.org>
> 
> Frank
> 
> >  drivers/dma/dw-edma/dw-edma-core.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index c2feb3adc79f..df0d1a946ed0 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/dmaengine.h>
> >  #include <linux/err.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/irq.h>
> >  #include <linux/dma/edma.h>
> >  #include <linux/dma-mapping.h>
> > @@ -331,6 +332,20 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
> >  	return err;
> >  }
> >
> > +static void dw_edma_device_synchronize(struct dma_chan *dchan)
> > +{
> > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > +
> > +	/*
> > +	 * Make sure all the in-flight DMA operations are completed before
> > +	 * draining the tasklet using vchan_synchronize().
> > +	 */
> > +	read_poll_timeout(READ_ONCE, chan->status, chan->status != EDMA_ST_BUSY,
> > +			  10, 0, false, chan->status);
> > +
> > +	vchan_synchronize(&chan->vc);
> > +}
> > +
> >  static void dw_edma_device_issue_pending(struct dma_chan *dchan)
> >  {
> >  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > @@ -968,6 +983,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  	dma->device_pause = dw_edma_device_pause;
> >  	dma->device_resume = dw_edma_device_resume;
> >  	dma->device_terminate_all = dw_edma_device_terminate_all;
> > +	dma->device_synchronize = dw_edma_device_synchronize;
> >  	dma->device_issue_pending = dw_edma_device_issue_pending;
> >  	dma->device_tx_status = dw_edma_device_tx_status;
> >  	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
> >
> > --
> > 2.43.0
> >

-- 
மணிவண்ணன் சதாசிவம்
