Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751408AbdCYRoU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 25 Mar 2017 13:44:20 -0400
Date: Sat, 25 Mar 2017 12:43:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pci: mvebu: avoid changing the SCC bit in the link
 status register
Message-ID: <20170325174330.GH25380@bhelgaas-glaptop.roam.corp.google.com>
References: <E1cTbUq-0008Gj-9u@rmk-PC.armlinux.org.uk>
 <20170325125859.GM7909@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170325125859.GM7909@n2100.armlinux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 25, 2017 at 12:58:59PM +0000, Russell King - ARM Linux wrote:
> Ping.  This _fix_ doesn't seem to have made it in.

Thanks for the ping.  I work from patchwork, and I couldn't find any
trace of this patch there, so there must have been a glitch.

I applied it to pci/host-mvebu for v4.12.

> On Tue, Jan 17, 2017 at 09:40:52PM +0000, Russell King wrote:
> > It seems on later Armada 38x, the slot clock configuration bit is not
> > read-only, but can be written.  This means that our RW1C protection
> > ends up clearing this bit when the link control register is written.
> > 
> > Adjust the mask so that we only avoid writing '1' bits to the RW1C
> > bits of this register (bits 15 and 14 of the link status) rather than
> > masking out all the status register bits.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/pci/host/pci-mvebu.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> > index 58f75c098b42..3ed4cb7501bd 100644
> > --- a/drivers/pci/host/pci-mvebu.c
> > +++ b/drivers/pci/host/pci-mvebu.c
> > @@ -827,10 +827,11 @@ static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
> >  		 * If the mask is 0xffff0000, then we only want to write
> >  		 * the link control register, rather than clearing the
> >  		 * RW1C bits in the link status register.  Mask out the
> > -		 * status register bits.
> > +		 * RW1C bits.
> >  		 */
> >  		if (mask == 0xffff0000)
> > -			value &= 0xffff;
> > +			value &= ~((PCI_EXP_LNKSTA_LABS |
> > +				    PCI_EXP_LNKSTA_LBMS) << 16);
> >  
> >  		mvebu_writel(port, value, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
> >  		break;
> > -- 
> > 2.7.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
