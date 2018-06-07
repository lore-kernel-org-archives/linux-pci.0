Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750891AbeFGN70 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jun 2018 09:59:26 -0400
Date: Thu, 7 Jun 2018 08:59:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: poza@codeaurora.org
Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci-owner@vger.kernel.org
Subject: Re: pci_error_handlers for pci_host_bridge ?
Message-ID: <20180607135923.GC15137@bhelgaas-glaptop.roam.corp.google.com>
References: <CAFZiPx29KrKGDJiQ8huTpuVb7tMn=wjMWAvJEZaBiV7eSXYMSQ@mail.gmail.com>
 <20180606125025.GA100923@bhelgaas-glaptop.roam.corp.google.com>
 <CAFZiPx0UUB25kOgSNzUruNLom4=F5y==QbF_Q2g1uPA7csGOHA@mail.gmail.com>
 <80853b92d0f69f32f2f0e2bbcd106993@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <80853b92d0f69f32f2f0e2bbcd106993@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 07, 2018 at 04:20:10PM +0530, poza@codeaurora.org wrote:
> On 2018-06-07 15:45, Subrahmanya Lingappa wrote:
> > Bjorn,
> > 
> > On Wed, Jun 6, 2018 at 6:20 PM, Bjorn Helgaas <helgaas@kernel.org>
> > wrote:
> > > Hi Subrahmanya,
> > > 
> > > On Wed, Jun 06, 2018 at 05:57:17PM +0530, Subrahmanya Lingappa wrote:
> > > > Hi,
> > > > according to https://github.com/torvalds/linux/blob/master/Documentation/PCI/pci-error-recovery.txt
> > > > 
> > > > as part of AER handling, struct pci_error_handlers{} is
> > > > implemented by
> > > > endpoint drivers to handle device specific recovery steps for "struct
> > > > pci_driver".
> > > > 
> > > > But we have a platform_driver which implements "struct
> > > > pci_host_bridge" which also supports AER capability how can we
> > > > support
> > > > pci_error_handlers() for the host bridge drivers ?
> > > 
> > > I assume you're referring to Mobiveil.  Can you explain more of the
> > > topology here?  Can you also include "sudo lspci -vv" output?
> > > 
> > Yes, it is for Mobiveil's Host bridge driver :
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/pci/host/pcie-mobiveil.c
> > lspci output is now is not available, I'll try to get it sooner.
> > 
> > we have an endpoint connected directly to Rootport as follows
> > RC Rootport ----->BUS------> EP
> > 
> > > The AER capability is an optional capability of PCIe device functions.
> > > A host bridge is not itself a PCIe function; it's a bridge between a
> > > platform-specific host bus and the PCIe bus.
> > > 
> > > Sometimes there is a PCI function that corresponds to the host bridge,
> > > but that's not required by the PCI specs and there is no generic
> > > programming model for it.
> > > 
> > > If you have an PCIe function corresponding to the Mobiveil host
> > > bridge, and it has an AER capability, what would you want the error
> > > handlers to do?  This function would not normally be a Root Port or
> > > other type 1 PCI-to-PCI bridge device, so it's not clear how its AER
> > > would integrate with the PCIe hierarchy.
> > > 
> > Yes we do have a PCI function with AER capability, after an AER
> > reported by EP, AER driver initiates an hot_reset on subordinate
> > bus, which happens to be downstream port for RC. So we get a
> > downstream port link down happens in this case RC driver needs to
> > follow a specific register restore sequence, which is most of the
> > HW specific initialization done in probe function of the driver
> > to recover properly.

I'm still not quite getting your point.  Let's try a concrete example.
Assume this topology (this is what you described above):

  00:00.0 Root Port to [bus 01]
  01:00.0 Endpoint

Then we have this situation:

  - AER driver binds to Root Port 00:00.0
  - Endpoint 01:00.0 detects an error and sends ERR_* message upstream
  - Root Port 00:00.0 receives ERR_* message
  - Root Port 00:00.0 generates AER interrupt
  - AER driver handles the interrupt and does a secondary bus reset on
    Root Port 00:00.0.  This resets the Endpoint (01:00.0) but not the
    Root Port itself.

It sounds like you need to do an RC register restore sequence at this
point, i.e., something like mobiveil_host_init()?  That sounds like a
hardware defect.  Doing a secondary bus reset via the Root Port's
bridge control register should have no effect on the RC itself.

What am I missing?

> Are you looking at something similar to pci_error_handlers to be called for
> your RC driver ?
> where probably you are expecting during ERR_NONFATAL recovery you would want
> to restore some of your platform
> specific registers. I dont think that support exists now. since
> pci_error_handlers is of struct pci_driver
> while yours is platform driver.
> 
> Although please also note that ERR_FATAL is no more handled with error and
> recovery callbacks.
> that are just going to be handled with removal, re-enumeration of the
> devices.
> 
> but I suppose in any case you want to restore the registers in any type of
> uncorrectable error.
> 
> although this is really platform specific, some sort of quirk I cna think
> of, but again err.c has to check
> that quirk's existence and calls platform specific callback
> (that again I am not sure because such things do not exist with respect to
> error/recovery callbacks)
> 
> Yeah just re-thinking, this is too specific, not to be addressed by generic
> framework I think.
> 
> > I was wondering if this can be handled by using AER error handlers, or
> > would suggest a better way to handle this ?
> > 
> > As of now plan is to handle this situation is by calling a minimal
> > probe recovery sequence after link down interrupt within the
> > driver interrupt service routine.
> 
> Well I think that is a better place,
> I was wondering why are you loosing registers at the first point ?
> Is because of link down even you are loosing them ? some issue with hw !
> 
> 
> Lets hear from Bjorn anyway, I am curious.
> 
> > 
> > > Bjorn
> > 
> > Thanks,
