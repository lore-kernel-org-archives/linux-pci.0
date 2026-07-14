Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD335A3A9;
	Tue, 14 Jul 2026 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015424; cv=none; b=B2KhjWkI2RCxubnm8nz/NFpHZjHdh4Olzs6R4ylFCAQKsN4TYWNJxl0CBlPT32jk3e1Q/hp2ZFsk/LKC/hs0Nse+M7/Y9WsHXtGHxF2zxs4fToXydmCFkHIYgGzXbTgAjE205YROq+EqxtQe2Am5zpYYxNnRJlKUQ8KoPlTOtIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015424; c=relaxed/simple;
	bh=B49Ya582Hq/vtQMmZq6fFpUGfafAXLxMSt/DG1ZdF18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2+jEN4mHIQGkiysjDCqLPNAFpvYbbL1OlldXSJVH7qvGECI5i7Q4U8Q4EMFPlq3VBbjFDaGLxv9eElJ/ToPe7JQvEzr/qIiV8+IG3I1r9f905Ms5Lj2SCOfXgeat8Qcx3kNMEY+0yrLediMXoq5qlZ1UuJ1TbwacWErBvkWsF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bw2FV1i0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bw2FV1i0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC49B1F00A3A;
	Tue, 14 Jul 2026 07:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784015422;
	bh=Tebc2NeUG7Zb/GUBTx6WOEzhHdP1aFOy2L/umZYWOTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bw2FV1i0pqKFISINqUqMyOwpgK4A+2GckdDnCmm1sILFVEA/UP758T7WU7qPQnV2C
	 wEkOepAxsD6+XXr4Rzm/X/yQxOv6e01unSyPCHATE3qC1i4Dq+oKnDEogELlTpMMAU
	 I9C5fw1SA2R6vK/g/U/6lTJQO/vlUG6HEvlN1QrYz/7WHA6oUXSkyvtGdPRmyQysc4
	 an7EU6DkVwhh1V0gsk4uCxiOJ2glJcHKVK70qMcqUsp/AIbVrvz1k06SEsayqXly+J
	 dROukbT84ttXPtacE/IMOr5vbYXIke17x/a4wrV+Tzu7ell/U1AuMm+6vk2aN1cK39
	 weurdYplN3Nvg==
Date: Tue, 14 Jul 2026 09:50:14 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: dw-edma: Implement device_synchronize()
 callback
Message-ID: <lv4nfvtxjjhn2j6k5zd2zyjidz367low4cvpplrzy3fj3srqsu@vsrgaalsacbo>
References: <20260629-mhi-ep-flush-v1-0-714e0d56e87c@oss.qualcomm.com>
 <20260629-mhi-ep-flush-v1-1-714e0d56e87c@oss.qualcomm.com>
 <akJ_SH31xqs_AYCQ@SMW015318>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akJ_SH31xqs_AYCQ@SMW015318>

On Mon, Jun 29, 2026 at 09:20:56AM -0500, Frank Li wrote:
> On Mon, Jun 29, 2026 at 10:45:15AM +0200, Manivannan Sadhasivam via B4 Relay wrote:
> >
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >
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
> >  drivers/dma/dw-edma/dw-edma-core.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index c2feb3adc79f..7b12dfe8cfd3 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -331,6 +331,21 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
> >         return err;
> >  }
> >
> > +static void dw_edma_device_synchronize(struct dma_chan *dchan)
> > +{
> > +       struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > +       unsigned long timeout = jiffies + msecs_to_jiffies(5000);
> > +
> > +       /*
> > +        * Make sure all the in-flight DMA operations are completed before
> > +        * draining the tasklet using vchan_synchronize().
> > +        */
> > +       while (chan->status == EDMA_ST_BUSY && time_before(jiffies, timeout))
> > +               cpu_relax();
> 
> read_poll_timeout(...),  Does need READ_ONCE(chan->status)?
> 

Yeah, makes sense. I'll use:

read_poll_timeout(READ_ONCE, chan->status, chan->status != EDMA_ST_BUSY,
		10, 0, false, chan->status);

- Mani

-- 
மணிவண்ணன் சதாசிவம்
