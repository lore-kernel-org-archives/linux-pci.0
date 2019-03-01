Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F78C43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 14:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD4F20850
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 14:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfCAO5B (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:57:01 -0500
Received: from ns.lynxeye.de ([87.118.118.114]:58736 "EHLO lynxeye.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728187AbfCAO5B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Mar 2019 09:57:01 -0500
Received: by lynxeye.de (Postfix, from userid 501)
        id 0F49AE7421F; Fri,  1 Mar 2019 15:56:59 +0100 (CET)
Received: from antimon.fritz.box (a89-183-15-158.net-htp.de [89.183.15.158])
        by lynxeye.de (Postfix) with ESMTPSA id BFDD6E7414D;
        Fri,  1 Mar 2019 15:56:58 +0100 (CET)
Message-ID: <d0e83ca1648a3ec80c01bc5e6708286f9d891580.camel@lynxeye.de>
Subject: Re: [PATCH] PCI: tegra: Do not allocate MSI target memory
From:   Lucas Stach <dev@lynxeye.de>
To:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, treding@nvidia.com, swarren@nvidia.com,
        mperttunen@nvidia.com, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com
Date:   Fri, 01 Mar 2019 15:56:58 +0100
In-Reply-To: <8b6f53c4-ac39-40d6-0979-86137236f890@nvidia.com>
References: <1551366004-32547-1-git-send-email-vidyas@nvidia.com>
         <247102e57e067d1477f3260bdeaa3ea011d0f3ed.camel@lynxeye.de>
         <8b6f53c4-ac39-40d6-0979-86137236f890@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Freitag, den 01.03.2019, 08:45 +0530 schrieb Vidya Sagar:
> On 3/1/2019 12:32 AM, Lucas Stach wrote:
> > Am Donnerstag, den 28.02.2019, 20:30 +0530 schrieb Vidya Sagar:
> > > The PCI host bridge found on Tegra SoCs doesn't require the MSI target
> > > address to be backed by physical system memory. Writes are intercepted
> > > within the controller and never make it to the memory pointed to.
> > > 
> > > Since no actual system memory is required, remove the allocation of a
> > > single page and hardcode the MSI target address with a special address
> > > on a per-SoC basis. Ideally this would be an address to an MMIO memory
> > > region (such as where the controller's register are located). However,
> > > those addresses don't work reliably across all Tegra generations. The
> > > only set of addresses that work consistently are those that point to
> > > external memory.
> > > 
> > > This is not ideal, since those addresses could technically be used for
> > > DMA and hence be confusing. However, the first page of external memory
> > > is unlikely to be used and special enough to avoid confusion.
> > So you are trading a slight memory waste of a single page against a
> > sporadic (and probably hard to debug) DMA failure if any device happens
> > to initiate DMA to the first page of physical memory? That does not
> > sound like a good deal...
> > 
> > Also why would the first page of external memory be unlikely to be
> > used?
> > 
> > Regards,
> > Lucas
> 
> We are not wasting single page of memory here and if any device's DMA is 
> trying to access it, it will still go through. Its just that we are using that 
> same address for MSI (note that MSI writes don't go beyond PCIe IP as they get
> decoded at PCIe IP level itself and only an interrupt
> goes to CPU) and that might be a bit confusing as same address is used 
> as normal memory as well as MSI target address. Since there can never be any
> issue with this would you suggest to remove the last paragraph from commit
> description?

How does the core distinguish between a normal DMA memory write and a
MSI? If I remember the PCIe spec correctly, there aren't any
differences between the two besides the target address.

So if you now set a non-reserved region of memory to decode as a MSI at
the PCIe host controller level, wouldn't this lead to normal DMA
transactions to this address being wrongfully turned into an MSI and
the write not reaching the targeted location?

Regards,
Lucas

