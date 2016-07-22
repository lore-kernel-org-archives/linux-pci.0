Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 22 Jul 2016 11:40:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Durbin <adurbin@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: ACPI device using sub-resource of PCI device
Message-ID: <20160722164056.GD20646@localhost>
References: <CAE2855tofJV=HV2dYuC+1=pi2mb942zrRF7f0+wqxPPay44RGA@mail.gmail.com>
 <CAE2855t5M2=OVXTBfosdNjqg6jUpM-PK02eP6KHC82eKk71-4w@mail.gmail.com>
 <20160720193543.GA4186@localhost>
 <1787767.fkqrmkTfXg@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1787767.fkqrmkTfXg@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 21, 2016 at 12:46:03AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 20, 2016 02:35:43 PM Bjorn Helgaas wrote:
> > On Tue, Jun 28, 2016 at 09:41:19PM -0700, Aaron Durbin wrote:
> > > On Fri, Jun 24, 2016 at 12:34 PM, Aaron Durbin <adurbin@google.com> wrote:

> > > > acpi_init() and pci_subsys_init() are both subsys_initcalls during
> > > > boot up. I'm not sure if the ordering is dumb luck or not, but
> > > > acpi_init() is called prior to pci_subsys_init(). The conflict error
> > > > is spit out from pcibios_resource_survey() by way of pci_subsys_init()
> > > >  subsys_initcall. However, the PCI device scanning is kicked off prior
> > > > to this through acpi_scan_init() by way of acpi_init()
> > > > subsys_initcall.  The conflict error occurs because there's already
> > > > the child ACPI device in the resource tree. I'm not sure when/where
> > > > those ACPI devices' resources are added, but clearly they are sitting
> > > > in there since the conflict was found.
> > 
> > I think the acpi_init()/pci_subsys_init() ordering is correct.  The
> > ACPI namespace is primary.  A PCI hierarchy originates at a PCI host
> > bridge in the ACPI namespace, so we should enumerate the ACPI
> > namespace first, and when we find a PCI host bridge, we should
> > enumerate the PCI devices below it.
> > 
> > That said, I think it is correct mostly by accident and it would be
> > nice if it were more explicit.
> 
> No, it isn't by accident.
> 
> The enumeration of PCI devices under a PCI host bridge discovered via ACPI
> starts in acpi_pci_root_add() which quite explicitly is only called after
> enumerating the ACPI namespace entirely.
> 
> acpi_bus_scan() has two passes now, one is to call acpi_bus_check_add() for
> all namespace objects and the other is the acpi_bus_attach() pass where
> all things like acpi_pci_root_add() are called.

I meant the ordering between acpi_init() and pci_subsys_init().
They're both subsys_initcalls, so their ordering is determined by link
order, which is not at all obvious (at least to me), since acpi_init()
is in drivers/acpi and pci_subsys_init() is in arch/x86.  If they were
both in drivers, the drivers/Makefile would make it pretty obvious.
But finding the order of "arch" relative to "drivers" in Makefile is
less obvious.

acpi_init() has to be before pci_subsys_init(), and it is.  I
shouldn't have said it was by accident, just that it's non-obvious.

Bjorn
