Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42741 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190Ab3HLNSl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2013 09:18:41 -0400
Date: Mon, 12 Aug 2013 09:18:33 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next list <linux-next@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: linux-next: Tree for Aug 8 (not CONFIG_PCI_MSI conflict)
Message-ID: <20130812131833.GI25111@titan.lakedaemon.net>
References: <20130808170822.82bf33d3cf5100f5e2646815@canb.auug.org.au>
 <5203F978.2050504@infradead.org>
 <20130809145939.GE25111@titan.lakedaemon.net>
 <52051BC2.2060004@infradead.org>
 <20130809185036.GG25111@titan.lakedaemon.net>
 <CAErSpo6S9uYTEhoS-+4EZv41pc0bu6jvcMaGX7WR9hY4o+2dsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo6S9uYTEhoS-+4EZv41pc0bu6jvcMaGX7WR9hY4o+2dsA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 10, 2013 at 08:01:49AM -0600, Bjorn Helgaas wrote:
> On Fri, Aug 9, 2013 at 12:50 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > Randy,
> >
> > On Fri, Aug 09, 2013 at 09:41:38AM -0700, Randy Dunlap wrote:
> >> On 08/09/13 07:59, Jason Cooper wrote:
> >> > Randy,
> >> >
> >> > On Thu, Aug 08, 2013 at 01:03:04PM -0700, Randy Dunlap wrote:
> >> >> On 08/08/13 00:08, Stephen Rothwell wrote:
> >> >>> Hi all,
> >> >>>
> >> >>> Changes since 20130807:
> >> >>>
> >> >>
> >> >> on i386 and x86_64:
> >> >> when CONFIG_PCI_MSI is not enabled:
> >> >>
> >> >> There are many of these errors:
> >> >> include/linux/msi.h:65:6: error: expected identifier or '(' before 'void'
> >> >> include/linux/msi.h:65:6: error: expected ')' before numeric constant
> >> >>
> >> >> because arch/x86/include/asm/pci.h defines:
> >> >> #define default_teardown_msi_irqs  NULL
> >> >
> >> > Do you have an example config you used?
> >>
> >> Sure, attached. (or I have 14 of them)
> >
> > Thanks, I was able to reproduce the error.  I'm not real familiar with
> > this area of the code, but the relief is it doesn't appear to be caused
> > by the mvebu changes (well, relief for us ;-) ).
> >
> > At any rate, give this a spin and see if it works for you
> >
> > If it's acceptable, I'll do an official patch for Bjorn.
> >
> > thx,
> >
> > Jason.
> >
> > ---------->8----------
> > diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> > index d9e9e6c..6169414 100644
> > --- a/arch/x86/include/asm/pci.h
> > +++ b/arch/x86/include/asm/pci.h
> > @@ -138,8 +138,8 @@ void default_restore_msi_irqs(struct pci_dev *dev, int irq);
> >  #else
> >  #define native_setup_msi_irqs          NULL
> >  #define native_teardown_msi_irq                NULL
> > -#define default_teardown_msi_irqs      NULL
> > -#define default_restore_msi_irqs       NULL
> > +void __weak default_teardown_msi_irqs(struct pci_dev *dev) { }
> > +void __weak default_restore_msi_irqs(struct pci_dev *dev, int irq) { }
> 
> I don't really like this solution of putting the empty implementation
> in the header file, because then a weak body is generated in the
> object of every source file that includes the header.
> 
> default_teardown_msi_irqs() and default_restore_msi_irqs() seem like
> fairly internal MSI functions, so I wonder why we need them defined at
> all when CONFIG_PCI_MSI=n.  It seems like any uses of them should be
> in code that's only compiled when CONFIG_PCI_MSI=y.  But I haven't
> reproduced the problem and investigated yet.

I first tried commenting out the definitions after reproducing the
problem.  It also failed miserably.

Please take a look at Thomas' latest MSI patch series,

  [PATCHv9 01/10] PCI: use weak functions for MSI arch-specific functions

I think his solution is much nicer than mine.

thx,

Jason.
