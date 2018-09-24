Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0026ECE561
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 12:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F3D20833
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 12:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F3D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbeIXSOF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:14:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35394 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729726AbeIXSOE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Sep 2018 14:14:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2FEDB208B1; Mon, 24 Sep 2018 14:12:13 +0200 (CEST)
Received: from windsurf (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id DDF4A20725;
        Mon, 24 Sep 2018 14:12:02 +0200 (CEST)
Date:   Mon, 24 Sep 2018 14:12:03 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20180924141203.3df9707a@windsurf>
In-Reply-To: <20180924111341.GP30658@n2100.armlinux.org.uk>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
        <87zhwm4kl6.fsf@tkos.co.il>
        <20180912231050.GX30658@n2100.armlinux.org.uk>
        <20180913094515.351967bb@windsurf>
        <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
        <20180913104241.65db8243@windsurf>
        <20180924101213.GO30658@n2100.armlinux.org.uk>
        <20180924122614.70738b5c@windsurf>
        <20180924111341.GP30658@n2100.armlinux.org.uk>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Mon, 24 Sep 2018 12:13:41 +0100, Russell King - ARM Linux wrote:

> > But being able to unmap it would also be needed to be able to remove
> > PCI host controller drivers, and therefore compile them as module, and
> > make them more like any other drivers.
> > 
> > I'm not sure why we need to guarantee that the I/O space is always
> > mapped:
> > 
> >  - It isn't mapped before the PCI controller driver does the mapping.
> > 
> >  - There is no reason for it to be accessed when the PCI controller
> >    driver is not initialized: PCI devices can only be probed and
> >    initialized when the PCI controller driver is probed/initialized.  
> 
> There are historic reasons.  PCI provides ISA IO space, and when you
> have a machine with ISA peripherals present, the PCI IO space must
> never be unmapped - if it is, ISA drivers will oops the kernel.  There
> is no way for a vanishing PCI controller to cause ISA drivers to be
> unbound.
> 
> If you have a host controller that does unmap PCI IO space and you have
> ISA peripherals with drivers present, unbinding the PCI host controller
> will remove the IO space mapping, and next time an ISA peripheral
> touches IO space, the kernel will oops.

Thanks for sharing some additional technical context on this, very
useful.

I have another question though: shouldn't those ISA devices be child
devices of the PCI controller, if they use some resources of the PCI
controller ? Could you give an example of such an ISA device driver ?
This is just to understand better the issue, because there seems to be
a kind of hidden dependency between those ISA drivers and the setup of
the PCI controller.

> > All other drivers, including on ARM, use pci_remap_iospace(), which
> > does provide the pci_unmap_iospace() counter part.  
> 
> ... which has been created in PCI land just to deal with PCI without
> regard for the above issue.
> 
> However, there's another issue I missed - if you _do_ have ISA
> peripherals, you likely want the IO space setup from very early on,
> and you won't be using the new fangled PCI host driver support anyway.
> That uses pci_map_io_early() rather than pci_ioremap_io() or
> pci_remap_io().

OK. There's today a single platform (Footbridge) that uses
pci_map_io_early(), and it is indeed called through the ->map_io()
hook, which is very early in the boot process.

BTW, look at drivers/pcmcia/at91_cf.c. It has ->probe() and ->remove(),
and does a pci_ioremap_io() in its ->probe(), and nothing in its
->remove(). I don't think this driver, compiled as a module, will work
well after a insmod/rmmod/insmod cycle.

> > But to me, the general direction is that the ARM-specific
> > pci_remap_io() API is fading away, and its replacement already provides
> > an unmapping capability. So why not add the same unmapping capability
> > to pci_remap_io() ?  
> 
> Yes, that would be a good longer term plan - we don't need three
> different ways to map PCI IO space, but it is development.

Absolutely. Glad to hear that you agree on the longer term plan.

> > But we have a regression and we need to fix it. Do you suggest to not
> > use the new pci_host_probe() API ?  
> 
> Well, arguably, the patch that caused the regression is the buggy patch,
> _not_ the lack of unmapping API for pci_ioremap_io().

Totally true.

> Trying to address a regression with further development means that
> _that_ development needs thought and review, which is a slower
> process.
> 
> I do understand the desire to keep moving forward and never take a
> step backwards, but sometimes backwards steps are the best way to
> resolve a regression.  But I also do appreciate that a simple revert
> in this case is not possible.

Well, I can revert:

42342073e38b50113354944cd51dcfed28d857a1 PCI: mvebu: Convert to use
pci_host_bridge directly ee1604381a371b3ea6aec7d5e43b6e3f5e153854 PCI:
mvebu: Only remap I/O space if configured

so it's not a big deal either. I can revert those, and then resubmit a
more complete series later on that moves pci-mvebu to use
pci_remap_iospace().

> I'll accept your patch on the condition that the ARM private
> pci_ioremap_io() will go away in the very near future (please _try_
> to get agreement on that before this patch is merged.)

Bjorn, Lorenzo, what do you prefer ? 

If we want to get rid of pci_ioremap_io(), then we need a way to tell
pci_remap_iospace() the memory attributes that should be used for the
mapping, because on Armada 38x, we need to map the I/O space mapped
MT_UNCACHED instead of MT_DEVICE. I'm not sure how to achieve this yet.
Should pgprot_device() be changed to return MT_UNCACHED on a
platform-specific basis ? Any other idea ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
