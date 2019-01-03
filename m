Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A542C43387
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 12:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82E32070D
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519703;
	bh=5IBE/DjvfwJILDCjxwb5K0N9tlq6o8rwDDros1Ja1CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CHgXE3/vgROJeaUN62xw5fIi3qDpZb5YqGC92U0Csg8iNEdNQoLoc985oPWWAK0Vg
	 Ce3ucxpeSuH6Qbn5Ss1uSgS6p9pMGxj/Ac+r4hl/wffKvXGMPQT+rwXF5trZQE4CLk
	 aigjBADgWU+JbYblsRNoScU0MID4LYybXpHLDn0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfACMrY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:42756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731576AbfACMrY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:24 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 378C62070D;
        Thu,  3 Jan 2019 12:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519643;
        bh=5IBE/DjvfwJILDCjxwb5K0N9tlq6o8rwDDros1Ja1CU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3sKPctijoVANCeDZ0Oi3p9Xga3gcvr2EccMWiFwKn31bo+nDSDXFMiHNW21oUe1h
         OmASxm/Xzc2K4EuHI1npraL3nC/BUQULHCvKvp+3CEem5wbUALfMm2IOp0fgh8VWBO
         KvrxZ9rNNMLTVsnZSSYcnaFsDLmFHhAimYfIhxuU=
Date:   Thu, 3 Jan 2019 18:15:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: Re: [RFC 1/6] dma: Add Synopsys eDMA IP core driver
Message-ID: <20190103124542.GC21403@vkoul-mobl>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
 <bf4eb88265bf8bd95f7b2effdbfbeda8c52a2e0b.1544610287.git.gustavo.pimentel@synopsys.com>
 <20181217065120.GH2472@vkoul-mobl>
 <0768a44c-60d2-0983-b2e3-b8f711a24504@synopsys.com>
 <256fef2b-0dea-edee-396a-353520159005@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <256fef2b-0dea-edee-396a-353520159005@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

On 03-01-19, 09:53, Gustavo Pimentel wrote:
> Hi Vinod,
> 
> (snipped)
> 
> >>> +{
> >>> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> >>> +	const struct dw_edma_core_ops *ops = chan2ops(chan);
> >>> +	enum dma_transfer_direction dir;
> >>> +	unsigned long flags;
> >>> +	int err = 0;
> >>> +
> >>> +	spin_lock_irqsave(&chan->vc.lock, flags);
> >>> +
> >>> +	if (!config) {
> >>> +		err = -EINVAL;
> >>> +		goto err_config;
> >>> +	}
> >>> +
> >>> +	if (chan->configured) {
> >>> +		dev_err(chan2dev(chan), ": channel already configured\n");
> >>> +		err = -EPERM;
> >>> +		goto err_config;
> >>> +	}
> >>> +
> >>> +	dir = config->direction;
> >>
> >> Direction is depreciated, I have already removed the usages, so please
> >> do not add new ones.
> >>
> >> You need to take direction for respective prep_ calls
> > 
> > Ok, I already do that. IMHO I found it strange to have the same information
> > repeated on two places. But now that you say that this is deprecated, it makes
> > sense now.
> > 
> >>
> >>> +	if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE) {
> >>> +		dev_info(chan2dev(chan),
> >>> +			": direction DMA_DEV_TO_MEM (EDMA_DIR_WRITE)\n");
> >>> +		chan->p_addr = config->src_addr;
> >>> +	} else if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ) {
> >>> +		dev_info(chan2dev(chan),
> >>> +			": direction DMA_MEM_TO_DEV (EDMA_DIR_READ)\n");
> >>> +		chan->p_addr = config->dst_addr;
> >>> +	} else {
> >>> +		dev_err(chan2dev(chan), ": invalid direction\n");
> >>> +		err = -EINVAL;
> >>> +		goto err_config;
> >>> +	}
> >>
> >> This should be removed
> > 
> > Yeah, it was just for validation purposes. Now that direction is deprecated on
> > the API, makes no sense to validate it.
> > 
> >>
> >>> +
> >>> +	dev_info(chan2dev(chan),
> >>> +		": src_addr(physical) = 0x%.16x\n", config->src_addr);
> >>> +	dev_info(chan2dev(chan),
> >>> +		": dst_addr(physical) = 0x%.16x\n", config->dst_addr);
> >>
> 
> I've a doubt now. As you know, for a DMA transfer you need the source and
> destination addresses, which in the limited can be swapped according to the
> direction MEM_TO_DEV/DEV_TO_MEM case.
> 
> For the sake of simplicity, I'll just consider now the MEM_TO_DEV case, since
> the other case is similar but the source and destination address are swapped.
> 
> In my code I can get some of the information that I need by using the
> sg_dma_address() in the scatter-gather list (which gives me the source address).
> 
> The remaining information I got from here, using the direction to help me to
> select which address I'll use later on the DMA transfer, in this case the
> destination address.
> 
> Since this is deprecated how should I proceed? How can I get that information?
> There is some similar function to sg_dma_address() that could give me the
> destination address?

So the direction field is deprecated but rest of the configuration comes
from from dma_slave_config. The user should set src_addr, dst_addr and
then based on direction passed in the .device_prep_dma_* call arguments
one can use one of these as peripheral address.

Also, please keep in mind that for memory to memory transfers you should
not expect the dma_slave_config to be used

Thanks
-- 
~Vinod
