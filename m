Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:59013 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbbDGHor (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Apr 2015 03:44:47 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@lists.ozlabs.org, wangyijing@huawei.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 04/19] powerpc: Create pci_controller_ops.dma_dev_setup and shim
Date: Tue, 07 Apr 2015 09:44:36 +0200
Message-ID: <2489424.TEiBTfgpvS@wuerfel>
In-Reply-To: <1428366696.22268.28.camel@axtens.net>
References: <1427778057-9505-1-git-send-email-dja@axtens.net> <5500778.Q4t9Fg7Irn@wuerfel> <1428366696.22268.28.camel@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 07 April 2015 10:31:36 Daniel Axtens wrote:
> > Please see https://patchwork.ozlabs.org/patch/431333/ for related work.
> > 
> I'm familiar with that patch series - I've been helping Yijing get it up
> to speed on PowerPC.
> 
> 
> > I think it would be better not to introduce another architecture-specific
> > pci host bridge operations structure, but instead consolidate into
> > the one that is already there. We are also adding a generic way to set up
> > PCI DMA, so it would seems reasonable to hook into that place.
> I see what you're getting at, and I agree that we want to move towards
> generic operations. 
> 
> However, I think this should go in as is at this point, for two main
> reasons:
> 
> 1) This is a good midpoint that makes it easier to move to a generic
> structure. Our arch specific stuff is quirky and difficult. This patch
> series does a lot to reduce the complexity, and would make it very easy
> to move these ops into a generic structure at some future point. 
> 
> 2) Trying to go generic at this point risks making the change set so
> complex and wide ranging that it will really struggle to get in. For
> example, Yijing's patch set, despite not changing any of the quirky
> stuff in PowerPC, is already quite long, and will require agreement from
> a lot of people before it can go in.
> 
> Much as I would like to have everything as generic as possible, if we
> were to try to do the whole job in one go, it'd become a big, difficult,
> messy patch set, and would be less likely to happen than if we were to
> do it in two steps.

Ok, fair enough. Let's do this one first then.

	Arnd
