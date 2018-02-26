Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751697AbeBZSJD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Feb 2018 13:09:03 -0500
Date: Mon, 26 Feb 2018 12:09:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>, kishon@ti.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] misc: pci_endpoint_test: Handle 64-bit BARs
 properly
Message-ID: <20180226180901.GB25159@bhelgaas-glaptop.roam.corp.google.com>
References: <20180208123346.20784-1-niklas.cassel@axis.com>
 <20180208123346.20784-3-niklas.cassel@axis.com>
 <20180226172618.GA26815@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180226172618.GA26815@e107981-ln.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 26, 2018 at 05:26:18PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Feb 08, 2018 at 01:33:45PM +0100, Niklas Cassel wrote:
> > A 64-bit BAR uses the succeeding BAR for the upper bits,
> > so we cannot simply call pci_ioremap_bar() on every single BAR.
> > 
> > Ignore BARs that does not have a valid resource length.
> > 
> > pci 0000:01:00.0: BAR 4: assigned [mem 0xc0300000-0xc031ffff 64bit]
> > pci 0000:01:00.0: BAR 2: assigned [mem 0xc0320000-0xc03203ff 64bit]
> > pci 0000:01:00.0: BAR 0: assigned [mem 0xc0320400-0xc03204ff 64bit]
> > pci-endpoint-test 0000:01:00.0: can't ioremap BAR 1: [??? 0x00000000 flags 0x0]
> > pci-endpoint-test 0000:01:00.0: failed to read BAR1
> > pci-endpoint-test 0000:01:00.0: can't ioremap BAR 3: [??? 0x00000000 flags 0x0]
> > pci-endpoint-test 0000:01:00.0: failed to read BAR3
> > pci-endpoint-test 0000:01:00.0: can't ioremap BAR 5: [??? 0x00000000 flags 0x0]
> > pci-endpoint-test 0000:01:00.0: failed to read BAR5
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> > Lorenzo/Bjorn: pci_resource_len() seems to fix my problem,
> > but is it the correct function to use here?
> > If BAR[x] is a 64-bit BAR, I'm assuming that pci_resource_len() on BAR[x+1]
> > will always return 0 (since BAR[x+1] cannot have any prefetchable/type bits
> > when BAR[x] is 64-bit).
> > 
> >  drivers/misc/pci_endpoint_test.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index 320276f42653..3af31bfdcfdd 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -534,6 +534,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
> >  	}
> >  
> >  	for (bar = BAR_0; bar <= BAR_5; bar++) {
> > +		if (pci_resource_len(pdev, bar) == 0)
> > +			continue;
> 
> Should not it be handled by checking the resource flags as you loop
> through the bar counter and incrementing the bar counter (+1) if
> IORESOURCE_MEM_64 is detected ?

I agree, pci_resource_len() is the wrong thing here.  The length
(actually the entire resource[x]) *should* be zero if the slot
corresponds to the upper bits of a 64-bit BAR, but I think it would be
more natural to do this:

  if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM)
    base = pci_ioremap_bar(pdev, bar);

You *could* check for IORESOURCE_MEM_64 and increment "bar" if you
find it, but I don't think that's really idiomatic, and it builds in a
little bit of unnecessary knowledge about how the PCI core maps BAR
registers to the resource[] array.

> >  		base = pci_ioremap_bar(pdev, bar);
> >  		if (!base) {
> >  			dev_err(dev, "failed to read BAR%d\n", bar);
> > -- 
> > 2.14.2
> > 
