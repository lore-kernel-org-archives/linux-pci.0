Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:59777 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752662AbeARBNt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jan 2018 20:13:49 -0500
Message-ID: <1516238026.3045.61.camel@perches.com>
Subject: Re: [PATCH v3 1/3] PCI: Create  minor pci_dev log wrapper functions
From: Joe Perches <joe@perches.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        Frederick Lawler <fred@fredlawl.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 17 Jan 2018 17:13:46 -0800
In-Reply-To: <20180117201239.GC7039@bhelgaas-glaptop.roam.corp.google.com>
References: <1515819518-6501-1-git-send-email-fred@fredlawl.com>
         <1515819518-6501-2-git-send-email-fred@fredlawl.com>
         <20180117201239.GC7039@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2018-01-17 at 14:12 -0600, Bjorn Helgaas wrote:
> [+to Joe]
> 
> On Fri, Jan 12, 2018 at 10:58:36PM -0600, Frederick Lawler wrote:
> > Add PCI-specific dev_printk() wrappers so we can do:
> > 
> >   pci_info(dev, "message\n");
> > 
> > instead of
> > 
> >   dev_info(&dev->dev, "message\n");
> 
> Hi Joe,
> 
> I proposed that Fred add pci_info(), pci_warn(), pci_err(), etc.
> You've done sort of similar things in the past:
> 
>   256df2f3879e ("netdevice.h net/core/dev.c: Convert netdev_<level> logging macros to functions")
>   a9a79dfec239 ("ata: Convert ata_<foo>_printk(KERN_<LEVEL> to ata_<foo>_<level>")
> 
> Do you have any implementation advice for us?

I try to use separate functions only when there is
some object code savings that is greater than the
increase in object size of the new function(s).

In this case, only the object indirection dev->dev is
being saved/reused so likely unless this is going to
be used multiple dozens of times, most likely a simple
macro wrapper might be best.

> Would you recommend:
> 
>   - simple #defines as below,

For this case, yes.

>   - multiple non-inline functions like netdev,

Probably not unless you want to additionally prefix
the output with some new PCI specific content.

>   - single non-inline *_printk() with macros like ata,

Individual ata_<foo>_printk functions were used along
with multiple ata_<foo>_<level> macros there.

ata_<foo>_printk was used because there weren't enough
callers of individual ata_<foo>_<level> functions to
justify their creation to reduce overall object code size
and macros created overall smaller objects.

>   - something else?
> 
> Thanks for any advice!

> diff --git a/include/linux/pci.h b/include/linux/pci.h
[]
> > @@ -2281,4 +2281,31 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
> >  /* provide the legacy pci_dma_* API */
> >  #include <linux/pci-dma-compat.h>
> >  
> > +#define pci_printk(level, pdev, fmt, arg...)		\
> > +	dev_printk(level, &(pdev)->dev, fmt, ##arg)

I would generally use the ##__VA_ARGS__ form

#define pci_printk(level, pdev, fmt, ...)			\
	dev_printk(level, &(pdev)->dev, fmt, ##__VA_ARGS__)

> > +#define pci_emerg(pdev, fmt, arg...)			\
> > +	dev_emerg(&(pdev)->dev, fmt, ##arg)

#define pci_emerg(level, pdev, fmt, ...)			\
	dev_emerg(level
, &(pdev)->dev, fmt, ##__VA_ARGS__)

etc...

cheers, Joe
