Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1933ECE561
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 11:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F48221480
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 11:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KifoXzPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F48221480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeIXRP3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:15:29 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42886 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeIXRP3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Sep 2018 13:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=StR9z8XziZ854Gz49Nwx94jSYQxbm1EuvCMEYM7LdWE=; b=KifoXzPNhYLx6UOknRelFsLSx
        No1SzRapBqMQbvzcDwVE+rfrtJMinSYPi5ecW9d2VR2HouFP6CyQZhdaZVmboIDrr17y93ks37E+1
        J3NIzX0XhwsgmelhRv/H0Reskxu0OL0b+c/HzzQbc/nAQbJboebxHJ4hwWnT5abO/apb4=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:43544)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g4OoF-0002wH-8I; Mon, 24 Sep 2018 12:13:47 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g4OoB-0006oG-TM; Mon, 24 Sep 2018 12:13:44 +0100
Date:   Mon, 24 Sep 2018 12:13:41 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20180924111341.GP30658@n2100.armlinux.org.uk>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il>
 <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
 <20180913104241.65db8243@windsurf>
 <20180924101213.GO30658@n2100.armlinux.org.uk>
 <20180924122614.70738b5c@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924122614.70738b5c@windsurf>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 24, 2018 at 12:26:14PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Mon, 24 Sep 2018 11:12:13 +0100, Russell King - ARM Linux wrote:
> 
> > > Thanks for the testing. I'll wait for Russell to say if he is happy
> > > (or not) with the addition of pci_unmap_io() in the ARM code, if that's
> > > the case, I'll send a proper patch to fix the issue.  
> > 
> > I'd prefer not to provide an unmapping API, because it gives the
> > impression that it's okay to unmap the IO space mapping, and we'll
> > end up with drivers that decide to call it in their cleanup path.
> > IO space isn't expected to ever go away - eg, on a PC, it's always
> > present.
> 
> But being able to unmap it would also be needed to be able to remove
> PCI host controller drivers, and therefore compile them as module, and
> make them more like any other drivers.
> 
> I'm not sure why we need to guarantee that the I/O space is always
> mapped:
> 
>  - It isn't mapped before the PCI controller driver does the mapping.
> 
>  - There is no reason for it to be accessed when the PCI controller
>    driver is not initialized: PCI devices can only be probed and
>    initialized when the PCI controller driver is probed/initialized.

There are historic reasons.  PCI provides ISA IO space, and when you
have a machine with ISA peripherals present, the PCI IO space must
never be unmapped - if it is, ISA drivers will oops the kernel.  There
is no way for a vanishing PCI controller to cause ISA drivers to be
unbound.

If you have a host controller that does unmap PCI IO space and you have
ISA peripherals with drivers present, unbinding the PCI host controller
will remove the IO space mapping, and next time an ISA peripheral
touches IO space, the kernel will oops.

> All other drivers, including on ARM, use pci_remap_iospace(), which
> does provide the pci_unmap_iospace() counter part.

... which has been created in PCI land just to deal with PCI without
regard for the above issue.

However, there's another issue I missed - if you _do_ have ISA
peripherals, you likely want the IO space setup from very early on,
and you won't be using the new fangled PCI host driver support anyway.
That uses pci_map_io_early() rather than pci_ioremap_io() or
pci_remap_io().

> But to me, the general direction is that the ARM-specific
> pci_remap_io() API is fading away, and its replacement already provides
> an unmapping capability. So why not add the same unmapping capability
> to pci_remap_io() ?

Yes, that would be a good longer term plan - we don't need three
different ways to map PCI IO space, but it is development.

> But we have a regression and we need to fix it. Do you suggest to not
> use the new pci_host_probe() API ?

Well, arguably, the patch that caused the regression is the buggy patch,
_not_ the lack of unmapping API for pci_ioremap_io().  Trying to address
a regression with further development means that _that_ development
needs thought and review, which is a slower process.

I do understand the desire to keep moving forward and never take a step
backwards, but sometimes backwards steps are the best way to resolve a
regression.  But I also do appreciate that a simple revert in this case
is not possible.

I'll accept your patch on the condition that the ARM private
pci_ioremap_io() will go away in the very near future (please _try_
to get agreement on that before this patch is merged.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
