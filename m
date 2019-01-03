Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEEEC43387
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 14:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52420217F5
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 14:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546527310;
	bh=ZTSg7awGFkSlf7Gnz73PvfD62ZyD5N3wFx9QhOhrvmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QbfY/QDgAHZj1nC/YxScgjXKSpgHYCT0moirK8qPBqtUozO9M6vmD59+bmH7pwW60
	 tDmos5prLViNOt9Xt6LkO55QluKM2cZbVcB69qZZaoNUP5X9rAmMf1qHBhH4bvMIr9
	 H5rLoyuPc4203vbMkIKihX0tLSRXYX8nCCQiqqko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfACOzJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:55:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfACOzJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jan 2019 09:55:09 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD63A217D9;
        Thu,  3 Jan 2019 14:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546527308;
        bh=ZTSg7awGFkSlf7Gnz73PvfD62ZyD5N3wFx9QhOhrvmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1cM/T0wP4Ddl6vFWYt4S+FYN0yoMZJgng2sN87ma3sdU+4YKfbEHOFO2NGLOG/LSp
         Yc6YibNwBDPMK9V7B/dNefB+r7F6mo+YxLnvqW+nRFwl8YtIke6scPJ6pzxmaPpP2c
         mSQIuR+CPOCCSRsQbEzSElxQuwaAKLXbTpoi36uY=
Date:   Thu, 3 Jan 2019 20:23:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: Re: [RFC 1/6] dma: Add Synopsys eDMA IP core driver
Message-ID: <20190103145330.GD21403@vkoul-mobl>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
 <bf4eb88265bf8bd95f7b2effdbfbeda8c52a2e0b.1544610287.git.gustavo.pimentel@synopsys.com>
 <20181217065120.GH2472@vkoul-mobl>
 <0768a44c-60d2-0983-b2e3-b8f711a24504@synopsys.com>
 <256fef2b-0dea-edee-396a-353520159005@synopsys.com>
 <20190103124542.GC21403@vkoul-mobl>
 <a860efb2-5f96-ee51-0bf5-653e3358ff7d@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a860efb2-5f96-ee51-0bf5-653e3358ff7d@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HI Gustavo,

On 03-01-19, 12:55, Gustavo Pimentel wrote:
> On 03/01/2019 12:45, Vinod Koul wrote:
> > On 03-01-19, 09:53, Gustavo Pimentel wrote:
> >> I've a doubt now. As you know, for a DMA transfer you need the source and
> >> destination addresses, which in the limited can be swapped according to the
> >> direction MEM_TO_DEV/DEV_TO_MEM case.
> >>
> >> For the sake of simplicity, I'll just consider now the MEM_TO_DEV case, since
> >> the other case is similar but the source and destination address are swapped.
> >>
> >> In my code I can get some of the information that I need by using the
> >> sg_dma_address() in the scatter-gather list (which gives me the source address).
> >>
> >> The remaining information I got from here, using the direction to help me to
> >> select which address I'll use later on the DMA transfer, in this case the
> >> destination address.
> >>
> >> Since this is deprecated how should I proceed? How can I get that information?
> >> There is some similar function to sg_dma_address() that could give me the
> >> destination address?
> > 
> > So the direction field is deprecated but rest of the configuration comes
> > from from dma_slave_config. The user should set src_addr, dst_addr and
> > then based on direction passed in the .device_prep_dma_* call arguments
> > one can use one of these as peripheral address.
> 
> Ok, and the address given by sg_dma_address()? Is redundant or not applicable
> for this case?

It is, it is the memory address you need to program. The device address
comes from dma_slave_config.

To elaborate, if you have MEM_TO_DEV use sg_dma_address() for src
address and dst_addr from dma_slave_config.

Similarly for DEV_TO_MEM, we use src_addr from dma_slave_config and
sg_dma_address()

The peripheral is static but memory buffer keeps changing wrt different
descriptors, so device address can be programmed once for multiple
descriptors to be transferred from a device.

HTH
-- 
~Vinod
