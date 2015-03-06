Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35321 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364AbbCFEyF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Mar 2015 23:54:05 -0500
Received: by oifz81 with SMTP id z81so15825230oif.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2015 20:54:04 -0800 (PST)
Date: Thu, 5 Mar 2015 22:53:48 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Rob Herring <robh@kernel.org>
Cc: Feng Kan <fkan@apm.com>, "patches@apm.com" <patches@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH] pci: host: xgene: fix incorrectly returned address by
 map_bus
Message-ID: <20150306045348.GB20077@google.com>
References: <1424214840-26498-1-git-send-email-fkan@apm.com>
 <20150227002151.GG25765@google.com>
 <20150305163822.GA3048@google.com>
 <CAL_JsqJZ2JN8ZyUeLBbJqRV9bjHBCEs8JZRx=47sFrJL-QEgbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqJZ2JN8ZyUeLBbJqRV9bjHBCEs8JZRx=47sFrJL-QEgbQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 05, 2015 at 02:57:55PM -0600, Rob Herring wrote:
> On Thu, Mar 5, 2015 at 10:38 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > [+cc Mark]
> >
> > On Thu, Feb 26, 2015 at 06:21:51PM -0600, Bjorn Helgaas wrote:
> >> On Tue, Feb 17, 2015 at 03:14:00PM -0800, Feng Kan wrote:
> >> > The generic accessor functions for pci-xgene uses map_bus
> >> > call that returns the base address but did not add the additional
> >> > offset.
> >> >
> >> > Signed-off-by: Feng Kan <fkan@apm.com>
> >> > ...

> >> > @@ -137,7 +137,7 @@ static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> >> >             return NULL;
> >> >
> >> >     xgene_pcie_set_rtdid_reg(bus, devfn);
> >> > -   return xgene_pcie_get_cfg_base(bus);
> >> > +   return xgene_pcie_get_cfg_base(bus) + offset;
> >>
> >> Where's the locking here?  ECAM doesn't need locking because the
> >> bus/dev/fn/offset is all encoded in the MMIO address.  But it looks
> >> like X-Gene doesn't work that way and bus/dev/fn is in the RTDID register.
> >>
> >> So it seems like X-Gene needs locking that not everybody needs.  Are you
> >> relying on higher-level locking somewhere?
> >> ...
> 
> There's no locking problem. The config accesses are all within the
> pci_lock spinlock and nothing else touches that register.

Mmmmm.  Yes, you're right.  pci_bus_{read,write}_config_{byte,word,dword}()
all acquire pci_lock.  For anybody following along at home, here's the
path I was concerned about:

    pci_read_config_byte
      pci_bus_read_config_byte
        lock(&pci_lock)                         # acquire pci_lock
        bus->ops->read/write                    # struct pci_ops
          pci_generic_config_read               # gen_pci_ops
            bus->ops->map_bus
              xgene_pcie_map_bus                # xgene_pcie_ops
                xgene_pcie_set_rtdid_reg
                  writel                        # requires mutex
            readb                               # config read

I'm not exactly sure *why* we do locking there, other than we're just
too scared to change it.  As far as I know, methods like ECAM shouldn't
require that lock, so it's sort of a shame to do it at the top level
like that.

Some of the low-level routines, like pci_{conf1,conf2,bios}, also use a
lock (pci_config_lock in these cases).  We do need it there because a
few paths do call the low-level routines directly.

Here's a typical path on x86:

    pci_read_config_byte
      pci_bus_read_config_byte
        lock(&pci_lock)                         # acquire pci_lock
        bus->ops->read/write                    # struct pci_ops
          pci_read                              # x86 pci_root_ops
            raw_pci_read
              raw_pci_ops->read
                pci_conf1_read                  # x86 raw_pci_ops
                  lock(&pci_config_lock)        # acquire pci_config_lock

And here's a path on x86 that uses the low-level routines directly and
requires the locking there:

    acpi_os_read_pci_configuration
      raw_pci_read
        raw_pci_ops->read
          pci_conf1_read
            lock(&pci_config_lock)

So ideally I think the locking would be done in the low-level routines
that need it, and we could do without pci_lock.  But I don't know
whether that's practical at this point or not.

Bjorn
