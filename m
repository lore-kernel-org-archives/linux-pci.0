Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0042C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 08:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F35820877
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 08:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F35820877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeIYOY1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:24:27 -0400
Received: from foss.arm.com ([217.140.101.70]:46586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbeIYOY1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 10:24:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF56D80D;
        Tue, 25 Sep 2018 01:18:04 -0700 (PDT)
Received: from localhost (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1329F3F5B7;
        Tue, 25 Sep 2018 01:18:03 -0700 (PDT)
Date:   Tue, 25 Sep 2018 09:18:02 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20180925081801.GA54965@e119886-lin.cambridge.arm.com>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il>
 <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
 <20180913104241.65db8243@windsurf>
 <20180924101213.GO30658@n2100.armlinux.org.uk>
 <20180924122614.70738b5c@windsurf>
 <20180924111341.GP30658@n2100.armlinux.org.uk>
 <20180924141203.3df9707a@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924141203.3df9707a@windsurf>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Mon, Sep 24, 2018 at 02:12:03PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Mon, 24 Sep 2018 12:13:41 +0100, Russell King - ARM Linux wrote:
> 
> > > But being able to unmap it would also be needed to be able to remove
> > > PCI host controller drivers, and therefore compile them as module, and
> > > make them more like any other drivers.
> > > 
> > > I'm not sure why we need to guarantee that the I/O space is always
> > > mapped:
> > > 
> > >  - It isn't mapped before the PCI controller driver does the mapping.
> > > 
> > >  - There is no reason for it to be accessed when the PCI controller
> > >    driver is not initialized: PCI devices can only be probed and
> > >    initialized when the PCI controller driver is probed/initialized.  
> > 
> > There are historic reasons.  PCI provides ISA IO space, and when you
> > have a machine with ISA peripherals present, the PCI IO space must
> > never be unmapped - if it is, ISA drivers will oops the kernel.  There
> > is no way for a vanishing PCI controller to cause ISA drivers to be
> > unbound.
> > 
> > If you have a host controller that does unmap PCI IO space and you have
> > ISA peripherals with drivers present, unbinding the PCI host controller
> > will remove the IO space mapping, and next time an ISA peripheral
> > touches IO space, the kernel will oops.
> 
> Thanks for sharing some additional technical context on this, very
> useful.
> 
> I have another question though: shouldn't those ISA devices be child
> devices of the PCI controller, if they use some resources of the PCI
> controller ? Could you give an example of such an ISA device driver ?

Legacy VGA also falls into this category - for example
drivers/video/console/vgacon.c will happily use outb/inb macros to hard
coded addresses which are hoped to be present on some PCI/ISA bus.

With regards to ISA drivers - take a look for anything that registers with
isa_register_driver - for example:

drivers/input/touchscreen/htcpen.c
drivers/net/ethernet/3com/3c509.c
drivers/watchdog/ebc-c384_wdt.c

None of these drivers do any kind of mapping before attempting to access
these addresses.

Thanks,

Andrew Murray

> This is just to understand better the issue, because there seems to be
> a kind of hidden dependency between those ISA drivers and the setup of
> the PCI controller.
> 
> > > All other drivers, including on ARM, use pci_remap_iospace(), which
> > > does provide the pci_unmap_iospace() counter part.  
> > 
> > ... which has been created in PCI land just to deal with PCI without
> > regard for the above issue.
> > 
> > However, there's another issue I missed - if you _do_ have ISA
> > peripherals, you likely want the IO space setup from very early on,
> > and you won't be using the new fangled PCI host driver support anyway.
> > That uses pci_map_io_early() rather than pci_ioremap_io() or
> > pci_remap_io().
> 
> OK. There's today a single platform (Footbridge) that uses
> pci_map_io_early(), and it is indeed called through the ->map_io()
> hook, which is very early in the boot process.
> 
> BTW, look at drivers/pcmcia/at91_cf.c. It has ->probe() and ->remove(),
> and does a pci_ioremap_io() in its ->probe(), and nothing in its
> ->remove(). I don't think this driver, compiled as a module, will work
> well after a insmod/rmmod/insmod cycle.
> 
> > > But to me, the general direction is that the ARM-specific
> > > pci_remap_io() API is fading away, and its replacement already provides
> > > an unmapping capability. So why not add the same unmapping capability
> > > to pci_remap_io() ?  
> > 
> > Yes, that would be a good longer term plan - we don't need three
> > different ways to map PCI IO space, but it is development.
> 
> Absolutely. Glad to hear that you agree on the longer term plan.
> 
> > > But we have a regression and we need to fix it. Do you suggest to not
> > > use the new pci_host_probe() API ?  
> > 
> > Well, arguably, the patch that caused the regression is the buggy patch,
> > _not_ the lack of unmapping API for pci_ioremap_io().
> 
> Totally true.
> 
> > Trying to address a regression with further development means that
> > _that_ development needs thought and review, which is a slower
> > process.
> > 
> > I do understand the desire to keep moving forward and never take a
> > step backwards, but sometimes backwards steps are the best way to
> > resolve a regression.  But I also do appreciate that a simple revert
> > in this case is not possible.
> 
> Well, I can revert:
> 
> 42342073e38b50113354944cd51dcfed28d857a1 PCI: mvebu: Convert to use
> pci_host_bridge directly ee1604381a371b3ea6aec7d5e43b6e3f5e153854 PCI:
> mvebu: Only remap I/O space if configured
> 
> so it's not a big deal either. I can revert those, and then resubmit a
> more complete series later on that moves pci-mvebu to use
> pci_remap_iospace().
> 
> > I'll accept your patch on the condition that the ARM private
> > pci_ioremap_io() will go away in the very near future (please _try_
> > to get agreement on that before this patch is merged.)
> 
> Bjorn, Lorenzo, what do you prefer ? 
> 
> If we want to get rid of pci_ioremap_io(), then we need a way to tell
> pci_remap_iospace() the memory attributes that should be used for the
> mapping, because on Armada 38x, we need to map the I/O space mapped
> MT_UNCACHED instead of MT_DEVICE. I'm not sure how to achieve this yet.
> Should pgprot_device() be changed to return MT_UNCACHED on a
> platform-specific basis ? Any other idea ?
> 
> Best regards,
> 
> Thomas
> -- 
> Thomas Petazzoni, CTO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
