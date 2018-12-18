Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC540C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 03:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900222184B
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 03:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545105290;
	bh=ePalVh3JawN93rBu5YYkKMohLgY1+Q/U85arqRGWWK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GhQY/nzcMKXDRC3SExzTJ73QW0KgaUQmPj2CWxtO7QhtrNcfmo3KAxb9+QstR9xzO
	 g70u/ofDeDhiOOKu4xd0P5py7oBpUUSk0WUhj0LrQvvKPtOBXhURiDTYNqGOqDmWwj
	 E9eHI/UXxeGQfxELNA1uDkhn015ybWShlcosQEdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbeLRDyt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:54:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbeLRDyt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 22:54:49 -0500
Received: from localhost (unknown [171.61.92.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 556E020874;
        Tue, 18 Dec 2018 03:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545105289;
        bh=ePalVh3JawN93rBu5YYkKMohLgY1+Q/U85arqRGWWK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lhxvu0c33L8ge564jVYVmuxpDBID2aqPRy5xnok5HYquSmvHVO8yEqBos9q05pCKE
         AcdFY3H19KKEH7aJ6+FGxhBhWvnX9VFi794jOV6JRzEjUG5OzMVjiN2oJdZuYmLYlD
         wSJ/qMOEgczZHbW631sIDd2U4hy26LRskRUzkGls=
Date:   Tue, 18 Dec 2018 09:24:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: Re: [RFC 1/6] dma: Add Synopsys eDMA IP core driver
Message-ID: <20181218035438.GO2472@vkoul-mobl>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
 <bf4eb88265bf8bd95f7b2effdbfbeda8c52a2e0b.1544610287.git.gustavo.pimentel@synopsys.com>
 <20181217065120.GH2472@vkoul-mobl>
 <0768a44c-60d2-0983-b2e3-b8f711a24504@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0768a44c-60d2-0983-b2e3-b8f711a24504@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17-12-18, 15:56, Gustavo Pimentel wrote:

> >> +
> >> +#define SET(reg, name, val)			\
> >> +	reg.name = val
> >> +
> >> +#define SET_BOTH_CH(name, value)		\
> >> +	do {					\
> >> +		SET(dw->wr_edma, name, value);	\
> >> +		SET(dw->rd_edma, name, value);	\
> >> +	} while (0)
> > 
> > I am not sure how this helps, makes things not explicit..
> 
> Since this driver has 2 channels (write and read) I'd like to simplify all the
> configurations that I've to make on both channels (avoiding any omission), that
> why I created this macro.

So in order to configure a channel you need to write to both?

> Should I add some comment on top of this macro or do you think that is better to
> replicate the code for each channel?

That will help to explain..

> >> +
> >> +	err = ops->device_config(dchan);
> > 
> > okay what does this callback do. You are already under and dmaengine fwk
> > so what is the need to add one more abstraction layer, can you explain
> > that in details please
> 
> This callback just configures the eDMA HW block interrupt address (abort and
> done) and data for each channel. This callback could easily moved to the
> dw_edma_probe() where each channel is created at first.
> Should I do it in your opinion?

My question is about callbacks in this driver in general. You are
already under a dmaengine fwk, so this is adding one more layer on top
with callbacks implementing low level stiff. Why do we need another layer
is the question..

-- 
~Vinod
