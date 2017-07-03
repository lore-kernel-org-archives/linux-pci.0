Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 3 Jul 2017 08:05:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Ethan Zhao <ethan.kernel@gmail.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, thejoe@gmail.com,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PCI: Work around poweroff & suspend-to-RAM issue on
 Macbook Pro 11
Message-ID: <20170703130526.GC13824@bhelgaas-glaptop.roam.corp.google.com>
References: <20170702205948.GB18324@bhelgaas-glaptop.roam.corp.google.com>
 <20170703042621.GA22429@yu-desktop-1.sh.intel.com>
 <CABawtvNd0MtxVnwedJc3nrMuAViAnRojezuRqJK+-QXaRfNOAA@mail.gmail.com>
 <20170703091048.GA15823@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170703091048.GA15823@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 03, 2017 at 11:10:48AM +0200, Lukas Wunner wrote:
> On Mon, Jul 03, 2017 at 02:33:39PM +0800, Ethan Zhao wrote:
> > On Mon, Jul 3, 2017 at 12:26 PM, Chen Yu <yu.c.chen@intel.com> wrote:
> > > On Sun, Jul 02, 2017 at 03:59:48PM -0500, Bjorn Helgaas wrote:
> > >> --- a/arch/x86/pci/fixup.c
> > >> +++ b/arch/x86/pci/fixup.c
> [snip]
> > >> +static void quirk_apple_mbp_poweroff(struct pci_dev *pdev)
> > >> +{
> > >> +     struct device *dev = &pdev->dev;
> > >> +     struct resource *res;
> > >> +
> > >> +     if ((!dmi_match(DMI_PRODUCT_NAME, "MacBookPro11,4") &&
> > >> +          !dmi_match(DMI_PRODUCT_NAME, "MacBookPro11,5")) ||
> > >> +         pdev->bus->number != 0 || pdev->devfn != PCI_DEVFN(0x1c, 0))
> > >> +             return;
> > >> +
> > > Not sure why we need to also the bus number of devfn, as there
> > > is only one PCI bridge that would match 0x8c10? according to
> > > https://bugzilla.kernel.org/attachment.cgi?id=210611
> > > am I missing something?
> > 
> >  To make sure it runs only once only when 00:1c.0 is 0x8c10 ?
> 
> Each root port has a different PCI device ID and is only present once
> on the affected machines, so I think Chen Yu is right.
> 
> Actually, since the quirk is now related to a memory region and no longer
> to a specific PCI device, it need not be a PCI fixup.  It could go into
> arch/x86/kernel/setup.c:trim_platform_memory_ranges() as a DMI quirk.
> 
> This would also allow declaration of the code as __init.

That's a good idea, but I don't know what (if any) ordering issues
we'd have with reserving this region vs. the host bridge windows.

If somebody wants to rework this and test it, I'd be glad to replace
the current patch.  If you do, please collect the /proc/iomem contents
to make sure they look reasonable.

Bjorn
