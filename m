Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751251AbeFHMgv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jun 2018 08:36:51 -0400
Date: Fri, 8 Jun 2018 07:36:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: poza@codeaurora.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci-owner@vger.kernel.org
Subject: Re: pci_error_handlers for pci_host_bridge ?
Message-ID: <20180608123649.GA197137@bhelgaas-glaptop.roam.corp.google.com>
References: <CAFZiPx29KrKGDJiQ8huTpuVb7tMn=wjMWAvJEZaBiV7eSXYMSQ@mail.gmail.com>
 <20180606125025.GA100923@bhelgaas-glaptop.roam.corp.google.com>
 <CAFZiPx0UUB25kOgSNzUruNLom4=F5y==QbF_Q2g1uPA7csGOHA@mail.gmail.com>
 <80853b92d0f69f32f2f0e2bbcd106993@codeaurora.org>
 <20180607135923.GC15137@bhelgaas-glaptop.roam.corp.google.com>
 <CAFZiPx2E_aDCghJBeri2kTp6TaNTo2k6RY+0oLRk2JNwMeCBEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFZiPx2E_aDCghJBeri2kTp6TaNTo2k6RY+0oLRk2JNwMeCBEw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 08, 2018 at 05:27:12PM +0530, Subrahmanya Lingappa wrote:
> Bjorn,
> 
> On Thu, Jun 7, 2018 at 7:29 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Jun 07, 2018 at 04:20:10PM +0530, poza@codeaurora.org wrote:
> >> On 2018-06-07 15:45, Subrahmanya Lingappa wrote:
> >> > Bjorn,
> >> >
> >> > On Wed, Jun 6, 2018 at 6:20 PM, Bjorn Helgaas <helgaas@kernel.org>
> >> > wrote:
> >> > > Hi Subrahmanya,
> >> > >
> >> > > On Wed, Jun 06, 2018 at 05:57:17PM +0530, Subrahmanya Lingappa wrote:
> >> > > > Hi,
> >> > > > according to https://github.com/torvalds/linux/blob/master/Documentation/PCI/pci-error-recovery.txt
> >> > > >
> >> > > > as part of AER handling, struct pci_error_handlers{} is
> >> > > > implemented by
> >> > > > endpoint drivers to handle device specific recovery steps for "struct
> >> > > > pci_driver".
> >> > > >
> >> > > > But we have a platform_driver which implements "struct
> >> > > > pci_host_bridge" which also supports AER capability how can we
> >> > > > support
> >> > > > pci_error_handlers() for the host bridge drivers ?
> >> > >
> >> > > I assume you're referring to Mobiveil.  Can you explain more of the
> >> > > topology here?  Can you also include "sudo lspci -vv" output?
> >> > >
> >> > Yes, it is for Mobiveil's Host bridge driver :
> >> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/pci/host/pcie-mobiveil.c
> >> > lspci output is now is not available, I'll try to get it sooner.
> >> >
> >> > we have an endpoint connected directly to Rootport as follows
> >> > RC Rootport ----->BUS------> EP
> >> >
> >> > > The AER capability is an optional capability of PCIe device functions.
> >> > > A host bridge is not itself a PCIe function; it's a bridge between a
> >> > > platform-specific host bus and the PCIe bus.
> >> > >
> >> > > Sometimes there is a PCI function that corresponds to the host bridge,
> >> > > but that's not required by the PCI specs and there is no generic
> >> > > programming model for it.
> >> > >
> >> > > If you have an PCIe function corresponding to the Mobiveil host
> >> > > bridge, and it has an AER capability, what would you want the error
> >> > > handlers to do?  This function would not normally be a Root Port or
> >> > > other type 1 PCI-to-PCI bridge device, so it's not clear how its AER
> >> > > would integrate with the PCIe hierarchy.
> >> > >
> >> > Yes we do have a PCI function with AER capability, after an AER
> >> > reported by EP, AER driver initiates an hot_reset on subordinate
> >> > bus, which happens to be downstream port for RC. So we get a
> >> > downstream port link down happens in this case RC driver needs to
> >> > follow a specific register restore sequence, which is most of the
> >> > HW specific initialization done in probe function of the driver
> >> > to recover properly.
> >
> > I'm still not quite getting your point.  Let's try a concrete example.
> > Assume this topology (this is what you described above):
> >
> >   00:00.0 Root Port to [bus 01]
> >   01:00.0 Endpoint
> >
> > Then we have this situation:
> >
> >   - AER driver binds to Root Port 00:00.0
> >   - Endpoint 01:00.0 detects an error and sends ERR_* message upstream
> >   - Root Port 00:00.0 receives ERR_* message
> >   - Root Port 00:00.0 generates AER interrupt
> >   - AER driver handles the interrupt and does a secondary bus reset on
> >     Root Port 00:00.0.  This resets the Endpoint (01:00.0) but not the
> >     Root Port itself.
> >
> > It sounds like you need to do an RC register restore sequence at this
> > point, i.e., something like mobiveil_host_init()?  That sounds like a
> > hardware defect.  Doing a secondary bus reset via the Root Port's
> > bridge control register should have no effect on the RC itself.
> >
> > What am I missing?
> Yes, in this situation PCI config registers are fine, but due to a bug
> RC, config space registers will get reset
> in the SW we need to call the mobiveil_host_init() again to recover in
> case of directly connected EP to the Root-port.
> 
> We do get an local interrupt when this problem occurs, so this can be
> handled in Driver's ISR;
> or is there a better way to handle it ?

I don't see a better way to handle it.

If the PCI core were doing something wrong here, e.g., missing some
restore required by hardware that follows the spec, we would of course
want a nice way to fix it in the core.

But this sounds like hardware that does not follow the spec, so the
workaround should be in the hardware-specific driver.

Note that this may be an issue if/when you want to support ACPI with
this hardware, because in that case we use the generic ACPI host
bridge driver (drivers/acpi/pci_root.c) and there is less opportunity
for device-specific workarounds like this.

Bjorn
