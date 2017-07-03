Return-Path: <SRS0=zSJD=6G=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=zSJD=6G=h08.hostsharing.net=foo00@kernel.org>
Date: Mon, 3 Jul 2017 11:10:48 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ethan Zhao <ethan.kernel@gmail.com>
Cc: Chen Yu <yu.c.chen@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, thejoe@gmail.com,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PCI: Work around poweroff & suspend-to-RAM issue on
 Macbook Pro 11
Message-ID: <20170703091048.GA15823@wunner.de>
References: <20170702205948.GB18324@bhelgaas-glaptop.roam.corp.google.com>
 <20170703042621.GA22429@yu-desktop-1.sh.intel.com>
 <CABawtvNd0MtxVnwedJc3nrMuAViAnRojezuRqJK+-QXaRfNOAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABawtvNd0MtxVnwedJc3nrMuAViAnRojezuRqJK+-QXaRfNOAA@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 03, 2017 at 02:33:39PM +0800, Ethan Zhao wrote:
> On Mon, Jul 3, 2017 at 12:26 PM, Chen Yu <yu.c.chen@intel.com> wrote:
> > On Sun, Jul 02, 2017 at 03:59:48PM -0500, Bjorn Helgaas wrote:
> >> --- a/arch/x86/pci/fixup.c
> >> +++ b/arch/x86/pci/fixup.c
[snip]
> >> +static void quirk_apple_mbp_poweroff(struct pci_dev *pdev)
> >> +{
> >> +     struct device *dev = &pdev->dev;
> >> +     struct resource *res;
> >> +
> >> +     if ((!dmi_match(DMI_PRODUCT_NAME, "MacBookPro11,4") &&
> >> +          !dmi_match(DMI_PRODUCT_NAME, "MacBookPro11,5")) ||
> >> +         pdev->bus->number != 0 || pdev->devfn != PCI_DEVFN(0x1c, 0))
> >> +             return;
> >> +
> > Not sure why we need to also the bus number of devfn, as there
> > is only one PCI bridge that would match 0x8c10? according to
> > https://bugzilla.kernel.org/attachment.cgi?id=210611
> > am I missing something?
> 
>  To make sure it runs only once only when 00:1c.0 is 0x8c10 ?

Each root port has a different PCI device ID and is only present once
on the affected machines, so I think Chen Yu is right.

Actually, since the quirk is now related to a memory region and no longer
to a specific PCI device, it need not be a PCI fixup.  It could go into
arch/x86/kernel/setup.c:trim_platform_memory_ranges() as a DMI quirk.

This would also allow declaration of the code as __init.

Thanks,

Lukas

> >> +     res = request_mem_region(0x7fa00000, 0x200000,
> >> +                              "MacBook Pro poweroff workaround");
> >> +     if (res)
> >> +             dev_info(dev, "claimed %s %pR\n", res->name, res);
> >> +     else
> >> +             dev_info(dev, "can't work around MacBook Pro poweroff issue\n");
> >> +}
> >> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_apple_mbp_poweroff);
